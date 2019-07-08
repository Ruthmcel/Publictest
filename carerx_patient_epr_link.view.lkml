view: carerx_patient_epr_link {
  sql_table_name: MTM_CLINICAL.PATIENT_EPR_LINK ;;
  ## THIS VIEW FILE WILL ONLY BE NEEDED IF WE ARE GOING TO JOIN TO EPR DATA. THIS WILL BE IMPORTANT WHEN SOURCING INTO SNOWFLAKE. THE CARE RX USER DOES NOT HAVE ACCESS TO EPR TABLES, SO JOIN IS NOT POSSIBLE AT THIS TIME

  # used for joining with other tables in the MTM_CLINICAL schema
  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  ######################################################################################### Foreign Key References #################################################################################################

  dimension: chain_id {
    hidden: yes
    label: "Chain ID"
    description: "The CareRx unique database ID of the chain that the Care Rx patient is linked to. This is NOT the Chain NHIN ID assigned by NHIN"
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: rx_com_id {
    hidden: yes
    label: "Rx Com ID"
    description: "Unique ID number issued by the EPR used to identify the patient on on the Rx.com network for a specific chain"
    type: number
    sql: ${TABLE}.RX_COM_ID ;;
  }

  dimension: original_patient_id {
    hidden: yes
    label: "Patient Original ID"
    description: "The unique database ID of the Care Rx patient that the Rxcom Id is linked to"
    type: number
    sql: ${TABLE}.ORIGINAL_PATIENT_ID ;;
  }

  ######################################################################################### Dimensions #################################################################################################

  dimension: patient_primary_rx_com_id_flag {
    hidden: yes
    label: "Patient Primary Rx Com ID"
    description: "A flag indicating the RX_COM_ID to use for the patient, for the chain, when the CareRx application is communicating with the EPR application."
    type: number
    sql: ${TABLE}.IS_PRIMARY ;;
  }
}
