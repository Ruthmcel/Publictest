# [ERXDWPS-9281] - View created with derived sql to fetch latest record for store_setting_name. Based on data profile, we found duplicate records for same setting name and want to pick latest record by applying raking and filtering.
# Kumaran, Craig and Ramesh had a discussion on this and come up with creating derived sql to get the latest info for each store_setting_name.
# This view file will be utilized in future to replace existing dimensions which currently utilizing store_setting view file. (Ex: Pharmacy Fax Number (Store) and Pharmacy Alternate Phone Number (Store)).
view: store_setting_rank {
  label: "Store Setting"
  derived_table: {
    sql: select *
          from (select *
                      ,row_number() over(partition by chain_id, nhin_store_id, store_setting_name order by source_timestamp desc) as rnk
                from edw.d_store_setting
                where {% condition chain.chain_id %} chain_id {% endcondition %}
                  and {% condition store.nhin_store_id %} nhin_store_id {% endcondition %}
                  and nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                          where source_system_id = 5
                                            and {% condition chain.chain_id %} chain_id {% endcondition %}
                                            and {% condition store.store_number %} store_number {% endcondition %}
                                       )
               )
         where rnk = 1
        ;;
  }

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${store_setting_name} ;; #ERXLPS-1649
  }

  ################################################################## Foreign Key references##############################
  dimension: chain_id {
    label: "Chain Id"
    type: number
    description: "Identification number assinged to each customer chain by NHIN"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    type: number
    description: "Store record in the source system. This column is used to link STORE & STORE_SETTINGS table in source system"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_setting_id {
    label: "Store Setting Id"
    type: number
    description: "The number that uniquely identifies the store settings in the source system,"
    hidden: yes
    sql: ${TABLE}.STORE_SETTING_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    type: number
    description: "Unique ID number identifying an BI source sytem (0 - HOST, 1 - ECC, 2 - SEC_ADMIN,   3 - EPR, 4 - EPS, 5 - ARS, 6 - NHIN)"
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  ############################################################## Dimensions######################################################
  dimension: store_setting_name {
    label: "Pharmacy Setting Name (Store)"
    type: string
    description: "This is the name of store setting used by EPS key binding class"
    sql: ${TABLE}.STORE_SETTING_NAME ;;
  }

  dimension: store_setting_list_index {
    label: "Pharmacy Setting List Index (Store)"
    type: number
    description: "This is the ordinal of a set of identically named store settings, i.e store_settings.name is the same for multiple records each of which is distingushed by the value of their list_index"
    sql: ${TABLE}.STORE_SETTING_LIST_INDEX ;;
    value_format: "#,##0"
  }

  dimension: store_setting_display_name {
    label: "Pharmacy Setting Display Name (Store)"
    type: string
    description: "This is the label of this store setting that is displayed on the Enterprise Control Center (ECC)"
    sql: ${TABLE}.STORE_SETTING_DISPLAY_NAME ;;
  }

  dimension: store_setting_value {
    label: "Pharmacy Setting Value (Store)"
    type: string
    description: "This is the default value of the store setting. This is the  literal value of the store setting expressed as a string value. A NULL value is permissible if no value is meant to be the default value"
    sql: ${TABLE}.STORE_SETTING_VALUE ;;
  }

  dimension: store_setting_available_in_rapid_fill_flag {
    label: "Pharmacy Setting Available In Rapid Fill (Store)"
    type: yesno
    description: "Yes/No flag indicating whether this store setting record is available when the Enterprise Pharmacy System (EPS) is in a 'Rapid Fill' operational mode. This is an operational mode that compresses the normal Workflow operational mode into fewer application screens that the normal Workflow uses"
    sql: ${TABLE}.STORE_SETTING_AVAILABLE_IN_RAPID_FILL_FLAG = 'Y' ;;
  }

  dimension: store_setting_editable_flag {
    label: "Pharmacy Setting Editable (Store)"
    type: yesno
    description: "Yes/No flag indicating whether this store setting record must be manually populated individually when copying one store's store setting to another store"
    sql: ${TABLE}.STORE_SETTING_EDITABLE_FLAG = 'Y' ;;
  }

  dimension: store_setting_requires_server_restart_flag {
    label: "Pharmacy Setting Requires Server Restart (Store)"
    type: yesno
    description: "Yes/No flag indicating whether this store setting record requires a server restart for changes to take effect"
    sql: ${TABLE}.STORE_SETTING_REQUIRES_SERVER_RESTART_FLAG = 'Y' ;;
  }

  dimension: store_setting_data_type {
    label: "Pharmacy Setting Data Type (Store)"
    type: string
    description: "This is the data type used to display this store setting on the ECC"
    #hidden: true
    sql: ${TABLE}.STORE_SETTING_DATA_TYPE ;;
  }

  dimension: store_setting_data_class_code_reference{
    label: "Pharmacy Setting Data Class (Store)"
    description: "Data Class to define if the store setting is to be secure and not exported in the ECC exports"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_SETTING_DATA_CLASS_CODE ;;
  }

  #[ERXDWPS-6493] - Added default value UNKNOWN. Added bypass_suggest_restrictions : yes. Added drill down option to see the actual value.
  dimension: store_setting_data_class_code {
    label: "Pharmacy Setting Data Class (Store)"
    type: string
    description: "Data Class to define if the store setting is to be secure and not exported in the ECC exports"
    sql: (SELECT NVL(MAX(MASTER_CODE_SHORT_DESCRIPTION), 'UNKNOWN') FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.STORE_SETTING_DATA_CLASS_CODE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'STORE_SETTING_DATA_CLASS_CODE') ;;
    bypass_suggest_restrictions: yes
    drill_fields: [store_setting_data_class_code_reference]
  }

  dimension_group: store_setting_created {
    label: "Pharmacy Setting Created (Store)"
    type: time
    description: "This is the date that this store setting record was inserted into the database"
    hidden: yes
    sql: ${TABLE}.STORE_SETTING_CREATED_DATE ;;
  }

  dimension_group: store_setting_last_update {
    label: "Pharmacy Setting Last Update (Store)"
    type: time
    description: "This is the date of the last update of this store setting record"
    hidden: yes
    sql: ${TABLE}.STORE_SETTING_LAST_UPDATE_DATE ;;
  }

}
