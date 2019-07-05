#[ERXDWPS-7476][ERXDWPS-7987] - view name changed from gpi_pdc_group to pdc_group.
view: pdc_group {
  sql_table_name: EDW.D_PDC_GROUP ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${pdc_group_id} ;;
  }

  dimension: pdc_group_id {
    hidden: yes
    type: number
    sql: ${TABLE}.PDC_GROUP_ID ;;
  }

  dimension: medical_condition {
    label: "Medical Condition"
    description: "Medical Condition is the Therapy Class, which is the set of GPI's that make up a drug Therapy Class for which the PDC is calculated"
    type: string
    sql: ${TABLE}.PDC_GROUP_NAME ;;
  }

  dimension: pdc_group_deactivated_flag {
    label: "PDC Group Deactivated"
    description: "Yes/No flag indicating the PDC group has been deactivated in CareRx for PDC calculation"
    type: yesno
    hidden: yes
    sql: ${TABLE}.PDC_GROUP_DEACTIVATED_FLAG = 'Y' ;;
  }

  dimension: pdc_group_deleted {
    label: "PDC Group Deleted"
    description: "Yes/No flag indicating the record has been deleted in the source table"
    type: yesno
    hidden: yes
    sql: ${TABLE}.PDC_GROUP_DELETED = 'Y' ;;
  }
}
