view: ar_plan {
  sql_table_name: EDW.D_PLAN ;;

  #################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${plan_id} ;;
  }

  dimension: chain_id {
    hidden: yes
    label: "Chain ID"
    description: "Identification number assigned to each customer chain by NHIN."
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: plan_id {
    hidden: yes
    type: number
    label: "Plan ID"
    description: "Unique number assigned to Carrier Plan"
    sql: ${TABLE}.PLAN_CARRIER_PLAN_ID ;;
  }

  dimension: source_system_id {
    hidden: yes
    type: number
    label: "Source System ID"
    description: "Unique ID number identifying an BI source system"
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: plan_carrier_id {
    type: number
    hidden: yes
    label: "Plan Carrier ID"
    description: "Used as a way to group multiple plan records associated to one carrier"
    sql: ${TABLE}.PLAN_CARRIER_ID ;;
  }

  dimension: plan_type_id {
    type: number
    hidden: yes
    label: "Plan Type ID"
    description: "Third Party Plan Type"
    sql: ${TABLE}.PLAN_TYPE_ID ;;
  }

  dimension: plan_processord_identifier {
    type: string
    label: "Plan Processor ID"
    description: "Link to the Processor table within the AR system"
    sql: ${TABLE}.PLAN_PROCESSOR_IDENTIFIER ;;
  }

  dimension: plan_processord_identifier_aging {
    type: string
    label: "Aging Plan Processor ID"
    description: "Link to the Processor table within the AR system"
    sql: ${TABLE}.PLAN_PROCESSOR_IDENTIFIER ;;
  }

  dimension: plan_added_user_identifier {
    type: number
    label: "Plan Added User Identifier"
    description: "User ID from when the Plan record was added to the Plan Table"
    sql: ${TABLE}.PLAN_ADDED_USER_IDENTIFER ;;
  }

  dimension: plan_last_update_user_identifier {
    type: number
    label: "Plan Last Update User Identifier"
    description: "User ID from when the Plan record was last updated by a User"
    sql: ${TABLE}.PLAN_LAST_UPDATE_USER_IDENTIFIER ;;
  }

  dimension: plan_government_plan_flag {
    label: "Contract Rate Network ID"
    description: "Y/N Flag indicating if this is a government regulated plan"
    type: yesno
    sql: ${TABLE}.PLAN_GOVERNMENT_PLAN_FLAG = 'Y';;
  }

  dimension: plan_bin_number {
    type: string
    label: "Plan BIN Number"
    description: "BIN number associated with the NHIN Carrier and Plan combination"
    sql: ${TABLE}.PLAN_BIN_NUMBER ;;
  }

  dimension: plan_pcn {
    type: string
    label: "Plan PCN"
    description: "PCN number associated with the NHIN Carrier and Plan combination"
    sql: ${TABLE}.PLAN_PCN;;
  }

  dimension: plan_true_payer_code {
    type: string
    label: "Plan True Payer Code"
    description: "Payer who actually pays the claims, it can be different than the payer who sends the 835 and who processes the claims"
    sql: ${TABLE}.PLAN_TRUE_PAYER_CODE;;
  }

################################################################################## Master code dimensions ################################################################################################

dimension: plan_type_id_mc {
    type: string
    label: "Plan Type"
    description: "Third Party Plan Type"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.PLAN_TYPE_ID) ;;
    suggestions : [ "COMMERCIAL",
                    "MEDICAID",
                   "MANAGED MEDICAID",
                   "MEDICARE B",
                   "MEDICARE D",
                   "WORKERS COMPENSATION",
                   "OTHER STATE PLAN",
                   "CASH",
                   "ADAP",
                   "DISCOUNT CARD",
                   "COPAY ASSISTANCE PLAN",
                   "INTERNAL",
                   "SPECIAL PROGRAMS",
                   "FLU PLAN",
                   "MTM SERVICES",
                   "OTHER",
                   "MAJOR MEDICAL",
                   "SECONDARY PLAN",
                   "PATIENT BILLING",
                   "MEDICARE SUPPLEMENT"]
  }

#################################################################################### Measure  ##########################################################################################################################

  measure: count {
    type: count
    label: "Total Plans"
    }

#################################################################################### EDW Metadata Fields  ##############################################################################################################

    dimension: lcr_id {
    type: number
    hidden:  yes
    label: "Plan LCR ID"
    description: "Unique ID populated in the stage table during the data load process that identifies the record"
    sql: ${TABLE}.PLAN_LCR_ID ;;
  }

  dimension: event_id {
    hidden:  yes
    type: number
    label: "EDW Event ID"
    description: "EVENT_ID of the ETL run that inserted or updated this record in EDW"
    sql: ${TABLE}.EVENT_ID ;;
  }

  dimension: load_type {
    hidden:  yes
    type: string
    label: "EDW Load Type"
    description: "Indicates which type of load (Initial/Regular/Correction) inserted/updated the record in EDW"
    sql: ${TABLE}.LOAD_TYPE ;;
  }

  dimension_group: edw_insert_timestamp {
    hidden:  yes
    type: time
    label: "EDW Insert Timestamp"
    description: "The date/time at which the record is inserted to EDW"
    sql: ${TABLE}.EDW_INSERT_TIMESTAMP ;;
  }

  dimension_group: edw_last_update_timestamp {
    hidden:  yes
    type: time
    label: "EDW Last Update Timestamp"
    description: "The date/time at which the record is updated in EDW"
    sql: ${TABLE}.EDW_LAST_UPDATE_TIMESTAMP ;;
  }
  dimension_group: source_timestamp {
    hidden:  yes
    type: time
    label: "Source Timestamp"
    description: "The date/time at which the record was last updated in the source application"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }


  #################################################################################### Dimensions ##############################################################################################################


  dimension: carrier_code {
    label: "Plan Carrier Code"
    description: "Unique code used to identify a Third Party Carrier"
    type: string
    sql: ${TABLE}.CARRIER_CODE ;;
  }
  dimension: plan_name {
    label: "Plan Name"
    description: "Name of the third party plan. HOST Table Name: PLAN"
    type: string
    sql: ${TABLE}.PLAN_NAME ;;
  }
  dimension: plan_code {
    label: "Plan Code"
    description: "Unique code used to identify a Third Party Plan. HOST Table Name: PLAN"
    type: string
    sql: ${TABLE}.PLAN_CODE ;;
  }
}
