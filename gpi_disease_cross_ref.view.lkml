view: gpi_disease_cross_ref {
  #1. This view is created to pull records by either GPI and Disease code grain or gpi grain
  #2. Use GPI_DISEASE_RNK to view all disease for GPI and respective fields
  #3.use GPI_RNK to view one record per gpi based on choronic or acute duration. This view will have two sets dimension, one for each grain so that we accomdate when different grian level filter can be used



  derived_table: {
    sql:
    SELECT DISEASE_CODE,  GPI,
              DESCRIPTION,
              MNEMONIC,
              DURATION,
              ROW_NUMBER() OVER (PARTITION BY DISEASE_CODE, GPI ORDER BY INDICATION_CODE ASC) GPI_DISEASE_RNK,
              ROW_NUMBER() OVER (PARTITION BY GPI ORDER BY  DURATION DESC, INDICATION_CODE ASC , DESCRIPTION ASC) GPI_RNK
        FROM EDW.D_GPI_DISEASE_CROSS_REF
     ;;
  }

  dimension: disease_code {
    label: "GPI Disease Code"
    group_label: "GPI Disease"
    description: "Medi-Span ICD9/ICD10 disease codes, display multiple disease for single gpi"
    type: string
    sql: ${TABLE}.disease_code ;;
  }

  dimension: gpi {
    hidden: yes
    group_label: "GPI Disease"
    type: string
    sql: ${TABLE}.gpi ;;
  }

  dimension: disease_code_description {
    label: "GPI Disease Description"
    group_label: "GPI Disease"
    description: "Medi-Span ICD9/ICD10 disease codes description ,display multiple disease code description for same gpi"
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: disease_code_mnemonic {
    label: "GPI Disease Mnemonic"
    group_label: "GPI Disease"
    description: "Medi-Span ICD9/ICD10 disease codes mnemonic, display multiple disease code mnemonic for same gpi"
    type: string
    sql: ${TABLE}.mnemonic ;;
  }

  dimension: duration {
    label: "GPI Disease Duration"
    group_label: "GPI Disease"
    description: "Medi-Span ICD9/ICD10 disease codes duration. A = Acute, C = Chronic, , display multiple disease code duration for same gpi"
    type: string
    sql: ${TABLE}.duration ;;
  }

  dimension: gpi_disease_rnk {
    hidden: yes
    group_label: "GPI Disease"
    type: number
    sql: ${TABLE}.GPI_DISEASE_RNK ;;
  }

  dimension: gpi_rnk {
    hidden: yes
    group_label: "GPI Disease (Unique)"
    type: number
    sql: ${TABLE}.GPI_RNK ;;
  }

  dimension: gpi_disease_gpi {
    hidden: yes
    type: string
    group_label: "GPI Disease (Unique)"
    sql: ${TABLE}.gpi ;;
  }

  dimension: gpi_disease_code {
    label: "GPI Disease Code (Unique)"
    group_label: "GPI Disease (Unique)"
    description: "Medi-Span ICD9/ICD10 disease codes, displays one disease code for a GPI"
    type: string
    sql: ${TABLE}.disease_code ;;
  }

  dimension: gpi_disease_code_description {
    label: "GPI Disease Description (Unique)"
    group_label: "GPI Disease (Unique)"
    description: "Medi-Span ICD9/ICD10 disease codes description, displays one disease code description for a GPI"
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: gpi_disease_code_mnemonic {
    label: "GPI Disease Mnemonic (Unique)"
    group_label: "GPI Disease (Unique)"
    description: "Medi-Span ICD9/ICD10 disease codes mnemonic, displays one disease code mnemonic for a GPI"
    type: string
    sql: ${TABLE}.mnemonic ;;
  }

  dimension: gpi_duration {
    label: "GPI Disease Duration (Unique)"
    group_label: "GPI Disease (Unique)"
    description: "Medi-Span ICD9/ICD10 disease codes duration. A = Acute, C = Chronic, displays one disease code duration for a GPI"
    type: string
    sql: ${TABLE}.duration ;;
  }

  set: gpi_disease_candidate_list {
    fields: [
      disease_code,
      disease_code_description,
      disease_code_mnemonic,
      duration,
      gpi_disease_rnk,
      gpi
    ]
  }

  set: gpi_candidate_list {
    fields: [
      gpi_disease_code,
      gpi_disease_code_description,
      gpi_disease_code_mnemonic,
      gpi_duration,
      gpi_rnk,
      gpi_disease_gpi
    ]
  }
}
