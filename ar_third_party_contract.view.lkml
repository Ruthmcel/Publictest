view: ar_third_party_contract {
  sql_table_name: EDW.D_THIRD_PARTY_CONTRACT ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${third_party_contract_id} ;;
  }

  dimension: chain_id {
    type: number
    label: "Chain ID"
    description: "Identification number assigned to each customer chain by NHIN."
    hidden: yes
    sql: ${TABLE}.chain_id ;;
  }

  dimension: third_party_contract_id {
    type: number
    label: "Third Party Contract ID"
    description: "Unique ID number identifying this record"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_ID ;;
  }

  dimension: third_party_contract_termination_bankruptcy_type_id {
    type: number
    hidden: yes
    label: "Third Party Contract Termination Bankruptcy Type ID"
    description: "Contract timeframe for termination due to bankruptcy"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_BANKRUPTCY_TYPE_ID ;;
  }

  dimension: third_party_contract_termination_criminal_type_id {
    type: number
    hidden: yes
    label: "Third Party Contract Termination Criminal Type ID"
    description: "Contract timeframe for termination due to criminal circumstances"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_CRIMINAL_TYPE_ID ;;
  }

  dimension: third_party_contract_termination_dea_type_id {
    type: number
    hidden: yes
    label: "Third Party Contract Termination DEA Type ID"
    description: "Contract timeframe for termination due to DEA"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_DEA_TYPE_ID ;;
  }

  dimension: third_party_contract_termination_endangerment_type_id {
    type: number
    hidden: yes
    label: "Third Party Contract Termination Endangerment Type ID"
    description: "Contract timeframe for termination due to endangerment"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_ENDANGERMENT_TYPE_ID ;;
  }

  dimension: third_party_contract_termination_fail_to_pay_type_id {
    type: number
    hidden: yes
    label: "Third Party Contract Termination Fail to Pay Type ID"
    description: "Contract timeframe for termination due to a failure to pay"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_FAIL_TO_PAY_TYPE_ID ;;
  }

  dimension: third_party_contract_termination_fraud_type_id {
    type: number
    hidden: yes
    label: "Third Party Contract Termination Fraud Type ID"
    description: "Contract timeframe for termination due to fraud"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_FRAUD_TYPE_ID ;;
  }

  dimension: third_party_contract_termination_license_revoke_type_id {
    type: number
    hidden: yes
    label: "Third Party Contract Termination License Revoke Type ID"
    description: "Contract timeframe for termination due to a license revocation"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_LICENSE_REVOKE_TYPE_ID ;;
  }

  dimension: third_party_contract_termination_material_breach_type_id {
    type: number
    hidden: yes
    label: "Third Party Contract Termination Material Breach Type ID"
    description: "Contract timeframe for termination when a material breach occurred"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_MATERIAL_BREACH_TYPE_ID ;;
  }

  dimension: third_party_contract_termination_member_harm_type_id {
    type: number
    hidden: yes
    label: "Third Party Contract Termination Member Harm Type ID"
    description: "Contract timeframe for termination due to member harm"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_MEMBER_HARM_TYPE_ID ;;
  }

  dimension: third_party_contract_termination_neglect_type_id {
    type: number
    hidden: yes
    label: "Third Party Contract Termination Neglect Type ID"
    description: "Contract timeframe for termination due to neglect"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_NEGLECT_TYPE_ID ;;
  }

  dimension: third_party_contract_termination_refuse_service_type_id {
    type: number
    hidden: yes
    label: "Third Party Contract Termination Refuse Service Type ID"
    description: "Contract timeframe for termination due to refusal of service"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_REFUSE_SERVICE_TYPE_ID ;;
  }

  dimension: third_party_contract_termination_without_cause_type_id {
    type: number
    hidden: yes
    label: "Third Party Contract Termination Without Cause Type ID"
    description: "Contract timeframe for termination without cause"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_WITHOUT_CAUSE_TYPE_ID ;;
  }

  dimension: third_party_contract_termination_written_objection_type_id {
    type: number
    hidden: yes
    label: "Third Party Contract Termination Written Objection Type ID"
    description: "Contract timeframe for termination due to a written objection"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_WRITTEN_OBJECTION_TYPE_ID ;;
  }

  dimension: third_party_contract_amendment_amend_agreement_type_id {
    type: number
    hidden: yes
    label: "Third Party Contract Amendment Agreement Type ID"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_AMENDMENT_AMEND_AGREEMENT_TYPE_ID ;;
  }

  dimension: third_party_contract_amendment_modify_type_id {
    type: number
    hidden: yes
    label: "Third Party Contract Amendment Modify Type ID"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_AMENDMENT_MODIFY_TYPE_ID ;;
  }

  dimension: third_party_contract_contract_status_type_id {
    type: number
    hidden: yes
    label: "Third Party Contract Contract Status Type ID"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_CONTRACT_STATUS_TYPE_ID ;;
  }

  dimension: third_party_contract_added_user_identifer {
    type: number
    label: "Third Party Contract Added User Identifier"
    description: "User ID from when the Third Party Contract record was added to the Third Party Contract Table"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_ADDED_USER_IDENTIFER ;;
    value_format: "######"
  }

  dimension: third_party_contract_last_update_user_identifier {
    type: number
    label: "Third Party Contract Last Update User Identifier"
    description: "User ID from when the Third Party Contract record was last updated by a User"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_LAST_UPDATE_USER_IDENTIFIER ;;
  }

  dimension: third_party_contract_company_name {
    type: string
    label: "Third Party Contract Company Name"
    description: "Name of the company with which this contract record is associated"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_COMPANY_NAME ;;
  }

  dimension_group: third_party_contract_start_date {
    type: time
    label: "Third Party Contract Start"
    description: "Date/Time this Third Party Contract became effective"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_START_DATE ;;
  }

  dimension_group: third_party_contract_end_date {
    type: time
    label: "Third Party Contract End"
    description: "Date/Time this Third Party Contract was ended"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_END_DATE ;;
  }

  dimension_group: third_party_contract_date_signed {
    type: time
    label: "Third Party Contract Signed"
    description: "Date/Time the contract associate with this record was signed"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_DATE_SIGNED ;;
  }

  dimension_group: third_party_contract_deactivate_date {
    type: time
    label: "Third Party Contract Deactivate"
    description: "Date/Time this Third Party Contract was deactivated"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_DEACTIVATE_DATE ;;
  }


  dimension: third_party_contract_carrier_code {
    type: string
    label: "Third Party Contract Carrier Code"
    description: "Carrier Code of the Third Party Contract"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_CARRIER_CODE ;;
  }

  dimension: third_party_contract_plan_code {
    type: string
    label: "Third Party Contract Plan Code"
    description: "Plan Code of the Third Party Contract"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_PLAN_CODE ;;
  }

  dimension: third_party_contract_group_code {
    type: string
    label: "Third Party Contract Group Code"
    description: "Group Code of the Third Party Contract"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_GROUP_CODE ;;
  }

  dimension: third_party_contract_name {
    type: string
    label: "Third Party Contract Name"
    description: "Name assigned to this third party contract"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_NAME ;;
  }

  dimension: third_party_contract_signed_by_whom {
    type: string
    label: "Third Party Contract Signed by Whom"
    description: "Party that signed the contract associated with this record"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_SIGNED_BY_WHOM ;;
  }

  dimension: third_party_contract_fax_number {
    type: string
    label: "Third Party Contract Fax Number"
    description: "FAX Number for the company with which this contract record is associated"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_FAX_NUMBER ;;
    value_format: "(###) ###-####"
  }

  dimension: third_party_contract_phone_number {
    type: string
    label: "Third Party Contract Phone Number"
    description: "Telephone Number for the company with which this contract record is associated"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_PHONE_NUMBER ;;
    value_format: "(###) ###-####"
  }

  dimension: third_party_contract_address_line1 {
    type: string
    label: "Third Party Contract Address Line1"
    group_label: "Third Party Contract Address Info"
    description: "Address line 1 for the company with which this contract record is associated"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_ADDRESS_LINE1 ;;
  }

  dimension: third_party_contract_address_line2 {
    type: string
    label: "Third Party Contract Address Line2"
    group_label: "Third Party Contract Address Info"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_ADDRESS_LINE2 ;;
  }

  dimension: third_party_contract_city {
    type: string
    label: "Third Party Contract City"
    group_label: "Third Party Contract Address Info"
    description: "City for the company with which this contract record is associated"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_CITY ;;
  }

  dimension: third_party_contract_state {
    type: string
    label: "Third Party Contract Last Update User Identifier"
    group_label: "Third Party Contract Address Info"
    description: "State for the company with which this contract record is associated"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_STATE ;;
  }

  dimension: third_party_contract_zip_code {
    type: zipcode
    label: "Third Party Contract Zip Code"
    group_label: "Third Party Contract Address Info"
    description: "Postal Zip Code for the company with which this contract record is associated"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_ZIP_CODE ;;
  }

  dimension: third_party_contract_website_address {
    type: string
    label: "Third Party Contract Website Address"
    description: "Website URL for the company with which this contract record is associated"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_WEBSITE_ADDRESS ;;
  }


  dimension: third_party_contract_deleted {
    type: string
    hidden:  yes
    label: "Third Party Contract Deleted"
    description: "Third Party Contract Deleted"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_DELETED ;;
  }

  ################################################################################## Master code dimensions ################################################################################################

  dimension: third_party_contract_termination_material_breach_type_id_mc {
    type: string
    label: "Third Party Contract Termination Material Breach Type"
    description: "Contract timeframe for termination when a material breach occurred"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_MATERIAL_BREACH_TYPE_ID) ;;
    suggestions : ["90 DAYS","20 DAYS"]
    }

    dimension: third_party_contract_termination_without_cause_type_id_mc {
      type: string
      label: "Third Party Contract Termination Without Cause Type"
      description: "Contract timeframe for termination without cause"
      sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_WITHOUT_CAUSE_TYPE_ID) ;;
      suggestions : ["90 DAYS"]
  }

  dimension: third_party_contract_termination_written_objection_type_id_mc {
    type: string
    label: "Third Party Contract Termination Written Objection Type"
    description: "Contract timeframe for termination due to a written objection"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_WRITTEN_OBJECTION_TYPE_ID) ;;
    suggestions : ["90 DAYS","30 DAYS"]
  }

  dimension: third_party_contract_termination_fail_to_pay_type_id_mc {
    type: string
    label: "Third Party Contract Termination Fail to Pay Type"
    description: "Contract timeframe for termination due to a failure to pay"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_FAIL_TO_PAY_TYPE_ID) ;;
    suggestions : ["90 DAYS"]
  }

  dimension: third_party_contract_termination_license_revoke_type_id_mc {
    type: string
    label: "Third Party Contract Termination License Revoke Type"
    description: "Contract timeframe for termination due to a license revocation"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_LICENSE_REVOKE_TYPE_ID) ;;
    suggestions : ["90 DAYS","IMMEDIATE"]
  }

  dimension: third_party_contract_termination_fraud_type_id_mc {
    type: string
    label: "Third Party Contract Termination Fraud Type"
    description: "Contract timeframe for termination due to fraud"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_FRAUD_TYPE_ID) ;;
    suggestions : ["90 DAYS"]
  }

  dimension: third_party_contract_termination_neglect_type_id_mc {
    type: string
    label: "Third Party Contract Termination Neglect Type"
    description: "Contract timeframe for termination due to neglect"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_NEGLECT_TYPE_ID) ;;
    suggestions : ["90 DAYS"]
  }

  dimension: third_party_contract_termination_bankruptcy_type_id_mc {
    type: string
    label: "Third Party Contract Termination Bankruptcy Type"
    description: "Contract timeframe for termination due to bankruptcy"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_BANKRUPTCY_TYPE_ID) ;;
    suggestions : ["90 DAYS","IMMEDIATE"]
  }

  dimension: third_party_contract_termination_refuse_service_type_id_mc {
    type: string
    label: "Third Party Contract Termination Refuse Service Type"
    description: "Contract timeframe for termination due to refusal of service"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_REFUSE_SERVICE_TYPE_ID) ;;
    suggestions : ["90 DAYS","IMMEDIATE"]
  }

  dimension: third_party_contract_termination_dea_type_id_mc {
    type: string
    label: "Third Party Contract Termination DEA Type"
    description: "Contract timeframe for termination due to DEA"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_DEA_TYPE_ID) ;;
    suggestions : ["90 DAYS","IMMEDIATE"]
  }

  dimension: third_party_contract_termination_member_harm_type_id_mc {
    type: string
    label: "Third Party Contract Termination Member Harm Type"
    description: "Contract timeframe for termination due to member harm"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_MEMBER_HARM_TYPE_ID) ;;
    suggestions : ["90 DAYS"]
  }

  dimension: third_party_contract_termination_criminal_type_id_mc {
    type: string
    label: "Third Party Contract Termination Criminal Type"
    description: "Contract timeframe for termination due to criminal circumstances"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_CRIMINAL_TYPE_ID) ;;
    suggestions : ["90 DAYS"]
  }

  dimension: third_party_contract_termination_endangerment_type_id_mc {
    type: string
    label: "Third Party Contract Termination Endangerment Type"
    description: "Contract timeframe for termination due to endangerment"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.THIRD_PARTY_CONTRACT_TERMINATION_ENDANGERMENT_TYPE_ID) ;;
    suggestions : ["90 DAYS"]
  }

  dimension: third_party_contract_contract_status_type_id_mc {
    type: string
    label: "Third Party Contract Contract Status Type"
    description: "Contract Status Type"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${TABLE}.THIRD_PARTY_CONTRACT_CONTRACT_STATUS_TYPE_ID) ;;
    suggestions : ["ACTIVE"]
  }

#################################################################################### Measure  ##############################################################################################################


  measure: count {
    type: count
    label: "Total Third Party Contracts"
    value_format: "#,##0;(#,##0)"
  }

#################################################################################### EDW Metadata Fields  ##############################################################################################################


  dimension: lcr_id {
    type: number
    hidden:  yes
    label: "Contract Rate LCR ID"
    description: "Unique ID populated in the stage table during the data load process that identifies the record"
    sql: ${TABLE}.THIRD_PARTY_CONTRACT_LCR_ID ;;
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
}
