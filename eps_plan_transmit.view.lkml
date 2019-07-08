view: eps_plan_transmit {
  #[ERXLPS-2383] - Two set of dimensions created for PLAN_TRANSMIT view. One with lable name of Claim Plan *** to show plan information associated with Claim.
  #[ERXLPS-2383] - Another set created with label name of Patient Plan **** to show the Plan information associated with Patient.
  label: "Plan transmit"

  derived_table: {
    sql: select *
        from (select *,
                     row_number() over(partition by chain_id, nhin_store_id, plan_id, source_system_id order by store_plan_transmit_sequence_number asc, plan_transmit_id desc) rnk
                from edw.d_store_plan_transmit
               where store_plan_transmit_deleted = 'N'
             )
       where rnk = 1
       ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${plan_transmit_id} ||'@'|| ${source_system_id} ;; #ERXLPS-1649 ,#ERXDWPS-5124
  }

  #################################################################################################### Foreign Key References ####################################################################################

  dimension: chain_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    hidden: yes
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: plan_transmit_id {
    hidden: yes
    type: string
    sql: ${TABLE}.PLAN_TRANSMIT_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: plan_id {
    label: "Plan Id"
    hidden: yes
    description: "Unique ID that links this record to a specific PLAN record. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.PLAN_ID ;;
  }

  #################################################################################################### End of Foreign Key References #########################################################################

  ################################################################################################## Dimensions ################################################################################################

  dimension: store_plan_transmit_sequence_number {
    label: "Claim Plan Transmit Sequence Number"
    description: "Determines order of which sites the system transmits claims to. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_SEQUENCE_NUMBER ;;
  }

  dimension: store_plan_transmit_billing_claim_format {
    label: "Claim Plan Transmit Billing Claim Format"
    description: "Claim format to be used when transmitting this claim electronically. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_BILLING_CLAIM_FORMAT ;;
  }

  dimension: store_plan_transmit_site_code {
    label: "Claim Plan Transmit Site Code"
    description: "Site code that identifies which communication record should be used when transmitting a claim. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_SITE_CODE ;;
  }

  dimension: store_plan_transmit_bin_number {
    label: "Claim Plan BIN"
    description: "ANSI BIN (Bank Identification Number) number for claim transmittals. This information is associated with the transaction, but is set in the patient’s plan file. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_BIN_NUMBER ;;
  }

  dimension: store_plan_transmit_processor_control_number {
    label: "Claim Plan PCN"
    description: "Processor control number for claim transmittals. This information is associated with the transaction, but is set in the patient’s plan file. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_PROCESSOR_CONTROL_NUMBER ;;
  }

  dimension: store_plan_transmit_bin_pcn {
    label: "Claim Plan BIN/PCN"
    description: "Concatenated value of BIN (Bank Identification Number) and PCN (Processor Control Number). This information is associated with the transaction, but is set in the patient’s plan file. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: CASE WHEN ${store_plan_transmit_bin_number} IS NULL AND ${store_plan_transmit_processor_control_number} IS NULL THEN NULL ELSE CONCAT(CONCAT(NVL(REGEXP_REPLACE(${store_plan_transmit_bin_number}, '[[:space:]]*',''),''), '-'),NVL(REGEXP_REPLACE(${store_plan_transmit_processor_control_number}, '[[:space:]]*',''),'')) END ;;
  }

  #[ERXDWPS-6646] - Added default value Unknown. Added bypass_suggest_restrictions : yes. Added drill down option to see the actual value.
  dimension: store_plan_transmit_header_reference {
    label: "Claim Plan Transmit Header"
    description: "Transmit special header. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_HEADER ;;
  }

  dimension: store_plan_transmit_header {
    label: "Claim Plan Transmit Header"
    description: "Transmit special header. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: etl_manager.fn_get_master_code_desc('STORE_PLAN_TRANSMIT_HEADER', ${TABLE}.STORE_PLAN_TRANSMIT_HEADER,'N') ;;
    drill_fields: [store_plan_transmit_header_reference]
    suggestions: ["BLANK", "NDC", "NDC-PHS", "PACE", "MD MED"]
  }

  #[ERXDWPS-6646] - Added default value Unknown. Added bypass_suggest_restrictions : yes. Added drill down option to see the actual value.
  dimension: store_plan_transmit_protocol_reference {
    label: "Claim Plan Transmit Protocol"
    description: "Communication protocol to use when transmitting a claim electronically. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_PROTOCOL ;;
  }

  dimension: store_plan_transmit_protocol {
    label: "Claim Plan Transmit Protocol"
    description: "Communication protocol to use when transmitting a claim electronically. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: etl_manager.fn_get_master_code_desc('STORE_PLAN_TRANSMIT_PROTOCOL', ${TABLE}.STORE_PLAN_TRANSMIT_PROTOCOL,'N') ;;
    drill_fields: [store_plan_transmit_protocol_reference]
    suggestions: ["VISA", "ENVOY", "OTHER"]
  }

  dimension: store_plan_transmit_script {
    label: "Claim Plan Transmit Script"
    description: "Shell Script to run if Protocol is OTHER. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_SCRIPT ;;
  }

  dimension: store_plan_transmit_eligibility_claim_code {
    label: "Claim Plan Transmit Eligibility Claim Code"
    description: "Eligibility claim code value. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_ELIGIBILITY_CLAIM_CODE ;;
  }

  dimension: store_plan_transmit_rems_claim_format {
    label: "Claim Plan Transmit REMS Claim Format"
    description: "REMS On-Line Claim Transmittal Type. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_REMS_CLAIM_FORMAT ;;
  }

  dimension: store_plan_transmit_deleted {
    label: "Claim Plan Transmit Deleted"
    description: "Value that indicates if the record has been inserted/updated/deleted in the source table. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_DELETED ;;
  }

  #[ERXLPS-820] New dimensions created to display prescription transaction primary payer details across all claims.
  dimension: store_plan_transmit_bin_number_primary {
    label: "Primary Payer Plan BIN"
    description: "Primary Payer ANSI BIN (Bank Identification Number) number for claim transmittals. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_BIN_NUMBER ;;
  }

  dimension: store_plan_transmit_processor_control_number_primary {
    label: "Primary Payer Plan PCN"
    description: "Primary Payer Processor control number for claim transmittals. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_PROCESSOR_CONTROL_NUMBER ;;
  }

  #[ERXLPS-1618] New dimensions created to display prescription transaction secondary payer details across all claims.
  dimension: store_plan_transmit_bin_number_secondary {
    label: "Secondary Payer Plan BIN"
    description: "Secondary Payer ANSI BIN (Bank Identification Number) number for claim transmittals. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_BIN_NUMBER ;;
  }

  dimension: store_plan_transmit_processor_control_number_secondary {
    label: "Secondary Payer Plan PCN"
    description: "Secondary Payer Processor control number for claim transmittals. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_PROCESSOR_CONTROL_NUMBER ;;
  }

  #[ERXLPS-1438] - Adding set of dimension to get patient card plan details
  dimension: patient_card_plan_transmit_bin_number {
    label: "Patient Plan BIN"
    description: "ANSI BIN (Bank Identification Number) number associated with patient plan. This information is set in the patient’s plan file and may, or may not, be associated with a transaction. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_BIN_NUMBER ;;
  }

  dimension: patient_card_plan_transmit_processor_control_number {
    label: "Patient Plan PCN"
    description: "Processor control number associated with patient plan. This information is set in the patient’s plan file and may, or may not, be associated with a transaction. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_PROCESSOR_CONTROL_NUMBER ;;
  }

  dimension: patient_card_plan_transmit_bin_pcn {
    label: "Patient Plan BIN/PCN"
    description: "Concatenated value of BIN (Bank Identification Number) and PCN (Processor Control Number) associated with patient plan. This information is set in the patient’s plan file and may, or may not, be associated with a transaction. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: CASE WHEN ${store_plan_transmit_bin_number} IS NULL AND ${store_plan_transmit_processor_control_number} IS NULL THEN NULL ELSE CONCAT(CONCAT(NVL(REGEXP_REPLACE(${store_plan_transmit_bin_number}, '[[:space:]]*',''),''), '-'),NVL(REGEXP_REPLACE(${store_plan_transmit_processor_control_number}, '[[:space:]]*',''),'')) END ;;
  }

  #[ERXLPS-2383] - Created duplicate dimensions with different label names. Used to show Patient Plan Transmit information in explores.
  dimension: patient_plan_transmit_sequence_number {
    label: "Patient Plan Transmit Sequence Number"
    description: "Determines order of which sites the system transmits claims to. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: number
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_SEQUENCE_NUMBER ;;
  }

  dimension: patient_plan_transmit_billing_claim_format {
    label: "Patient Plan Transmit Billing Claim Format"
    description: "Claim format to be used when transmitting this claim electronically. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_BILLING_CLAIM_FORMAT ;;
  }

  dimension: patient_plan_transmit_site_code {
    label: "Patient Plan Transmit Site Code"
    description: "Site code that identifies which communication record should be used when transmitting a claim. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_SITE_CODE ;;
  }

  #[ERXDWPS-6646] - Added default value Unknown. Added bypass_suggest_restrictions : yes. Added drill down option to see the actual value.
  dimension: patient_plan_transmit_header_reference {
    label: "Patient Plan Transmit Header"
    description: "Transmit special header. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_HEADER ;;
  }

  dimension: patient_plan_transmit_header {
    label: "Patient Plan Transmit Header"
    description: "Transmit special header. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: etl_manager.fn_get_master_code_desc('STORE_PLAN_TRANSMIT_HEADER', ${TABLE}.STORE_PLAN_TRANSMIT_HEADER,'N') ;;
    drill_fields: [patient_plan_transmit_header_reference]
    suggestions: ["BLANK", "NDC", "NDC-PHS", "PACE", "MD MED"]
  }

  #[ERXDWPS-6646] - Added default value Unknown. Added bypass_suggest_restrictions : yes. Added drill down option to see the actual value.
  dimension: patient_plan_transmit_protocol_reference {
    label: "Patient Plan Transmit Protocol"
    description: "Communication protocol to use when transmitting a claim electronically. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_PROTOCOL ;;
  }

  dimension: patient_plan_transmit_protocol {
    label: "Patient Plan Transmit Protocol"
    description: "Communication protocol to use when transmitting a claim electronically. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: etl_manager.fn_get_master_code_desc('STORE_PLAN_TRANSMIT_PROTOCOL', ${TABLE}.STORE_PLAN_TRANSMIT_PROTOCOL,'N') ;;
    drill_fields: [patient_plan_transmit_protocol_reference]
    suggestions: ["VISA", "ENVOY", "OTHER"]
  }

  dimension: patient_plan_transmit_script {
    label: "Patient Plan Transmit Script"
    description: "Shell Script to run if Protocol is OTHER. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_SCRIPT ;;
  }

  dimension: patient_plan_transmit_eligibility_claim_code {
    label: "Patient Plan Transmit Eligibility Claim Code"
    description: "Eligibility claim code value. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_ELIGIBILITY_CLAIM_CODE ;;
  }

  dimension: patient_plan_transmit_rems_claim_format {
    label: "Patient Plan Transmit REMS Claim Format"
    description: "REMS On-Line Claim Transmittal Type. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    type: string
    sql: ${TABLE}.STORE_PLAN_TRANSMIT_REMS_CLAIM_FORMAT ;;
  }

  #[ERXLPS-2383] - Source timestamp dimension group crated and exposed in Patient - Central explore.
  dimension_group: patient_plan_transmit_last_update {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    label: "Patient Plan Transmit Last Update"
    description: "Date and time at which the record was last updated in the source application. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  dimension_group: patient_plan_transmit_source_create {
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    label: "Patient Plan Transmit Source Create"
    description: "Date/Time that the record was created. EPS Table Name: PLAN_TRANSMIT, PDX Table Name: PLAN"
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  ################################################################################################## End of Dimensions #########################################################################################

  set: explore_sales_candidate_list {
    fields: [store_plan_transmit_bin_number, store_plan_transmit_processor_control_number, store_plan_transmit_bin_pcn]
  }

  set: explore_sales_primary_payer_candidate_list {
    fields: [store_plan_transmit_bin_number_primary, store_plan_transmit_processor_control_number_primary]
  }

  set: explore_sales_secondary_payer_candidate_list {
    fields: [store_plan_transmit_bin_number_secondary, store_plan_transmit_processor_control_number_secondary]
  }

  #[ERXLPS-1438]
  set: explore_sales_patient_plan_candidate_list {
    fields: [patient_card_plan_transmit_bin_number, patient_card_plan_transmit_processor_control_number, patient_card_plan_transmit_bin_pcn]
  }

  set: explore_patient_plan_candidate_list {
    fields:
    [patient_plan_transmit_sequence_number,
      patient_plan_transmit_billing_claim_format,
      patient_plan_transmit_site_code,
      patient_card_plan_transmit_bin_number,
      patient_card_plan_transmit_processor_control_number,
      patient_card_plan_transmit_bin_pcn,
      patient_plan_transmit_header,
      patient_plan_transmit_protocol,
      patient_plan_transmit_script,
      patient_plan_transmit_eligibility_claim_code,
      patient_plan_transmit_rems_claim_format,
      #[ERXLPS-2383] Exposing source_timestamp in patient - central explore.
      patient_plan_transmit_last_update,
      patient_plan_transmit_last_update_time,
      patient_plan_transmit_last_update_date,
      patient_plan_transmit_last_update_week,
      patient_plan_transmit_last_update_month,
      patient_plan_transmit_last_update_month_num,
      patient_plan_transmit_last_update_year,
      patient_plan_transmit_last_update_quarter,
      patient_plan_transmit_last_update_quarter_of_year,
      patient_plan_transmit_last_update_hour_of_day,
      patient_plan_transmit_last_update_time_of_day,
      patient_plan_transmit_last_update_hour2,
      patient_plan_transmit_last_update_minute15,
      patient_plan_transmit_last_update_day_of_week,
      patient_plan_transmit_source_create_time,
      patient_plan_transmit_source_create_date,
      patient_plan_transmit_source_create_week,
      patient_plan_transmit_source_create_month,
      patient_plan_transmit_source_create_month_num,
      patient_plan_transmit_source_create_year,
      patient_plan_transmit_source_create_quarter,
      patient_plan_transmit_source_create_quarter_of_year,
      patient_plan_transmit_source_create_hour_of_day,
      patient_plan_transmit_source_create_time_of_day,
      patient_plan_transmit_source_create_hour2,
      patient_plan_transmit_source_create_minute15,
      patient_plan_transmit_source_create_day_of_week
    ]
  }
}
