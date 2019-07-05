view: store_adjustment_group {
  sql_table_name: EDW.D_ADJUSTMENT_GROUP ;;

  dimension: adjustment_group_id {
    type: number
    hidden: yes
    label: "Adjustment Group ID"
    sql: ${TABLE}.ADJUSTMENT_GROUP_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${adjustment_group_id} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References #####################################################################################################

  dimension: chain_id {
    type: number
    label: "Adjustment Group Chain ID"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    label: "Adjustment Group NHIN STORE ID"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: vendor_id {
    type: number
    label: "Adjustment Group Vendor ID"
    hidden: yes
    sql: ${TABLE}.VENDOR_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  #################################################################################################### Dimensions #####################################################################################################

  dimension: deleted {
    hidden: yes
    type: string
    label: "Adjustment Group Deleted"
    # Y/N flag as in database is used so a customer can update the record accordingly, if this entity is consumed as-is to the customer
    description: "Y/N Flag indicating if the adjustment group was deleted from the source system"
    sql: ${TABLE}.ADJUSTMENT_GROUP_DELETED ;;
  }

  ########################################################################################################### DATE/TIME specific Fields ################################################################################

  dimension_group: adjustment_group_applied {
    label: "Adjustment Group Applied"
    description: "Date the adjustment group was applied"
    type: time
    sql: ${TABLE}.ADJUSTMENT_GROUP_APPLIED_DATE ;;
  }

  dimension_group: adjustment_group_create {
    label: "Adjustment Group Created"
    description: "Date the adjustment group was created"
    type: time
    sql: ${TABLE}.ADJUSTMENT_GROUP_CREATE_DATE ;;
  }
}
