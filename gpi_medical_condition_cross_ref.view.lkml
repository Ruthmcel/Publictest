view: gpi_medical_condition_cross_ref {
  sql_table_name: EDW.D_GPI_MEDICAL_CONDITION_CROSS_REF ;;

  dimension: gpi_medical_condition {
    #hidden: yes #[ERXLPS-1942] Exposed Therapy class information from master data set.
    label: "Medical Condition"
    description: "Medical Condition is the Therapy Class, which is the set of GPI's that make up a drug Therapy Class."
    type: string
    sql: ${TABLE}.MEDICAL_CONDITION ;;
  }

  dimension: medical_condition {
    #hidden: yes #[ERXLPS-1942] Exposed Therapy class information from master data set.
    label: "Medical Condition"
    description: "Medical Condition is the Therapy Class, which is the set of GPI's that make up a drug Therapy Class. Use this field to show PDC scores by Therapy Class. This field can also be used without PDC."
    type: string
    sql: ${TABLE}.MEDICAL_CONDITION ;;
  }

  dimension: gpi {
    hidden: yes
    type: string
    sql: ${TABLE}.GPI ;;
  }

  dimension: medical_condition_description {
    label: "Medical Condition Description"
    hidden: yes
    description: "Description of the Medical Condition / Therapy Class, which is the set of GPI's that make up a drug Therapy Class for which the PDC is calculated"
    type: string
    sql: ${TABLE}.MEDICAL_CONDITION_DESCRIPTION ;;
  }
}
