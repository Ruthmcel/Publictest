view: source_system {
  sql_table_name: EDW.D_SOURCE_SYSTEM ;;

  dimension: source_system_id {
    primary_key: yes
    label: "Source System ID"
    description: "Unique ID number identifying a BI source system"
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  ####################################################################################### Dimension ######################################################################

  dimension: central_service_flag {
    label: "Central Services Flag"
    description: "Y/N flag describing whether the source system is a Central Service application or not"
    type: string
    sql: ${TABLE}.CENTRAL_SERVICE_FLAG ;;
  }

  dimension: name {
    label: "Source System Name"
    description: "Name of the source system, from where the BI source system extracts data from"
    type: string
    sql: ${TABLE}.SOURCE_SYSTEM_NAME ;;
  }

  dimension: description {
    label: "Source System Description"
    description: "Describes  the usage of the source sytem"
    type: string
    sql: ${TABLE}.SOURCE_SYSTEM_DESCRIPTION ;;
  }
}

################################################################################ End of Dimension ######################################################################
