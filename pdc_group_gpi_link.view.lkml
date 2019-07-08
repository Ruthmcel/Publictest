#[ERXDWPS-7476][ERXDWPS-7987] - View name changed from gpi_pdc_group_link to pdc_group_gpi_link.
view: pdc_group_gpi_link {
  sql_table_name: EDW.D_PDC_GROUP_GPI_LINK ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${pdc_group_gpi_link_id} ;;
  }

  dimension: pdc_group_gpi_link_id {
    hidden: yes
    type: number
    sql: ${TABLE}.PDC_GROUP_GPI_LINK_ID ;;
  }

  dimension: pdc_group_id {
    hidden: yes
    type: number
    sql: ${TABLE}.PDC_GROUP_ID ;;
  }

  dimension: gpi {
    hidden: yes
    type: string
    sql: ${TABLE}.GPI ;;
  }

  dimension: pdc_group_gpi_link_deleted_reference {
    label: "PDC Group GPI Link Deleted"
    description: "Yes/No flag indicating the record has been deleted in the source table"
    type: string
    hidden: yes
    sql: ${TABLE}.PDC_GROUP_GPI_LINK_DELETED ;;
  }

  dimension: pdc_group_gpi_link_deleted {
    label: "PDC Group GPI Link Deleted"
    description: "Yes/No flag indicating the record has been deleted in the source table"
    type: yesno
    hidden: yes
    sql: ${TABLE}.PDC_GROUP_GPI_LINK_DELETED = 'Y' ;;
  }
}
