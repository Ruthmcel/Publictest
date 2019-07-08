view: chain_patient_phone_list {
  derived_table: {
    sql: Select chain_id,rx_com_id,
        CASE
        WHEN CHARINDEX (', ',home_phone_list,0) = 1 then SUBSTRING(home_phone_list,3,LENGTH(home_phone_list))
        WHEN CHARINDEX (', ',home_phone_list,0) = LENGTH(home_phone_list) -1 then SUBSTRING (home_phone_list,1,LENGTH(home_phone_list)-2)
        ELSE home_phone_list END home_phone_list,
        CASE
        WHEN CHARINDEX (', ',work_phone_list,0) = 1 then SUBSTRING(work_phone_list,3,LENGTH(work_phone_list))
        WHEN CHARINDEX (', ',work_phone_list,0) = LENGTH(work_phone_list) -1 then SUBSTRING (work_phone_list,1,LENGTH(work_phone_list)-2)
        ELSE work_phone_list END work_phone_list
         from (
        SELECT
        CHAIN_ID as chain_id
        ,RX_COM_ID as rx_com_id
        ,LISTAGG(DISTINCT PATIENT_ADDRESS_HOME_PHONE_NUM, ', ')  WITHIN GROUP (ORDER BY PATIENT_ADDRESS_HOME_PHONE_NUM) AS home_phone_list
        ,LISTAGG(DISTINCT PATIENT_ADDRESS_WORK_PHONE_NUM, ', ')  WITHIN GROUP (ORDER BY PATIENT_ADDRESS_WORK_PHONE_NUM)  AS work_phone_list
        FROM EDW.D_PATIENT_ADDRESS PAD
        WHERE  {% condition chain.chain_id %} PAD.CHAIN_ID {% endcondition %} and PATIENT_ADDRESS_DEACTIVATE_DATE is null and PATIENT_ADDRESS_DELETED = 'N'
        GROUP BY CHAIN_ID,RX_COM_ID )PAT_PHONE_LIST
       ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${chain_id} ||'@'|| ${rx_com_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References ####################################################################################
  dimension: chain_id {
    type: number
    hidden: yes
    # primary key in source
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: rx_com_id {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_COM_ID ;;
  }

  #################################################################################################### Patient Phone List Measures ####################################################################################
  measure: home_phone_list {
    type: string
    group_label: "Central Patient Phone Info"
    label: "Central Patient Home Phone List"
    description: "Combines Patient Home Number with comma delimited"
    sql: MAX(${TABLE}.home_phone_list) ;;
    value_format: "(###) ###-####"
  }

  measure: work_phone_list {
    type: string
    group_label: "Central Patient Phone Info"
    label: "Central Patient Work Phone List"
    description: "Combines Patient Work Number with comma delimited"
    sql: MAX(${TABLE}.work_phone_list) ;;
    value_format: "(###) ###-####"
  }
}
