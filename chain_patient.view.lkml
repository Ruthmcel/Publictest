view: chain_patient {
  # this view is created to display store level patient information which is not available at EPR patient,
  # when PDX Classic patient information is sourced and loaded, please make sure the logic used is not affected
  # sql_table_name: my_schema_name.eps_chain_patient
  derived_table: {
    sql:
    Select CHAIN_ID,RX_COM_ID,NHIN_STORE_ID,PATIENT_NO_AUTOMATED_CALLS_FLAG
    FROM (
     Select CHAIN_ID,RX_COM_ID,NHIN_STORE_ID,PATIENT_NO_AUTOMATED_CALLS_FLAG,
     ROW_NUMBER() OVER(PARTITION BY CHAIN_ID,RX_COM_ID ORDER BY SOURCE_TIMESTAMP DESC NULLS LAST)
    AS LATEST_PAT_STORE  from EDW.D_STORE_PATIENT PAT
    WHERE {% condition chain.chain_id %} PAT.CHAIN_ID {% endcondition %} -- Required for performance reasons and to avoid scanning all chain/store records
    AND PAT.source_system_id = 4
    ) patient where LATEST_PAT_STORE = 1
     ;;
  }

  dimension: chain_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: rx_com_id {
    label: "Store Patient RX COM ID"
    description: "Patient unique identifier"
    hidden: yes
    type: number
    sql: ${TABLE}.RX_COM_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${chain_id} ||'@'|| ${rx_com_id} ;; #ERXLPS-1649
  }

  dimension: no_automated_calls {
    label: "Store Patient Contact No Automatic Calls"
    description: "Y/N flag indicating if patient does not want automatic calls for contacting the patient"
    type: string

    case: {
      when: {
        sql: ${TABLE}.PATIENT_NO_AUTOMATED_CALLS_FLAG = 'Y' ;;
        label: "Y"
      }

      when: {
        sql: true ;;
        label: "N"
      }
    }
  }
}
