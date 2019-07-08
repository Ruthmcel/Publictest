view: eps_rx_tx {
  #[ERX-6185]
  sql_table_name:
  {% if _explore._name == 'eps_workflow_order_entry_rx_tx' %}
    {% assign active_archive_filter_input_value = eps_rx_tx.active_archive_filter_input._sql | slice: 1,7 | downcase %}
    {% if active_archive_filter_input_value == 'archive'  %}
      EDW.F_RX_TX_LINK_ARCHIVE
    {% else %}
      EDW.F_RX_TX_LINK
    {% endif %}
  {% else %}
    EDW.F_RX_TX_LINK
  {% endif %}
  ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_id} ;; #ERXLPS-1649
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

  dimension: rx_tx_id {
    label: "Prescription Transaction ID"
    description: "Unique ID number identifying a transanction record within a pharmacy chain"
    type: number
    sql: ${TABLE}.RX_TX_ID ;;
  }

  dimension: rx_id {
    label: "Prescription ID"
    description: "Unique ID number identifying an Prescription record within a pharmacy chain"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_ID ;;
  }

  dimension: rx_tx_basecost_id {
    label: "Prescription Basecost ID"
    description: "Unique ID number identifying an Basecost record within a pharmacy chain"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_BASECOST_ID ;;
  }

  dimension: rx_tx_completion_rx_tx_id {
    label: "Prescription Transaction Completion Fill ID"
    description: "Unique Prescription Transaction ID number identifying an completion fill Prescription Transaction record of a partially filled transaction within a pharmacy chain"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_COMPLETION_RX_TX_ID ;;
  }

  dimension: rx_tx_partial_rx_tx_id {
    label: "Prescription Transaction Partial Fill ID"
    description: "Unique Prescription Transaction ID number of the partial fill Prescription Transaction record of a partially filled transaction within a pharmacy chain"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_PARTIAL_RX_TX_ID ;;
  }

  dimension: rx_tx_compound_id {
    label: "Prescription Transaction Compound ID"
    description: "Unique ID that links this record to a specific COMPOUND record, if this prescription is filled for a compound within a pharmacy chain"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_COMPOUND_ID ;;
  }

  dimension: rx_tx_discount_id {
    label: "Prescription Transaction Discount ID"
    description: "Unique ID of the Discount Code that was used during pricing this transaction within a pharmacy chain"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_DISCOUNT_ID ;;
  }

  dimension: rx_tx_drug_brand_id {
    label: "Prescription Transanction Drug Brand ID"
    description: "Unique ID that links this record to a specific DRUG record, which identifies the Brand drug selected for this transaction within a pharmacy chain"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_DRUG_BRAND_ID ;;
  }

  dimension: rx_tx_drug_generic_id {
    label: "Prescription Transanction Drug Generic ID"
    description: "Unique ID that links this record to a specific DRUG record, which identifies the Generic drug selected for this transaction within a pharmacy chain"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_DRUG_GENERIC_ID ;;
  }

  dimension: rx_tx_reference_brand_id {
    label: "Prescription Transaction Reference Brand ID"
    description: "Unique ID of the brand drug record used when Brand % Pricing is used to price the transaction within a pharmacy chain"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_REFERENCE_BRAND_ID ;;
  }

  #[ERX-3940]- Added as a part of EDW Performance Improvement for Reports - eps_rx_tx dimensions Search & Joins in Looker US
  # ERXLPS-1351 - Search and replace all view files to use EDW materialized columns from RX_TX_LINK
  dimension: rx_tx_drug_id {
    label: "Prescription Transaction Drug ID"
    type: string
    hidden: yes
    sql: ${TABLE}.RX_TX_DRUG_DISPENSED_ID ;;
  }

  # [ERX-2586] created this dimension for join with Hist tables
  #[ERX-3940]- Added as a part of EDW Performance Improvement for Reports - eps_rx_tx dimensions Search & Joins in Looker US
  # ERXLPS-1351 - Search and replace all view files to use EDW materialized columns from RX_TX_LINK
  dimension: rx_tx_drug_id_hist {
    label: "Prescription Transaction Drug ID"
    type: string
    hidden: yes
    sql: ${TABLE}.RX_TX_DRUG_DISPENSED_ID ;;
  }

  dimension: rx_tx_drug_cost_type_id {
    label: "Prescription Transaction Drug Cost Type ID"
    description: "Unique ID that links this transaction to a specific DRUG COST TYPE  record within a pharmacy chain.  This is the Cost Base that pricing used to price this transaction"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_DRUG_COST_TYPE_ID ;;
  }

  dimension: rx_tx_tax_id {
    label: "Prescription Transaction Tax ID"
    description: "Unique ID that links this record to a specific TAX record within a pharmacy chain"
    type: string
    hidden: yes
    sql: ${TABLE}.RX_TX_TAX_ID ;;
  }

  dimension: rx_tx_returned_user_id {
    label: "Prescription Transaction Returned User ID"
    description: "Unique ID that links this record to the specific USER record, indicating the user who performed a credit return on this transaction within a pharmacy chain"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_RETURNED_USER_ID ;;
  }

  dimension: rx_tx_override_user_id {
    label: "Prescription Transaction Override User ID"
    description: "Unique ID that links this record to the specific USER record, indicating the person who performed a price override on this transaction within a pharmacy chain"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_OVERRIDE_USER_ID ;;
  }

  dimension: rx_tx_price_code_id {
    label: "Prescription Transaction Price Code ID"
    description: "Unique ID number identifying an prescription record within a pharmacy chain"
    type: string
    hidden: yes
    sql: ${TABLE}.RX_TX_PRICE_CODE_ID ;;
  }

  dimension: rx_tx_ltc_facility_id {
    label: "Prescription Transaction LTC Facility ID"
    description: "Unique ID number identifying the Long Term Care Facility that the patient was assigned to at the time of the transaction within a pharmacy chain"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_LTC_FACILITY_ID ;;
  }

  dimension: rx_tx_price_override_note_id {
    label: "Prescription Transaction Override Notes ID"
    description: "Unique ID that links this transaction to a specific NOTE record, textually describing the reason that the user chose to override the price of this transaction within a pharmacy chain"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_PRICE_OVERRIDE_NOTE_ID ;;
  }

  dimension: rx_tx_rph_counsel_notes_id {
    label: "Prescription Transaction Counsel Notes ID"
    description: "Unique ID that identifies notes that were saved from the Tools --> Pharmacist Counsel screen. Used to document any additional notes during the required counseling of a patient within a pharmacy chain"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_RPH_COUNSEL_NOTES_ID ;;
  }

  dimension: rx_tx_shipment_id {
    label: "Prescription Transaction Shipment ID"
    description: "Unique ID indicating the ID of the Shipment (from the Shipment table) that the Prescription was included in within a pharmacy chain"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_SHIPMENT_ID ;;
  }

  dimension: rx_tx_patient_disease_id {
    label: "Prescription Transaction Patient Disease ID"
    description: "Unique ID that links this record to a specific PATIENT DISEASE record for this transanction within a pharmacy chain"
    type: string
    hidden: yes
    sql: ${TABLE}.RX_TX_PATIENT_DISEASE_ID ;;
  }

  dimension: rx_tx_sup_presc_clinic_link_id {
    label: "Prescription Transaction Supervising Prescriber Clinic Link ID"
    description: "Unique ID that links this record to a specific PRESCRIBER CLINIC LINK record, which identifies the Supervising Prescriber for this transaction within a pharmacy chain"
    type: string
    hidden: yes
    sql: ${TABLE}.RX_TX_SUP_PRESC_CLINIC_LINK_ID ;;
  }

  dimension: rx_tx_presc_clinic_link_id {
    label: "Prescription Transaction Clinic Link ID"
    description: "Unique ID that links this record to a specific PRESCRIBER_CLINIC_LINK record, which identifies the Prescriber for this transaction for this transaction within a pharmacy chain"
    type: string
    hidden: yes
    sql: ${TABLE}.RX_TX_PRESC_CLINIC_LINK_ID ;;
  }

  #[ERXLPS-743] Dimensions referenced in other views. Currently referenced in sales view.
  dimension: rx_tx_tx_status_reference {
    type: string
    hidden: yes
    sql: ${TABLE}.RX_TX_TX_STATUS ;;
  }

  dimension: rx_tx_partial_fill_status_reference {
    type: string
    hidden: yes
    sql: ${TABLE}.RX_TX_PARTIAL_FILL_STATUS ;;
  }

  dimension: source_system_id {
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  #[ERXDWPS-6802][ERXDWPS-9844]
  dimension: is_active {
    hidden: yes
    type: string
    sql: ${TABLE}.IS_ACTIVE ;;
  }

  ################################################################################################# End of Foreign Key References #####################################################################################

  filter: is_on_time_filter {
    label: "On Time Will Call Arrival Goal"
    description: "Enter the time goal (in minutes) to be equal to or less than, for the duration of time from the Prescription Transaction Start time, to the time of arrival in Will Call."
    type: string
  }

  ########################################################################################################## Dimensions ##############################################################################################

  dimension: rx_tx_tx_number {
    label: "Prescription TX Number"
    description: "Transaction number"
    type: number
    sql: ${TABLE}.RX_TX_TX_NUMBER ;;
    value_format: "######"
  }

  dimension: rx_tx_refill_number {
    label: "Prescription Refill Number"
    description: "Refill number of the transaction"
    type: number
    sql: ${TABLE}.RX_TX_REFILL_NUMBER ;;
    value_format: "#,##0"
  }

  dimension: rx_tx_counseling_rph_employee_number {
    label: "Prescription Counseling Rph Employee Number"
    description: "Employee Number of the Pharmacist that completed the RPh Counseling task for a prescription"
    type: string
    sql: ${TABLE}.RX_TX_COUNSELING_RPH_EMPLOYEE_NUMBER ;;
  }

  dimension: rx_tx_counseling_rph_initials {
    label: "Prescription Counseling Rph Initials"
    description: "Pharmacist of Record initials on POS system"
    type: string
    sql: ${TABLE}.RX_TX_COUNSELING_RPH_INITIALS ;;
  }

  dimension: rx_tx_ddid_used_by_drug_selection {
    label: "Prescription DDID Used By Drug Selection"
    description: "DDID used by automatic drug selection for a particular fill"
    type: number
    sql: ${TABLE}.RX_TX_DDID_USED_BY_DRUG_SELECTION ;;
    value_format: "######"
  }

  dimension: rx_tx_de_initials {
    label: "Prescription DE Initials"
    description: "Initials of the user who performed Data Entry on this transaction"
    type: string
    sql: ${TABLE}.RX_TX_DE_INITIALS ;;
  }

  dimension: rx_tx_dob_override_employee_number {
    label: "Prescription DOB Override Employee Number"
    description: "Employee Number of the individual that completed the Override of the DOB during DOB verification prompted at will call screen"
    type: string
    sql: ${TABLE}.RX_TX_DOB_OVERRIDE_EMPLOYEE_NUMBER ;;
  }

  dimension: rx_tx_dob_override_reason_id {
    label: "Prescription DOB Override Reason ID"
    description: "ID for the reason of the Override of the DOB during DOB verification prompted at will call screen"
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_DOB_OVERRIDE_REASON_ID ;;
  }

  dimension: rx_tx_dv_initials {
    label: "Prescription DV Initials"
    description: "Initials of the user who performed Data Verification on this transaction"
    type: string
    sql: ${TABLE}.RX_TX_DV_INITIALS ;;
  }

  dimension: rx_tx_epr_synch_version {
    label: "Prescription EPR Synch Version"
    description: "EPS version when the EPS SYNC occurs and EPR sends a successful response"
    type: string
    sql: ${TABLE}.RX_TX_EPR_SYNCH_VERSION ;;
  }

  dimension: rx_tx_gpi_used_by_drug_selection {
    label: "Prescription GPI Used By Drug Selection"
    description: "Prescribed Drug GPI used by automatic drug selection for a particular fill"
    type: string
    sql: ${TABLE}.RX_TX_GPI_USED_BY_DRUG_SELECTION ;;
  }

  dimension: rx_tx_mobile_services_channel {
    label: "Prescription Mobile Services Channel"
    description: "Route that refills are coming into the system. Via IVR or mobile device, Mobile App, Text, Epharm, Email, etc"
    type: string
    sql: ${TABLE}.RX_TX_MOBILE_SERVICES_CHANNEL ;;
  }

  dimension: rx_tx_new_ddid_authorized_by_emp_number {
    label: "Prescription New DDID Authorized By Emp Number"
    description: "Employee Number of the user who authorized the use of the new DDID for this fill"
    type: string
    sql: ${TABLE}.RX_TX_NEW_DDID_AUTHORIZED_BY_EMP_NUMBER ;;
  }

  dimension: rx_tx_pos_invoice_number {
    label: "Prescription POS Invoice Number"
    description: "The invoice number from the POS system"
    type: number
    sql: ${TABLE}.RX_TX_POS_INVOICE_NUMBER ;;
    value_format: "######"
  }

  dimension: rx_tx_pos_reason_for_void {
    label: "Prescription POS Reason For Void"
    description: "Reason that a POS sold transaction was unsold or voided"
    type: string
    sql: ${TABLE}.RX_TX_POS_REASON_FOR_VOID ;;
  }

  dimension: rx_tx_pv_employee_number {
    label: "Prescription PV Employee Number"
    description: "Employee Number of the person who completed Product Verification"
    type: string
    sql: ${TABLE}.RX_TX_PV_EMPLOYEE_NUMBER ;;
  }

  dimension: rx_tx_register_number {
    label: "Prescription Register Number"
    description: "Register number where the prescription was sold"
    type: string
    sql: ${TABLE}.RX_TX_REGISTER_NUMBER ;;
  }

  ###################################################################################################End of Dimensions ################################################################################################

  ########################################################################################### YES/NO & CASE WHEN fields ###############################################################################################
  # ERXLPS-1351 Search and replace all view files to use EDW materialized columns from RX_TX_LINK
  dimension: rx_tx_active {
    label: "Prescription Transaction Active"
    description: "Yes/No Flag indicating if the transaction is active"
    type: yesno
    sql: NVL(${TABLE}.RX_TX_TX_STATUS,'Y') = 'Y' AND  DECODE(${TABLE}.RX_TX_RETURNED_DATE,NULL,${TABLE}.RX_TX_ACQUISITION_COST,0) IS NOT NULL AND ${TABLE}.RX_TX_FILL_STATUS IS NOT NULL AND ${TABLE}.RX_TX_FILL_QUANTITY IS NOT NULL AND DECODE(${TABLE}.RX_TX_RETURNED_DATE,NULL,${TABLE}.RX_TX_PRICE,NVL(${TABLE}.RX_TX_ORIGINAL_PRICE,0)) IS NOT NULL ;;
  }

  dimension: rx_tx_tx_status {
    label: "Prescription Transaction Status"
    description: "Status of the Transaction. Normal, Cancelled, Credit Returned, Hold, and Replacement"
    type: string

    case: {
      when: {
        sql: NVL(${TABLE}.RX_TX_TX_STATUS,'Y') = 'Y' ;;
        label: "NORMAL"
      }

      when: {
        sql: ${TABLE}.RX_TX_TX_STATUS = 'N' ;;
        label: "CANCELLED"
      }

      when: {
        sql: ${TABLE}.RX_TX_TX_STATUS = 'C' ;;
        label: "CREDIT RETURNED"
      }

      when: {
        sql: ${TABLE}.RX_TX_TX_STATUS = 'H' ;;
        label: "HOLD"
      }

      when: {
        sql: ${TABLE}.RX_TX_TX_STATUS = 'R' ;;
        label: "REPLACEMENT"
      }
    }
  }

  dimension: rx_tx_fill_status {
    label: "Prescription Fill Status"
    description: "Indicates the type of transaction. New prescription transaction, Refill transaction and Non-filled, Cognitive service transaction"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_FILL_STATUS = 'N' ;;
        label: "NEW PRESCRIPTION"
      }

      when: {
        sql: ${TABLE}.RX_TX_FILL_STATUS = 'R' ;;
        label: "REFILL"
      }

      when: {
        sql: ${TABLE}.RX_TX_FILL_STATUS = 'F' ;;
        label: "NON FILLED COGNITIVE"
      }

      when: {
        sql: true ;;
        label: "NOT SPECIFIED"
      }
    }
  }

  dimension: rx_tx_drug_dispensed {
    label: "Prescription Drug Dispensed"
    description: "Indicates the type of drug dispensed. Brand, Generic, Compound"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_DRUG_DISPENSED = 'B' ;;
        label: "BRAND"
      }

      when: {
        sql: ${TABLE}.RX_TX_DRUG_DISPENSED = 'G' ;;
        label: "GENERIC"
      }

      when: {
        sql: ${TABLE}.RX_TX_DRUG_DISPENSED = 'C' ;;
        label: "COMPOUND"
      }

      when: {
        sql: true ;;
        label: "NOT SPECIFIED"
      }
    }
  }

  dimension: on_time {
    label: "Promise Time Variance"
    description: "This is the difference between 'Will Call Arrival Time' and 'Promise Time' for a Prescription Transaction for a Pharmacy Chain"
    type: number
    sql: DATEDIFF(MINUTE,${eps_order_entry.order_entry_promised_time},${will_call_arrival_time}) ;;
    value_format: "#,##0 \" Min\""
    html: {% if value <= 0 %}
        <b><p style="color: green; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
      {% else %}
        <b><p style="color: red; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
      {% endif %}
      ;;
  }

  dimension: is_on_time {
    label: "On Time"
    description: "Flag indicating if the prescription orders met the promised time, based on when the transanction reaches Will Call"
    type: string

    case: {
      when: {
        sql: ${on_time} <= 0 ;;
        label: "Yes"
      }

      when: {
        sql: ${on_time} > 0 ;;
        label: "No"
      }

      when: {
        sql: ${on_time} IS NULL ;;
        label: "TX Yet to Arrive WC"
      }
    }
  }

  dimension: is_on_time_fifteen {
    label: "On Time Will Call Arrival Goal (Yes/No)"
    description: "Yes/No flag indicating if a Prescription Transaction arrives in Will Call in allotted time, based on 'On Time Will Call Arrival Goal'.  Undetermined represents Prescription Transactions we are unable to calculate due to NULL dates"
    type: string

    case: {
      when: {
        sql: ${prescription_fill_duration} <= NVL(TO_NUMBER( DECODE ( REGEXP_REPLACE( {% parameter is_on_time_filter %}, '[^0-9]+', ''), '', NULL, REGEXP_REPLACE( {% parameter is_on_time_filter %}, '[^0-9]+', '') ) ), 15) ;;
        label: "Yes"
      }

      when: {
        sql: ${prescription_fill_duration} > NVL(TO_NUMBER( DECODE ( REGEXP_REPLACE( {% parameter is_on_time_filter %}, '[^0-9]+', ''), '', NULL, REGEXP_REPLACE( {% parameter is_on_time_filter %}, '[^0-9]+', '') ) ), 15) ;;
        label: "No"
      }

      when: {
        sql: true ;;
        label: "Undetermined"
      }
    }
  }

  dimension: bi_demo_is_on_time_fifteen {
    label: "On Time Will Call Arrival Goal (Yes/No)"
    description: "Yes/No flag indicating if a Prescription Transaction arrives in Will Call in allotted time, based on 'On Time Will Call Arrival Goal'.  Undetermined represents Prescription Transactions we are unable to calculate due to NULL dates"
    type: string

    case: {
      when: {
        sql: ${bi_demo_prescription_fill_duration} <= NVL(TO_NUMBER( DECODE ( REGEXP_REPLACE( {% parameter is_on_time_filter %}, '[^0-9]+', ''), '', NULL, REGEXP_REPLACE( {% parameter is_on_time_filter %}, '[^0-9]+', '') ) ), 15) ;;
        label: "Yes"
      }

      when: {
        sql: ${bi_demo_prescription_fill_duration} > NVL(TO_NUMBER( DECODE ( REGEXP_REPLACE( {% parameter is_on_time_filter %}, '[^0-9]+', ''), '', NULL, REGEXP_REPLACE( {% parameter is_on_time_filter %}, '[^0-9]+', '') ) ), 15) ;;
        label: "No"
      }

      when: {
        sql: true ;;
        label: "Undetermined"
      }
    }
  }

  dimension: rx_tx_admin_rebilled {
    label: "Prescription Admin Rebilled"
    description: "Yes/No flag indicating if the prescription has been admin rebilled"
    type: yesno
    sql: ${TABLE}.RX_TX_ADMIN_REBILLED = 'Y' ;;
  }

  dimension: rx_tx_allow_price_override {
    label: "Prescription Allow Price Override"
    description: "Yes/No flag indicating if a price override can be performed on this transaction"
    type: yesno
    sql: NVL(${TABLE}.RX_TX_ALLOW_PRICE_OVERRIDE,'Y') = 'Y' ;;
  }

  dimension: rx_tx_brand_manually_selected {
    label: "Precription Brand Manually Selected"
    description: "Yes/No flag indicating if the Brand drug was manually selected rather than being selected through auto drug selection"
    type: yesno
    sql: ${TABLE}.RX_TX_BRAND_MANUALLY_SELECTED = 'Y' ;;
  }

  dimension: rx_tx_competitive_priced {
    label: "Prescription Competitive Priced"
    description: "Yes/No flag indicating if competitive pricing was used when transaction was priced"
    type: yesno
    sql: ${TABLE}.RX_TX_COMPETITIVE_PRICED = 'Y' ;;
  }

  dimension: rx_tx_controlled_substance_escript {
    label: "Prescription Controlled Substance Escript"
    description: "Yes/No flag indicating if prescription was generated from a controlled substance escript. Used to identify prescriptions for auditing and prescription edits requirements"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_CONTROLLED_SUBSTANCE_ESCRIPT = 'N' ;;
        label: "Not Controlled Substance"
      }

      when: {
        sql: true ;;
        label: "Yes"
      }
    }
  }

  dimension: rx_tx_custom_sig {
    label: "Prescription Custom SIG"
    description: "Yes/No flag indicating if SIG is a custom SIG. This means that the user typed the SIG manually or they used a SIG code and manually added additional SIG text"
    type: yesno
    sql: ${TABLE}.RX_TX_CUSTOM_SIG = 'Y' ;;
  }

  dimension: rx_tx_different_generic {
    label: "Prescription Different Generic"
    description: "Yes/No flag indicating if a different generic drug was used for this fill from the previous fill"
    type: yesno
    sql: ${TABLE}.RX_TX_DIFFERENT_GENERIC = 'Y' ;;
  }

  dimension: rx_tx_fill_location {
    label: "Prescription Fill Location"
    description: "Flag that identifies where this transaction was filled"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_FILL_LOCATION = 'A' ;;
        label: "ACS System"
      }

      when: {
        sql: ${TABLE}.RX_TX_FILL_LOCATION = 'L' ;;
        label: "Local Pharmacy"
      }

      when: {
        sql: ${TABLE}.RX_TX_FILL_LOCATION = 'M' ;;
        label: "Mail Order"
      }

      when: {
        sql: ${TABLE}.RX_TX_FILL_LOCATION = 'C' ;;
        label: "Central Fill"
      }

      when: {
        sql: true ;;
        label: "Unknown"
      }
    }
  }

  dimension: rx_tx_generic_manually_selected {
    label: "Prescription Generic Manually Selected"
    description: "Yes/No flag indicating if the Generic drug was manually selected rather than being selected through auto drug selection"
    type: yesno
    sql: ${TABLE}.RX_TX_GENERIC_MANUALLY_SELECTED = 'Y' ;;
  }

  dimension: rx_tx_keep_same_drug {
    label: "Prescription Keep Same Drug"
    description: "Yes/No flag indicating if the same drug should be used for each refill of a prescription"
    type: yesno
    sql: ${TABLE}.RX_TX_KEEP_SAME_DRUG = 'Y' ;;
  }

  dimension: rx_tx_manual_acquisition_drug_dispensed {
    label: "Prescription Manual Acquisition Drug Dispensed"
    description: "Yes/No flag indicating if, at the time the transaction was processed, the Dispensed Drug was identified as a Manual ACQ Drug. This would imply that the ACQ used to price the prescription was manually entered before pricing was done."
    type: yesno
    sql: ${TABLE}.RX_TX_MANUAL_ACQUISITION_DRUG_DISPENSED = 'Y' ;;
  }

  dimension: rx_tx_medicare_notice {
    label: "Prescription Medicare Notice"
    description: "Yes/No flag indicating if approval code or reject code were received in the response from the PBM and that the patient should be given a Medicare Rights Notice"
    type: yesno
    sql: ${TABLE}.RX_TX_MEDICARE_NOTICE = 'Y' ;;
  }

  dimension: rx_tx_no_sales_tax {
    label: "Prescription No Sales Tax"
    description: "Yes/No flag indicating if the patient associated with this transaction is flagged as tax exempt"
    type: yesno
    sql: ${TABLE}.RX_TX_NO_SALES_TAX = 'Y' ;;
  }

  dimension: rx_tx_otc_taxable_indicator {
    label: "Prescription OTC Taxable Indicator"
    description: "Yes/No flag indicating if the OTC drug is taxable"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_OTC_TAXABLE_INDICATOR = 'Y' ;;
        label: "Yes Taxable"
      }

      when: {
        sql: true ;;
        label: "Not Taxable"
      }
    }
  }

  dimension: rx_tx_patient_request_brand_generic {
    label: "Prescription Patient Request Brand Generic"
    description: "Flag to identify that a patient has specifically requested the brand or generic when requesting their prescription be filled"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_PATIENT_REQUEST_BRAND_GENERIC = 'B' ;;
        label: "Brand"
      }

      when: {
        sql: ${TABLE}.RX_TX_PATIENT_REQUEST_BRAND_GENERIC = 'G' ;;
        label: "Generic"
      }

      when: {
        sql: true ;;
        label: "Not Specified"
      }
    }
  }

  dimension: rx_tx_patient_requested_price {
    label: "Prescription Patient Requested Price"
    description: "Yes/No flag indicating if the patient requested a specific price for this transaction in Order Entry"
    type: yesno
    sql: ${TABLE}.RX_TX_PATIENT_REQUESTED_PRICE = 'Y' ;;
  }

  dimension: rx_tx_pickup_signature_not_required {
    label: "Prescriber Pickup Signature Not Required"
    description: "flag that marks the transaction as 'Y' Yes, it needs, or 'N', No it does not need a pickup signature due to the plan setting at the time it was sold"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_PICKUP_SIGNATURE_NOT_REQUIRED = 'Y' ;;
        label: "Yes Required"
      }

      when: {
        sql: true ;;
        label: "Not Required"
      }
    }
  }

  dimension: rx_tx_price_override_reason {
    label: "Prescription Price Override Reason"
    description: "Reason that the user chose to override the price of this transaction"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_PRICE_OVERRIDE_REASON = '0' ;;
        label: "Other"
      }

      when: {
        sql: ${TABLE}.RX_TX_PRICE_OVERRIDE_REASON = '1' ;;
        label: "Match Compete Price"
      }

      when: {
        sql: ${TABLE}.RX_TX_PRICE_OVERRIDE_REASON = '2' ;;
        label: "Match Quote"
      }

      when: {
        sql: ${TABLE}.RX_TX_PRICE_OVERRIDE_REASON = '3' ;;
        label: "Match Previous Fill"
      }

      when: {
        sql: ${TABLE}.RX_TX_PRICE_OVERRIDE_REASON = '4' ;;
        label: "Pricing Error"
      }

      when: {
        sql: true ;;
        label: "Not Performed"
      }
    }
  }

  # ERXLPS-643 - Add yes no flag for price overrides
  dimension: rx_tx_price_override_yesno {
    label: "Prescription Price Override"
    description: "Yes/No Flag indicating if a price override was performed on this transaction"
    type: yesno
    sql: ${TABLE}.RX_TX_PRICE_OVERRIDE_REASON IS NOT NULL ;;
  }

  dimension: rx_tx_refill_source {
    label: "Prescription Refill Source"
    description: "Flag represents the process that initiated the creation of this Prescription Transaction record"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '0' ;;
        label: "IVR"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '1' ;;
        label: "Fax"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '2' ;;
        label: "Auto-fill"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '3' ;;
        label: "N/H Batch"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '4' ;;
        label: "N/H unit Dose Billing"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '5' ;;
        label: "Call-In(Non_IVR)"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '6' ;;
        label: "Walk-up"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '7' ;;
        label: "Drive-up"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '8' ;;
        label: "Order Entry"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '9' ;;
        label: "eScript"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '10' ;;
        label: "WS EPHARM"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '11' ;;
        label: "WS IVR"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '12' ;;
        label: "ePharm"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '13' ;;
        label: "Mobile Service Provider"
      }

      when: {
        sql: true ;;
        label: "Not A Refill"
      }
    }
  }

  dimension: rx_tx_relationship_to_patient {
    label: "Prescription Relationship To Patient"
    description: "Relationship of the person dropping off or picking up the Rx, on behalf of the patient/customer"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_RELATIONSHIP_TO_PATIENT = '01' ;;
        label: "Patient"
      }

      when: {
        sql: ${TABLE}.RX_TX_RELATIONSHIP_TO_PATIENT = '02' ;;
        label: "Parent/Legal Guardian"
      }

      when: {
        sql: ${TABLE}.RX_TX_RELATIONSHIP_TO_PATIENT = '03' ;;
        label: "Spouse"
      }

      when: {
        sql: ${TABLE}.RX_TX_RELATIONSHIP_TO_PATIENT = '04' ;;
        label: "Caregiver"
      }

      when: {
        sql: ${TABLE}.RX_TX_RELATIONSHIP_TO_PATIENT = '99' ;;
        label: "Other"
      }

      when: {
        sql: true ;;
        label: "Not Specified"
      }
    }
  }

  dimension: rx_tx_require_relation_to_patient {
    label: "Prescription Require Relation To Patient"
    description: "Flag to identify if the relationship of the person picking up or dropping off the Rx on behalf of the customer still needs to be collected"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_REQUIRE_RELATION_TO_PATIENT = 'Y' ;;
        label: "Yes Need Data"
      }

      when: {
        sql: ${TABLE}.RX_TX_REQUIRE_RELATION_TO_PATIENT = 'N' ;;
        label: "No Data Not Needed"
      }

      when: {
        sql: ${TABLE}.RX_TX_REQUIRE_RELATION_TO_PATIENT = 'D' ;;
        label: "Data Acquired"
      }

      when: {
        sql: true ;;
        label: "Not Specified"
      }
    }
  }

  dimension: rx_tx_rx_com_down {
    label: "Prescription RXCOM Down"
    description: "Flag that indicates that the RX_TX record was added while communication to the Central Patient database was down, and a patient select has not occured"
    type: yesno
    sql: ${TABLE}.RX_TX_RX_COM_DOWN = 'Y' ;;
  }

  dimension: rx_tx_rx_stolen {
    label: "Prescription Stolen"
    description: "Yes/No flag indicating if the prescription has been marked as stolen"
    type: yesno
    sql: ${TABLE}.RX_TX_RX_STOLEN = 'Y' ;;
  }

  dimension: rx_tx_sent_to_ehr {
    label: "Prescription Sent To EHR"
    description: "Yes/No flag indicating if the transaction has been sent EHR (Set by the application when the record is sent to EHR)"
    type: yesno
    sql: ${TABLE}.RX_TX_SENT_TO_EHR = 'Y' ;;
  }

  dimension: rx_tx_specialty_pa {
    label: "Prescription Specialty PA"
    description: "Yes/No flag indicating if the drug marked as a specialty drug, is to be used for the specialty prior authorization services"
    type: yesno
    sql: ${TABLE}.RX_TX_SPECIALTY_PA = 'Y' ;;
  }

  dimension: rx_tx_specialty_pa_status {
    label: "Prescription Specialty PA Status"
    description: "Status used to determine where the order is in the specialty prior authorization communication process, from the time it leaves EPS for billing analysis to the time it comes back to the store for filling"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_SPECIALTY_PA_STATUS = '1' ;;
        label: "Specialty Sent"
      }

      when: {
        sql: ${TABLE}.RX_TX_SPECIALTY_PA_STATUS = '2' ;;
        label: "Specialty Received"
      }

      when: {
        sql: ${TABLE}.RX_TX_SPECIALTY_PA_STATUS = '3' ;;
        label: "Specialty Failed"
      }

      when: {
        sql: ${TABLE}.RX_TX_SPECIALTY_PA_STATUS = '4' ;;
        label: "Specialty Complete"
      }

      when: {
        sql: true ;;
        label: "Not Specified"
      }
    }
  }

  dimension: rx_tx_state_report_status {
    label: "Prescription State Report Status"
    description: "Flag indicating if the EC5 report has been submitted to the pharmacies specific state prescription monitoring program"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_STATE_REPORT_STATUS = '0' ;;
        label: "ECS Not Sent"
      }

      when: {
        sql: ${TABLE}.RX_TX_STATE_REPORT_STATUS = '1' ;;
        label: "ECS Sent"
      }

      when: {
        sql: ${TABLE}.RX_TX_STATE_REPORT_STATUS = '2' ;;
        label: "ECS Sent And Credited"
      }

      when: {
        sql: ${TABLE}.RX_TX_STATE_REPORT_STATUS = '3' ;;
        label: "ECS Sent And Changed"
      }

      when: {
        sql: true ;;
        label: "Not Available"
      }
    }
  }

  dimension: rx_tx_tx_user_modified {
    label: "Prescription Transaction User Modified"
    description: "Yes/No flag indicating if the prescription or transaction Modification/Correction was performed at the source system (EPS)"
    type: yesno
    sql: ${TABLE}.RX_TX_TX_USER_MODIFIED = 'Y' ;;
  }

  dimension: rx_tx_using_compound_plan_pricing {
    label: "Prescription Using Compound Plan Pricing"
    description: "Yes/No flag indicating if the Compound Plan Pricing was used when this transaction was priced"
    type: yesno
    sql: ${TABLE}.RX_TX_USING_COMPOUND_PLAN_PRICING = 'Y' ;;
  }

  dimension: rx_tx_using_percent_of_brand {
    label: "Prescription Using Percent of Brand"
    description: "Yes/No flag indicating if the generic price was based on a percentage of the brand price"
    type: yesno
    sql: ${TABLE}.RX_TX_USING_PERCENT_OF_BRAND = 'Y' ;;
  }

  #[ERXDWPS-5961] - Updated description.
  dimension: prescription_fill_duration {
    label: "Prescription Transaction Time to Will Call"
    description: "Difference in minutes between 'Prescription Transaction Start Time' and 'Will Call Arrival Time' for a Prescription Transaction for a Pharmacy Chain. Prescription Transaction Start time is the time of latest occurrence of Order Entry/Data Entry/RX Filling start task time from TASK_HISTORY table."
    type: number
    sql: CASE WHEN DATEDIFF(MINUTE,${start_time},${will_call_arrival_time}) <= 0 THEN NULL ELSE DATEDIFF(MINUTE,${start_time},${will_call_arrival_time}) END ;;
  }

  # For use with BI_DEMO / CUSTOMER_DEMO Model only. Dimension is a duplication of "prescription_fill_duration"
  #[ERXDWPS-5961] - Updated description.
  dimension: bi_demo_prescription_fill_duration {
    label: "Prescription Transaction Time to Will Call"
    description: "Difference in minutes between 'Prescription Transaction Start Time' and 'Will Call Arrival Time' for a Prescription Transaction for a Pharmacy Chain. Prescription Transaction Start time is the time of latest occurrence of Order Entry/Data Entry/RX Filling start task time from TASK_HISTORY table."
    type: number
    sql: CASE WHEN DATEDIFF(MINUTE,${bi_demo_start_time},${will_call_arrival_time}) <= 0 THEN NULL ELSE DATEDIFF(MINUTE,${bi_demo_start_time},${will_call_arrival_time}) END ;;
  }

  dimension: rx_tx_dispensed_drug_ndc {
    label: "Prescription Dispensed Drug NDC"
    description: "Prescription Dispensed Drug NDC"
    type: string
    sql: ${store_drug.ndc} ;;
  }

  dimension: rx_tx_intended_days_supply {
    label: "Prescription Intended Days Supply"
    description: "The original Days Supply that the customer requested for this transaction"
    type: number
    sql: ${TABLE}.RX_TX_INTENDED_DAYS_SUPPLY ;;
  }

  dimension: rx_tx_days_supply {
    label: "Prescription Days Supply"
    description: "The Days supply of the transaction, for the drug. The days supply is auto-populated in the client when the fill quantity and the SIG are entered. However, it can be entered manually by a user."
    type: number
    sql: ${TABLE}.RX_TX_DAYS_SUPPLY ;;
  }

  dimension: rx_tx_number_of_labels {
    label: "Prescription Number of Labels"
    description: "Total number of labels to print for this prescription. User entered via client or client prints default number of labels for prescription if not entered"
    type: number
    sql: ${TABLE}.RX_TX_NUMBER_OF_LABELS ;;
  }

  #####################################################################################End of YES/NO & CASE WHEN fields ###############################################################################################

  ############################################################ Start ERXLPS-386 New Dimensions added for BI ALB ##################################
  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  dimension: rx_tx_fill_quantity {
    label: "Prescription Fill Quantity"
    description: "Quantity (number of units) of the drug dispensed. (This field should only be used for grouping or filtering. Example: if you want to see Transaction Disp by Qty 30, 60, etc... )"
    type: number
    #hidden: true
    sql: ${TABLE}.rx_tx_fill_quantity ;;
    value_format: "###0.00"
  }

  # ERXLPS-1351 Search and replace all view files to use EDW materialized columns from RX_TX_LINK
  dimension: rx_tx_price {
    label: "Sales"
    description: "Price of prescription for Active transactions. (This field should only be used for grouping or filtering. Example: if you want to see the price of Prescriptions Sales $25, $35, etc ... )"
    type: number
    #hidden: true
    sql: DECODE(${TABLE}.RX_TX_RETURNED_DATE,NULL,${TABLE}.RX_TX_PRICE,NVL(${TABLE}.RX_TX_ORIGINAL_PRICE,0)) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: rx_tx_uc_price {
    label: "Prescription U & C Price"
    description: "Usual & Customary pricing of the Prescription Transaction. (This field should only be used for grouping or filtering. Example: if you want to see U&C pricing of $50, $100,etc... )"
    type: number
    #hidden: true
    sql: ${TABLE}.RX_TX_UC_PRICE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ############################################################ Start ERXLPS-386 New Dimensions added for BI ALB ##################################

  ########################################################################################################## Date/Time Dimensions #############################################################################################

  #[ERXDWPS-5961] - Updated description.
  dimension_group: start {
    label: "Prescription Transaction Start"
    description: "Date/Time that a Prescription was started. Latest occurrence of Order Entry/Data Entry/RX Filling start task is considered as Prescription start time."
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${eps_task_history_rx_start_time.prescription_start} ;;
  }

  #sql: ${TABLE}.SOURCE_TIMESTAMP

  # For use with BI_DEMO / CUSTOMER_DEMO Model only. Dimension is a duplication of "start"
  #[ERXDWPS-5961] - Updated description.
  dimension_group: bi_demo_start {
    label: "Prescription Transaction Start"
    description: "Date/Time that a Prescription was started. Latest occurrence of Order Entry/Data Entry/RX Filling start task is considered as Prescription start time."
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${bi_demo_eps_task_history_rx_start_time.bi_demo_prescription_start} ;;
  }

  #sql: ${TABLE}.SOURCE_TIMESTAMP

  dimension_group: rx_tx_will_call_picked_up {
    label: "Prescription Will Call PickedUp"
    description: "Date/time that a prescription was sold out of Will Call by a user or by a POS system "
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_WILL_CALL_PICKED_UP_DATE ;;
  }

  dimension_group: rx_tx_fill {
    label: "Prescription Filled"
    description: "Date prescription was filled"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_FILL_DATE ;;
  }

  dimension_group: rx_tx_pos_sold {
    label: "Prescription POS Sold"
    description: "Date/Time the transaction was sold from the POS system. It is set upon the receipt of a POSSoldRequest from the POS system. This field is EPS only!!!"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_POS_SOLD_DATE ;;
  }

  dimension_group: rx_tx_reportable_sales {
    label: "Prescription Reportable Sales"
    description: "Used to record the date when a TP script was adjudicated. For cash scripts, it is set when DE is completed"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_REPORTABLE_SALES_DATE ;;
  }

  dimension_group: rx_tx_returned {
    label: "Prescription Returned"
    description: "Date/Time Credit Return on the transaction is performed"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_RETURNED_DATE ;;
  }

  dimension_group: will_call_arrival {
    label: "Prescription Will Call Arrival"
    description: "Date/time that a prescription enters Will Call"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_WILL_CALL_ARRIVAL_DATE ;;
  }

  dimension_group: rx_tx_custom_reported_date {
    label: "Prescription Custom Reported"
    description: "Date/time the record was reported on the Meijer Sales Report"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_CUSTOM_REPORTED_DATE ;;
  }

  dimension_group: rx_tx_dob_override_time {
    label: "Prescription DOB Override"
    description: "Date/time that the Override of the DOB was completed during DOB verification prompted at will call screen"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_DOB_OVERRIDE_TIME ;;
  }

  dimension_group: rx_tx_last_epr_synch {
    label: "Prescription Last EPR Synch"
    description: "Date/time when the EPS SYNC occurs and EPR sends a successful response"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_LAST_EPR_SYNCH ;;
  }

  dimension_group: rx_tx_missing_date {
    label: "Prescription Missing"
    description: "Date/time when the user reported that prescription missing"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_MISSING_DATE ;;
  }

  dimension_group: rx_tx_pc_ready_date {
    label: "Prescription PC Ready"
    description: "Date/time of when the prescription was marked as Patient Accepted Counseling"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_PC_READY_DATE ;;
  }

  dimension_group: rx_tx_replace_date {
    label: "Prescription Replace"
    description: "Date application replaced missing/stolen prescription filling"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_REPLACE_DATE ;;
  }

  dimension_group: rx_tx_return_to_stock_date {
    label: "Prescription Return To Stock"
    #[ERXLPS-208] Change
    description: "Date prescription was returned to stock. The returned to stock date can be populated by a (1) Sold/Picked Up Credit Return, (2) a Will Call/Not Picked Up Return to Stock, or (3) a return from the RTS Utility. This field is EPS only!!!"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_RETURN_TO_STOCK_DATE ;;
  }

  ################################################################################################### End of DATE/TIME specific Fields ################################################################################

  #####################  Dimensions Hidden (This view is primarily used for what is required for Workflow/Task History and will be extended for other subjects as it seems fit #############################################################################################
  dimension: rx_tx_is_340_b {
    label: "Prescription 340B"
    description: "Yes/No flag indicating if the transaction is a 340B transaction"
    type: yesno
    sql: ${TABLE}.RX_TX_IS_340B = 'Y' ;;
  }

  dimension: rx_tx_partial_fill_bill_type {
    label: "Prescription Partial Fill Bill Type"
    description: "Flag that indicates on a partial fill transaction, whether both the partial fill and completion fill are billed to a third party as the entire quantity or as separate quantities"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_PARTIAL_FILL_BILL_TYPE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_PARTIAL_FILL_BILL_TYPE') ;;
    suggestions: ["BILLED SEPARATELY", "BILLED WHEN COMPLETION FILL IS FILLED", "BILLED WHEN PARTIAL FILL IS FILLED", "NOT BILLED AS PARTIAL OR COMPLETION"]
  }

  dimension: rx_tx_partial_fill_status {
    label: "Prescription Partial Fill Status"
    description: "Stores the indicator of 'P' or 'C' for partial(P) /completion(C) fills"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_PARTIAL_FILL_STATUS AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_PARTIAL_FILL_STATUS') ;;
    suggestions: ["COMPLETED PARTIAL", "PARTIAL FILL", "NOT A PARTIAL"]
  }

  dimension: rx_tx_pos_status {
    label: "Prescription POS Status"
    description: "Status of the transaction with respect to the POS system"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_POS_STATUS AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_POS_STATUS') ;;
    suggestions: ["NOT SENT", "SENT", "REPLACE WHEN SENT", "TO BE DELETED", "ALREADY ON POS"]
  }

  dimension: rx_tx_rx_credit_initiator {
    label: "Prescription Credit Initiator"
    description: " Flag that indicates what function initiated the credit return"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_RX_CREDIT_INITIATOR AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_RX_CREDIT_INITIATOR') ;;
    suggestions: ["NURSING HOME", "NOT CREDIT RETURNED", "NURSING HOME", "PHARMACY"]
  }

  dimension: rx_tx_deleted {
    type: string
    hidden: yes
    sql: ${TABLE}.RX_TX_DELETED ;;
  }

  dimension: rx_tx_tp_bill {
    label: "Prescription Tp Bill Status"
    description: "Indicates if this transaction was charged to a third party"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_TP_BILL AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_TP_BILL') ;;
    suggestions: ["CHARGED TO TP", "NO CHARGE TO TP", "TRANSMITTED TO TP", "NO CHARGE TO TP"]
  }

  dimension: rx_tx_tx_deleted {
    type: string
    hidden: yes
    sql: ${TABLE}.RX_TX_TX_DELETED ;;
  }

  #[ERXLPS-2186] - Updated logic to use return_to_stock_date.
  dimension: return_to_stock_yesno {
    label: "Prescription Transaction Return to Stock"
    description: " Yes/No field indicating if the transaction is returned to stock"
    type: yesno
    sql: ${rx_tx_return_to_stock_date_date} IS NOT NULL ;;
  }

  #[ERX-3940]- Added as a part of EDW Performance Improvement for Reports - eps_rx_tx dimensions Search & Joins in Looker US
  dimension: discount_amount {
    label: "Total Discount Amount"
    hidden: yes
    description: "Total Discount Amount"
    type: number
    sql: ${TABLE}.RX_TX_DISCOUNT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXLPS-1452] Comparable Flag. Created the dimension as type: string to keep the results in synch with store_algnment.pharmacy_comparable_flag dimension in other explores. (Ex: Pharamacy Explore)
  dimension: pharmacy_comparable_flag {
    label: "Pharmacy Comparable Flag (Align)"
    view_label: "Pharmacy - Store Alignment"
    description: "Yes/No flag indicating whether a Pharmacy can be compared to year over year metrics, and enterprise financial bench marks. (Calculation used: Comp Date < Report Date AND Non Comp Date > Report Date)"
    type: string
    sql: CASE WHEN NVL(${store_alignment.pharmacy_comparable_date}, TO_DATE('2099-01-01')) <= NVL(${rx_tx_reportable_sales_date}, TO_DATE('1900-01-01'))
                AND NVL(${store_alignment.pharmacy_non_comparable_date}, TO_DATE('2099-01-01')) > NVL(${rx_tx_reportable_sales_date}, TO_DATE('1900-01-01'))
              THEN 'Y'
              ELSE 'N'
         END;;
  }

  ########################################################################################################## End of Dimensions #############################################################################################

  ############################################################################################################### Measures #################################################################################################

  measure: count {
    label: "Fill Count"
    description: "Prescription Fill Count"
    type: number
    sql: COUNT(DISTINCT(${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_id})) ;; #ERXLPS-1649
    value_format: "#,##0"
  }

  measure: fill_count {
    label: "Fill Count (r)"
    description: "Count of Prescription Fills as determined by the Refill number"
    type: number
    sql: COUNT(DISTINCT(${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_refill_number})) ;; #ERXLPS-1649
    value_format: "#,##0"
  }

  measure: active_count {
    label: "Active Fill Count"
    description: "Active Prescription Fill Count"
    type: number
    sql: COUNT(DISTINCT(CASE WHEN ${rx_tx_active} = 'Yes' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_id}) END )) ;;
    value_format: "#,##0"
  }

  # ERXLPS-1351 Search and replace all view files to use EDW materialized columns from RX_TX_LINK
  measure: sum_price {
    label: "Total Sales"
    description: "Total Price of prescription for Active transactions"
    type: sum
    sql: CASE WHEN ${rx_tx_active} = 'Yes' THEN ${TABLE}.RX_TX_PRICE END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXLPS-2186] - Updated logic to use return_to_stock_date.
  measure: return_to_stock_count {
    label: "Prescription Transaction Return to Stock Count"
    description: "The number of scripts returned to stock. Return to Stock date is used to calculate the number of scripts returned to stock. This measure can be used with Return to Stock Date dimension."
    type: number
    #  ERXLPS-208 Change: Removed condition ${eps_task_history.task_history_task_action} = 'COMPLETE' AND ${eps_task_history.task_history_status} = 'COMPLETE_PRODUCT_VERIFICATION'. This condition also eliminates addition join to task_history and added will_call_arrival_date IS NOT NULL
    sql: COUNT(DISTINCT(CASE WHEN ${rx_tx_return_to_stock_date_date} IS NOT NULL THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_id}) END)) ;;
    value_format: "#,##0"
  }

  #[ERXLPS-2186] - Updated logic to use return_to_stock_date.
  measure: return_to_stock_sales {
    label: "Prescription Transaction Return to Stock Sales"
    description: "The total sales or the original prescription price of scripts which are returned to stock. Return to Stock date is used to calculate the sales of scripts returned to stock. This measure can be used with Return to Stock Date dimension."
    type: number
    #  ERXLPS-208 Change: Removed condition ${eps_task_history.task_history_task_action} = 'COMPLETE' AND ${eps_task_history.task_history_status} = 'COMPLETE_PRODUCT_VERIFICATION' This condition also eliminates addition join to task_history and added will_call_arrival_date IS NOT NULL
    sql: SUM(DISTINCT(CASE WHEN ${rx_tx_return_to_stock_date_date} IS NOT NULL THEN ${TABLE}.RX_TX_ORIGINAL_PRICE END)) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_rx_tx_manual_acquisition_cost {
    label: "Total Prescription Manual Acquisition Cost"
    description: "Total prescription manual acquisition cost"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: sum
    sql: ${TABLE}.RX_TX_MANUAL_ACQUISITION_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_rx_tx_manual_acquisition_cost {
    label: "Avg Prescription Manual Acquisition Cost"
    description: "Average prescription manual acquisition cost"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: average
    sql: ${TABLE}.RX_TX_MANUAL_ACQUISITION_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ## ERXLPS-643 -   sum_rx_tx_overridden_price_amount AND avg_rx_tx_overridden_price_amount measures were REMOVED from the sales candidate set, and exposed through the sales view using the logic to ensure that they do not increase in value when TY/LY analysis is turned on
  measure: sum_rx_tx_overridden_price_amount {
    label: "Total Prescription Overridden Price Amount"
    description: "Total prescription overridden price amount"
    type: sum
    sql: ${TABLE}.RX_TX_OVERRIDDEN_PRICE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_rx_tx_overridden_price_amount {
    label: "Avg Prescription Overridden Price Amount"
    description: "Average prescription overridden price amount"
    type: average
    sql: ${TABLE}.RX_TX_OVERRIDDEN_PRICE_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_rx_tx_professional_fee {
    label: "Prescription Total Professional Fee"
    description: "Total of any additional fees included in the price of this transaction, outside of the normal pricing calculation"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: sum
    sql: ${TABLE}.RX_TX_PROFESSIONAL_FEE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_rx_tx_professional_fee {
    label: "Prescription Average Professional Fee"
    description: "Average of any additional fees included in the price of this transaction, outside of the normal pricing calculation"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: average
    sql: ${TABLE}.RX_TX_PROFESSIONAL_FEE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  # The following are being commented and are part of US50297. They need to be tested as part of that US before promoting / deploying
  # 12/18/16 -- Removed the Comments for the Time to Will Call Measures. Leadership is requesting that these are available for Demo on Tuesday 12/20
  # [ERXDWPS-5916] - Updated description for Prescription Time to Will Call (Minutes) measures.
  measure: sum_fill_duration {
    label: "Total Prescription Time to Will Call (Minutes)"
    description: "Total time taken to process a Prescription from Start Time to Will Call Arrival. Value is displayed in Minutes. Calculation Used: Prescription Transaction Start Time - Will Call Arrival Time."
    type: number
    sql: SUM(${prescription_fill_duration}) ;;
    value_format: "#,##0.00"
  }

  measure: avg_fill_duration {
    label: "Average Prescription Time to Will Call (Minutes)"
    description: "Average time taken to process a Prescription from Start Time to Will Call Arrival. Value is displayed in Minutes. Calculation Used: Prescription Transaction Start Time - Will Call Arrival Time."
    type: number
    sql: AVG(${prescription_fill_duration}) ;;
    value_format: "#,##0.00"
  }

  measure: median_fill_duration {
    label: "Median Prescription Time to Will Call (Minutes)"
    description: "Median time taken to process a Prescription from Start Time to Will Call Arrival. Value is displayed in Minutes. Calculation Used: Prescription Transaction Start Time - Will Call Arrival Time."
    type: number
    sql: MEDIAN(${prescription_fill_duration}) ;;
    value_format: "#,##0.00"
  }

  measure: max_fill_duration {
    label: "Max Prescription Time to Will Call (Minutes)"
    description: "Maximum time taken to process a Prescription from Start Time to Will Call Arrival. Value is displayed in Minutes. Calculation Used: Prescription Transaction Start Time - Will Call Arrival Time."
    type: number
    sql: MAX(${prescription_fill_duration}) ;;
    value_format: "#,##0.00"
  }

  measure: min_fill_duration {
    label: "Min Prescription Time to Will Call (Minutes)"
    description: "Minimum time taken to process a Prescription from Start Time to Will Call Arrival. Value is displayed in Minutes. Calculation Used: Prescription Transaction Start Time - Will Call Arrival Time."
    type: number
    sql: MIN(${prescription_fill_duration}) ;;
    value_format: "#,##0.00"
  }

  # ==================================== DUPLICATED MEASURES ============================================ #
  # The Following Time to Will Call Measures are duplicated from immediately above. They are for the CUSTOMER DEMO Model as it uses a different view / join
  measure: bi_demo_sum_fill_duration {
    label: "Total Prescription Time to Will Call (Minutes)"
    description: "Total time taken to process a Prescription from Start Time to Will Call Arrival. Value is displayed in Minutes. Calculation Used: Prescription Transaction Start Time - Will Call Arrival Time."
    type: number
    sql: SUM(${bi_demo_prescription_fill_duration}) ;;
    value_format: "#,##0.00"
  }

  measure: bi_demo_avg_fill_duration {
    label: "Average Prescription Time to Will Call (Minutes)"
    description: "Average time taken to process a Prescription from Start Time to Will Call Arrival. Value is displayed in Minutes. Calculation Used: Prescription Transaction Start Time - Will Call Arrival Time."
    type: number
    sql: AVG(${bi_demo_prescription_fill_duration}) ;;
    value_format: "#,##0.00"
  }

  measure: bi_demo_median_fill_duration {
    label: "Median Prescription Time to Will Call (Minutes)"
    description: "Median time taken to process a Prescription from Start Time to Will Call Arrival. Value is displayed in Minutes. Calculation Used: Prescription Transaction Start Time - Will Call Arrival Time."
    type: number
    sql: MEDIAN(${bi_demo_prescription_fill_duration}) ;;
    value_format: "#,##0.00"
  }

  measure: bi_demo_max_fill_duration {
    label: "Max Prescription Time to Will Call (Minutes)"
    description: "Maximum time taken to process a Prescription from Start Time to Will Call Arrival. Value is displayed in Minutes. Calculation Used: Prescription Transaction Start Time - Will Call Arrival Time."
    type: number
    sql: MAX(${bi_demo_prescription_fill_duration}) ;;
    value_format: "#,##0.00"
  }

  measure: bi_demo_min_fill_duration {
    label: "Min Prescription Time to Will Call (Minutes)"
    description: "Minimum time taken to process a Prescription from Start Time to Will Call Arrival. Value is displayed in Minutes. Calculation Used: Prescription Transaction Start Time - Will Call Arrival Time."
    type: number
    sql: MIN(${bi_demo_prescription_fill_duration}) ;;
    value_format: "#,##0.00"
  }

  # =================================== END DUPLICATED "Time to Will Call" MEASURES ========================================== #

  ## ERXLPS-799 - Time spent "IN" Will Call measure

  dimension: time_in_will_call {
    label: "Prescription Time Spent in Will Call (Hours)"
    description: "The time a prescription spent in Will Call. Value is displayed in Hours. Calculation Used: The difference between Prescription Transaction Will Call Arrival Time, and Prescription Transaction Will Call Pick-up Time or Current time if prescription is not yet picked up."
    #hidden: true # Exposed to add ability to limit negative numbers due to POS DE with picked up time
    type: number
    #[ERXLPS-854] - Added check with workflow_token to find the active will call transactions and calculated time spent in will call for transactions which are not yet picked up.
    sql: (DATEDIFF(MINUTE,
                   ${will_call_arrival_time},
                   CASE WHEN ${rx_tx_will_call_picked_up_time} IS NULL
                        THEN CASE WHEN ${eps_workflow_token.workflow_token_required_role} = 'WC'
                                  THEN CASE WHEN ${store.store_server_time_zone} IS NOT NULL
                                            THEN CONVERT_TIMEZONE('UTC',
                                                                  CASE WHEN ${store.store_server_time_zone} = 'US/ALASKA' THEN 'US/Alaska'
                                                                       WHEN ${store.store_server_time_zone} = 'US/ARIZONA' THEN 'US/Arizona'
                                                                       WHEN ${store.store_server_time_zone} = 'US/ATLANTIC' THEN 'America/New_York'
                                                                       WHEN ${store.store_server_time_zone} = 'US/CENTRAL' THEN 'US/Central'
                                                                       WHEN ${store.store_server_time_zone} = 'US/EAST' THEN 'US/Eastern'
                                                                       WHEN ${store.store_server_time_zone} = 'US/EASTERN' THEN 'US/Eastern'
                                                                       WHEN ${store.store_server_time_zone} = 'US/HAWAII' THEN 'US/Hawaii'
                                                                       WHEN ${store.store_server_time_zone} = 'US/HAWAII-ALEUTIAN' THEN 'US/Aleutian'
                                                                       WHEN ${store.store_server_time_zone} = 'US/MOUNTAIN' THEN 'US/Mountain'
                                                                       WHEN ${store.store_server_time_zone} = 'US/PACIFIC' THEN 'US/Pacific'
                                                                  END,
                                                                  to_timestamp_ntz(current_timestamp())
                                                                 )
                                            ELSE NULL
                                       END
                                  ELSE NULL
                             END
                        ELSE ${rx_tx_will_call_picked_up_time}
                  END
                  )
          /60) ;;
    value_format: "#,##0.00"
  }

  measure: sum_time_in_will_call {
    label: "Total Prescription Time Spent in Will Call (Hours)"
    description: "Total time spent in Will Call. Value is displayed in Hours. Calculation Used: The total time difference between Prescription Transaction Will Call Arrival Time, and Prescription Transaction Will Call Pick-up Time"
    type: sum
    sql: ${time_in_will_call} ;;
    value_format: "#,##0.00"
  }

  measure: avg_time_in_will_call {
    label: "Average Prescription Time Spent in Will Call (Hours)"
    description: "Average time spent in Will Call. Value is displayed in Hours. Calculation Used: The average time difference between Prescription Transaction Will Call Arrival Time, and Prescription Transaction Will Call Pick-up Time"
    type: average
    sql: ${time_in_will_call} ;;
    value_format: "#,##0.00"
  }

  measure: median_time_in_will_call {
    label: "Median Prescription Time Spent in Will Call (Hours)"
    description: "Median time spent in Will Call. Value is displayed in Hours. Calculation Used: The median time difference between Prescription Transaction Will Call Arrival Time, and Prescription Transaction Will Call Pick-up Time"
    type: number
    ## Median is not available until Looker 4.12
    sql: MEDIAN(${time_in_will_call}) ;;
    value_format: "#,##0.00"
  }

  measure: max_time_in_will_call {
    label: "Max Prescription Time Spent in Will Call (Hours)"
    description: "Max time spent in Will Call. Value is displayed in Hours. Calculation Used: The max time difference between Prescription Transaction Will Call Arrival Time, and Prescription Transaction Will Call Pick-up Time"
    type: max
    sql: ${time_in_will_call} ;;
    value_format: "#,##0.00"
  }

  measure: min_time_in_will_call {
    label: "Min Prescription Time Spent in Will Call (Hours)"
    description: "Min time spent in Will Call. Value is displayed in Hours. Calculation Used: The minimum time difference between Prescription Transaction Will Call Arrival Time, and Prescription Transaction Will Call Pick-up Time"
    type: min
    sql: ${time_in_will_call} ;;
    value_format: "#,##0.00"
  }

  ## == ERXLPS-799 == DUPLICATED "Time spent 'IN' Will Call" measures for DEMO Model == #

  dimension: bi_demo_time_in_will_call {
    label: "Prescription Time Spent in Will Call (Hours)"
    description: "The time a prescription spent in Will Call. Value is displayed in Hours. Calculation Used: The difference between Prescription Transaction Will Call Arrival Time, and Prescription Transaction Will Call Pick-up Time"
    #hidden: true # Exposed to add ability to limit negative numbers due to POS DE with picked up time
    type: number
    sql: (DATEDIFF(MINUTE,${will_call_arrival_time},COALESCE(${rx_tx_will_call_picked_up_time}, CURRENT_TIMESTAMP))/60) ;;
    value_format: "#,##0.00"
  }

  measure: bi_demo_sum_time_in_will_call {
    label: "Total Prescription Time Spent in Will Call (Hours)"
    description: "Total time spent in Will Call. Value is displayed in Hours. Calculation Used: The total time difference between Prescription Transaction Will Call Arrival Time, and Prescription Transaction Will Call Pick-up Time"
    type: sum
    sql: ${bi_demo_time_in_will_call} ;;
    value_format: "#,##0.00"
  }

  measure: bi_demo_avg_time_in_will_call {
    label: "Average Prescription Time Spent in Will Call (Hours)"
    description: "Average time spent in Will Call. Value is displayed in Hours. Calculation Used: The average time difference between Prescription Transaction Will Call Arrival Time, and Prescription Transaction Will Call Pick-up Time"
    type: average
    sql: ${bi_demo_time_in_will_call} ;;
    value_format: "#,##0.00"
  }

  measure: bi_demo_median_time_in_will_call {
    label: "Median Prescription Time Spent in Will Call (Hours)"
    description: "Median time spent in Will Call. Value is displayed in Hours. Calculation Used: The median time difference between Prescription Transaction Will Call Arrival Time, and Prescription Transaction Will Call Pick-up Time"
    type: number
    ## Median is not available until Looker 4.12
    sql: MEDIAN(${bi_demo_time_in_will_call}) ;;
    value_format: "#,##0.00"
  }

  measure: bi_demo_max_time_in_will_call {
    label: "Max Prescription Time Spent in Will Call (Hours)"
    description: "Max time spent in Will Call. Value is displayed in Hours. Calculation Used: The max time difference between Prescription Transaction Will Call Arrival Time, and Prescription Transaction Will Call Pick-up Time"
    type: max
    sql: ${bi_demo_time_in_will_call} ;;
    value_format: "#,##0.00"
  }

  measure: bi_demo_min_time_in_will_call {
    label: "Min Prescription Time Spent in Will Call (Hours)"
    description: "Min time spent in Will Call. Value is displayed in Hours. Calculation Used: The minimum time difference between Prescription Transaction Will Call Arrival Time, and Prescription Transaction Will Call Pick-up Time"
    type: min
    sql: ${bi_demo_time_in_will_call} ;;
    value_format: "#,##0.00"
  }

  # =================================== END TIME SPENT IN WILL CALL MEASURES ========================================== #

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_rx_tx_intended_quantity {
    label: "Prescription Intended Quantity"
    description: "The original quantity that the customer requested for this transaction"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: sum
    sql: ${TABLE}.RX_TX_INTENDED_QUANTITY ;;
    value_format: "###0.00"
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_rx_tx_original_quantity {
    label: "Prescription Original Quantity"
    description: "Original quantity on the transaction before credit return"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: sum
    sql: ${TABLE}.RX_TX_ORIGINAL_QUANTITY ;;
    value_format: "###0.00"
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_rx_tx_prescribed_quantity {
    label: "Prescription Prescribed Quantity"
    description: "Number of units (quantity) of the drug the doctor ordered"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: sum
    sql: ${TABLE}.RX_TX_PRESCRIBED_QUANTITY ;;
    value_format: "###0.00"
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_rx_tx_prescribed_quantity_tp {
    label: "T/P Prescription Prescribed Quantity"
    description: "Number of units (quantity) of the drug the doctor ordered for Third Party transactions"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: sum
    sql: CASE WHEN ${eps_rx_tx.rx_tx_tp_bill_reference} = 'Y' THEN ${TABLE}.RX_TX_PRESCRIBED_QUANTITY END ;;
    value_format: "###0.00"
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_rx_tx_prescribed_quantity_cash {
    label: "Cash Prescription Prescribed Quantity"
    description: "Number of units (quantity) of the drug the doctor ordered for Cash transactions"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: sum
    sql: CASE WHEN ${eps_rx_tx.rx_tx_tp_bill_reference} = 'N' THEN ${TABLE}.RX_TX_PRESCRIBED_QUANTITY END ;;
    value_format: "###0.00"
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_rx_tx_requested_price_to_quantity {
    label: "Prescription Requested Price To Quantity"
    description: "The requested dollar amount of the prescription that the patient would like to purchase"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: sum
    sql: ${TABLE}.RX_TX_REQUESTED_PRICE_TO_QUANTITY ;;
    value_format: "###0.00"
  }

  measure: sum_rx_tx_pos_overridden_net_paid {
    label: "Prescription POS Overridden Net Paid"
    description: "Total overridden net pay amount in the POS system, when it is a different amount than the patient net pay amount sent in the transaction request from EPS"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: sum
    sql: ${TABLE}.RX_TX_POS_OVERRIDDEN_NET_PAID ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_rx_tx_pos_overridden_net_paid {
    label: "Avg Prescription POS Overridden Net Paid"
    description: "Average overridden net pay amount in the POS system, when it is a different amount than the patient net pay amount sent in the transaction request from EPS"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: average
    sql: COALESCE(${TABLE}.RX_TX_POS_OVERRIDDEN_NET_PAID,0) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_rx_tx_original_price {
    label: "Prescription Original Price"
    description: "Total Original Price of the Prescription Transaction"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: sum
    sql: COALESCE(${TABLE}.RX_TX_ORIGINAL_PRICE,0) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_rx_tx_fill_quantity {
    label: "Prescription Fill Quantity"
    description: "Total Quantity (number of units) of the drug dispensed"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: sum
    sql: ${TABLE}.RX_TX_FILL_QUANTITY ;;
    value_format: "###0.00"
  }

  #[ERXLPS-1521] Created for TurnRx team. Used in eps_rx_tx_local_setting_hist_at_fill join.
  measure: sum_rx_tx_fill_quantity_at_fill {
    label: "Prescription Fill Quantity At Fill"
    description: "Total Quantity (number of units) of the drug dispensed based on Fill Date"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: sum
    sql: ${TABLE}.RX_TX_FILL_QUANTITY ;;
    value_format: "###0.00"
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_rx_tx_fill_quantity_tp {
    label: "T/P Prescription Fill Quantity"
    description: "Total Fill Quantity of the T/P Prescription Transaction"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: sum
    sql: CASE WHEN ${eps_rx_tx.rx_tx_tp_bill_reference} = 'Y' THEN ${TABLE}.RX_TX_FILL_QUANTITY END ;;
    value_format: "###0.00"
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_rx_tx_fill_quantity_cash {
    label: "Cash Prescription Fill Quantity"
    description: "Total Fill Quantity of the Cash Prescription Transaction"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: sum
    sql: CASE WHEN ${eps_rx_tx.rx_tx_tp_bill_reference} = 'N' THEN ${TABLE}.RX_TX_FILL_QUANTITY END ;;
    value_format: "###0.00"
  }

  #[ERXLPS-1283] - Acquisition cost for Inventory explore.
  #[ERX-3940]- Added as a part of EDW Performance Improvement for Reports - eps_rx_tx dimensions Search & Joins in Looker US
  # ERXLPS-1351 - Search and replace all view files to use EDW materialized columns from RX_TX_LINK
  measure: sum_acquisition_cost {
    label: "Prescription Acquisition Cost"
    description: "Represents the total acquisition cost of filled drug used on the prescription transaction record"
    type: sum
    sql: ${TABLE}.RX_TX_ACQUISITION_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #####################  Measures Created as Dimension - Hidden (This view is primarily used for what is required for Workflow/Task History and will be extended for other subjects as it seems fit #########################################################
  #################### These objects are referenced in sales explore to determine the Brand, Generic - ACQ, PRICE, Discount etc ##########################


  dimension: rx_tx_generic_acquisition_cost {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_GENERIC_ACQUISITION_COST ;;
  }

  dimension: rx_tx_brand_acquisition_cost {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_BRAND_ACQUISITION_COST ;;
  }

  dimension: rx_tx_generic_discount {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_GENERIC_DISCOUNT ;;
  }

  dimension: rx_tx_brand_discount {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_BRAND_DISCOUNT ;;
  }

  dimension: rx_tx_generic_price {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_GENERIC_PRICE ;;
  }

  dimension: rx_tx_tax_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_TAX_AMOUNT ;;
  }

  dimension: rx_tx_brand_price {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_BRAND_PRICE ;;
  }

  ########################################################################################################## reference dates used in other explores (currently used in sales )#############################################################################################
  ###### reference dates does not have any type as the type is defined in other explores....
  ###### the below objects are used as references in other view files....
  ### [ERXLPS-147]
  ####
  dimension: rx_tx_reportable_sales_reference {
    hidden: yes
    label: "Prescription Reportable Sales"
    description: "Used to record the date when a TP script was adjudicated. For cash scripts, it is set when DE is completed"
    sql: ${TABLE}.RX_TX_REPORTABLE_SALES_DATE ;;
  }

  dimension: rx_tx_fill_reference {
    hidden: yes
    label: "Prescription Filled"
    description: "Date prescription was filled"
    sql: ${TABLE}.RX_TX_FILL_DATE ;;
  }

  dimension: rx_tx_will_call_picked_up_reference {
    hidden: yes
    label: "Prescription Will Call PickedUp"
    description: "Date/time that a prescription was sold out of Will Call by a user or by a POS system "
    sql: ${TABLE}.RX_TX_WILL_CALL_PICKED_UP_DATE ;;
  }

  dimension: rx_tx_returned_reference {
    hidden: yes
    label: "Prescription Returned"
    description: "Date/Time Credit Return on the transaction is performed"
    sql: ${TABLE}.RX_TX_RETURNED_DATE ;;
  }

  dimension: will_call_arrival_reference {
    hidden: yes
    label: "Prescription Will Call Arrival"
    description: "Date/time that a prescription enters Will Call"
    sql: ${TABLE}.RX_TX_WILL_CALL_ARRIVAL_DATE ;;
  }

  dimension: rx_tx_return_to_stock_reference {
    hidden: yes
    label: "Prescription Return To Stock"
    #[ERXLPS-208] Change
    description: "Date prescription was returned to stock. The returned to stock date can be populated by a (1) Sold/Picked Up Credit Return, (2) a Will Call/Not Picked Up Return to Stock, or (3) a return from the RTS Utility. This field is EPS only!!!"
    sql: ${TABLE}.RX_TX_RETURN_TO_STOCK_DATE ;;
  }

  #[ERXLPS-645] Adding dimension to refere in Sales date
  dimension: rx_tx_written_reference {
    hidden: yes
    label: "Prescription Written Date"
    description: "Date the doctor wrote the prescription. User entered"
    sql: ${TABLE}.RX_TX_WRITTEN_DATE ;;
  }

  #[ERXLPS-645] Adding dimension to refere in Sales date
  dimension: rx_tx_next_refill_reference {
    hidden: yes
    label: "Next Refill Date"
    description: "Date prescription can be refilled, based on the days supply. Calculation Used: Filled Date + Days Supply"
    sql: DATEADD(DAY,${TABLE}.RX_TX_DAYS_SUPPLY,TO_DATE(${TABLE}.RX_TX_FILL_DATE)) ;;
  }

  dimension: rx_tx_drug_dispensed_reference {
    hidden: yes
    label: "Prescription Drug Dispensed"
    description: "Indicates the type of drug dispensed. Brand, Generic, Compound"
    type: string
    sql: ${TABLE}.RX_TX_DRUG_DISPENSED ;;
  }

  dimension: rx_tx_fill_status_reference {
    hidden: yes
    label: "Prescription Fill Status"
    description: "Indicates the type of transaction. New prescription transaction, Refill transaction and Non-filled, Cognitive service transaction"
    type: string
    sql: ${TABLE}.RX_TX_FILL_STATUS ;;
  }

  dimension: rx_tx_tp_bill_reference {
    hidden: yes
    label: "Prescription T/P Bill Status"
    description: "Indicates if this transaction was charged to a third party"
    type: string
    sql: ${TABLE}.RX_TX_TP_BILL ;;
  }

  #{ERXLPS-652} Dimensions created to reference in sales view. This is required to maintain the correct Uniqueness when pulling measures from Sales and TP Transmit Queue subject area.

  dimension: rx_tx_manual_acquisition_cost_reference {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_MANUAL_ACQUISITION_COST ;;
  }

  dimension: rx_tx_professional_fee_reference {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_PROFESSIONAL_FEE ;;
  }

  dimension: rx_tx_intended_quantity_reference {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_INTENDED_QUANTITY ;;
  }

  dimension: rx_tx_original_quantity_reference {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_ORIGINAL_QUANTITY ;;
  }

  dimension: rx_tx_prescribed_quantity_reference {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_PRESCRIBED_QUANTITY ;;
  }

  dimension: rx_tx_requested_price_to_quantity_reference {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_REQUESTED_PRICE_TO_QUANTITY ;;
  }

  dimension: rx_tx_pos_overridden_net_paid_reference {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_POS_OVERRIDDEN_NET_PAID ;;
  }

  dimension: rx_tx_fill_quantity_reference {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_FILL_QUANTITY ;;
  }

  dimension: rx_tx_fill_quantity_tp_reference {
    type: number
    hidden: yes
    sql: CASE WHEN ${eps_rx_tx.rx_tx_tp_bill_reference} = 'Y' THEN ${TABLE}.RX_TX_FILL_QUANTITY END ;;
  }

  dimension: rx_tx_fill_quantity_cash_reference {
    type: number
    hidden: yes
    sql: CASE WHEN ${eps_rx_tx.rx_tx_tp_bill_reference} = 'N' THEN ${TABLE}.RX_TX_FILL_QUANTITY END ;;
  }

  dimension: rx_tx_original_price_reference {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_ORIGINAL_PRICE ;;
  }

  dimension: rx_tx_base_cost_reference {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_BASE_COST ;;
  }

  dimension: rx_tx_compound_fee_reference {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_COMPOUND_FEE ;;
  }

  dimension: rx_tx_sig_per_day_reference {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_SIG_PER_DAY ;;
  }

  dimension: rx_tx_sig_per_dose_reference {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_SIG_PER_DOSE ;;
  }

  dimension: rx_tx_up_charge_reference {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_UP_CHARGE ;;
  }

  dimension: rx_tx_owed_quantity_reference {
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_OWED_QUANTITY ;;
  }

  dimension: rx_tx_prescribed_quantity_tp_reference {
    type: number
    hidden: yes
    sql: CASE WHEN ${eps_rx_tx.rx_tx_tp_bill_reference} = 'Y' THEN ${TABLE}.RX_TX_PRESCRIBED_QUANTITY END ;;
  }

  dimension: rx_tx_prescribed_quantity_cash_reference {
    type: number
    hidden: yes
    sql: CASE WHEN ${eps_rx_tx.rx_tx_tp_bill_reference} = 'N' THEN ${TABLE}.RX_TX_PRESCRIBED_QUANTITY END ;;
  }

  #[ERXLPS-724] - New dimension added to reference in other views. Right now this is beign reference in sales view to calculate dollar amount based on fill and credit return
  dimension: rx_tx_overridden_price_amount_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_OVERRIDDEN_PRICE_AMOUNT ;;
  }

  #[ERXLPS-724] - New dimension added to reference in other views. Right now this is beign reference in sales view to calculate dollar amount based on fill and credit return
  dimension: rx_tx_uc_price_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_UC_PRICE ;;
  }

  #[ERXDWPS-8916] - Reference dimensions created to utilize in central fill explore for Fiscal timeframes.
  dimension: rpt_cal_rx_tx_reportable_sales_date {
    hidden: yes
    sql: TO_DATE(${TABLE}.RX_TX_REPORTABLE_SALES_DATE) ;;
  }

  dimension: rpt_cal_sold_date {
    hidden: yes
    sql: TO_DATE(${TABLE}.RX_TX_WILL_CALL_PICKED_UP_DATE) ;;
  }

  #[ERX-326]/[ERX-1624]
  ########################################################################################################## 4.8.000 New columns start #############################################################################################
  ## FK Columns

  dimension: rx_tx_new_rx_tx_id {
    description: "Unique ID that identifies the reassigned RXTX record that was generated from this record. System generated"
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_NEW_RX_TX_ID ;;
    value_format: "######"
  }

  dimension: rx_tx_old_rx_tx_id {
    description: "Unique ID that identifies the previous RXTX record that this record was generated from. System generated"
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_OLD_RX_TX_ID ;;
    value_format: "######"
  }

  ########################################################################################################## Dimensions #############################################################################################

  dimension: rx_tx_auto_counting_system_priority {
    label: "Prescription Auto Counting System Priority"
    description: "Flag that indicates the priority of the prescription in the automated counting system"
    type: string
    sql: ${TABLE}.RX_TX_AUTO_COUNTING_SYSTEM_PRIORITY ;;
  }

  dimension: rx_tx_cashier_name {
    label: "Prescription Cashier Name"
    description: "The cashier's name who sold the prescription. User dependent, system populated"
    type: string
    sql: ${TABLE}.RX_TX_CASHIER_NAME ;;
  }

  # Check with Kumaran. This Dimension is already exists with transformation in eps_rx_tx.
  #- dimension: rx_tx_dispensed_drug_ndc
  #  label: "Prescription Dispensed Drug NDC"
  #  description: "National Drug Code (US) or DIN (Canada) for the dispensed drug. User entered/scanned into client"
  #  type: string
  #  sql: ${TABLE}.RX_TX_DISPENSED_DRUG_NDC

  dimension: rx_tx_drug_image_key {
    label: "Prescription Drug Image Key"
    description: "DIB filename of the drug image associated with this transaction.  System Generated"
    type: string
    sql: ${TABLE}.RX_TX_DRUG_IMAGE_KEY ;;
  }

  dimension: rx_tx_group_code {
    label: "Prescription Group Code"
    description: "Group code for this prescription"
    type: string
    sql: ${TABLE}.RX_TX_GROUP_CODE ;;
  }

  dimension: rx_tx_icd9_code {
    label: "Prescription ICD9 Code"
    description: "ICD9 code selected during data entry. User selected"
    type: string
    sql: ${TABLE}.RX_TX_ICD9_CODE ;;
  }

  dimension: rx_tx_manufacturer {
    label: "Prescription Manufacturer"
    description: "Manufacturer of the dispensed drug. System Generated"
    type: string
    sql: ${TABLE}.RX_TX_MANUFACTURER ;;
  }

  dimension: rx_tx_mar_sort_order {
    label: "Prescription MAR Sort Order"
    description: "Secondary sort field which determines where medications should print on the MAR (Medication Application Record). User Defined"
    type: string
    sql: ${TABLE}.RX_TX_MAR_SORT_ORDER ;;
  }

  #Label name mentioned as Prescription Transaction Note (rx_tx_note) as eps_rx has another column Prescription Transaction whcih contain rx_note
  dimension: rx_tx_note {
    label: "Prescription Transaction Note"
    description: "Notes entered by a User, or by the system, that pertain to a prescription. Alpha-Numeric"
    type: string
    sql: ${TABLE}.RX_TX_NOTE ;;
  }

  dimension: rx_tx_photo_id_address {
    label: "Prescription Photo Identifier Address"
    description: "Address of the photographic identification card, which was presented by the person dropping off or Picking up the Rx. User entered"
    type: string
    sql: ${TABLE}.RX_TX_PHOTO_ID_ADDRESS ;;
  }

  dimension: rx_tx_photo_id_city {
    label: "Prescription Photo Identifier City"
    description: "City of the photographic identification card, which was presented by the person dropping off or Picking up the Rx. User Entered"
    type: string
    sql: ${TABLE}.RX_TX_PHOTO_ID_CITY ;;
  }

  dimension: rx_tx_photo_id_number {
    label: "Prescription Photo Identifier"
    description: "Identification number(s) or letter(s) on the photographic identification card, which was presented at drop off or pick up. User entered"
    type: string
    sql: ${TABLE}.RX_TX_PHOTO_ID_NUMBER ;;
  }

  dimension: rx_tx_photo_id_postal_code {
    label: "Prescription Photo Identifier Postal Code"
    description: "Postal Code (Zip Code) of the photographic identification card, which was presented by the person dropping off or Picking up the prescription"
    type: string
    sql: ${TABLE}.RX_TX_PHOTO_ID_POSTAL_CODE ;;
  }

  dimension: rx_tx_photo_id_state {
    label: "Prescription Photo Identifier State"
    description: "State, Province, or Country of the photographic identification card, which was presented by the person dropping off or Picking up the prescription. User Entered"
    type: string
    sql: ${TABLE}.RX_TX_PHOTO_ID_STATE ;;
  }

  dimension: rx_tx_pickup_first_name {
    label: "Prescription Pickup First Name"
    description: "First name on the photographic identification card, which was presented by the person dropping off or picking up the Rx. User entered"
    type: string
    sql: ${TABLE}.RX_TX_PICKUP_FIRST_NAME ;;
  }

  dimension: rx_tx_pickup_last_name {
    label: "Prescription Pickup Last Name"
    description: "Last name on the photographic identification card, which was presented by the person dropping off or picking up the Rx.User entered"
    type: string
    sql: ${TABLE}.RX_TX_PICKUP_LAST_NAME ;;
  }

  dimension: rx_tx_pickup_middle_name {
    label: "Prescription Pickup Middle Name"
    description: "Middle name on the photographic identification card, which was presented by the person dropping off or picking up the Rx. User entered"
    type: string
    sql: ${TABLE}.RX_TX_PICKUP_MIDDLE_NAME ;;
  }

  dimension: rx_tx_pos_barcode_number {
    label: "Prescription POS Barcode Number"
    description: "Barcode identifier required by the POS system"
    type: number
    sql: ${TABLE}.RX_TX_POS_BARCODE_NUMBER ;;
    value_format: "######"
  }

  dimension: rx_tx_physician_order_sort_order {
    label: "Prescription Physician Order Sort Order"
    description: "Secondary sort for medications for positioning on the MAR chart. Primary sort is MAR_PAGE Position. User Entered/Defined"
    type: string
    sql: ${TABLE}.RX_TX_PHYSICIAN_ORDER_SORT_ORDER ;;
  }

  dimension: rx_tx_pv_initials {
    label: "Prescription PV Initials"
    description: "Initials of the user who performed Product Verification on this transaction. Entered by user, and system generated when transaction is created"
    type: string
    sql: ${TABLE}.RX_TX_PV_INITIALS ;;
  }

  dimension: rx_tx_rems_dispensing {
    label: "Prescription REMS Dispensing"
    description: "Yes/No flag indicating if the dispensed is a Risk Evaluation and Mitigation Strategy drug"
    type: yesno
    sql: ${TABLE}.RX_TX_REMS_DISPENSING = 'Y' ;;
  }

  dimension: rx_tx_route_of_administration_id {
    label: "Prescription Route Of Administration Identifier"
    description: "ID of the Route of Administration record linked to this RX_TX record. SNOMED code provided in the nhinclin file from NHIN. Must exist in the Route of Administration table"
    type: number
    sql: ${TABLE}.RX_TX_ROUTE_OF_ADMINISTRATION_ID ;;
    value_format: "######"
  }

  dimension: rx_tx_rph_employee_number_of_record {
    label: "Prescription Rph Employee Number Of Record"
    description: "Employee Number of the Pharmacist associated with this record"
    type: string
    sql: ${TABLE}.RX_TX_RPH_EMPLOYEE_NUMBER_OF_RECORD ;;
  }

  dimension: rx_tx_rx_match_key {
    label: "Prescription Match Key"
    description: "External vendor identifier"
    type: string
    sql: ${TABLE}.RX_TX_RX_MATCH_KEY ;;
  }

  dimension: rx_tx_sig_code {
    label: "Prescription SIG Code"
    description: "Code that signifies how the medication should be taken and is written on the prescription as directions. User Entered/selected"
    type: string
    sql: ${TABLE}.RX_TX_SIG_CODE ;;
  }

  dimension: rx_tx_sig_text {
    label: "Prescription SIG Text"
    description: "Actual SIG text printed on the bottle label. Created by the system or entered manually by the user"
    type: string
    sql: ${TABLE}.RX_TX_SIG_TEXT ;;
  }

  dimension: rx_tx_submitted_prescriber_dea {
    label: "Prescription Submitted Prescriber DEA"
    description: "Most recent DEA number of the prescriber that was submitted for PMP reporting for the RX_TX record"
    type: string
    sql: ${TABLE}.RX_TX_SUBMITTED_PRESCRIBER_DEA ;;
  }

  dimension: rx_tx_submitted_prescriber_npi {
    label: "Prescription Submitted Prescriber NPI"
    description: "Most recent NPI number of the prescriber that was submitted for PMP reporting for the RX_TX record"
    type: string
    sql: ${TABLE}.RX_TX_SUBMITTED_PRESCRIBER_NPI ;;
  }

  dimension: rx_tx_consent_by_first_name {
    label: "Prescription Consent By First Name"
    description: "First name of the person consenting to the administration of this immunization"
    type: string
    sql: ${TABLE}.RX_TX_CONSENT_BY_FIRST_NAME ;;
  }

  dimension: rx_tx_consent_by_last_name {
    label: "Prescription Consent By Last Name"
    description: "Last name of the person consenting to the administration of this immunization"
    type: string
    sql: ${TABLE}.RX_TX_CONSENT_BY_LAST_NAME ;;
  }

  dimension: rx_tx_consent_by_middle_name {
    label: "Prescription Consent By Middle Name"
    description: "Middle name of the person consenting to the administration of this immunization"
    type: string
    sql: ${TABLE}.RX_TX_CONSENT_BY_MIDDLE_NAME ;;
  }

  dimension: rx_tx_consent_by_relation_code {
    label: "Prescription Consent By Relation Code"
    description: "3 Character Relationship code identifying the relationship of the person consenting to the administration of this immunization"
    type: string
    sql: ${TABLE}.RX_TX_CONSENT_BY_RELATION_CODE ;;
  }

  #ERXDWPS-7253 - Sync EPS RX_TX to EDW | Start
  dimension: rx_tx_dispensing_rules_state {
    label:"Prescription Transaction Dispensing Rules State"
    description:"Stores the code of the state where the prescription will be delivered to the patient."
    type: string
    sql: ${TABLE}.RX_TX_DISPENSING_RULES_STATE ;;
  }

  dimension: rx_tx_prescriber_license_state {
    label:"Prescription Transaction Prescriber License State"
    description:"In order to assist the pharmacies in case of audit, this field stores the prescriber license state at the transaction level so if a customer is audited they will know the license used at the time of filling."
    type: string
    sql: ${TABLE}.RX_TX_PRESCRIBER_LICENSE_STATE ;;
  }

  dimension: rx_tx_prescriber_license_number {
    label:"Prescription Transaction Prescriber License Number"
    description:"In order to assist the pharmacies in case of audit,  this field stores the prescriber license number at the transaction level so if a customer is audited they will know the license used at the time of filling."
    type: string
    sql: ${TABLE}.RX_TX_PRESCRIBER_LICENSE_NUMBER ;;
  }

  dimension: rx_tx_wait_for_pa_rx_tx_id {
    label:"Prescription Transaction Wait For Pa Rx Tx Id"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_WAIT_FOR_PA_RX_TX_ID ;;
  }

  dimension: rx_tx_cii_partial_dispensed_count {
    label:"Prescription Transaction CII Partial Dispensed Count"
    description:"This column will be used only in case of C-II drug. The value of this column will be incremented when a prescription is partially dispensed (ie Fill quantity is less than prescribed quantity) for a CII drug.
    In case of new fill for C-II drug, If Fill quantity = Prescribed quantity then CII Partial Dispensed Count = 0. If Fill quantity < Prescribed quantity CII Partial Dispensed Count = 1.
    In case of second fill for C-II drug If Fill quantity = Prescribed quantity CII Partial Dispensed Count = copy value of CII Partial Dispensed Count for the last RX_TX. If Fill quantity < Prescribed quantity CII Partial Dispensed Count = Increment one to the value CII Partial Dispensed Count for the last RX_TX"
    type: number
    sql: ${TABLE}.RX_TX_CII_PARTIAL_DISPENSED_COUNT ;;
  }

  dimension: rx_tx_alignment_fill_days_supply {
    label:"Prescription Transaction Alignment Fill Days Supply"
    description:"Signifies the days supply of standard fill received in alignment request from Care Rx. If prescription is filled for a different days supply, then the patient medications will not be aligned."
    type: number
    sql: ${TABLE}.RX_TX_ALIGNMENT_FILL_DAYS_SUPPLY ;;
  }

  dimension: rx_tx_alignment_fill_type_reference {
    label:"Prescription Transaction Alignment Fill Type"
    description:"Identifies type of alignment fill transactions"
    type: string
    hidden: yes
    sql: ${TABLE}.RX_TX_ALIGNMENT_FILL_TYPE ;;
  }

  dimension: rx_tx_alignment_fill_type {
    label:"Prescription Transaction Alignment Fill Type"
    description:"Identifies type of alignment fill transactions"
    type: string
    sql: CASE WHEN to_char(${TABLE}.RX_TX_ALIGNMENT_FILL_TYPE) IS NULL THEN 'NULL - UNKNOWN'
              WHEN to_char(${TABLE}.RX_TX_ALIGNMENT_FILL_TYPE) = '1' THEN '1 - STORT FILL TRANSACTION'
              WHEN to_char(${TABLE}.RX_TX_ALIGNMENT_FILL_TYPE) = '2' THEN '2 - LONG FILL TRANSACTION'
              WHEN to_char(${TABLE}.RX_TX_ALIGNMENT_FILL_TYPE) = '3' THEN '3 - STANDARD FILL TRANSACTION'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: ["NULL - UNKNOWN", "1 - STORT FILL TRANSACTION", "2 - LONG FILL TRANSACTION", "3 - STANDARD FILL TRANSACTION"]
    suggest_persist_for: "24 hours"
    drill_fields: [rx_tx_alignment_fill_type_reference]
  }

  dimension: rx_tx_is_alignment_fill_request {
    label:"Prescription Transaction Is Alignment Fill Request"
    description:"Yes/No flag indicating if transaction is created as result of alignment fill request from Care Rx"
    type: yesno
    sql: ${TABLE}.RX_TX_IS_ALIGNMENT_FILL_REQUEST_FLAG = 'Y' ;;
  }

  dimension: rx_tx_immunization_share_flag_reference {
    label:"Prescription Transaction Immunization Share Flag"
    description:"Flag indicating if the Immunization should be shared with the Immunization Registry."
    type: string
    hidden: yes
    sql: ${TABLE}.RX_TX_IMMUNIZATION_SHARE_FLAG ;;
  }

  dimension: rx_tx_immunization_share_flag {
    label:"Prescription Transaction Immunization Share Flag"
    description:"Flag indicating if the Immunization should be shared with the Immunization Registry."
    type: string
    sql: CASE WHEN ${TABLE}.RX_TX_IMMUNIZATION_SHARE_FLAG IS NULL THEN 'NULL - UNKNOWN'
              WHEN ${TABLE}.RX_TX_IMMUNIZATION_SHARE_FLAG = 'Y' THEN 'Y - YES'
              WHEN ${TABLE}.RX_TX_IMMUNIZATION_SHARE_FLAG = 'N' THEN 'N - NO'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: ["NULL - UNKNOWN", "Y - YES", "N - NO"]
    suggest_persist_for: "24 hours"
    drill_fields: [rx_tx_immunization_share_flag_reference]
  }

  dimension: rx_tx_pmp_opioid_treatment_type_reference {
    label:"Prescription Transaction PMP Opioid Treatment Type"
    description:"This field indicates that the prescription is for opioid dependency treatment or not."
    type: string
    hidden: yes
    sql: ${TABLE}.RX_TX_PMP_OPIOID_TREATMENT_TYPE ;;
  }

  dimension: rx_tx_pmp_opioid_treatment_type {
    label:"Prescription Transaction PMP Opioid Treatment Type"
    description:"This field indicates that the prescription is for opioid dependency treatment or not."
    type: string
    sql: CASE WHEN ${TABLE}.RX_TX_PMP_OPIOID_TREATMENT_TYPE IS NULL THEN 'NULL - UNKNOWN'
              WHEN ${TABLE}.RX_TX_PMP_OPIOID_TREATMENT_TYPE = '01' THEN  '01 - NOT USED FOR OPIOID DEPENDENCY TREATMENT'
              WHEN ${TABLE}.RX_TX_PMP_OPIOID_TREATMENT_TYPE = '02' THEN  '02 - USED FOR OPIOID DEPENDENCY TREATMENT'
              WHEN ${TABLE}.RX_TX_PMP_OPIOID_TREATMENT_TYPE = '03' THEN  '03 - PAIN ASSOCIATED WITH ACTIVE AND AFTERCARE CANCER TREATMENT'
              WHEN ${TABLE}.RX_TX_PMP_OPIOID_TREATMENT_TYPE = '04' THEN  '04 - PALLIATIVE CARE IN CONJUNCTION WITH A SERIOUS ILLNESS'
              WHEN ${TABLE}.RX_TX_PMP_OPIOID_TREATMENT_TYPE = '05' THEN  '05 - END-OF-LIFE AND HOSPICE CARE'
              WHEN ${TABLE}.RX_TX_PMP_OPIOID_TREATMENT_TYPE = '06' THEN  '06 - A PREGNANT INDIVIDUAL WITH A PRE-EXISTING PRESCRIPTION FOR OPIOIDS'
              WHEN ${TABLE}.RX_TX_PMP_OPIOID_TREATMENT_TYPE = '07' THEN  '07 - ACUTE PAIN FOR AN INDIVIDUAL WITH AN EXISTING OPIOID PRESCRIPTION FOR CHRONIC PAIN'
              WHEN ${TABLE}.RX_TX_PMP_OPIOID_TREATMENT_TYPE = '08' THEN  '08 - INDIVIDUALS PURSUING AN ACTIVE TAPER OF OPIOID MEDICATIONS'
              WHEN ${TABLE}.RX_TX_PMP_OPIOID_TREATMENT_TYPE = '09' THEN  '09 - PATIENT IS PARTICIPATING IN A PAIN MANAGEMENT CONTRACT'
              WHEN ${TABLE}.RX_TX_PMP_OPIOID_TREATMENT_TYPE = '99' THEN  '99 - OTHER (TRADING PARTNER AGREED UPON REASON)'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: ["NULL - UNKNOWN", "01 - NOT USED FOR OPIOID DEPENDENCY TREATMENT", "02 - USED FOR OPIOID DEPENDENCY TREATMENT", "03 - PAIN ASSOCIATED WITH ACTIVE AND AFTERCARE CANCER TREATMENT", "04 - PALLIATIVE CARE IN CONJUNCTION WITH A SERIOUS ILLNESS", "05 - END-OF-LIFE AND HOSPICE CARE", "06 - A PREGNANT INDIVIDUAL WITH A PRE-EXISTING PRESCRIPTION FOR OPIOIDS", "07 - ACUTE PAIN FOR AN INDIVIDUAL WITH AN EXISTING OPIOID PRESCRIPTION FOR CHRONIC PAIN", "08 - INDIVIDUALS PURSUING AN ACTIVE TAPER OF OPIOID MEDICATIONS", "09 - PATIENT IS PARTICIPATING IN A PAIN MANAGEMENT CONTRACT", "99 - OTHER (TRADING PARTNER AGREED UPON REASON)"]
    suggest_persist_for: "24 hours"
    drill_fields: [rx_tx_pmp_opioid_treatment_type_reference]
  }

  dimension: rx_tx_require_id_pickup_dropoff_qualifier_reference {
    label:"Prescription Transaction Require Id Pickup Dropoff Qualifier"
    description:"Flag to identify if the pick up /drop off qualifier is a mandatory field."
    type: string
    hidden: yes
    sql: ${TABLE}.RX_TX_REQUIRE_ID_PICKUP_DROPOFF_QUALIFIER ;;
  }

  dimension: rx_tx_require_id_pickup_dropoff_qualifier {
    label:"Prescription Transaction Require ID Pickup Dropoff Qualifier"
    description:"Flag to identify if the pick up /drop off qualifier is a mandatory field."
    type: string
    sql: CASE WHEN ${TABLE}.RX_TX_REQUIRE_ID_PICKUP_DROPOFF_QUALIFIER IS NULL THEN 'NULL - UNKNOWN'
              WHEN ${TABLE}.RX_TX_REQUIRE_ID_PICKUP_DROPOFF_QUALIFIER= 'Y' THEN 'Y - HAVE TO GET THE PICKUP INFO'
              WHEN ${TABLE}.RX_TX_REQUIRE_ID_PICKUP_DROPOFF_QUALIFIER= 'N' THEN 'N - DO NOT NEED THE PICKUP INFO'
              WHEN ${TABLE}.RX_TX_REQUIRE_ID_PICKUP_DROPOFF_QUALIFIER= 'D' THEN 'D - DONE WITH THE PICKUP INFO COLLECTION'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: ["NULL - UNKNOWN", "Y - HAVE TO GET THE PICKUP INFO", "N - DO NOT NEED THE PICKUP INFO", "D - DONE WITH THE PICKUP INFO COLLECTION"]
    suggest_persist_for: "24 hours"
    drill_fields: [rx_tx_require_id_pickup_dropoff_qualifier_reference]
  }

  dimension: rx_tx_pv_double_count_performed {
    label:"Prescription Transaction PV Double Count Performed"
    description:"Prescription Transaction PV Double Count Performed"
    type: string
    sql: ${TABLE}.RX_TX_PV_DOUBLE_COUNT_PERFORMED ;;
  }

  dimension_group: rx_tx_counseling_completion {
    label:"Prescription Transaction Counseling Completion"
    description:"Date/Time when the counseling is completed on a particular transaction."
    type: time
    sql: ${TABLE}.RX_TX_COUNSELING_COMPLETION_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: rx_tx_change_billing  {
    label:"Prescription Transaction Change Billing"
    description:"Prescription Transaction Change Billing. 'Y' signifies change billing was performed at will call.'N' Signifies change billing was performed at will call -> adjudication failed -> user chose 'Use Original Billing'. No situation tracks successful/unsuccessful adjudication. If 'Use Original Billing' is used, then corresponding rx_tx_id will get the value as 'Y' and this ID will get deactivated. The original RX_TX_ID will get the value as 'N' that will signify that change billing was performed at will call -> adjudication failed -> user chose 'Use Original Billing'. NULL value stands for Change Billing hasn’t been done/attempted"
    type: string
    sql: ${TABLE}.RX_TX_CHANGE_BILLING ;;
  }

  dimension: rx_tx_last_foreground_rph_employee_number {
    label:"Prescription Transaction Last Foreground Rph Employee Number"
    description:"Inserted by code and is populated only when a transaction has completed data verification (In work flow) or fulfillment/RPh verification (In Rapid fill) in background."
    type: string
    sql: ${TABLE}.RX_TX_LAST_FOREGROUND_RPH_EMPLOYEE_NUMBER ;;
  }

  dimension: rx_tx_ship_to_provider_address_only {
    label:"Prescription Transaction Ship To Provider Address Only"
    description:"Prescription Transaction Ship To Provider Address Only"
    type: string
    sql: ${TABLE}.RX_TX_SHIP_TO_PROVIDER_ADDRESS_ONLY ;;
  }

  dimension: rx_tx_tax_code_id {
    label:"Prescription Transaction Tax Code Id"
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_TAX_CODE_ID ;;
  }

  dimension: rx_tx_initial_rx_tx_id {
    label:"Prescription Transaction Initial Rx Tx Id"
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_INITIAL_RX_TX_ID ;;
  }

  dimension: rx_tx_subsequent_rx_tx_id {
    label:"Prescription Transaction Subsequent Rx Tx Id"
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_SUBSEQUENT_RX_TX_ID ;;
  }

  dimension: rx_tx_used_in_insulin_pump_reference {
    label:"Prescription Transaction Used In Insulin Pump"
    description:"Prescription Transaction Used In Insulin Pump. Set when using rx edit#23"
    type: string
    hidden: yes
    sql: ${TABLE}.RX_TX_USED_IN_INSULIN_PUMP ;;
  }

  dimension: rx_tx_used_in_insulin_pump {
    label:"Prescription Transaction Used In Insulin Pump"
    description:"Prescription Transaction Used In Insulin Pump. Set when using rx edit#23"
    type: string
    sql: CASE WHEN ${TABLE}.RX_TX_USED_IN_INSULIN_PUMP IS NULL THEN 'NULL - UNKNOWN'
              WHEN ${TABLE}.RX_TX_USED_IN_INSULIN_PUMP = 'Y' THEN 'Y - YES'
              WHEN ${TABLE}.RX_TX_USED_IN_INSULIN_PUMP = 'N' THEN 'N - NO'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: ["NULL - UNKNOWN", "Y - YES", "N - NO"]
    suggest_persist_for: "24 hours"
    drill_fields: [rx_tx_used_in_insulin_pump_reference]
  }

  measure: sum_rx_tx_patient_pay_amount {
    label:"Prescription Transaction Patient Pay Amount"
    description:"Holds the final amount a patient owes to the pharmacy. If the rx has been priced to a tp, the value in this field will exactly match with tx_tp.received_copay. This is the NCPDP 505-F5 patient pay/patient net pay/balance due from patient value. for a cash rx, the value stored here will be calculated as generic_price - generic_discount + tax_amount. For brand or compound the value stored here will be calculated as rx_tx.brand_price – rx_tx.brand_discount + rx_tx.tax_amount"
    type: sum
    sql: ${TABLE}.RX_TX_PATIENT_PAY_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension_group: rx_tx_network_plan_bill {
    label:"Prescription Transaction Network Plan Bill"
    description:"Date/Time of Prescription Transaction Network Plan Bill"
    type: time
    sql: ${TABLE}.RX_TX_NETWORK_PLAN_BILL_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  measure: sum_rx_tx_expected_completion_patient_pay_amount {
    label:"Prescription Transaction Expected Completion Patient Pay Amount"
    description:"Estimated Patient pay for total fill on partial fill."
    type: sum
    sql: ${TABLE}.RX_TX_EXPECTED_COMPLETION_PATIENT_PAY_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #ERXDWPS-7253 - Sync EPS RX_TX to EDW | End

  ########################################################################################################## End of Dimensions #############################################################################################

  ########################################################################################################### DATE/TIME specific Fields ################################################################################

  dimension_group: rx_tx_central_fill_cutoff {
    label: "Prescription Central Fill Cutoff"
    description: "The cut-off date that the prescription must be transmitted to the fulfillment site by so that the prescription can be delivered by the promised date. System generated depending upon time and date of prescription"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_CENTRAL_FILL_CUTOFF_DATE ;;
  }

  dimension_group: rx_tx_drug_expiration {
    label: "Prescription Drug Expiration"
    description: "Dispensed drug's expiration date. system generated or user entered"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_DRUG_EXPIRATION_DATE ;;
  }

  dimension_group: rx_tx_drug_image_start {
    label: "Prescription Drug Image Start"
    description: "Date the drug image was added to the Medi-Span database. Medi-Span DIB"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_DRUG_IMAGE_START_DATE ;;
  }

  dimension_group: rx_tx_follow_up {
    label: "Prescription Follow Up"
    description: "Date of prescription follow-up. System Generated"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_FOLLOW_UP_DATE ;;
  }

  dimension_group: rx_tx_host_retrieval {
    label: "Prescription Host Retrieval"
    description: "Date Host retrieved the transaction record. System Generated when transaction record is retrieved"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_HOST_RETRIEVAL_DATE ;;
  }

  dimension_group: rx_tx_photo_id_birth {
    label: "Prescription Photo Identifier Birth"
    description: "Date of birth of the person dropping off or picking up the prescription. User input"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_PHOTO_ID_BIRTH_DATE ;;
  }

  dimension_group: rx_tx_photo_id_expire {
    label: "Prescription Photo Identifier Expire"
    description: "The expiration date on photographic identification card, which was presented at drop off or pick up. User entered"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_PHOTO_ID_EXPIRE_DATE ;;
  }

  dimension_group: rx_tx_stop {
    label: "Prescription Stop"
    description: "Nursing home or institutional stop date. (The date that the patient should stop receiving medication)"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_STOP_DATE ;;
  }

  dimension_group: rx_tx_written {
    label: "Prescription Written"
    description: "Date the Prescriber wrote the prescription. User entered"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_WRITTEN_DATE ;;
  }

  #Label name mentioned as Prescription Transaction Source Create as eps_rx has another column with same name
  dimension_group: source_create {
    label: "Prescription Transaction Source Create"
    description: "Date/Time that the record was created. This date is used for central data analysis. Oracle generated timestamp when the insert is made in the database"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  ########################################################################################################### End of DATE/TIME specific Fields ################################################################################

  ########################################################################################### YES/NO & CASE WHEN fields ###############################################################################################

  dimension: rx_tx_charge {
    label: "Prescription Charge"
    description: "Yes/No flag indicating if you charged the transaction to accounts receivable. System generated when charged"
    type: yesno
    sql: ${TABLE}.RX_TX_CHARGE_FLAG = 'Y' ;;
  }

  dimension: rx_tx_counseling_choice {
    label: "Prescription Counseling Choice"
    description: "Indicates if Patient Counseling was Required, Accepted, or Refused for the transaction"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_COUNSELING_CHOICE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_COUNSELING_CHOICE' ) ;;
    suggestions: [
      "ACCEPTED",
      "REFUSED",
      "REQUIRED",
      "NO RECORD",
      "ASK PATIENT",
      "ACCEPTED",
      "REFUSED",
      "REQUIRED",
      "NOT REQUIRED"
    ]
  }

  dimension: rx_tx_days_supply_basis {
    label: "Prescription Days Supply Basis"
    description: "Basis of days supply. User selected"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_DAYS_SUPPLY_BASIS AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_DAYS_SUPPLY_BASIS' ) ;;
    suggestions: ["NOT SPECIFIED", "EXPLICIT DIRECTIONS", "PRN DIRECTIONS", "PRESCRIBER DIRECTED"]
  }

  dimension: rx_tx_drug_schedule {
    label: "Drug Schedule"
    description: "The U.S. Drug Schedule."
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_DRUG_SCHEDULE = 1 ;;
        label: "SCHEDULE I DRUGS"
      }

      when: {
        sql: ${TABLE}.RX_TX_DRUG_SCHEDULE = 2 ;;
        label: "SCHEDULE II DRUGS"
      }

      when: {
        sql: ${TABLE}.RX_TX_DRUG_SCHEDULE = 3 ;;
        label: "SCHEDULE III DRUGS"
      }

      when: {
        sql: ${TABLE}.RX_TX_DRUG_SCHEDULE = 4 ;;
        label: "SCHEDULE IV DRUGS"
      }

      when: {
        sql: ${TABLE}.RX_TX_DRUG_SCHEDULE = 5 ;;
        label: "SCHEDULE V DRUGS"
      }

      when: {
        sql: ${TABLE}.RX_TX_DRUG_SCHEDULE = 6 ;;
        label: "LEGEND"
      }

      when: {
        sql: ${TABLE}.RX_TX_DRUG_SCHEDULE = 8 ;;
        label: "OTC"
      }

      when: {
        sql: true ;;
        label: "UNKNOWN"
      }
    }
  }

  ## [ERXLPS-418] ## - This is part of the rx_tx_drug_schedule dimension, it was replaced by sql_case: Due to the naming format being different for the Drug Schedule on the transaction, and the Master code change having to be done through a seperate release, commented out Master Code subquery until release of Master Code change in 4.8.002
  #     sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION)
  #             FROM EDW.D_MASTER_CODE MC
  #             WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_DRUG_SCHEDULE AS VARCHAR),'NULL')
  #             AND MC.EDW_COLUMN_NAME = 'RX_TX_DRUG_SCHEDULE'
  #             AND MC.SOURCE_SYSTEM = 'EPS')
  #    suggestions: ['SCHEDULE I DRUGS', 'SCHEDULE II DRUGS','SCHEDULE III DRUGS','SCHEDULE IV DRUGS','SCHEDULE V DRUGS','LEGEND DRUGS','OTC DRUGS','UNKNOWN']

  dimension: rx_tx_exclude_from_batch_fill {
    label: "Prescription Exclude From Batch"
    description: "Yes/No flag indicating if the prescription is to be excluded from the batch fill process. Input by the user on various DE and DV screens"
    type: yesno
    sql: ${TABLE}.RX_TX_EXCLUDE_FROM_BATCH_FILL_FLAG = 'Y' ;;
  }

  dimension: rx_tx_exclude_from_mar {
    label: "Prescription Exclude From MAR"
    description: "Yes/No flag indicating if the prescription is to be excluded from the MAR's report. Input by the user on various DE and DV screens"
    type: yesno
    sql: ${TABLE}.RX_TX_EXCLUDE_FROM_MAR_FLAG = 'Y' ;;
  }

  dimension: rx_tx_exclude_from_prescriber_order {
    label: "Prescription Exclude From Prescriber Order"
    description: "Yes/No flag indicating if the prescription is to be excluded from the Physician's Orders report. Input by the user on various DE and DV screens"
    type: yesno
    sql: ${TABLE}.RX_TX_EXCLUDE_FROM_PRESCRIBER_ORDER_FLAG = 'Y' ;;
  }

  dimension: rx_tx_icd9_type {
    label: "Prescription ICD9 Type"
    description: "ICD9 type. User Selected"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_ICD9_TYPE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_ICD9_TYPE' ) ;;
    suggestions: ["ICD9", "EXTERNAL CAUSE", "FACTORS", "MORPHOLOGY", "ODB"]
  }

  dimension: rx_tx_sig_language {
    label: "Prescription SIG Language"
    description: "Indicates the SIG language. User selected"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_SIG_LANGUAGE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_SIG_LANGUAGE') ;;
    suggestions: ["ENGLISH", "SPANISH", "FRENCH", "GERMAN"]
  }

  dimension: rx_tx_mar_page_position {
    label: "Prescription MAR Page Position"
    description: "Primary sort field which determines where medications should print on the MAR (Medication Application Record). User Defined"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_MAR_PAGE_POSITION AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_MAR_PAGE_POSITION') ;;
    suggestions: ["NOT SPECIFIED", "TOP", "BOTTOM", "MIDDLE", "SEPARATE PAGE"]
  }

  dimension: rx_tx_ncpdp_daw {
    label: "Prescription NCPDP DAW"
    description: "Indicates which DAW code was assigned during data entry. User Entered"
    type: string

   case: {
    when: {
      sql: ${TABLE}.RX_TX_NCPDP_DAW = '0' ;;
      label: "0 - NO SELECTION"
    }

    when: {
      sql: ${TABLE}.RX_TX_NCPDP_DAW = '1' ;;
      label: "1 - DISPENSE AS WRITTEN"
    }

    when: {
      sql: ${TABLE}.RX_TX_NCPDP_DAW = '2' ;;
      label: "2 - BRAND - PATIENT CHOICE"
    }

    when: {
      sql: ${TABLE}.RX_TX_NCPDP_DAW = '3' ;;
      label: "3 - BRAND - PHARMACIST CHOICE"
    }

    when: {
      sql: ${TABLE}.RX_TX_NCPDP_DAW = '4' ;;
      label: "4 - BRAND - GENERIC OUT OF STOCK"
    }

    when: {
      sql: ${TABLE}.RX_TX_NCPDP_DAW = '5' ;;
      label: "5 - BRAND - DISPENSED AS GENERIC"
    }

    when: {
      sql: ${TABLE}.RX_TX_NCPDP_DAW = '6' ;;
      label: "6 - OVERRIDE"
    }

    when: {
      sql: ${TABLE}.RX_TX_NCPDP_DAW = '7' ;;
      label: "7 - BRAND - MANDATED BY LAW"
    }

    when: {
      sql: ${TABLE}.RX_TX_NCPDP_DAW = '8' ;;
      label: "8 - BRAND - GENERIC UNAVAILABLE"
    }

    when: {
      sql: ${TABLE}.RX_TX_NCPDP_DAW = '9' ;;
      label: "9 - OTHER"
    }

    when: {
      sql: ${TABLE}.RX_TX_NCPDP_DAW IS NULL ;;
      label: "NOT SPECIFIED"
    }
  }
  suggestions: [
    "0 - NO SELECTION",
    "1 - DISPENSE AS WRITTEN",
    "2 - BRAND - PATIENT CHOICE",
    "3 - BRAND - PHARMACIST CHOICE",
    "4 - BRAND - GENERIC OUT OF STOCK",
    "5 - BRAND - DISPENSED AS GENERIC",
    "6 - OVERRIDE",
    "7 - BRAND - MANDATED BY LAW",
    "8 - BRAND - GENERIC UNAVAILABLE",
    "9 - OTHER",
    "NOT SPECIFIED"
  ]
  }

  dimension: rx_tx_off_site {
    label: "Prescription Off Site Flag"
    description: "Yes/No flag indicating that the Single Drug Batch transaction was processed outside of the pharmacy. User Defined"
    type: yesno
    sql: ${TABLE}.RX_TX_OFF_SITE_FLAG = 'Y' ;;
  }

  dimension: rx_tx_pac_med {
    label: "Prescription PAC Med Flag"
    description: "Yes/No flag indicating whether the prescription was filled with a PacMed system. System Generated when pac med selection is made"
    type: yesno
    sql: ${TABLE}.RX_TX_PAC_MED_FLAG = 'Y' ;;
  }

  dimension: rx_tx_photo_id_pickup_dropoff_qualifier {
    label: "Prescription Photo Identifier Dropoff Qualifer"
    description: "Additional qualifier for the ID contained in AIR05. System Generated depending on user entry"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_PHOTO_ID_PICKUP_DROPOFF_QUALIFIER AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_PHOTO_ID_PICKUP_DROPOFF_QUALIFIER') ;;
    suggestions: ["PERSON DROPPING OFF", "PERSON PICKING UP", "UNKNOWN", "NOT SPECIFIED"]
  }

  dimension: rx_tx_photo_id_type {
    label: "Prescription Photo Identifier Type"
    description: "Type of photographic identification offered by the person dropping off or picking up the prescription. User entered/selected"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_PHOTO_ID_TYPE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_PHOTO_ID_TYPE') ;;
    #Add suggetions once master codes are present in edw.d_master_code table
    suggestions: [
      "MILITARY ID",
      "STATE ISSUED ID",
      "UNIQUE SYSTEM ID",
      "PASSPORT ID",
      "DRIVER S LICENSE ID",
      "SOCIAL SECURITY NUMBER",
      "OTHER",
      "NOT SPECIFIED"
    ]
  }

  dimension: rx_tx_picked_up {
    label: "Prescription Picked Up"
    description: "Indicates if the prescription was picked up by the patient"
    type: yesno
    sql: ${TABLE}.RX_TX_PICKED_UP_FLAG = 'Y' ;;
  }

  dimension: rx_tx_physician_order_page_position {
    label: "Prescription Physician Order Page Position"
    description: "Primary sort to determine where this medication should print on the  Physician's order. User Defined"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_PHYSICIAN_ORDER_PAGE_POSITION AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_PHYSICIAN_ORDER_PAGE_POSITION') ;;
    suggestions: ["NOT SPECIFIED", "TOP", "BOTTOM", "MIDDLE", "SEPARATE PAGE"]
  }

  dimension: rx_tx_prescriber_transmitted {
    label: "Prescription Prescriber Transmitted"
    description: "Display whether the supervising prescriber or the actual prescriber was transmitted to the third party during adjudication. Used to determine what should be sent on refills during the transition. Written at time of dispensing"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_PRESCRIBER_TRANSMITTED AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_PRESCRIBER_TRANSMITTED') ;;
    suggestions: ["FILLED PRIOR TO CHANGE", "SUPERVISING PRESCRIBER", "PRESCRIBER"]
  }

  dimension: rx_tx_require_pickup_id_address {
    label: "Prescription Require Pickup Identifier Address"
    description: "Indicates if the address listed on the person's ID, dropping off or picking up the prescription, still needs to be collected"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_REQUIRE_PICKUP_ID_ADDRESS AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_REQUIRE_PICKUP_ID_ADDRESS') ;;
    suggestions: ["YES", "NO", "DATA ACQUIRED", "NOT SPECIFIED"]
  }

  dimension: rx_tx_require_pickup_id_birth_date {
    label: "Prescription Require Pickup Identifier Birth Date"
    description: "Yes/No Flag indicating if the birth date of the person dropping off or picking up the prescription is a mandatory field. User input"
    type: yesno
    sql: ${TABLE}.RX_TX_REQUIRE_PICKUP_ID_BIRTH_DATE = 'Y' ;;
  }

  dimension: rx_tx_require_pickup_id_city {
    label: "Prescription Require Pickup Identifier City"
    description: "Indicates if the city listed on the person's ID, dropping off or picking up the prescription, still needs to be collected"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_REQUIRE_PICKUP_ID_CITY AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_REQUIRE_PICKUP_ID_CITY') ;;
    suggestions: ["YES", "NO", "DATA ACQUIRED", "NOT SPECIFIED"]
  }

  dimension: rx_tx_require_pickup_id_expiration {
    label: "Prescription Require Pickup Identifier Expiration"
    description: "Indicates if the expiration date of the person's ID, dropping off or picking up the prescription, still needs to be collected"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_REQUIRE_PICKUP_ID_EXPIRATION AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_REQUIRE_PICKUP_ID_EXPIRATION') ;;
    suggestions: ["YES", "NO", "DATA ACQUIRED", "NOT SPECIFIED"]
  }

  dimension: rx_tx_require_pickup_id_middle_name {
    label: "Prescription Require Pickup Identifier Middle Name"
    description: "Yes/No Flag indicating if the middle name on the person's ID, dropping off or picking up the prescription, still needs to be collected"
    type: yesno
    sql: ${TABLE}.RX_TX_REQUIRE_PICKUP_ID_MIDDLE_NAME = 'Y' ;;
  }

  dimension: rx_tx_require_pickup_id_name {
    label: "Prescription Require Pickup Identifier Name"
    description: "Indicates if the first and last name on the person's ID, dropping off or picking up the prescription, still needs to be collected"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_REQUIRE_PICKUP_ID_NAME AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_REQUIRE_PICKUP_ID_NAME') ;;
    suggestions: ["YES", "NO", "DATA ACQUIRED", "NOT SPECIFIED"]
  }

  dimension: rx_tx_require_pickup_id_number {
    label: "Prescription Require Pickup Identifier Number"
    description: "Indicates if the ID Number on the person's ID Card, dropping off or picking up the prescription, still needs to be collected"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_REQUIRE_PICKUP_ID_NUMBER AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_REQUIRE_PICKUP_ID_NUMBER') ;;
    suggestions: ["YES", "NO", "DATA ACQUIRED", "NOT SPECIFIED"]
  }

  dimension: rx_tx_require_pickup_id_postal_code {
    label: "Prescription Require Pickup Identifier Postal Code"
    description: "Indicates if the ID Number on the person's ID Card, dropping off or picking up the prescription, still needs to be collected"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_REQUIRE_PICKUP_ID_POSTAL_CODE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_REQUIRE_PICKUP_ID_POSTAL_CODE') ;;
    suggestions: ["YES", "NO", "DATA ACQUIRED", "NOT SPECIFIED"]
  }

  dimension: rx_tx_require_pickup_id_state {
    label: "Prescription Require Pickup Identifier State"
    description: "Indicates if the State on the person's ID, dropping off or picking up the prescription, still needs to be collected"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_REQUIRE_PICKUP_ID_STATE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_REQUIRE_PICKUP_ID_STATE') ;;
    suggestions: ["YES", "NO", "DATA ACQUIRED", "NOT SPECIFIED"]
  }

  dimension: rx_tx_require_pickup_id_type {
    label: "Prescription Require Pickup Identifier Type"
    description: "Indicates if the type of ID Card, for the person dropping off or picking up the prescription, still needs to be collected"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_REQUIRE_PICKUP_ID_TYPE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_REQUIRE_PICKUP_ID_TYPE') ;;
    suggestions: ["YES", "NO", "DATA ACQUIRED"]
  }

  dimension: rx_tx_safety_cap {
    label: "Prescription Safety Cap"
    description: "Yes/No Flag indicating if a safety cap was used on the prescription bottle for this transaction. User entered in EPS client"
    type: yesno
    sql: ${TABLE}.RX_TX_SAFETY_CAP_FLAG = 'Y' ;;
  }

  dimension: rx_tx_sig_prn {
    label: "Prescription SIG PRN"
    description: "Indicates if the SIG code for the transaction is PRN (as needed). System generated based on the SIG code associated with the prescription. Can be modified from the HOA's screen"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_SIG_PRN_FLAG AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_SIG_PRN_FLAG') ;;
    suggestions: ["SIG PRN", "ROUTINE MED", "ACTIVITY OF DAILY LIVING (ADL)", "TREATMENT"]
  }

  dimension: rx_tx_site_of_administration {
    label: "Prescription Site Of Administration"
    description: "Site on the patient that the medication was administered"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.RX_TX_SITE_OF_ADMINISTRATION AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_SITE_OF_ADMINISTRATION') ;;
    #Add suggetions once master codes are present in edw.d_master_code table
    suggestions: [
      "NOT SPECIFIED",
      "LEFT UPPER ARM",
      "LEFT DELTOID",
      "LEFT GLUTEUS MEDIUS",
      "LEFT LOWER FOREARM",
      "LEFT THIGH",
      "LEFT VASTUS LATERALIS",
      "NASAL",
      "ORAL",
      "RIGHT UPPER ARM",
      "RIGHT DELTOID",
      "RIGHT GLUTEUS MEDIUS",
      "RIGHT LOWER FOREARM",
      "RIGHT THIGH",
      "RIGHT VASTUS LATERALIS",
      "OTHER"
    ]
  }

  dimension: rx_tx_usual {
    label: "Prescription Usual"
    description: "Yes/No flag indicating if this transaction used usual and customary pricing. System Generated if usual and customary price = price sold"
    type: yesno
    sql: ${TABLE}.RX_TX_USUAL_FLAG = 'Y' ;;
  }

  dimension: rx_tx_partial_fill_approved {
    label: "Prescription Partial Fill Approved"
    description: "Yes/No flag indicating record if a successful response has been sentback from the patient for a partial fill request"
    type: yesno
    sql: ${TABLE}.RX_TX_PARTIAL_FILL_APPROVED_FLAG = 'Y' ;;
  }

  #[ERXLPS-1922]
  dimension: rx_file_buy_flag {
    label: "Prescription File Buy"
    description: "Y/N Flag Indicating if a prescription/transaction came via File Buy"
    type: yesno
    sql: ${eps_rx.rx_file_buy_date_time} IS NOT NULL AND ${rx_tx_fill_time} <= ${eps_rx.rx_file_buy_date_time} ;;
  }

  ########################################################################################### End of YES/NO & CASE WHEN fields ###############################################################################################

  ########################################################################################### Fiscal Timeframe dimensions ##################################################################################
  #Reportable sales Date fiscal timeframes.
  dimension_group: reportable_sales {
    label: "Reportable Sales"
    description: "Date when a TP script was adjudicated. For cash scripts, it is set when DE is completed. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    can_filter: no
    timeframes: [date]
    sql: ${TABLE}.RX_TX_REPORTABLE_SALES_DATE ;;
  }

  dimension: rpt_sales_calendar_date {
    label: "Reportable Sales Date"
    description: "Prescription Reportable Sales Date"
    type: date
    hidden: yes
    sql: ${rpt_sales_timeframes.calendar_date} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_chain_id {
    label: "Reportable Sales Chain ID"
    description: "Prescription Reportable Sales Chain ID"
    type: number
    hidden: yes
    sql: ${rpt_sales_timeframes.chain_id} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_calendar_owner_chain_id {
    label: "Reportable Sales Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rpt_sales_timeframes.calendar_owner_chain_id} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_yesno {
    label: "Reportable Sales (Yes/No)"
    group_label: "Reportable Sales Date"
    description: "Yes/No flag indicating if a prescription has a Reportable Sales Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes

    case: {
      when: {
        sql: ${TABLE}.RX_TX_REPORTABLE_SALES_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rpt_sales_day_of_week {
    label: "Reportable Sales Day Of Week"
    description: "Prescription Reportable Sales Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rpt_sales_timeframes.day_of_week} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_day_of_month {
    label: "Reportable Sales Day Of Month"
    description: "Prescription Reportable Sales Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rpt_sales_timeframes.day_of_month} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_week_of_year {
    label: "Reportable Sales Week Of Year"
    description: "Prescription Reportable Sales Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rpt_sales_timeframes.week_of_year} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_month_num {
    label: "Reportable Sales Month Num"
    description: "Prescription Reportable Sales Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rpt_sales_timeframes.month_num} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_month {
    label: "Reportable Sales Month"
    description: "Prescription Reportable Sales Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rpt_sales_timeframes.month} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_quarter_of_year {
    label: "Reportable Sales Quarter Of Year"
    description: "Prescription Reportable Sales Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rpt_sales_timeframes.quarter_of_year} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_quarter {
    label: "Reportable Sales Quarter"
    description: "Prescription Reportable Sales Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rpt_sales_timeframes.quarter} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_year {
    label: "Reportable Sales Year"
    description: "Prescription Reportable Sales Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rpt_sales_timeframes.year} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_day_of_week_index {
    label: "Reportable Sales Day Of Week Index"
    description: "Prescription Reportable Sales Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rpt_sales_timeframes.day_of_week_index} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_week_begin_date {
    label: "Reportable Sales Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Reportable Sales Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rpt_sales_timeframes.week_begin_date} ;;
    group_label: "Reportable Sales Date"
  }

  #[ERXLPS-1229] - Added remaining timeframe components from d_fiscal_date
  dimension: rpt_sales_week_end_date {
    label: "Reportable Sales Week End Date"
    description: "Prescription Reportable Sales Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rpt_sales_timeframes.week_end_date} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_week_of_quarter {
    label: "Reportable Sales Week Of Quarter"
    description: "Prescription Reportable Sales Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rpt_sales_timeframes.week_of_quarter} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_month_begin_date {
    label: "Reportable Sales Month Begin Date"
    description: "Prescription Reportable Sales Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rpt_sales_timeframes.month_begin_date} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_month_end_date {
    label: "Reportable Sales Month End Date"
    description: "Prescription Reportable Sales Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rpt_sales_timeframes.month_end_date} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_weeks_in_month {
    label: "Reportable Sales Weeks In Month"
    description: "Prescription Reportable Sales Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rpt_sales_timeframes.weeks_in_month} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_quarter_begin_date {
    label: "Reportable Sales Quarter Begin Date"
    description: "Prescription Reportable Sales Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rpt_sales_timeframes.quarter_begin_date} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_quarter_end_date {
    label: "Reportable Sales Quarter End Date"
    description: "Prescription Reportable Sales Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rpt_sales_timeframes.quarter_end_date} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_weeks_in_quarter {
    label: "Reportable Sales Weeks In Quarter"
    description: "Prescription Reportable Sales Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rpt_sales_timeframes.weeks_in_quarter} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_year_begin_date {
    label: "Reportable Sales Year Begin Date"
    description: "Prescription Reportable Sales Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rpt_sales_timeframes.year_begin_date} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_year_end_date {
    label: "Reportable Sales Year End Date"
    description: "Prescription Reportable Sales Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rpt_sales_timeframes.year_end_date} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_weeks_in_year {
    label: "Reportable Sales Weeks In Year"
    description: "Prescription Reportable Sales Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rpt_sales_timeframes.weeks_in_year} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_leap_year_flag {
    label: "Reportable Sales Leap Year Flag"
    description: "Prescription Reportable Sales Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rpt_sales_timeframes.leap_year_flag} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_day_of_quarter {
    label: "Reportable Sales Day Of Quarter"
    description: "Prescription Reportable Sales Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rpt_sales_timeframes.day_of_quarter} ;;
    group_label: "Reportable Sales Date"
  }

  dimension: rpt_sales_day_of_year {
    label: "Reportable Sales Day Of Year"
    description: "Prescription Reportable Sales Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rpt_sales_timeframes.day_of_year} ;;
    group_label: "Reportable Sales Date"
  }

  #Sold Date fiscal timeframes.
  dimension_group: sold {
    label: "Sold"
    description: "Date when prescription was sold. This is based on the Will Call Picked Up Date in EPS. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    can_filter: no
    timeframes: [date]
    sql: ${TABLE}.RX_TX_WILL_CALL_PICKED_UP_DATE ;;
  }

  dimension: sold_calendar_date {
    label: "Sold Date"
    description: "Prescription Sold Date"
    type: date
    hidden: yes
    sql: ${sold_timeframes.calendar_date} ;;
    group_label: "Sold Date"
  }

  dimension: sold_chain_id {
    label: "Sold Chain ID"
    description: "Prescription Sold Chain ID"
    type: number
    hidden: yes
    sql: ${sold_timeframes.chain_id} ;;
    group_label: "Sold Date"
  }

  dimension: sold_calendar_owner_chain_id {
    label: "Sold Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${sold_timeframes.calendar_owner_chain_id} ;;
    group_label: "Sold Date"
  }

  dimension: sold_yesno {
    label: "Sold (Yes/No)"
    group_label: "Sold Date"
    description: "Yes/No flag indicating if a prescription has a Sold Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_TX_WILL_CALL_PICKED_UP_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: sold_day_of_week {
    label: "Sold Day Of Week"
    description: "Prescription Sold Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${sold_timeframes.day_of_week} ;;
    group_label: "Sold Date"
  }

  dimension: sold_day_of_month {
    label: "Sold Day Of Month"
    description: "Prescription Sold Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${sold_timeframes.day_of_month} ;;
    group_label: "Sold Date"
  }

  dimension: sold_week_of_year {
    label: "Sold Week Of Year"
    description: "Prescription Sold Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${sold_timeframes.week_of_year} ;;
    group_label: "Sold Date"
  }

  dimension: sold_month_num {
    label: "Sold Month Num"
    description: "Prescription Sold Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${sold_timeframes.month_num} ;;
    group_label: "Sold Date"
  }

  dimension: sold_month {
    label: "Sold Month"
    description: "Prescription Sold Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${sold_timeframes.month} ;;
    group_label: "Sold Date"
  }

  dimension: sold_quarter_of_year {
    label: "Sold Quarter Of Year"
    description: "Prescription Sold Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${sold_timeframes.quarter_of_year} ;;
    group_label: "Sold Date"
  }

  dimension: sold_quarter {
    label: "Sold Quarter"
    description: "Prescription Sold Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${sold_timeframes.quarter} ;;
    group_label: "Sold Date"
  }

  dimension: sold_year {
    label: "Sold Year"
    description: "Prescription Sold Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${sold_timeframes.year} ;;
    group_label: "Sold Date"
  }

  dimension: sold_day_of_week_index {
    label: "Sold Day Of Week Index"
    description: "Prescription Sold Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${sold_timeframes.day_of_week_index} ;;
    group_label: "Sold Date"
  }

  dimension: sold_week_begin_date {
    label: "Sold Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Sold Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${sold_timeframes.week_begin_date} ;;
    group_label: "Sold Date"
  }

  #[ERXLPS-1229] - Added remaining timeframe components from d_fiscal_date
  dimension: sold_week_end_date {
    label: "Sold Week End Date"
    description: "Prescription Sold Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${sold_timeframes.week_end_date} ;;
    group_label: "Sold Date"
  }

  dimension: sold_week_of_quarter {
    label: "Sold Week Of Quarter"
    description: "Prescription Sold Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${sold_timeframes.week_of_quarter} ;;
    group_label: "Sold Date"
  }

  dimension: sold_month_begin_date {
    label: "Sold Month Begin Date"
    description: "Prescription Sold Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${sold_timeframes.month_begin_date} ;;
    group_label: "Sold Date"
  }

  dimension: sold_month_end_date {
    label: "Sold Month End Date"
    description: "Prescription Sold Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${sold_timeframes.month_end_date} ;;
    group_label: "Sold Date"
  }

  dimension: sold_weeks_in_month {
    label: "Sold Weeks In Month"
    description: "Prescription Sold Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${sold_timeframes.weeks_in_month} ;;
    group_label: "Sold Date"
  }

  dimension: sold_quarter_begin_date {
    label: "Sold Quarter Begin Date"
    description: "Prescription Sold Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${sold_timeframes.quarter_begin_date} ;;
    group_label: "Sold Date"
  }

  dimension: sold_quarter_end_date {
    label: "Sold Quarter End Date"
    description: "Prescription Sold Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${sold_timeframes.quarter_end_date} ;;
    group_label: "Sold Date"
  }

  dimension: sold_weeks_in_quarter {
    label: "Sold Weeks In Quarter"
    description: "Prescription Sold Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${sold_timeframes.weeks_in_quarter} ;;
    group_label: "Sold Date"
  }

  dimension: sold_year_begin_date {
    label: "Sold Year Begin Date"
    description: "Prescription Sold Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${sold_timeframes.year_begin_date} ;;
    group_label: "Sold Date"
  }

  dimension: sold_year_end_date {
    label: "Sold Year End Date"
    description: "Prescription Sold Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${sold_timeframes.year_end_date} ;;
    group_label: "Sold Date"
  }

  dimension: sold_weeks_in_year {
    label: "Sold Weeks In Year"
    description: "Prescription Sold Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${sold_timeframes.weeks_in_year} ;;
    group_label: "Sold Date"
  }

  dimension: sold_leap_year_flag {
    label: "Sold Leap Year Flag"
    description: "Prescription Sold Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${sold_timeframes.leap_year_flag} ;;
    group_label: "Sold Date"
  }

  dimension: sold_day_of_quarter {
    label: "Sold Day Of Quarter"
    description: "Prescription Sold Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${sold_timeframes.day_of_quarter} ;;
    group_label: "Sold Date"
  }

  dimension: sold_day_of_year {
    label: "Sold Day Of Year"
    description: "Prescription Sold Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${sold_timeframes.day_of_year} ;;
    group_label: "Sold Date"
  }

  #Prescription Transaction Start Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_tx_start_cust {
    label: "Prescription Transaction Start"
    description: "Prescription Transaction Start Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: TO_DATE(${eps_task_history_rx_start_time.prescription_start}) ;;
  }

  dimension: rx_tx_start_cust_calendar_date {
    label: "Prescription Transaction Start Date"
    description: "Prescription Transaction Start Date"
    type: date
    hidden: yes
    sql: ${rx_tx_start_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_chain_id {
    label: "Prescription Transaction Start Chain ID"
    description: "Prescription Transaction Start Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_start_cust_timeframes.chain_id} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_calendar_owner_chain_id {
    label: "Prescription Transaction Start Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_start_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_yesno {
    label: "Prescription Transaction Start (Yes/No)"
    group_label: "Prescription Transaction Start Date"
    description: "Yes/No flag indicating if a prescription has Start Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    sql: CASE WHEN ${eps_task_history_rx_start_time.prescription_start} IS NOT NULL THEN 'Yes' ELSE 'No' END  ;;
#     #logic re-written using sql syntax. Getting validation errors when trying to run the below code.
#     case: {
#       when: {
#         sql: ${eps_task_history_rx_start_time.prescription_start} IS NOT NULL ;;
#         label: "Yes"
#       }
#
#       when: {
#         sql: true ;;
#         label: "No"
#       }
#     }
  }

  dimension: rx_tx_start_cust_day_of_week {
    label: "Prescription Transaction Start Day Of Week"
    description: "Prescription Transaction Start Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_start_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_day_of_month {
    label: "Prescription Transaction Start Day Of Month"
    description: "Prescription Transaction Start Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_start_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_week_of_year {
    label: "Prescription Transaction Start Week Of Year"
    description: "Prescription Transaction Start Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_start_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_month_num {
    label: "Prescription Transaction Start Month Num"
    description: "Prescription Transaction Start Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_start_cust_timeframes.month_num} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_month {
    label: "Prescription Transaction Start Month"
    description: "Prescription Transaction Start Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_start_cust_timeframes.month} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_quarter_of_year {
    label: "Prescription Transaction Start Quarter Of Year"
    description: "Prescription Transaction Start Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_start_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_quarter {
    label: "Prescription Transaction Start Quarter"
    description: "Prescription Transaction Start Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_start_cust_timeframes.quarter} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_year {
    label: "Prescription Transaction Start Year"
    description: "Prescription Transaction Start Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_start_cust_timeframes.year} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_day_of_week_index {
    label: "Prescription Transaction Start Day Of Week Index"
    description: "Prescription Transaction Start Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_start_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_week_begin_date {
    label: "Prescription Transaction Start Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Transaction Start Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_start_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_week_end_date {
    label: "Prescription Transaction Start Week End Date"
    description: "Prescription Transaction Start Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_start_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_week_of_quarter {
    label: "Prescription Transaction Start Week Of Quarter"
    description: "Prescription Transaction Start Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_start_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_month_begin_date {
    label: "Prescription Transaction Start Month Begin Date"
    description: "Prescription Transaction Start Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_start_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_month_end_date {
    label: "Prescription Transaction Start Month End Date"
    description: "Prescription Transaction Start Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_start_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_weeks_in_month {
    label: "Prescription Transaction Start Weeks In Month"
    description: "Prescription Transaction Start Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_start_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_quarter_begin_date {
    label: "Prescription Transaction Start Quarter Begin Date"
    description: "Prescription Transaction Start Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_start_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_quarter_end_date {
    label: "Prescription Transaction Start Quarter End Date"
    description: "Prescription Transaction Start Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_start_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_weeks_in_quarter {
    label: "Prescription Transaction Start Weeks In Quarter"
    description: "Prescription Transaction Start Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_start_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_year_begin_date {
    label: "Prescription Transaction Start Year Begin Date"
    description: "Prescription Transaction Start Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_start_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_year_end_date {
    label: "Prescription Transaction Start Year End Date"
    description: "Prescription Transaction Start Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_start_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_weeks_in_year {
    label: "Prescription Transaction Start Weeks In Year"
    description: "Prescription Transaction Start Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_start_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_leap_year_flag {
    label: "Prescription Transaction Start Leap Year Flag"
    description: "Prescription Transaction Start Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_start_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_day_of_quarter {
    label: "Prescription Transaction Start Day Of Quarter"
    description: "Prescription Transaction Start Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_start_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Transaction Start Date"
  }

  dimension: rx_tx_start_cust_day_of_year {
    label: "Prescription Transaction Start Day Of Year"
    description: "Prescription Transaction Start Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_start_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Transaction Start Date"
  }

  #Prescription Transaction Fill Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_tx_fill_cust {
    label: "Prescription Transaction Fill"
    description: "Prescription Transaction Fill Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_TX_FILL_DATE ;;
  }

  dimension: rx_tx_fill_cust_calendar_date {
    label: "Prescription Transaction Fill Date"
    description: "Prescription Transaction Fill Date"
    type: date
    hidden: yes
    sql: ${rx_tx_fill_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_chain_id {
    label: "Prescription Transaction Fill Chain ID"
    description: "Prescription Transaction Fill Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_fill_cust_timeframes.chain_id} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_calendar_owner_chain_id {
    label: "Prescription Transaction Fill Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_fill_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_yesno {
    label: "Prescription Transaction Fill (Yes/No)"
    group_label: "Prescription Transaction Fill Date"
    description: "Yes/No flag indicating if a prescription transaction has Fill Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_TX_FILL_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_tx_fill_cust_day_of_week {
    label: "Prescription Transaction Fill Day Of Week"
    description: "Prescription Transaction Fill Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_fill_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_day_of_month {
    label: "Prescription Transaction Fill Day Of Month"
    description: "Prescription Transaction Fill Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_fill_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_week_of_year {
    label: "Prescription Transaction Fill Week Of Year"
    description: "Prescription Transaction Fill Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_fill_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_month_num {
    label: "Prescription Transaction Fill Month Num"
    description: "Prescription Transaction Fill Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_fill_cust_timeframes.month_num} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_month {
    label: "Prescription Transaction Fill Month"
    description: "Prescription Transaction Fill Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_fill_cust_timeframes.month} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_quarter_of_year {
    label: "Prescription Transaction Fill Quarter Of Year"
    description: "Prescription Transaction Fill Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_fill_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_quarter {
    label: "Prescription Transaction Fill Quarter"
    description: "Prescription Transaction Fill Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_fill_cust_timeframes.quarter} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_year {
    label: "Prescription Transaction Fill Year"
    description: "Prescription Transaction Fill Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_fill_cust_timeframes.year} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_day_of_week_index {
    label: "Prescription Transaction Fill Day Of Week Index"
    description: "Prescription Transaction Fill Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_fill_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_week_begin_date {
    label: "Prescription Transaction Fill Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Transaction Fill Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_fill_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_week_end_date {
    label: "Prescription Transaction Fill Week End Date"
    description: "Prescription Transaction Fill Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_fill_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_week_of_quarter {
    label: "Prescription Transaction Fill Week Of Quarter"
    description: "Prescription Transaction Fill Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_fill_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_month_begin_date {
    label: "Prescription Transaction Fill Month Begin Date"
    description: "Prescription Transaction Fill Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_fill_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_month_end_date {
    label: "Prescription Transaction Fill Month End Date"
    description: "Prescription Transaction Fill Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_fill_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_weeks_in_month {
    label: "Prescription Transaction Fill Weeks In Month"
    description: "Prescription Transaction Fill Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_fill_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_quarter_begin_date {
    label: "Prescription Transaction Fill Quarter Begin Date"
    description: "Prescription Transaction Fill Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_fill_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_quarter_end_date {
    label: "Prescription Transaction Fill Quarter End Date"
    description: "Prescription Transaction Fill Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_fill_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_weeks_in_quarter {
    label: "Prescription Transaction Fill Weeks In Quarter"
    description: "Prescription Transaction Fill Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_fill_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_year_begin_date {
    label: "Prescription Transaction Fill Year Begin Date"
    description: "Prescription Transaction Fill Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_fill_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_year_end_date {
    label: "Prescription Transaction Fill Year End Date"
    description: "Prescription Transaction Fill Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_fill_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_weeks_in_year {
    label: "Prescription Transaction Fill Weeks In Year"
    description: "Prescription Transaction Fill Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_fill_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_leap_year_flag {
    label: "Prescription Transaction Fill Leap Year Flag"
    description: "Prescription Transaction Fill Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_fill_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_day_of_quarter {
    label: "Prescription Transaction Fill Day Of Quarter"
    description: "Prescription Transaction Fill Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_fill_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  dimension: rx_tx_fill_cust_day_of_year {
    label: "Prescription Transaction Fill Day Of Year"
    description: "Prescription Transaction Fill Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_fill_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Transaction Fill Date"
  }

  #Prescription Transaction POS Sold Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_tx_pos_sold_cust {
    label: "Prescription Transaction POS Sold"
    description: "Prescription Transaction POS Sold Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_TX_POS_SOLD_DATE ;;
  }

  dimension: rx_tx_pos_sold_cust_calendar_date {
    label: "Prescription Transaction POS Sold Date"
    description: "Prescription Transaction POS Sold Date"
    type: date
    hidden: yes
    sql: ${rx_tx_pos_sold_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_chain_id {
    label: "Prescription Transaction POS Sold Chain ID"
    description: "Prescription Transaction POS Sold Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_pos_sold_cust_timeframes.chain_id} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_calendar_owner_chain_id {
    label: "Prescription Transaction POS Sold Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_pos_sold_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_yesno {
    label: "Prescription Transaction POS Sold (Yes/No)"
    group_label: "Prescription Transaction POS Sold Date"
    description: "Yes/No flag indicating if a prescription has POS Sold Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_TX_POS_SOLD_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_tx_pos_sold_cust_day_of_week {
    label: "Prescription Transaction POS Sold Day Of Week"
    description: "Prescription Transaction POS Sold Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_pos_sold_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_day_of_month {
    label: "Prescription Transaction POS Sold Day Of Month"
    description: "Prescription Transaction POS Sold Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_pos_sold_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_week_of_year {
    label: "Prescription Transaction POS Sold Week Of Year"
    description: "Prescription Transaction POS Sold Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_pos_sold_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_month_num {
    label: "Prescription Transaction POS Sold Month Num"
    description: "Prescription Transaction POS Sold Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_pos_sold_cust_timeframes.month_num} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_month {
    label: "Prescription Transaction POS Sold Month"
    description: "Prescription Transaction POS Sold Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_pos_sold_cust_timeframes.month} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_quarter_of_year {
    label: "Prescription Transaction POS Sold Quarter Of Year"
    description: "Prescription Transaction POS Sold Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_pos_sold_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_quarter {
    label: "Prescription Transaction POS Sold Quarter"
    description: "Prescription Transaction POS Sold Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_pos_sold_cust_timeframes.quarter} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_year {
    label: "Prescription Transaction POS Sold Year"
    description: "Prescription Transaction POS Sold Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_pos_sold_cust_timeframes.year} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_day_of_week_index {
    label: "Prescription Transaction POS Sold Day Of Week Index"
    description: "Prescription Transaction POS Sold Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_pos_sold_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_week_begin_date {
    label: "Prescription Transaction POS Sold Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Transaction POS Sold Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_pos_sold_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_week_end_date {
    label: "Prescription Transaction POS Sold Week End Date"
    description: "Prescription Transaction POS Sold Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_pos_sold_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_week_of_quarter {
    label: "Prescription Transaction POS Sold Week Of Quarter"
    description: "Prescription Transaction POS Sold Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_pos_sold_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_month_begin_date {
    label: "Prescription Transaction POS Sold Month Begin Date"
    description: "Prescription Transaction POS Sold Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_pos_sold_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_month_end_date {
    label: "Prescription Transaction POS Sold Month End Date"
    description: "Prescription Transaction POS Sold Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_pos_sold_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_weeks_in_month {
    label: "Prescription Transaction POS Sold Weeks In Month"
    description: "Prescription Transaction POS Sold Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_pos_sold_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_quarter_begin_date {
    label: "Prescription Transaction POS Sold Quarter Begin Date"
    description: "Prescription Transaction POS Sold Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_pos_sold_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_quarter_end_date {
    label: "Prescription Transaction POS Sold Quarter End Date"
    description: "Prescription Transaction POS Sold Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_pos_sold_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_weeks_in_quarter {
    label: "Prescription Transaction POS Sold Weeks In Quarter"
    description: "Prescription Transaction POS Sold Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_pos_sold_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_year_begin_date {
    label: "Prescription Transaction POS Sold Year Begin Date"
    description: "Prescription Transaction POS Sold Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_pos_sold_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_year_end_date {
    label: "Prescription Transaction POS Sold Year End Date"
    description: "Prescription Transaction POS Sold Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_pos_sold_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_weeks_in_year {
    label: "Prescription Transaction POS Sold Weeks In Year"
    description: "Prescription Transaction POS Sold Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_pos_sold_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_leap_year_flag {
    label: "Prescription Transaction POS Sold Leap Year Flag"
    description: "Prescription Transaction POS Sold Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_pos_sold_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_day_of_quarter {
    label: "Prescription Transaction POS Sold Day Of Quarter"
    description: "Prescription Transaction POS Sold Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_pos_sold_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  dimension: rx_tx_pos_sold_cust_day_of_year {
    label: "Prescription Transaction POS Sold Day Of Year"
    description: "Prescription Transaction POS Sold Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_pos_sold_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Transaction POS Sold Date"
  }

  #Prescription Transaction Returned Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_tx_returned_cust {
    label: "Prescription Transaction Returned"
    description: "Prescription Transaction Returned Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_TX_RETURNED_DATE ;;
  }

  dimension: rx_tx_returned_cust_calendar_date {
    label: "Prescription Transaction Returned Date"
    description: "Prescription Transaction Returned Date"
    type: date
    hidden: yes
    sql: ${rx_tx_returned_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_chain_id {
    label: "Prescription Transaction Returned Chain ID"
    description: "Prescription Transaction Returned Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_returned_cust_timeframes.chain_id} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_calendar_owner_chain_id {
    label: "Prescription Transaction Returned Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_returned_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_yesno {
    label: "Prescription Transaction Returned (Yes/No)"
    group_label: "Prescription Transaction Returned Date"
    description: "Yes/No flag indicating if a prescription has Returned Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_TX_RETURNED_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_tx_returned_cust_day_of_week {
    label: "Prescription Transaction Returned Day Of Week"
    description: "Prescription Transaction Returned Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_returned_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_day_of_month {
    label: "Prescription Transaction Returned Day Of Month"
    description: "Prescription Transaction Returned Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_returned_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_week_of_year {
    label: "Prescription Transaction Returned Week Of Year"
    description: "Prescription Transaction Returned Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_returned_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_month_num {
    label: "Prescription Transaction Returned Month Num"
    description: "Prescription Transaction Returned Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_returned_cust_timeframes.month_num} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_month {
    label: "Prescription Transaction Returned Month"
    description: "Prescription Transaction Returned Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_returned_cust_timeframes.month} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_quarter_of_year {
    label: "Prescription Transaction Returned Quarter Of Year"
    description: "Prescription Transaction Returned Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_returned_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_quarter {
    label: "Prescription Transaction Returned Quarter"
    description: "Prescription Transaction Returned Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_returned_cust_timeframes.quarter} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_year {
    label: "Prescription Transaction Returned Year"
    description: "Prescription Transaction Returned Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_returned_cust_timeframes.year} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_day_of_week_index {
    label: "Prescription Transaction Returned Day Of Week Index"
    description: "Prescription Transaction Returned Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_returned_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_week_begin_date {
    label: "Prescription Transaction Returned Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Transaction Returned Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_returned_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_week_end_date {
    label: "Prescription Transaction Returned Week End Date"
    description: "Prescription Transaction Returned Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_returned_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_week_of_quarter {
    label: "Prescription Transaction Returned Week Of Quarter"
    description: "Prescription Transaction Returned Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_returned_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_month_begin_date {
    label: "Prescription Transaction Returned Month Begin Date"
    description: "Prescription Transaction Returned Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_returned_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_month_end_date {
    label: "Prescription Transaction Returned Month End Date"
    description: "Prescription Transaction Returned Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_returned_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_weeks_in_month {
    label: "Prescription Transaction Returned Weeks In Month"
    description: "Prescription Transaction Returned Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_returned_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_quarter_begin_date {
    label: "Prescription Transaction Returned Quarter Begin Date"
    description: "Prescription Transaction Returned Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_returned_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_quarter_end_date {
    label: "Prescription Transaction Returned Quarter End Date"
    description: "Prescription Transaction Returned Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_returned_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_weeks_in_quarter {
    label: "Prescription Transaction Returned Weeks In Quarter"
    description: "Prescription Transaction Returned Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_returned_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_year_begin_date {
    label: "Prescription Transaction Returned Year Begin Date"
    description: "Prescription Transaction Returned Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_returned_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_year_end_date {
    label: "Prescription Transaction Returned Year End Date"
    description: "Prescription Transaction Returned Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_returned_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_weeks_in_year {
    label: "Prescription Transaction Returned Weeks In Year"
    description: "Prescription Transaction Returned Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_returned_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_leap_year_flag {
    label: "Prescription Transaction Returned Leap Year Flag"
    description: "Prescription Transaction Returned Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_returned_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_day_of_quarter {
    label: "Prescription Transaction Returned Day Of Quarter"
    description: "Prescription Transaction Returned Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_returned_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  dimension: rx_tx_returned_cust_day_of_year {
    label: "Prescription Transaction Returned Day Of Year"
    description: "Prescription Transaction Returned Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_returned_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Transaction Returned Date"
  }

  #Prescription Transaction Will Call Arrival Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_tx_will_call_arrival_cust {
    label: "Prescription Transaction Will Call Arrival"
    description: "Prescription Transaction Will Call Arrival Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_TX_WILL_CALL_ARRIVAL_DATE ;;
  }

  dimension: rx_tx_will_call_arrival_cust_calendar_date {
    label: "Prescription Transaction Will Call Arrival Date"
    description: "Prescription Transaction Will Call Arrival Date"
    type: date
    hidden: yes
    sql: ${rx_tx_will_call_arrival_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_chain_id {
    label: "Prescription Transaction Will Call Arrival Chain ID"
    description: "Prescription Transaction Will Call Arrival Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_will_call_arrival_cust_timeframes.chain_id} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_calendar_owner_chain_id {
    label: "Prescription Transaction Will Call Arrival Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_will_call_arrival_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_yesno {
    label: "Prescription Transaction Will Call Arrival (Yes/No)"
    group_label: "Prescription Transaction Will Call Arrival Date"
    description: "Yes/No flag indicating if a prescription has Will Call Arrival Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_TX_WILL_CALL_ARRIVAL_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_tx_will_call_arrival_cust_day_of_week {
    label: "Prescription Transaction Will Call Arrival Day Of Week"
    description: "Prescription Transaction Will Call Arrival Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_will_call_arrival_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_day_of_month {
    label: "Prescription Transaction Will Call Arrival Day Of Month"
    description: "Prescription Transaction Will Call Arrival Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_will_call_arrival_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_week_of_year {
    label: "Prescription Transaction Will Call Arrival Week Of Year"
    description: "Prescription Transaction Will Call Arrival Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_will_call_arrival_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_month_num {
    label: "Prescription Transaction Will Call Arrival Month Num"
    description: "Prescription Transaction Will Call Arrival Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_will_call_arrival_cust_timeframes.month_num} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_month {
    label: "Prescription Transaction Will Call Arrival Month"
    description: "Prescription Transaction Will Call Arrival Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_will_call_arrival_cust_timeframes.month} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_quarter_of_year {
    label: "Prescription Transaction Will Call Arrival Quarter Of Year"
    description: "Prescription Transaction Will Call Arrival Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_will_call_arrival_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_quarter {
    label: "Prescription Transaction Will Call Arrival Quarter"
    description: "Prescription Transaction Will Call Arrival Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_will_call_arrival_cust_timeframes.quarter} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_year {
    label: "Prescription Transaction Will Call Arrival Year"
    description: "Prescription Transaction Will Call Arrival Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_will_call_arrival_cust_timeframes.year} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_day_of_week_index {
    label: "Prescription Transaction Will Call Arrival Day Of Week Index"
    description: "Prescription Transaction Will Call Arrival Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_will_call_arrival_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_week_begin_date {
    label: "Prescription Transaction Will Call Arrival Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Transaction Will Call Arrival Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_will_call_arrival_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_week_end_date {
    label: "Prescription Transaction Will Call Arrival Week End Date"
    description: "Prescription Transaction Will Call Arrival Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_will_call_arrival_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_week_of_quarter {
    label: "Prescription Transaction Will Call Arrival Week Of Quarter"
    description: "Prescription Transaction Will Call Arrival Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_will_call_arrival_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_month_begin_date {
    label: "Prescription Transaction Will Call Arrival Month Begin Date"
    description: "Prescription Transaction Will Call Arrival Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_will_call_arrival_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_month_end_date {
    label: "Prescription Transaction Will Call Arrival Month End Date"
    description: "Prescription Transaction Will Call Arrival Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_will_call_arrival_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_weeks_in_month {
    label: "Prescription Transaction Will Call Arrival Weeks In Month"
    description: "Prescription Transaction Will Call Arrival Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_will_call_arrival_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_quarter_begin_date {
    label: "Prescription Transaction Will Call Arrival Quarter Begin Date"
    description: "Prescription Transaction Will Call Arrival Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_will_call_arrival_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_quarter_end_date {
    label: "Prescription Transaction Will Call Arrival Quarter End Date"
    description: "Prescription Transaction Will Call Arrival Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_will_call_arrival_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_weeks_in_quarter {
    label: "Prescription Transaction Will Call Arrival Weeks In Quarter"
    description: "Prescription Transaction Will Call Arrival Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_will_call_arrival_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_year_begin_date {
    label: "Prescription Transaction Will Call Arrival Year Begin Date"
    description: "Prescription Transaction Will Call Arrival Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_will_call_arrival_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_year_end_date {
    label: "Prescription Transaction Will Call Arrival Year End Date"
    description: "Prescription Transaction Will Call Arrival Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_will_call_arrival_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_weeks_in_year {
    label: "Prescription Transaction Will Call Arrival Weeks In Year"
    description: "Prescription Transaction Will Call Arrival Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_will_call_arrival_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_leap_year_flag {
    label: "Prescription Transaction Will Call Arrival Leap Year Flag"
    description: "Prescription Transaction Will Call Arrival Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_will_call_arrival_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_day_of_quarter {
    label: "Prescription Transaction Will Call Arrival Day Of Quarter"
    description: "Prescription Transaction Will Call Arrival Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_will_call_arrival_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  dimension: rx_tx_will_call_arrival_cust_day_of_year {
    label: "Prescription Transaction Will Call Arrival Day Of Year"
    description: "Prescription Transaction Will Call Arrival Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_will_call_arrival_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Transaction Will Call Arrival Date"
  }

  #Prescription Transaction Custom Reported Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_tx_custom_reported_cust {
    label: "Prescription Transaction Custom Reported"
    description: "Prescription Transaction Custom Reported Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_TX_CUSTOM_REPORTED_DATE ;;
  }

  dimension: rx_tx_custom_reported_cust_calendar_date {
    label: "Prescription Transaction Custom Reported Date"
    description: "Prescription Transaction Custom Reported Date"
    type: date
    hidden: yes
    sql: ${rx_tx_custom_reported_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_chain_id {
    label: "Prescription Transaction Custom Reported Chain ID"
    description: "Prescription Transaction Custom Reported Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_custom_reported_cust_timeframes.chain_id} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_calendar_owner_chain_id {
    label: "Prescription Transaction Custom Reported Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_custom_reported_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_yesno {
    label: "Prescription Transaction Custom Reported (Yes/No)"
    group_label: "Prescription Transaction Custom Reported Date"
    description: "Yes/No flag indicating if a prescription has Custom Reported Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_TX_CUSTOM_REPORTED_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_tx_custom_reported_cust_day_of_week {
    label: "Prescription Transaction Custom Reported Day Of Week"
    description: "Prescription Transaction Custom Reported Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_custom_reported_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_day_of_month {
    label: "Prescription Transaction Custom Reported Day Of Month"
    description: "Prescription Transaction Custom Reported Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_custom_reported_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_week_of_year {
    label: "Prescription Transaction Custom Reported Week Of Year"
    description: "Prescription Transaction Custom Reported Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_custom_reported_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_month_num {
    label: "Prescription Transaction Custom Reported Month Num"
    description: "Prescription Transaction Custom Reported Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_custom_reported_cust_timeframes.month_num} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_month {
    label: "Prescription Transaction Custom Reported Month"
    description: "Prescription Transaction Custom Reported Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_custom_reported_cust_timeframes.month} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_quarter_of_year {
    label: "Prescription Transaction Custom Reported Quarter Of Year"
    description: "Prescription Transaction Custom Reported Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_custom_reported_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_quarter {
    label: "Prescription Transaction Custom Reported Quarter"
    description: "Prescription Transaction Custom Reported Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_custom_reported_cust_timeframes.quarter} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_year {
    label: "Prescription Transaction Custom Reported Year"
    description: "Prescription Transaction Custom Reported Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_custom_reported_cust_timeframes.year} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_day_of_week_index {
    label: "Prescription Transaction Custom Reported Day Of Week Index"
    description: "Prescription Transaction Custom Reported Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_custom_reported_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_week_begin_date {
    label: "Prescription Transaction Custom Reported Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Transaction Custom Reported Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_custom_reported_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_week_end_date {
    label: "Prescription Transaction Custom Reported Week End Date"
    description: "Prescription Transaction Custom Reported Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_custom_reported_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_week_of_quarter {
    label: "Prescription Transaction Custom Reported Week Of Quarter"
    description: "Prescription Transaction Custom Reported Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_custom_reported_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_month_begin_date {
    label: "Prescription Transaction Custom Reported Month Begin Date"
    description: "Prescription Transaction Custom Reported Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_custom_reported_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_month_end_date {
    label: "Prescription Transaction Custom Reported Month End Date"
    description: "Prescription Transaction Custom Reported Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_custom_reported_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_weeks_in_month {
    label: "Prescription Transaction Custom Reported Weeks In Month"
    description: "Prescription Transaction Custom Reported Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_custom_reported_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_quarter_begin_date {
    label: "Prescription Transaction Custom Reported Quarter Begin Date"
    description: "Prescription Transaction Custom Reported Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_custom_reported_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_quarter_end_date {
    label: "Prescription Transaction Custom Reported Quarter End Date"
    description: "Prescription Transaction Custom Reported Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_custom_reported_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_weeks_in_quarter {
    label: "Prescription Transaction Custom Reported Weeks In Quarter"
    description: "Prescription Transaction Custom Reported Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_custom_reported_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_year_begin_date {
    label: "Prescription Transaction Custom Reported Year Begin Date"
    description: "Prescription Transaction Custom Reported Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_custom_reported_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_year_end_date {
    label: "Prescription Transaction Custom Reported Year End Date"
    description: "Prescription Transaction Custom Reported Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_custom_reported_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_weeks_in_year {
    label: "Prescription Transaction Custom Reported Weeks In Year"
    description: "Prescription Transaction Custom Reported Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_custom_reported_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_leap_year_flag {
    label: "Prescription Transaction Custom Reported Leap Year Flag"
    description: "Prescription Transaction Custom Reported Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_custom_reported_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_day_of_quarter {
    label: "Prescription Transaction Custom Reported Day Of Quarter"
    description: "Prescription Transaction Custom Reported Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_custom_reported_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  dimension: rx_tx_custom_reported_cust_day_of_year {
    label: "Prescription Transaction Custom Reported Day Of Year"
    description: "Prescription Transaction Custom Reported Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_custom_reported_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Transaction Custom Reported Date"
  }

  #Prescription Transaction DOB Override Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_tx_dob_override_cust {
    label: "Prescription Transaction DOB Override"
    description: "Prescription Transaction DOB Override Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_TX_DOB_OVERRIDE_TIME ;;
  }

  dimension: rx_tx_dob_override_cust_calendar_date {
    label: "Prescription Transaction DOB Override Date"
    description: "Prescription Transaction DOB Override Date"
    type: date
    hidden: yes
    sql: ${rx_tx_dob_override_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_chain_id {
    label: "Prescription Transaction DOB Override Chain ID"
    description: "Prescription Transaction DOB Override Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_dob_override_cust_timeframes.chain_id} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_calendar_owner_chain_id {
    label: "Prescription Transaction DOB Override Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_dob_override_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_yesno {
    label: "Prescription Transaction DOB Override (Yes/No)"
    group_label: "Prescription Transaction DOB Override Date"
    description: "Yes/No flag indicating if a prescription has DOB Override Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_TX_DOB_OVERRIDE_TIME IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_tx_dob_override_cust_day_of_week {
    label: "Prescription Transaction DOB Override Day Of Week"
    description: "Prescription Transaction DOB Override Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_dob_override_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_day_of_month {
    label: "Prescription Transaction DOB Override Day Of Month"
    description: "Prescription Transaction DOB Override Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_dob_override_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_week_of_year {
    label: "Prescription Transaction DOB Override Week Of Year"
    description: "Prescription Transaction DOB Override Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_dob_override_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_month_num {
    label: "Prescription Transaction DOB Override Month Num"
    description: "Prescription Transaction DOB Override Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_dob_override_cust_timeframes.month_num} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_month {
    label: "Prescription Transaction DOB Override Month"
    description: "Prescription Transaction DOB Override Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_dob_override_cust_timeframes.month} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_quarter_of_year {
    label: "Prescription Transaction DOB Override Quarter Of Year"
    description: "Prescription Transaction DOB Override Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_dob_override_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_quarter {
    label: "Prescription Transaction DOB Override Quarter"
    description: "Prescription Transaction DOB Override Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_dob_override_cust_timeframes.quarter} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_year {
    label: "Prescription Transaction DOB Override Year"
    description: "Prescription Transaction DOB Override Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_dob_override_cust_timeframes.year} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_day_of_week_index {
    label: "Prescription Transaction DOB Override Day Of Week Index"
    description: "Prescription Transaction DOB Override Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_dob_override_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_week_begin_date {
    label: "Prescription Transaction DOB Override Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Transaction DOB Override Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_dob_override_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_week_end_date {
    label: "Prescription Transaction DOB Override Week End Date"
    description: "Prescription Transaction DOB Override Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_dob_override_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_week_of_quarter {
    label: "Prescription Transaction DOB Override Week Of Quarter"
    description: "Prescription Transaction DOB Override Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_dob_override_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_month_begin_date {
    label: "Prescription Transaction DOB Override Month Begin Date"
    description: "Prescription Transaction DOB Override Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_dob_override_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_month_end_date {
    label: "Prescription Transaction DOB Override Month End Date"
    description: "Prescription Transaction DOB Override Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_dob_override_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_weeks_in_month {
    label: "Prescription Transaction DOB Override Weeks In Month"
    description: "Prescription Transaction DOB Override Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_dob_override_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_quarter_begin_date {
    label: "Prescription Transaction DOB Override Quarter Begin Date"
    description: "Prescription Transaction DOB Override Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_dob_override_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_quarter_end_date {
    label: "Prescription Transaction DOB Override Quarter End Date"
    description: "Prescription Transaction DOB Override Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_dob_override_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_weeks_in_quarter {
    label: "Prescription Transaction DOB Override Weeks In Quarter"
    description: "Prescription Transaction DOB Override Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_dob_override_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_year_begin_date {
    label: "Prescription Transaction DOB Override Year Begin Date"
    description: "Prescription Transaction DOB Override Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_dob_override_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_year_end_date {
    label: "Prescription Transaction DOB Override Year End Date"
    description: "Prescription Transaction DOB Override Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_dob_override_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_weeks_in_year {
    label: "Prescription Transaction DOB Override Weeks In Year"
    description: "Prescription Transaction DOB Override Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_dob_override_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_leap_year_flag {
    label: "Prescription Transaction DOB Override Leap Year Flag"
    description: "Prescription Transaction DOB Override Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_dob_override_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_day_of_quarter {
    label: "Prescription Transaction DOB Override Day Of Quarter"
    description: "Prescription Transaction DOB Override Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_dob_override_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  dimension: rx_tx_dob_override_cust_day_of_year {
    label: "Prescription Transaction DOB Override Day Of Year"
    description: "Prescription Transaction DOB Override Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_dob_override_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Transaction DOB Override Date"
  }

  #Prescription Transaction Last EPR Synch Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_tx_last_epr_synch_cust {
    label: "Prescription Transaction Last EPR Synch"
    description: "Prescription Transaction Last EPR Synch Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_TX_LAST_EPR_SYNCH ;;
  }

  dimension: rx_tx_last_epr_synch_cust_calendar_date {
    label: "Prescription Transaction Last EPRSynch Date"
    description: "Prescription Transaction Last EPR Synch Date"
    type: date
    hidden: yes
    sql: ${rx_tx_last_epr_synch_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_chain_id {
    label: "Prescription Transaction Last EPRSynch Chain ID"
    description: "Prescription Transaction Last EPR Synch Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_last_epr_synch_cust_timeframes.chain_id} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_calendar_owner_chain_id {
    label: "Prescription Transaction Last EPRSynch Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_last_epr_synch_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_yesno {
    label: "Prescription Transaction Last EPRSynch (Yes/No)"
    group_label: "Prescription Transaction Last EPRSynch Date"
    description: "Yes/No flag indicating if a prescription has Last EPR Synch Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_TX_LAST_EPR_SYNCH IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_tx_last_epr_synch_cust_day_of_week {
    label: "Prescription Transaction Last EPRSynch Day Of Week"
    description: "Prescription Transaction Last EPR Synch Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_last_epr_synch_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_day_of_month {
    label: "Prescription Transaction Last EPRSynch Day Of Month"
    description: "Prescription Transaction Last EPR Synch Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_last_epr_synch_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_week_of_year {
    label: "Prescription Transaction Last EPRSynch Week Of Year"
    description: "Prescription Transaction Last EPR Synch Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_last_epr_synch_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_month_num {
    label: "Prescription Transaction Last EPRSynch Month Num"
    description: "Prescription Transaction Last EPR Synch Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_last_epr_synch_cust_timeframes.month_num} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_month {
    label: "Prescription Transaction Last EPRSynch Month"
    description: "Prescription Transaction Last EPR Synch Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_last_epr_synch_cust_timeframes.month} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_quarter_of_year {
    label: "Prescription Transaction Last EPRSynch Quarter Of Year"
    description: "Prescription Transaction Last EPR Synch Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_last_epr_synch_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_quarter {
    label: "Prescription Transaction Last EPRSynch Quarter"
    description: "Prescription Transaction Last EPR Synch Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_last_epr_synch_cust_timeframes.quarter} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_year {
    label: "Prescription Transaction Last EPRSynch Year"
    description: "Prescription Transaction Last EPR Synch Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_last_epr_synch_cust_timeframes.year} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_day_of_week_index {
    label: "Prescription Transaction Last EPRSynch Day Of Week Index"
    description: "Prescription Transaction Last EPR Synch Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_last_epr_synch_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_week_begin_date {
    label: "Prescription Transaction Last EPRSynch Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Transaction Last EPR Synch Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_last_epr_synch_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_week_end_date {
    label: "Prescription Transaction Last EPRSynch Week End Date"
    description: "Prescription Transaction Last EPR Synch Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_last_epr_synch_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_week_of_quarter {
    label: "Prescription Transaction Last EPRSynch Week Of Quarter"
    description: "Prescription Transaction Last EPR Synch Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_last_epr_synch_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_month_begin_date {
    label: "Prescription Transaction Last EPRSynch Month Begin Date"
    description: "Prescription Transaction Last EPR Synch Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_last_epr_synch_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_month_end_date {
    label: "Prescription Transaction Last EPRSynch Month End Date"
    description: "Prescription Transaction Last EPR Synch Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_last_epr_synch_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_weeks_in_month {
    label: "Prescription Transaction Last EPRSynch Weeks In Month"
    description: "Prescription Transaction Last EPR Synch Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_last_epr_synch_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_quarter_begin_date {
    label: "Prescription Transaction Last EPRSynch Quarter Begin Date"
    description: "Prescription Transaction Last EPR Synch Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_last_epr_synch_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_quarter_end_date {
    label: "Prescription Transaction Last EPRSynch Quarter End Date"
    description: "Prescription Transaction Last EPR Synch Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_last_epr_synch_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_weeks_in_quarter {
    label: "Prescription Transaction Last EPRSynch Weeks In Quarter"
    description: "Prescription Transaction Last EPR Synch Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_last_epr_synch_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_year_begin_date {
    label: "Prescription Transaction Last EPRSynch Year Begin Date"
    description: "Prescription Transaction Last EPR Synch Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_last_epr_synch_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_year_end_date {
    label: "Prescription Transaction Last EPRSynch Year End Date"
    description: "Prescription Transaction Last EPR Synch Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_last_epr_synch_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_weeks_in_year {
    label: "Prescription Transaction Last EPRSynch Weeks In Year"
    description: "Prescription Transaction Last EPR Synch Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_last_epr_synch_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_leap_year_flag {
    label: "Prescription Transaction Last EPRSynch Leap Year Flag"
    description: "Prescription Transaction Last EPR Synch Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_last_epr_synch_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_day_of_quarter {
    label: "Prescription Transaction Last EPRSynch Day Of Quarter"
    description: "Prescription Transaction Last EPR Synch Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_last_epr_synch_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  dimension: rx_tx_last_epr_synch_cust_day_of_year {
    label: "Prescription Transaction Last EPRSynch Day Of Year"
    description: "Prescription Transaction Last EPR Synch Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_last_epr_synch_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Transaction Last EPRSynch Date"
  }

  #Prescription Transaction Missing Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_tx_missing_cust {
    label: "Prescription Transaction Missing"
    description: "Prescription Transaction Missing Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_TX_MISSING_DATE ;;
  }

  dimension: rx_tx_missing_cust_calendar_date {
    label: "Prescription Transaction Missing Date"
    description: "Prescription Transaction Missing Date"
    type: date
    hidden: yes
    sql: ${rx_tx_missing_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_chain_id {
    label: "Prescription Transaction Missing Chain ID"
    description: "Prescription Transaction Missing Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_missing_cust_timeframes.chain_id} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_calendar_owner_chain_id {
    label: "Prescription Transaction Missing Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_missing_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_yesno {
    label: "Prescription Transaction Missing (Yes/No)"
    group_label: "Prescription Transaction Missing Date"
    description: "Yes/No flag indicating if a prescription has Missing Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_TX_MISSING_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_tx_missing_cust_day_of_week {
    label: "Prescription Transaction Missing Day Of Week"
    description: "Prescription Transaction Missing Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_missing_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_day_of_month {
    label: "Prescription Transaction Missing Day Of Month"
    description: "Prescription Transaction Missing Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_missing_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_week_of_year {
    label: "Prescription Transaction Missing Week Of Year"
    description: "Prescription Transaction Missing Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_missing_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_month_num {
    label: "Prescription Transaction Missing Month Num"
    description: "Prescription Transaction Missing Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_missing_cust_timeframes.month_num} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_month {
    label: "Prescription Transaction Missing Month"
    description: "Prescription Transaction Missing Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_missing_cust_timeframes.month} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_quarter_of_year {
    label: "Prescription Transaction Missing Quarter Of Year"
    description: "Prescription Transaction Missing Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_missing_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_quarter {
    label: "Prescription Transaction Missing Quarter"
    description: "Prescription Transaction Missing Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_missing_cust_timeframes.quarter} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_year {
    label: "Prescription Transaction Missing Year"
    description: "Prescription Transaction Missing Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_missing_cust_timeframes.year} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_day_of_week_index {
    label: "Prescription Transaction Missing Day Of Week Index"
    description: "Prescription Transaction Missing Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_missing_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_week_begin_date {
    label: "Prescription Transaction Missing Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Transaction Missing Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_missing_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_week_end_date {
    label: "Prescription Transaction Missing Week End Date"
    description: "Prescription Transaction Missing Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_missing_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_week_of_quarter {
    label: "Prescription Transaction Missing Week Of Quarter"
    description: "Prescription Transaction Missing Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_missing_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_month_begin_date {
    label: "Prescription Transaction Missing Month Begin Date"
    description: "Prescription Transaction Missing Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_missing_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_month_end_date {
    label: "Prescription Transaction Missing Month End Date"
    description: "Prescription Transaction Missing Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_missing_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_weeks_in_month {
    label: "Prescription Transaction Missing Weeks In Month"
    description: "Prescription Transaction Missing Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_missing_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_quarter_begin_date {
    label: "Prescription Transaction Missing Quarter Begin Date"
    description: "Prescription Transaction Missing Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_missing_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_quarter_end_date {
    label: "Prescription Transaction Missing Quarter End Date"
    description: "Prescription Transaction Missing Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_missing_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_weeks_in_quarter {
    label: "Prescription Transaction Missing Weeks In Quarter"
    description: "Prescription Transaction Missing Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_missing_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_year_begin_date {
    label: "Prescription Transaction Missing Year Begin Date"
    description: "Prescription Transaction Missing Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_missing_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_year_end_date {
    label: "Prescription Transaction Missing Year End Date"
    description: "Prescription Transaction Missing Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_missing_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_weeks_in_year {
    label: "Prescription Transaction Missing Weeks In Year"
    description: "Prescription Transaction Missing Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_missing_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_leap_year_flag {
    label: "Prescription Transaction Missing Leap Year Flag"
    description: "Prescription Transaction Missing Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_missing_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_day_of_quarter {
    label: "Prescription Transaction Missing Day Of Quarter"
    description: "Prescription Transaction Missing Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_missing_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  dimension: rx_tx_missing_cust_day_of_year {
    label: "Prescription Transaction Missing Day Of Year"
    description: "Prescription Transaction Missing Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_missing_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Transaction Missing Date"
  }

  #Prescription Transaction PC Ready Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_tx_pc_ready_cust {
    label: "Prescription Transaction PC Ready"
    description: "Prescription Transaction PC Ready Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_TX_PC_READY_DATE ;;
  }

  dimension: rx_tx_pc_ready_cust_calendar_date {
    label: "Prescription Transaction PC Ready Date"
    description: "Prescription Transaction PC Ready Date"
    type: date
    hidden: yes
    sql: ${rx_tx_pc_ready_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_chain_id {
    label: "Prescription Transaction PC Ready Chain ID"
    description: "Prescription Transaction PC Ready Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_pc_ready_cust_timeframes.chain_id} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_calendar_owner_chain_id {
    label: "Prescription Transaction PC Ready Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_pc_ready_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_yesno {
    label: "Prescription Transaction PC Ready (Yes/No)"
    group_label: "Prescription Transaction PC Ready Date"
    description: "Yes/No flag indicating if a prescription has PC Ready Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_TX_PC_READY_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_tx_pc_ready_cust_day_of_week {
    label: "Prescription Transaction PC Ready Day Of Week"
    description: "Prescription Transaction PC Ready Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_pc_ready_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_day_of_month {
    label: "Prescription Transaction PC Ready Day Of Month"
    description: "Prescription Transaction PC Ready Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_pc_ready_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_week_of_year {
    label: "Prescription Transaction PC Ready Week Of Year"
    description: "Prescription Transaction PC Ready Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_pc_ready_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_month_num {
    label: "Prescription Transaction PC Ready Month Num"
    description: "Prescription Transaction PC Ready Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_pc_ready_cust_timeframes.month_num} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_month {
    label: "Prescription Transaction PC Ready Month"
    description: "Prescription Transaction PC Ready Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_pc_ready_cust_timeframes.month} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_quarter_of_year {
    label: "Prescription Transaction PC Ready Quarter Of Year"
    description: "Prescription Transaction PC Ready Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_pc_ready_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_quarter {
    label: "Prescription Transaction PC Ready Quarter"
    description: "Prescription Transaction PC Ready Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_pc_ready_cust_timeframes.quarter} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_year {
    label: "Prescription Transaction PC Ready Year"
    description: "Prescription Transaction PC Ready Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_pc_ready_cust_timeframes.year} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_day_of_week_index {
    label: "Prescription Transaction PC Ready Day Of Week Index"
    description: "Prescription Transaction PC Ready Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_pc_ready_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_week_begin_date {
    label: "Prescription Transaction PC Ready Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Transaction PC Ready Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_pc_ready_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_week_end_date {
    label: "Prescription Transaction PC Ready Week End Date"
    description: "Prescription Transaction PC Ready Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_pc_ready_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_week_of_quarter {
    label: "Prescription Transaction PC Ready Week Of Quarter"
    description: "Prescription Transaction PC Ready Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_pc_ready_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_month_begin_date {
    label: "Prescription Transaction PC Ready Month Begin Date"
    description: "Prescription Transaction PC Ready Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_pc_ready_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_month_end_date {
    label: "Prescription Transaction PC Ready Month End Date"
    description: "Prescription Transaction PC Ready Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_pc_ready_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_weeks_in_month {
    label: "Prescription Transaction PC Ready Weeks In Month"
    description: "Prescription Transaction PC Ready Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_pc_ready_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_quarter_begin_date {
    label: "Prescription Transaction PC Ready Quarter Begin Date"
    description: "Prescription Transaction PC Ready Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_pc_ready_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_quarter_end_date {
    label: "Prescription Transaction PC Ready Quarter End Date"
    description: "Prescription Transaction PC Ready Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_pc_ready_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_weeks_in_quarter {
    label: "Prescription Transaction PC Ready Weeks In Quarter"
    description: "Prescription Transaction PC Ready Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_pc_ready_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_year_begin_date {
    label: "Prescription Transaction PC Ready Year Begin Date"
    description: "Prescription Transaction PC Ready Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_pc_ready_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_year_end_date {
    label: "Prescription Transaction PC Ready Year End Date"
    description: "Prescription Transaction PC Ready Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_pc_ready_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_weeks_in_year {
    label: "Prescription Transaction PC Ready Weeks In Year"
    description: "Prescription Transaction PC Ready Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_pc_ready_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_leap_year_flag {
    label: "Prescription Transaction PC Ready Leap Year Flag"
    description: "Prescription Transaction PC Ready Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_pc_ready_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_day_of_quarter {
    label: "Prescription Transaction PC Ready Day Of Quarter"
    description: "Prescription Transaction PC Ready Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_pc_ready_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  dimension: rx_tx_pc_ready_cust_day_of_year {
    label: "Prescription Transaction PC Ready Day Of Year"
    description: "Prescription Transaction PC Ready Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_pc_ready_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Transaction PC Ready Date"
  }

  #Prescription Transaction Replace Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_tx_replace_cust {
    label: "Prescription Transaction Replace"
    description: "Prescription Transaction Replace Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_TX_REPLACE_DATE ;;
  }

  dimension: rx_tx_replace_cust_calendar_date {
    label: "Prescription Transaction Replace Date"
    description: "Prescription Transaction Replace Date"
    type: date
    hidden: yes
    sql: ${rx_tx_replace_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_chain_id {
    label: "Prescription Transaction Replace Chain ID"
    description: "Prescription Transaction Replace Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_replace_cust_timeframes.chain_id} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_calendar_owner_chain_id {
    label: "Prescription Transaction Replace Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_replace_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_yesno {
    label: "Prescription Transaction Replace (Yes/No)"
    group_label: "Prescription Transaction Replace Date"
    description: "Yes/No flag indicating if a prescription has Replace Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_TX_REPLACE_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_tx_replace_cust_day_of_week {
    label: "Prescription Transaction Replace Day Of Week"
    description: "Prescription Transaction Replace Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_replace_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_day_of_month {
    label: "Prescription Transaction Replace Day Of Month"
    description: "Prescription Transaction Replace Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_replace_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_week_of_year {
    label: "Prescription Transaction Replace Week Of Year"
    description: "Prescription Transaction Replace Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_replace_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_month_num {
    label: "Prescription Transaction Replace Month Num"
    description: "Prescription Transaction Replace Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_replace_cust_timeframes.month_num} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_month {
    label: "Prescription Transaction Replace Month"
    description: "Prescription Transaction Replace Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_replace_cust_timeframes.month} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_quarter_of_year {
    label: "Prescription Transaction Replace Quarter Of Year"
    description: "Prescription Transaction Replace Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_replace_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_quarter {
    label: "Prescription Transaction Replace Quarter"
    description: "Prescription Transaction Replace Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_replace_cust_timeframes.quarter} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_year {
    label: "Prescription Transaction Replace Year"
    description: "Prescription Transaction Replace Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_replace_cust_timeframes.year} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_day_of_week_index {
    label: "Prescription Transaction Replace Day Of Week Index"
    description: "Prescription Transaction Replace Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_replace_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_week_begin_date {
    label: "Prescription Transaction Replace Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Transaction Replace Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_replace_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_week_end_date {
    label: "Prescription Transaction Replace Week End Date"
    description: "Prescription Transaction Replace Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_replace_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_week_of_quarter {
    label: "Prescription Transaction Replace Week Of Quarter"
    description: "Prescription Transaction Replace Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_replace_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_month_begin_date {
    label: "Prescription Transaction Replace Month Begin Date"
    description: "Prescription Transaction Replace Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_replace_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_month_end_date {
    label: "Prescription Transaction Replace Month End Date"
    description: "Prescription Transaction Replace Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_replace_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_weeks_in_month {
    label: "Prescription Transaction Replace Weeks In Month"
    description: "Prescription Transaction Replace Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_replace_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_quarter_begin_date {
    label: "Prescription Transaction Replace Quarter Begin Date"
    description: "Prescription Transaction Replace Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_replace_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_quarter_end_date {
    label: "Prescription Transaction Replace Quarter End Date"
    description: "Prescription Transaction Replace Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_replace_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_weeks_in_quarter {
    label: "Prescription Transaction Replace Weeks In Quarter"
    description: "Prescription Transaction Replace Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_replace_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_year_begin_date {
    label: "Prescription Transaction Replace Year Begin Date"
    description: "Prescription Transaction Replace Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_replace_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_year_end_date {
    label: "Prescription Transaction Replace Year End Date"
    description: "Prescription Transaction Replace Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_replace_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_weeks_in_year {
    label: "Prescription Transaction Replace Weeks In Year"
    description: "Prescription Transaction Replace Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_replace_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_leap_year_flag {
    label: "Prescription Transaction Replace Leap Year Flag"
    description: "Prescription Transaction Replace Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_replace_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_day_of_quarter {
    label: "Prescription Transaction Replace Day Of Quarter"
    description: "Prescription Transaction Replace Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_replace_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  dimension: rx_tx_replace_cust_day_of_year {
    label: "Prescription Transaction Replace Day Of Year"
    description: "Prescription Transaction Replace Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_replace_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Transaction Replace Date"
  }

  #Prescription Transaction Return To Stock Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_tx_return_to_stock_cust {
    label: "Prescription Transaction Return To Stock"
    description: "Prescription Transaction Return To Stock Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_TX_RETURN_TO_STOCK_DATE ;;
  }

  dimension: rx_tx_return_to_stock_cust_calendar_date {
    label: "Prescription Transaction Return To Stock Date"
    description: "Prescription Transaction Return To Stock Date"
    type: date
    hidden: yes
    sql: ${rx_tx_return_to_stock_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_chain_id {
    label: "Prescription Transaction Return To Stock Chain ID"
    description: "Prescription Transaction Return To Stock Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_return_to_stock_cust_timeframes.chain_id} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_calendar_owner_chain_id {
    label: "Prescription Transaction Return To Stock Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_return_to_stock_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_yesno {
    label: "Prescription Transaction Return To Stock (Yes/No)"
    group_label: "Prescription Transaction Return To Stock Date"
    description: "Yes/No flag indicating if a prescription has Return To Stock Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_TX_RETURN_TO_STOCK_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_tx_return_to_stock_cust_day_of_week {
    label: "Prescription Transaction Return To Stock Day Of Week"
    description: "Prescription Transaction Return To Stock Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_return_to_stock_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_day_of_month {
    label: "Prescription Transaction Return To Stock Day Of Month"
    description: "Prescription Transaction Return To Stock Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_return_to_stock_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_week_of_year {
    label: "Prescription Transaction Return To Stock Week Of Year"
    description: "Prescription Transaction Return To Stock Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_return_to_stock_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_month_num {
    label: "Prescription Transaction Return To Stock Month Num"
    description: "Prescription Transaction Return To Stock Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_return_to_stock_cust_timeframes.month_num} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_month {
    label: "Prescription Transaction Return To Stock Month"
    description: "Prescription Transaction Return To Stock Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_return_to_stock_cust_timeframes.month} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_quarter_of_year {
    label: "Prescription Transaction Return To Stock Quarter Of Year"
    description: "Prescription Transaction Return To Stock Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_return_to_stock_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_quarter {
    label: "Prescription Transaction Return To Stock Quarter"
    description: "Prescription Transaction Return To Stock Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_return_to_stock_cust_timeframes.quarter} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_year {
    label: "Prescription Transaction Return To Stock Year"
    description: "Prescription Transaction Return To Stock Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_return_to_stock_cust_timeframes.year} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_day_of_week_index {
    label: "Prescription Transaction Return To Stock Day Of Week Index"
    description: "Prescription Transaction Return To Stock Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_return_to_stock_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_week_begin_date {
    label: "Prescription Transaction Return To Stock Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Transaction Return To Stock Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_return_to_stock_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_week_end_date {
    label: "Prescription Transaction Return To Stock Week End Date"
    description: "Prescription Transaction Return To Stock Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_return_to_stock_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_week_of_quarter {
    label: "Prescription Transaction Return To Stock Week Of Quarter"
    description: "Prescription Transaction Return To Stock Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_return_to_stock_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_month_begin_date {
    label: "Prescription Transaction Return To Stock Month Begin Date"
    description: "Prescription Transaction Return To Stock Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_return_to_stock_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_month_end_date {
    label: "Prescription Transaction Return To Stock Month End Date"
    description: "Prescription Transaction Return To Stock Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_return_to_stock_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_weeks_in_month {
    label: "Prescription Transaction Return To Stock Weeks In Month"
    description: "Prescription Transaction Return To Stock Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_return_to_stock_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_quarter_begin_date {
    label: "Prescription Transaction Return To Stock Quarter Begin Date"
    description: "Prescription Transaction Return To Stock Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_return_to_stock_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_quarter_end_date {
    label: "Prescription Transaction Return To Stock Quarter End Date"
    description: "Prescription Transaction Return To Stock Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_return_to_stock_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_weeks_in_quarter {
    label: "Prescription Transaction Return To Stock Weeks In Quarter"
    description: "Prescription Transaction Return To Stock Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_return_to_stock_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_year_begin_date {
    label: "Prescription Transaction Return To Stock Year Begin Date"
    description: "Prescription Transaction Return To Stock Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_return_to_stock_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_year_end_date {
    label: "Prescription Transaction Return To Stock Year End Date"
    description: "Prescription Transaction Return To Stock Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_return_to_stock_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_weeks_in_year {
    label: "Prescription Transaction Return To Stock Weeks In Year"
    description: "Prescription Transaction Return To Stock Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_return_to_stock_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_leap_year_flag {
    label: "Prescription Transaction Return To Stock Leap Year Flag"
    description: "Prescription Transaction Return To Stock Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_return_to_stock_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_day_of_quarter {
    label: "Prescription Transaction Return To Stock Day Of Quarter"
    description: "Prescription Transaction Return To Stock Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_return_to_stock_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  dimension: rx_tx_return_to_stock_cust_day_of_year {
    label: "Prescription Transaction Return To Stock Day Of Year"
    description: "Prescription Transaction Return To Stock Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_return_to_stock_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Transaction Return To Stock Date"
  }

  #Prescription Transaction Counseling Completion Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_tx_counseling_completion_cust {
    label: "Prescription Transaction Counseling Completion"
    description: "Prescription Transaction Counseling Completion Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_TX_COUNSELING_COMPLETION_DATE ;;
  }

  dimension: rx_tx_counseling_completion_cust_calendar_date {
    label: "Prescription Transaction Counseling Completion Date"
    description: "Prescription Transaction Counseling Completion Date"
    type: date
    hidden: yes
    sql: ${rx_tx_counseling_completion_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_chain_id {
    label: "Prescription Transaction Counseling Completion Chain ID"
    description: "Prescription Transaction Counseling Completion Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_counseling_completion_cust_timeframes.chain_id} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_calendar_owner_chain_id {
    label: "Prescription Transaction Counseling Completion Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_counseling_completion_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_yesno {
    label: "Prescription Transaction Counseling Completion (Yes/No)"
    group_label: "Prescription Transaction Counseling Completion Date"
    description: "Yes/No flag indicating if a prescription has Counseling Completion Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_TX_COUNSELING_COMPLETION_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_tx_counseling_completion_cust_day_of_week {
    label: "Prescription Transaction Counseling Completion Day Of Week"
    description: "Prescription Transaction Counseling Completion Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_counseling_completion_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_day_of_month {
    label: "Prescription Transaction Counseling Completion Day Of Month"
    description: "Prescription Transaction Counseling Completion Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_counseling_completion_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_week_of_year {
    label: "Prescription Transaction Counseling Completion Week Of Year"
    description: "Prescription Transaction Counseling Completion Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_counseling_completion_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_month_num {
    label: "Prescription Transaction Counseling Completion Month Num"
    description: "Prescription Transaction Counseling Completion Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_counseling_completion_cust_timeframes.month_num} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_month {
    label: "Prescription Transaction Counseling Completion Month"
    description: "Prescription Transaction Counseling Completion Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_counseling_completion_cust_timeframes.month} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_quarter_of_year {
    label: "Prescription Transaction Counseling Completion Quarter Of Year"
    description: "Prescription Transaction Counseling Completion Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_counseling_completion_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_quarter {
    label: "Prescription Transaction Counseling Completion Quarter"
    description: "Prescription Transaction Counseling Completion Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_counseling_completion_cust_timeframes.quarter} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_year {
    label: "Prescription Transaction Counseling Completion Year"
    description: "Prescription Transaction Counseling Completion Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_counseling_completion_cust_timeframes.year} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_day_of_week_index {
    label: "Prescription Transaction Counseling Completion Day Of Week Index"
    description: "Prescription Transaction Counseling Completion Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_counseling_completion_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_week_begin_date {
    label: "Prescription Transaction Counseling Completion Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Transaction Counseling Completion Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_counseling_completion_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_week_end_date {
    label: "Prescription Transaction Counseling Completion Week End Date"
    description: "Prescription Transaction Counseling Completion Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_counseling_completion_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_week_of_quarter {
    label: "Prescription Transaction Counseling Completion Week Of Quarter"
    description: "Prescription Transaction Counseling Completion Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_counseling_completion_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_month_begin_date {
    label: "Prescription Transaction Counseling Completion Month Begin Date"
    description: "Prescription Transaction Counseling Completion Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_counseling_completion_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_month_end_date {
    label: "Prescription Transaction Counseling Completion Month End Date"
    description: "Prescription Transaction Counseling Completion Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_counseling_completion_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_weeks_in_month {
    label: "Prescription Transaction Counseling Completion Weeks In Month"
    description: "Prescription Transaction Counseling Completion Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_counseling_completion_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_quarter_begin_date {
    label: "Prescription Transaction Counseling Completion Quarter Begin Date"
    description: "Prescription Transaction Counseling Completion Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_counseling_completion_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_quarter_end_date {
    label: "Prescription Transaction Counseling Completion Quarter End Date"
    description: "Prescription Transaction Counseling Completion Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_counseling_completion_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_weeks_in_quarter {
    label: "Prescription Transaction Counseling Completion Weeks In Quarter"
    description: "Prescription Transaction Counseling Completion Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_counseling_completion_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_year_begin_date {
    label: "Prescription Transaction Counseling Completion Year Begin Date"
    description: "Prescription Transaction Counseling Completion Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_counseling_completion_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_year_end_date {
    label: "Prescription Transaction Counseling Completion Year End Date"
    description: "Prescription Transaction Counseling Completion Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_counseling_completion_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_weeks_in_year {
    label: "Prescription Transaction Counseling Completion Weeks In Year"
    description: "Prescription Transaction Counseling Completion Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_counseling_completion_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_leap_year_flag {
    label: "Prescription Transaction Counseling Completion Leap Year Flag"
    description: "Prescription Transaction Counseling Completion Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_counseling_completion_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_day_of_quarter {
    label: "Prescription Transaction Counseling Completion Day Of Quarter"
    description: "Prescription Transaction Counseling Completion Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_counseling_completion_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  dimension: rx_tx_counseling_completion_cust_day_of_year {
    label: "Prescription Transaction Counseling Completion Day Of Year"
    description: "Prescription Transaction Counseling Completion Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_counseling_completion_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Transaction Counseling Completion Date"
  }

  #Prescription Transaction Network Plan Bill Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_tx_network_plan_bill_cust {
    label: "Prescription Transaction Network Plan Bill"
    description: "Prescription Transaction Network Plan Bill Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_TX_NETWORK_PLAN_BILL_DATE ;;
  }

  dimension: rx_tx_network_plan_bill_cust_calendar_date {
    label: "Prescription Transaction Network Plan Bill Date"
    description: "Prescription Transaction Network Plan Bill Date"
    type: date
    hidden: yes
    sql: ${rx_tx_network_plan_bill_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_chain_id {
    label: "Prescription Transaction Network Plan Bill Chain ID"
    description: "Prescription Transaction Network Plan Bill Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_network_plan_bill_cust_timeframes.chain_id} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_calendar_owner_chain_id {
    label: "Prescription Transaction Network Plan Bill Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_network_plan_bill_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_yesno {
    label: "Prescription Transaction Network Plan Bill (Yes/No)"
    group_label: "Prescription Transaction Network Plan Bill Date"
    description: "Yes/No flag indicating if a prescription has Network Plan Bill Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_TX_NETWORK_PLAN_BILL_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_tx_network_plan_bill_cust_day_of_week {
    label: "Prescription Transaction Network Plan Bill Day Of Week"
    description: "Prescription Transaction Network Plan Bill Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_network_plan_bill_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_day_of_month {
    label: "Prescription Transaction Network Plan Bill Day Of Month"
    description: "Prescription Transaction Network Plan Bill Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_network_plan_bill_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_week_of_year {
    label: "Prescription Transaction Network Plan Bill Week Of Year"
    description: "Prescription Transaction Network Plan Bill Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_network_plan_bill_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_month_num {
    label: "Prescription Transaction Network Plan Bill Month Num"
    description: "Prescription Transaction Network Plan Bill Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_network_plan_bill_cust_timeframes.month_num} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_month {
    label: "Prescription Transaction Network Plan Bill Month"
    description: "Prescription Transaction Network Plan Bill Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_network_plan_bill_cust_timeframes.month} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_quarter_of_year {
    label: "Prescription Transaction Network Plan Bill Quarter Of Year"
    description: "Prescription Transaction Network Plan Bill Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_network_plan_bill_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_quarter {
    label: "Prescription Transaction Network Plan Bill Quarter"
    description: "Prescription Transaction Network Plan Bill Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_network_plan_bill_cust_timeframes.quarter} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_year {
    label: "Prescription Transaction Network Plan Bill Year"
    description: "Prescription Transaction Network Plan Bill Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_network_plan_bill_cust_timeframes.year} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_day_of_week_index {
    label: "Prescription Transaction Network Plan Bill Day Of Week Index"
    description: "Prescription Transaction Network Plan Bill Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_network_plan_bill_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_week_begin_date {
    label: "Prescription Transaction Network Plan Bill Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Transaction Network Plan Bill Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_network_plan_bill_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_week_end_date {
    label: "Prescription Transaction Network Plan Bill Week End Date"
    description: "Prescription Transaction Network Plan Bill Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_network_plan_bill_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_week_of_quarter {
    label: "Prescription Transaction Network Plan Bill Week Of Quarter"
    description: "Prescription Transaction Network Plan Bill Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_network_plan_bill_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_month_begin_date {
    label: "Prescription Transaction Network Plan Bill Month Begin Date"
    description: "Prescription Transaction Network Plan Bill Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_network_plan_bill_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_month_end_date {
    label: "Prescription Transaction Network Plan Bill Month End Date"
    description: "Prescription Transaction Network Plan Bill Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_network_plan_bill_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_weeks_in_month {
    label: "Prescription Transaction Network Plan Bill Weeks In Month"
    description: "Prescription Transaction Network Plan Bill Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_network_plan_bill_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_quarter_begin_date {
    label: "Prescription Transaction Network Plan Bill Quarter Begin Date"
    description: "Prescription Transaction Network Plan Bill Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_network_plan_bill_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_quarter_end_date {
    label: "Prescription Transaction Network Plan Bill Quarter End Date"
    description: "Prescription Transaction Network Plan Bill Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_network_plan_bill_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_weeks_in_quarter {
    label: "Prescription Transaction Network Plan Bill Weeks In Quarter"
    description: "Prescription Transaction Network Plan Bill Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_network_plan_bill_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_year_begin_date {
    label: "Prescription Transaction Network Plan Bill Year Begin Date"
    description: "Prescription Transaction Network Plan Bill Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_network_plan_bill_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_year_end_date {
    label: "Prescription Transaction Network Plan Bill Year End Date"
    description: "Prescription Transaction Network Plan Bill Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_network_plan_bill_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_weeks_in_year {
    label: "Prescription Transaction Network Plan Bill Weeks In Year"
    description: "Prescription Transaction Network Plan Bill Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_network_plan_bill_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_leap_year_flag {
    label: "Prescription Transaction Network Plan Bill Leap Year Flag"
    description: "Prescription Transaction Network Plan Bill Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_network_plan_bill_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_day_of_quarter {
    label: "Prescription Transaction Network Plan Bill Day Of Quarter"
    description: "Prescription Transaction Network Plan Bill Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_network_plan_bill_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  dimension: rx_tx_network_plan_bill_cust_day_of_year {
    label: "Prescription Transaction Network Plan Bill Day Of Year"
    description: "Prescription Transaction Network Plan Bill Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_network_plan_bill_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Transaction Network Plan Bill Date"
  }

  #Prescription Transaction Central Fill Cutoff Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_tx_central_fill_cutoff_cust {
    label: "Prescription Transaction Central Fill Cutoff"
    description: "Prescription Transaction Central Fill Cutoff Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_TX_CENTRAL_FILL_CUTOFF_DATE ;;
  }

  dimension: rx_tx_central_fill_cutoff_cust_calendar_date {
    label: "Prescription Transaction Central Fill Cutoff Date"
    description: "Prescription Transaction Central Fill Cutoff Date"
    type: date
    hidden: yes
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_chain_id {
    label: "Prescription Transaction Central Fill Cutoff Chain ID"
    description: "Prescription Transaction Central Fill Cutoff Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.chain_id} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_calendar_owner_chain_id {
    label: "Prescription Transaction Central Fill Cutoff Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_yesno {
    label: "Prescription Transaction Central Fill Cutoff (Yes/No)"
    group_label: "Prescription Transaction Central Fill Cutoff Date"
    description: "Yes/No flag indicating if a prescription has Central Fill Cutoff Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_TX_CENTRAL_FILL_CUTOFF_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_tx_central_fill_cutoff_cust_day_of_week {
    label: "Prescription Transaction Central Fill Cutoff Day Of Week"
    description: "Prescription Transaction Central Fill Cutoff Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_day_of_month {
    label: "Prescription Transaction Central Fill Cutoff Day Of Month"
    description: "Prescription Transaction Central Fill Cutoff Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_week_of_year {
    label: "Prescription Transaction Central Fill Cutoff Week Of Year"
    description: "Prescription Transaction Central Fill Cutoff Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_month_num {
    label: "Prescription Transaction Central Fill Cutoff Month Num"
    description: "Prescription Transaction Central Fill Cutoff Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.month_num} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_month {
    label: "Prescription Transaction Central Fill Cutoff Month"
    description: "Prescription Transaction Central Fill Cutoff Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.month} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_quarter_of_year {
    label: "Prescription Transaction Central Fill Cutoff Quarter Of Year"
    description: "Prescription Transaction Central Fill Cutoff Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_quarter {
    label: "Prescription Transaction Central Fill Cutoff Quarter"
    description: "Prescription Transaction Central Fill Cutoff Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.quarter} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_year {
    label: "Prescription Transaction Central Fill Cutoff Year"
    description: "Prescription Transaction Central Fill Cutoff Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.year} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_day_of_week_index {
    label: "Prescription Transaction Central Fill Cutoff Day Of Week Index"
    description: "Prescription Transaction Central Fill Cutoff Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_week_begin_date {
    label: "Prescription Transaction Central Fill Cutoff Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Transaction Central Fill Cutoff Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_week_end_date {
    label: "Prescription Transaction Central Fill Cutoff Week End Date"
    description: "Prescription Transaction Central Fill Cutoff Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_week_of_quarter {
    label: "Prescription Transaction Central Fill Cutoff Week Of Quarter"
    description: "Prescription Transaction Central Fill Cutoff Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_month_begin_date {
    label: "Prescription Transaction Central Fill Cutoff Month Begin Date"
    description: "Prescription Transaction Central Fill Cutoff Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_month_end_date {
    label: "Prescription Transaction Central Fill Cutoff Month End Date"
    description: "Prescription Transaction Central Fill Cutoff Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_weeks_in_month {
    label: "Prescription Transaction Central Fill Cutoff Weeks In Month"
    description: "Prescription Transaction Central Fill Cutoff Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_quarter_begin_date {
    label: "Prescription Transaction Central Fill Cutoff Quarter Begin Date"
    description: "Prescription Transaction Central Fill Cutoff Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_quarter_end_date {
    label: "Prescription Transaction Central Fill Cutoff Quarter End Date"
    description: "Prescription Transaction Central Fill Cutoff Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_weeks_in_quarter {
    label: "Prescription Transaction Central Fill Cutoff Weeks In Quarter"
    description: "Prescription Transaction Central Fill Cutoff Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_year_begin_date {
    label: "Prescription Transaction Central Fill Cutoff Year Begin Date"
    description: "Prescription Transaction Central Fill Cutoff Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_year_end_date {
    label: "Prescription Transaction Central Fill Cutoff Year End Date"
    description: "Prescription Transaction Central Fill Cutoff Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_weeks_in_year {
    label: "Prescription Transaction Central Fill Cutoff Weeks In Year"
    description: "Prescription Transaction Central Fill Cutoff Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_leap_year_flag {
    label: "Prescription Transaction Central Fill Cutoff Leap Year Flag"
    description: "Prescription Transaction Central Fill Cutoff Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_day_of_quarter {
    label: "Prescription Transaction Central Fill Cutoff Day Of Quarter"
    description: "Prescription Transaction Central Fill Cutoff Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  dimension: rx_tx_central_fill_cutoff_cust_day_of_year {
    label: "Prescription Transaction Central Fill Cutoff Day Of Year"
    description: "Prescription Transaction Central Fill Cutoff Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_central_fill_cutoff_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Transaction Central Fill Cutoff Date"
  }

  #Prescription Transaction Drug Expiration Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_tx_drug_expiration_cust {
    label: "Prescription Transaction Drug Expiration"
    description: "Prescription Transaction Drug Expiration Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_TX_DRUG_EXPIRATION_DATE ;;
  }

  dimension: rx_tx_drug_expiration_cust_calendar_date {
    label: "Prescription Transaction Drug Expiration Date"
    description: "Prescription Transaction Drug Expiration Date"
    type: date
    hidden: yes
    sql: ${rx_tx_drug_expiration_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_chain_id {
    label: "Prescription Transaction Drug Expiration Chain ID"
    description: "Prescription Transaction Drug Expiration Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_drug_expiration_cust_timeframes.chain_id} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_calendar_owner_chain_id {
    label: "Prescription Transaction Drug Expiration Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_drug_expiration_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_yesno {
    label: "Prescription Transaction Drug Expiration (Yes/No)"
    group_label: "Prescription Transaction Drug Expiration Date"
    description: "Yes/No flag indicating if a prescription has Drug Expiration Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_TX_DRUG_EXPIRATION_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_tx_drug_expiration_cust_day_of_week {
    label: "Prescription Transaction Drug Expiration Day Of Week"
    description: "Prescription Transaction Drug Expiration Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_drug_expiration_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_day_of_month {
    label: "Prescription Transaction Drug Expiration Day Of Month"
    description: "Prescription Transaction Drug Expiration Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_drug_expiration_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_week_of_year {
    label: "Prescription Transaction Drug Expiration Week Of Year"
    description: "Prescription Transaction Drug Expiration Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_drug_expiration_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_month_num {
    label: "Prescription Transaction Drug Expiration Month Num"
    description: "Prescription Transaction Drug Expiration Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_drug_expiration_cust_timeframes.month_num} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_month {
    label: "Prescription Transaction Drug Expiration Month"
    description: "Prescription Transaction Drug Expiration Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_drug_expiration_cust_timeframes.month} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_quarter_of_year {
    label: "Prescription Transaction Drug Expiration Quarter Of Year"
    description: "Prescription Transaction Drug Expiration Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_drug_expiration_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_quarter {
    label: "Prescription Transaction Drug Expiration Quarter"
    description: "Prescription Transaction Drug Expiration Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_drug_expiration_cust_timeframes.quarter} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_year {
    label: "Prescription Transaction Drug Expiration Year"
    description: "Prescription Transaction Drug Expiration Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_drug_expiration_cust_timeframes.year} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_day_of_week_index {
    label: "Prescription Transaction Drug Expiration Day Of Week Index"
    description: "Prescription Transaction Drug Expiration Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_drug_expiration_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_week_begin_date {
    label: "Prescription Transaction Drug Expiration Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Transaction Drug Expiration Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_drug_expiration_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_week_end_date {
    label: "Prescription Transaction Drug Expiration Week End Date"
    description: "Prescription Transaction Drug Expiration Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_drug_expiration_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_week_of_quarter {
    label: "Prescription Transaction Drug Expiration Week Of Quarter"
    description: "Prescription Transaction Drug Expiration Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_drug_expiration_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_month_begin_date {
    label: "Prescription Transaction Drug Expiration Month Begin Date"
    description: "Prescription Transaction Drug Expiration Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_drug_expiration_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_month_end_date {
    label: "Prescription Transaction Drug Expiration Month End Date"
    description: "Prescription Transaction Drug Expiration Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_drug_expiration_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_weeks_in_month {
    label: "Prescription Transaction Drug Expiration Weeks In Month"
    description: "Prescription Transaction Drug Expiration Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_drug_expiration_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_quarter_begin_date {
    label: "Prescription Transaction Drug Expiration Quarter Begin Date"
    description: "Prescription Transaction Drug Expiration Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_drug_expiration_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_quarter_end_date {
    label: "Prescription Transaction Drug Expiration Quarter End Date"
    description: "Prescription Transaction Drug Expiration Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_drug_expiration_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_weeks_in_quarter {
    label: "Prescription Transaction Drug Expiration Weeks In Quarter"
    description: "Prescription Transaction Drug Expiration Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_drug_expiration_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_year_begin_date {
    label: "Prescription Transaction Drug Expiration Year Begin Date"
    description: "Prescription Transaction Drug Expiration Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_drug_expiration_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_year_end_date {
    label: "Prescription Transaction Drug Expiration Year End Date"
    description: "Prescription Transaction Drug Expiration Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_drug_expiration_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_weeks_in_year {
    label: "Prescription Transaction Drug Expiration Weeks In Year"
    description: "Prescription Transaction Drug Expiration Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_drug_expiration_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_leap_year_flag {
    label: "Prescription Transaction Drug Expiration Leap Year Flag"
    description: "Prescription Transaction Drug Expiration Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_drug_expiration_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_day_of_quarter {
    label: "Prescription Transaction Drug Expiration Day Of Quarter"
    description: "Prescription Transaction Drug Expiration Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_drug_expiration_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  dimension: rx_tx_drug_expiration_cust_day_of_year {
    label: "Prescription Transaction Drug Expiration Day Of Year"
    description: "Prescription Transaction Drug Expiration Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_drug_expiration_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Transaction Drug Expiration Date"
  }

  #Prescription Transaction Drug Image Start Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_tx_drug_image_start_cust {
    label: "Prescription Transaction Drug Image Start"
    description: "Prescription Transaction Drug Image Start Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_TX_DRUG_IMAGE_START_DATE ;;
  }

  dimension: rx_tx_drug_image_start_cust_calendar_date {
    label: "Prescription Transaction Drug Image Start Date"
    description: "Prescription Transaction Drug Image Start Date"
    type: date
    hidden: yes
    sql: ${rx_tx_drug_image_start_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_chain_id {
    label: "Prescription Transaction Drug Image Start Chain ID"
    description: "Prescription Transaction Drug Image Start Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_drug_image_start_cust_timeframes.chain_id} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_calendar_owner_chain_id {
    label: "Prescription Transaction Drug Image Start Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_drug_image_start_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_yesno {
    label: "Prescription Transaction Drug Image Start (Yes/No)"
    group_label: "Prescription Transaction Drug Image Start Date"
    description: "Yes/No flag indicating if a prescription has Drug Image Start Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_TX_DRUG_IMAGE_START_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_tx_drug_image_start_cust_day_of_week {
    label: "Prescription Transaction Drug Image Start Day Of Week"
    description: "Prescription Transaction Drug Image Start Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_drug_image_start_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_day_of_month {
    label: "Prescription Transaction Drug Image Start Day Of Month"
    description: "Prescription Transaction Drug Image Start Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_drug_image_start_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_week_of_year {
    label: "Prescription Transaction Drug Image Start Week Of Year"
    description: "Prescription Transaction Drug Image Start Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_drug_image_start_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_month_num {
    label: "Prescription Transaction Drug Image Start Month Num"
    description: "Prescription Transaction Drug Image Start Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_drug_image_start_cust_timeframes.month_num} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_month {
    label: "Prescription Transaction Drug Image Start Month"
    description: "Prescription Transaction Drug Image Start Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_drug_image_start_cust_timeframes.month} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_quarter_of_year {
    label: "Prescription Transaction Drug Image Start Quarter Of Year"
    description: "Prescription Transaction Drug Image Start Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_drug_image_start_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_quarter {
    label: "Prescription Transaction Drug Image Start Quarter"
    description: "Prescription Transaction Drug Image Start Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_drug_image_start_cust_timeframes.quarter} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_year {
    label: "Prescription Transaction Drug Image Start Year"
    description: "Prescription Transaction Drug Image Start Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_drug_image_start_cust_timeframes.year} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_day_of_week_index {
    label: "Prescription Transaction Drug Image Start Day Of Week Index"
    description: "Prescription Transaction Drug Image Start Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_drug_image_start_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_week_begin_date {
    label: "Prescription Transaction Drug Image Start Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Transaction Drug Image Start Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_drug_image_start_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_week_end_date {
    label: "Prescription Transaction Drug Image Start Week End Date"
    description: "Prescription Transaction Drug Image Start Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_drug_image_start_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_week_of_quarter {
    label: "Prescription Transaction Drug Image Start Week Of Quarter"
    description: "Prescription Transaction Drug Image Start Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_drug_image_start_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_month_begin_date {
    label: "Prescription Transaction Drug Image Start Month Begin Date"
    description: "Prescription Transaction Drug Image Start Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_drug_image_start_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_month_end_date {
    label: "Prescription Transaction Drug Image Start Month End Date"
    description: "Prescription Transaction Drug Image Start Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_drug_image_start_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_weeks_in_month {
    label: "Prescription Transaction Drug Image Start Weeks In Month"
    description: "Prescription Transaction Drug Image Start Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_drug_image_start_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_quarter_begin_date {
    label: "Prescription Transaction Drug Image Start Quarter Begin Date"
    description: "Prescription Transaction Drug Image Start Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_drug_image_start_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_quarter_end_date {
    label: "Prescription Transaction Drug Image Start Quarter End Date"
    description: "Prescription Transaction Drug Image Start Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_drug_image_start_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_weeks_in_quarter {
    label: "Prescription Transaction Drug Image Start Weeks In Quarter"
    description: "Prescription Transaction Drug Image Start Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_drug_image_start_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_year_begin_date {
    label: "Prescription Transaction Drug Image Start Year Begin Date"
    description: "Prescription Transaction Drug Image Start Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_drug_image_start_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_year_end_date {
    label: "Prescription Transaction Drug Image Start Year End Date"
    description: "Prescription Transaction Drug Image Start Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_drug_image_start_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_weeks_in_year {
    label: "Prescription Transaction Drug Image Start Weeks In Year"
    description: "Prescription Transaction Drug Image Start Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_drug_image_start_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_leap_year_flag {
    label: "Prescription Transaction Drug Image Start Leap Year Flag"
    description: "Prescription Transaction Drug Image Start Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_drug_image_start_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_day_of_quarter {
    label: "Prescription Transaction Drug Image Start Day Of Quarter"
    description: "Prescription Transaction Drug Image Start Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_drug_image_start_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  dimension: rx_tx_drug_image_start_cust_day_of_year {
    label: "Prescription Transaction Drug Image Start Day Of Year"
    description: "Prescription Transaction Drug Image Start Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_drug_image_start_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Transaction Drug Image Start Date"
  }

  #Prescription Transaction Follow Up Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_tx_follow_up_cust {
    label: "Prescription Transaction Follow Up"
    description: "Prescription Transaction Follow Up Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_TX_FOLLOW_UP_DATE ;;
  }

  dimension: rx_tx_follow_up_cust_calendar_date {
    label: "Prescription Transaction Follow Up Date"
    description: "Prescription Transaction Follow Up Date"
    type: date
    hidden: yes
    sql: ${rx_tx_follow_up_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_chain_id {
    label: "Prescription Transaction Follow Up Chain ID"
    description: "Prescription Transaction Follow Up Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_follow_up_cust_timeframes.chain_id} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_calendar_owner_chain_id {
    label: "Prescription Transaction Follow Up Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_follow_up_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_yesno {
    label: "Prescription Transaction Follow Up (Yes/No)"
    group_label: "Prescription Transaction Follow Up Date"
    description: "Yes/No flag indicating if a prescription has Follow Up Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_TX_FOLLOW_UP_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_tx_follow_up_cust_day_of_week {
    label: "Prescription Transaction Follow Up Day Of Week"
    description: "Prescription Transaction Follow Up Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_follow_up_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_day_of_month {
    label: "Prescription Transaction Follow Up Day Of Month"
    description: "Prescription Transaction Follow Up Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_follow_up_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_week_of_year {
    label: "Prescription Transaction Follow Up Week Of Year"
    description: "Prescription Transaction Follow Up Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_follow_up_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_month_num {
    label: "Prescription Transaction Follow Up Month Num"
    description: "Prescription Transaction Follow Up Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_follow_up_cust_timeframes.month_num} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_month {
    label: "Prescription Transaction Follow Up Month"
    description: "Prescription Transaction Follow Up Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_follow_up_cust_timeframes.month} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_quarter_of_year {
    label: "Prescription Transaction Follow Up Quarter Of Year"
    description: "Prescription Transaction Follow Up Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_follow_up_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_quarter {
    label: "Prescription Transaction Follow Up Quarter"
    description: "Prescription Transaction Follow Up Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_follow_up_cust_timeframes.quarter} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_year {
    label: "Prescription Transaction Follow Up Year"
    description: "Prescription Transaction Follow Up Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_follow_up_cust_timeframes.year} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_day_of_week_index {
    label: "Prescription Transaction Follow Up Day Of Week Index"
    description: "Prescription Transaction Follow Up Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_follow_up_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_week_begin_date {
    label: "Prescription Transaction Follow Up Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Transaction Follow Up Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_follow_up_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_week_end_date {
    label: "Prescription Transaction Follow Up Week End Date"
    description: "Prescription Transaction Follow Up Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_follow_up_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_week_of_quarter {
    label: "Prescription Transaction Follow Up Week Of Quarter"
    description: "Prescription Transaction Follow Up Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_follow_up_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_month_begin_date {
    label: "Prescription Transaction Follow Up Month Begin Date"
    description: "Prescription Transaction Follow Up Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_follow_up_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_month_end_date {
    label: "Prescription Transaction Follow Up Month End Date"
    description: "Prescription Transaction Follow Up Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_follow_up_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_weeks_in_month {
    label: "Prescription Transaction Follow Up Weeks In Month"
    description: "Prescription Transaction Follow Up Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_follow_up_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_quarter_begin_date {
    label: "Prescription Transaction Follow Up Quarter Begin Date"
    description: "Prescription Transaction Follow Up Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_follow_up_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_quarter_end_date {
    label: "Prescription Transaction Follow Up Quarter End Date"
    description: "Prescription Transaction Follow Up Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_follow_up_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_weeks_in_quarter {
    label: "Prescription Transaction Follow Up Weeks In Quarter"
    description: "Prescription Transaction Follow Up Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_follow_up_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_year_begin_date {
    label: "Prescription Transaction Follow Up Year Begin Date"
    description: "Prescription Transaction Follow Up Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_follow_up_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_year_end_date {
    label: "Prescription Transaction Follow Up Year End Date"
    description: "Prescription Transaction Follow Up Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_follow_up_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_weeks_in_year {
    label: "Prescription Transaction Follow Up Weeks In Year"
    description: "Prescription Transaction Follow Up Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_follow_up_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_leap_year_flag {
    label: "Prescription Transaction Follow Up Leap Year Flag"
    description: "Prescription Transaction Follow Up Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_follow_up_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_day_of_quarter {
    label: "Prescription Transaction Follow Up Day Of Quarter"
    description: "Prescription Transaction Follow Up Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_follow_up_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  dimension: rx_tx_follow_up_cust_day_of_year {
    label: "Prescription Transaction Follow Up Day Of Year"
    description: "Prescription Transaction Follow Up Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_follow_up_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Transaction Follow Up Date"
  }

  #Prescription Transaction Host Retrieval Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_tx_host_retrieval_cust {
    label: "Prescription Transaction Host Retrieval"
    description: "Prescription Transaction Host Retrieval Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_TX_HOST_RETRIEVAL_DATE ;;
  }

  dimension: rx_tx_host_retrieval_cust_calendar_date {
    label: "Prescription Transaction Host Retrieval Date"
    description: "Prescription Transaction Host Retrieval Date"
    type: date
    hidden: yes
    sql: ${rx_tx_host_retrieval_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_chain_id {
    label: "Prescription Transaction Host Retrieval Chain ID"
    description: "Prescription Transaction Host Retrieval Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_host_retrieval_cust_timeframes.chain_id} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_calendar_owner_chain_id {
    label: "Prescription Transaction Host Retrieval Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_host_retrieval_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_yesno {
    label: "Prescription Transaction Host Retrieval (Yes/No)"
    group_label: "Prescription Transaction Host Retrieval Date"
    description: "Yes/No flag indicating if a prescription has Host Retrieval Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_TX_HOST_RETRIEVAL_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_tx_host_retrieval_cust_day_of_week {
    label: "Prescription Transaction Host Retrieval Day Of Week"
    description: "Prescription Transaction Host Retrieval Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_host_retrieval_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_day_of_month {
    label: "Prescription Transaction Host Retrieval Day Of Month"
    description: "Prescription Transaction Host Retrieval Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_host_retrieval_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_week_of_year {
    label: "Prescription Transaction Host Retrieval Week Of Year"
    description: "Prescription Transaction Host Retrieval Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_host_retrieval_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_month_num {
    label: "Prescription Transaction Host Retrieval Month Num"
    description: "Prescription Transaction Host Retrieval Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_host_retrieval_cust_timeframes.month_num} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_month {
    label: "Prescription Transaction Host Retrieval Month"
    description: "Prescription Transaction Host Retrieval Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_host_retrieval_cust_timeframes.month} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_quarter_of_year {
    label: "Prescription Transaction Host Retrieval Quarter Of Year"
    description: "Prescription Transaction Host Retrieval Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_host_retrieval_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_quarter {
    label: "Prescription Transaction Host Retrieval Quarter"
    description: "Prescription Transaction Host Retrieval Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_host_retrieval_cust_timeframes.quarter} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_year {
    label: "Prescription Transaction Host Retrieval Year"
    description: "Prescription Transaction Host Retrieval Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_host_retrieval_cust_timeframes.year} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_day_of_week_index {
    label: "Prescription Transaction Host Retrieval Day Of Week Index"
    description: "Prescription Transaction Host Retrieval Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_host_retrieval_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_week_begin_date {
    label: "Prescription Transaction Host Retrieval Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Transaction Host Retrieval Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_host_retrieval_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_week_end_date {
    label: "Prescription Transaction Host Retrieval Week End Date"
    description: "Prescription Transaction Host Retrieval Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_host_retrieval_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_week_of_quarter {
    label: "Prescription Transaction Host Retrieval Week Of Quarter"
    description: "Prescription Transaction Host Retrieval Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_host_retrieval_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_month_begin_date {
    label: "Prescription Transaction Host Retrieval Month Begin Date"
    description: "Prescription Transaction Host Retrieval Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_host_retrieval_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_month_end_date {
    label: "Prescription Transaction Host Retrieval Month End Date"
    description: "Prescription Transaction Host Retrieval Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_host_retrieval_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_weeks_in_month {
    label: "Prescription Transaction Host Retrieval Weeks In Month"
    description: "Prescription Transaction Host Retrieval Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_host_retrieval_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_quarter_begin_date {
    label: "Prescription Transaction Host Retrieval Quarter Begin Date"
    description: "Prescription Transaction Host Retrieval Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_host_retrieval_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_quarter_end_date {
    label: "Prescription Transaction Host Retrieval Quarter End Date"
    description: "Prescription Transaction Host Retrieval Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_host_retrieval_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_weeks_in_quarter {
    label: "Prescription Transaction Host Retrieval Weeks In Quarter"
    description: "Prescription Transaction Host Retrieval Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_host_retrieval_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_year_begin_date {
    label: "Prescription Transaction Host Retrieval Year Begin Date"
    description: "Prescription Transaction Host Retrieval Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_host_retrieval_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_year_end_date {
    label: "Prescription Transaction Host Retrieval Year End Date"
    description: "Prescription Transaction Host Retrieval Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_host_retrieval_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_weeks_in_year {
    label: "Prescription Transaction Host Retrieval Weeks In Year"
    description: "Prescription Transaction Host Retrieval Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_host_retrieval_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_leap_year_flag {
    label: "Prescription Transaction Host Retrieval Leap Year Flag"
    description: "Prescription Transaction Host Retrieval Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_host_retrieval_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_day_of_quarter {
    label: "Prescription Transaction Host Retrieval Day Of Quarter"
    description: "Prescription Transaction Host Retrieval Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_host_retrieval_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  dimension: rx_tx_host_retrieval_cust_day_of_year {
    label: "Prescription Transaction Host Retrieval Day Of Year"
    description: "Prescription Transaction Host Retrieval Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_host_retrieval_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Transaction Host Retrieval Date"
  }

  #Prescription Transaction Photo ID Birth Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_tx_photo_id_birth_cust {
    label: "Prescription Transaction Photo ID Birth"
    description: "Prescription Transaction Photo ID Birth Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_TX_PHOTO_ID_BIRTH_DATE ;;
  }

  dimension: rx_tx_photo_id_birth_cust_calendar_date {
    label: "Prescription Transaction Photo ID Birth Date"
    description: "Prescription Transaction Photo ID Birth Date"
    type: date
    hidden: yes
    sql: ${rx_tx_photo_id_birth_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_chain_id {
    label: "Prescription Transaction Photo ID Birth Chain ID"
    description: "Prescription Transaction Photo ID Birth Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_photo_id_birth_cust_timeframes.chain_id} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_calendar_owner_chain_id {
    label: "Prescription Transaction Photo ID Birth Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_photo_id_birth_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_yesno {
    label: "Prescription Transaction Photo ID Birth (Yes/No)"
    group_label: "Prescription Transaction Photo ID Birth Date"
    description: "Yes/No flag indicating if a prescription has Photo ID Birth Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_TX_PHOTO_ID_BIRTH_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_tx_photo_id_birth_cust_day_of_week {
    label: "Prescription Transaction Photo ID Birth Day Of Week"
    description: "Prescription Transaction Photo ID Birth Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_photo_id_birth_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_day_of_month {
    label: "Prescription Transaction Photo ID Birth Day Of Month"
    description: "Prescription Transaction Photo ID Birth Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_photo_id_birth_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_week_of_year {
    label: "Prescription Transaction Photo ID Birth Week Of Year"
    description: "Prescription Transaction Photo ID Birth Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_photo_id_birth_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_month_num {
    label: "Prescription Transaction Photo ID Birth Month Num"
    description: "Prescription Transaction Photo ID Birth Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_photo_id_birth_cust_timeframes.month_num} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_month {
    label: "Prescription Transaction Photo ID Birth Month"
    description: "Prescription Transaction Photo ID Birth Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_photo_id_birth_cust_timeframes.month} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_quarter_of_year {
    label: "Prescription Transaction Photo ID Birth Quarter Of Year"
    description: "Prescription Transaction Photo ID Birth Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_photo_id_birth_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_quarter {
    label: "Prescription Transaction Photo ID Birth Quarter"
    description: "Prescription Transaction Photo ID Birth Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_photo_id_birth_cust_timeframes.quarter} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_year {
    label: "Prescription Transaction Photo ID Birth Year"
    description: "Prescription Transaction Photo ID Birth Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_photo_id_birth_cust_timeframes.year} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_day_of_week_index {
    label: "Prescription Transaction Photo ID Birth Day Of Week Index"
    description: "Prescription Transaction Photo ID Birth Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_photo_id_birth_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_week_begin_date {
    label: "Prescription Transaction Photo ID Birth Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Transaction Photo ID Birth Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_photo_id_birth_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_week_end_date {
    label: "Prescription Transaction Photo ID Birth Week End Date"
    description: "Prescription Transaction Photo ID Birth Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_photo_id_birth_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_week_of_quarter {
    label: "Prescription Transaction Photo ID Birth Week Of Quarter"
    description: "Prescription Transaction Photo ID Birth Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_photo_id_birth_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_month_begin_date {
    label: "Prescription Transaction Photo ID Birth Month Begin Date"
    description: "Prescription Transaction Photo ID Birth Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_photo_id_birth_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_month_end_date {
    label: "Prescription Transaction Photo ID Birth Month End Date"
    description: "Prescription Transaction Photo ID Birth Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_photo_id_birth_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_weeks_in_month {
    label: "Prescription Transaction Photo ID Birth Weeks In Month"
    description: "Prescription Transaction Photo ID Birth Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_photo_id_birth_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_quarter_begin_date {
    label: "Prescription Transaction Photo ID Birth Quarter Begin Date"
    description: "Prescription Transaction Photo ID Birth Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_photo_id_birth_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_quarter_end_date {
    label: "Prescription Transaction Photo ID Birth Quarter End Date"
    description: "Prescription Transaction Photo ID Birth Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_photo_id_birth_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_weeks_in_quarter {
    label: "Prescription Transaction Photo ID Birth Weeks In Quarter"
    description: "Prescription Transaction Photo ID Birth Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_photo_id_birth_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_year_begin_date {
    label: "Prescription Transaction Photo ID Birth Year Begin Date"
    description: "Prescription Transaction Photo ID Birth Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_photo_id_birth_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_year_end_date {
    label: "Prescription Transaction Photo ID Birth Year End Date"
    description: "Prescription Transaction Photo ID Birth Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_photo_id_birth_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_weeks_in_year {
    label: "Prescription Transaction Photo ID Birth Weeks In Year"
    description: "Prescription Transaction Photo ID Birth Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_photo_id_birth_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_leap_year_flag {
    label: "Prescription Transaction Photo ID Birth Leap Year Flag"
    description: "Prescription Transaction Photo ID Birth Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_photo_id_birth_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_day_of_quarter {
    label: "Prescription Transaction Photo ID Birth Day Of Quarter"
    description: "Prescription Transaction Photo ID Birth Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_photo_id_birth_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  dimension: rx_tx_photo_id_birth_cust_day_of_year {
    label: "Prescription Transaction Photo ID Birth Day Of Year"
    description: "Prescription Transaction Photo ID Birth Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_photo_id_birth_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Transaction Photo ID Birth Date"
  }

  #Prescription Transaction Photo ID Expire Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_tx_photo_id_expire_cust {
    label: "Prescription Transaction Photo ID Expire"
    description: "Prescription Transaction Photo ID Expire Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_TX_PHOTO_ID_EXPIRE_DATE ;;
  }

  dimension: rx_tx_photo_id_expire_cust_calendar_date {
    label: "Prescription Transaction Photo ID Expire Date"
    description: "Prescription Transaction Photo ID expire Date"
    type: date
    hidden: yes
    sql: ${rx_tx_photo_id_birth_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_chain_id {
    label: "Prescription Transaction Photo ID Expire Chain ID"
    description: "Prescription Transaction Photo ID expire Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_photo_id_birth_cust_timeframes.chain_id} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_calendar_owner_chain_id {
    label: "Prescription Transaction Photo ID Expire Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_photo_id_birth_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_yesno {
    label: "Prescription Transaction Photo ID Expire (Yes/No)"
    group_label: "Prescription Transaction Photo ID Expire Date"
    description: "Yes/No flag indicating if a prescription has Photo ID Expire Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_TX_PHOTO_ID_EXPIRE_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_tx_photo_id_expire_cust_day_of_week {
    label: "Prescription Transaction Photo ID Expire Day Of Week"
    description: "Prescription Transaction Photo ID expire Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_photo_id_birth_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_day_of_month {
    label: "Prescription Transaction Photo ID Expire Day Of Month"
    description: "Prescription Transaction Photo ID expire Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_photo_id_birth_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_week_of_year {
    label: "Prescription Transaction Photo ID Expire Week Of Year"
    description: "Prescription Transaction Photo ID expire Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_photo_id_birth_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_month_num {
    label: "Prescription Transaction Photo ID Expire Month Num"
    description: "Prescription Transaction Photo ID expire Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_photo_id_birth_cust_timeframes.month_num} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_month {
    label: "Prescription Transaction Photo ID Expire Month"
    description: "Prescription Transaction Photo ID expire Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_photo_id_birth_cust_timeframes.month} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_quarter_of_year {
    label: "Prescription Transaction Photo ID Expire Quarter Of Year"
    description: "Prescription Transaction Photo ID expire Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_photo_id_birth_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_quarter {
    label: "Prescription Transaction Photo ID Expire Quarter"
    description: "Prescription Transaction Photo ID expire Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_photo_id_birth_cust_timeframes.quarter} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_year {
    label: "Prescription Transaction Photo ID Expire Year"
    description: "Prescription Transaction Photo ID expire Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_photo_id_birth_cust_timeframes.year} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_day_of_week_index {
    label: "Prescription Transaction Photo ID Expire Day Of Week Index"
    description: "Prescription Transaction Photo ID expire Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_photo_id_birth_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_week_begin_date {
    label: "Prescription Transaction Photo ID Expire Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Transaction Photo ID expire Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_photo_id_birth_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_week_end_date {
    label: "Prescription Transaction Photo ID Expire Week End Date"
    description: "Prescription Transaction Photo ID expire Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_photo_id_birth_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_week_of_quarter {
    label: "Prescription Transaction Photo ID Expire Week Of Quarter"
    description: "Prescription Transaction Photo ID expire Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_photo_id_birth_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_month_begin_date {
    label: "Prescription Transaction Photo ID Expire Month Begin Date"
    description: "Prescription Transaction Photo ID expire Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_photo_id_birth_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_month_end_date {
    label: "Prescription Transaction Photo ID Expire Month End Date"
    description: "Prescription Transaction Photo ID expire Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_photo_id_birth_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_weeks_in_month {
    label: "Prescription Transaction Photo ID Expire Weeks In Month"
    description: "Prescription Transaction Photo ID expire Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_photo_id_birth_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_quarter_begin_date {
    label: "Prescription Transaction Photo ID Expire Quarter Begin Date"
    description: "Prescription Transaction Photo ID expire Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_photo_id_birth_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_quarter_end_date {
    label: "Prescription Transaction Photo ID Expire Quarter End Date"
    description: "Prescription Transaction Photo ID expire Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_photo_id_birth_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_weeks_in_quarter {
    label: "Prescription Transaction Photo ID Expire Weeks In Quarter"
    description: "Prescription Transaction Photo ID expire Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_photo_id_birth_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_year_begin_date {
    label: "Prescription Transaction Photo ID Expire Year Begin Date"
    description: "Prescription Transaction Photo ID expire Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_photo_id_birth_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_year_end_date {
    label: "Prescription Transaction Photo ID Expire Year End Date"
    description: "Prescription Transaction Photo ID expire Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_photo_id_birth_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_weeks_in_year {
    label: "Prescription Transaction Photo ID Expire Weeks In Year"
    description: "Prescription Transaction Photo ID expire Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_photo_id_birth_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_leap_year_flag {
    label: "Prescription Transaction Photo ID Expire Leap Year Flag"
    description: "Prescription Transaction Photo ID expire Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_photo_id_birth_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_day_of_quarter {
    label: "Prescription Transaction Photo ID Expire Day Of Quarter"
    description: "Prescription Transaction Photo ID expire Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_photo_id_birth_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  dimension: rx_tx_photo_id_expire_cust_day_of_year {
    label: "Prescription Transaction Photo ID Expire Day Of Year"
    description: "Prescription Transaction Photo ID expire Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_photo_id_birth_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Transaction Photo ID Expire Date"
  }

  #Prescription Transaction Stop Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_tx_stop_cust {
    label: "Prescription Transaction Stop"
    description: "Prescription Transaction Stop Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_TX_STOP_DATE ;;
  }

  dimension: rx_tx_stop_cust_calendar_date {
    label: "Prescription Transaction Stop Date"
    description: "Prescription Transaction Stop Date"
    type: date
    hidden: yes
    sql: ${rx_tx_stop_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_chain_id {
    label: "Prescription Transaction Stop Chain ID"
    description: "Prescription Transaction Stop Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_stop_cust_timeframes.chain_id} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_calendar_owner_chain_id {
    label: "Prescription Transaction Stop Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_stop_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_yesno {
    label: "Prescription Transaction Stop (Yes/No)"
    group_label: "Prescription Transaction Stop Date"
    description: "Yes/No flag indicating if a prescription has Stop Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_TX_STOP_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_tx_stop_cust_day_of_week {
    label: "Prescription Transaction Stop Day Of Week"
    description: "Prescription Transaction Stop Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_stop_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_day_of_month {
    label: "Prescription Transaction Stop Day Of Month"
    description: "Prescription Transaction Stop Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_stop_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_week_of_year {
    label: "Prescription Transaction Stop Week Of Year"
    description: "Prescription Transaction Stop Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_stop_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_month_num {
    label: "Prescription Transaction Stop Month Num"
    description: "Prescription Transaction Stop Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_stop_cust_timeframes.month_num} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_month {
    label: "Prescription Transaction Stop Month"
    description: "Prescription Transaction Stop Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_stop_cust_timeframes.month} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_quarter_of_year {
    label: "Prescription Transaction Stop Quarter Of Year"
    description: "Prescription Transaction Stop Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_stop_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_quarter {
    label: "Prescription Transaction Stop Quarter"
    description: "Prescription Transaction Stop Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_stop_cust_timeframes.quarter} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_year {
    label: "Prescription Transaction Stop Year"
    description: "Prescription Transaction Stop Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_stop_cust_timeframes.year} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_day_of_week_index {
    label: "Prescription Transaction Stop Day Of Week Index"
    description: "Prescription Transaction Stop Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_stop_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_week_begin_date {
    label: "Prescription Transaction Stop Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Transaction Stop Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_stop_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_week_end_date {
    label: "Prescription Transaction Stop Week End Date"
    description: "Prescription Transaction Stop Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_stop_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_week_of_quarter {
    label: "Prescription Transaction Stop Week Of Quarter"
    description: "Prescription Transaction Stop Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_stop_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_month_begin_date {
    label: "Prescription Transaction Stop Month Begin Date"
    description: "Prescription Transaction Stop Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_stop_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_month_end_date {
    label: "Prescription Transaction Stop Month End Date"
    description: "Prescription Transaction Stop Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_stop_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_weeks_in_month {
    label: "Prescription Transaction Stop Weeks In Month"
    description: "Prescription Transaction Stop Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_stop_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_quarter_begin_date {
    label: "Prescription Transaction Stop Quarter Begin Date"
    description: "Prescription Transaction Stop Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_stop_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_quarter_end_date {
    label: "Prescription Transaction Stop Quarter End Date"
    description: "Prescription Transaction Stop Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_stop_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_weeks_in_quarter {
    label: "Prescription Transaction Stop Weeks In Quarter"
    description: "Prescription Transaction Stop Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_stop_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_year_begin_date {
    label: "Prescription Transaction Stop Year Begin Date"
    description: "Prescription Transaction Stop Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_stop_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_year_end_date {
    label: "Prescription Transaction Stop Year End Date"
    description: "Prescription Transaction Stop Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_stop_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_weeks_in_year {
    label: "Prescription Transaction Stop Weeks In Year"
    description: "Prescription Transaction Stop Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_stop_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_leap_year_flag {
    label: "Prescription Transaction Stop Leap Year Flag"
    description: "Prescription Transaction Stop Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_stop_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_day_of_quarter {
    label: "Prescription Transaction Stop Day Of Quarter"
    description: "Prescription Transaction Stop Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_stop_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  dimension: rx_tx_stop_cust_day_of_year {
    label: "Prescription Transaction Stop Day Of Year"
    description: "Prescription Transaction Stop Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_stop_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Transaction Stop Date"
  }

  #Prescription Transaction Written Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_tx_written_cust {
    label: "Prescription Transaction Written"
    description: "Prescription Transaction Written Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.RX_TX_WRITTEN_DATE ;;
  }

  dimension: rx_tx_written_cust_calendar_date {
    label: "Prescription Transaction Written Date"
    description: "Prescription Transaction Written Date"
    type: date
    hidden: yes
    sql: ${rx_tx_written_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_chain_id {
    label: "Prescription Transaction Written Chain ID"
    description: "Prescription Transaction Written Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_written_cust_timeframes.chain_id} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_calendar_owner_chain_id {
    label: "Prescription Transaction Written Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_written_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_yesno {
    label: "Prescription Transaction Written (Yes/No)"
    group_label: "Prescription Transaction Written Date"
    description: "Yes/No flag indicating if a prescription has Written Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.RX_TX_WRITTEN_DATE IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_tx_written_cust_day_of_week {
    label: "Prescription Transaction Written Day Of Week"
    description: "Prescription Transaction Written Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_written_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_day_of_month {
    label: "Prescription Transaction Written Day Of Month"
    description: "Prescription Transaction Written Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_written_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_week_of_year {
    label: "Prescription Transaction Written Week Of Year"
    description: "Prescription Transaction Written Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_written_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_month_num {
    label: "Prescription Transaction Written Month Num"
    description: "Prescription Transaction Written Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_written_cust_timeframes.month_num} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_month {
    label: "Prescription Transaction Written Month"
    description: "Prescription Transaction Written Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_written_cust_timeframes.month} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_quarter_of_year {
    label: "Prescription Transaction Written Quarter Of Year"
    description: "Prescription Transaction Written Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_written_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_quarter {
    label: "Prescription Transaction Written Quarter"
    description: "Prescription Transaction Written Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_written_cust_timeframes.quarter} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_year {
    label: "Prescription Transaction Written Year"
    description: "Prescription Transaction Written Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_written_cust_timeframes.year} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_day_of_week_index {
    label: "Prescription Transaction Written Day Of Week Index"
    description: "Prescription Transaction Written Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_written_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_week_begin_date {
    label: "Prescription Transaction Written Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Transaction Written Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_written_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_week_end_date {
    label: "Prescription Transaction Written Week End Date"
    description: "Prescription Transaction Written Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_written_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_week_of_quarter {
    label: "Prescription Transaction Written Week Of Quarter"
    description: "Prescription Transaction Written Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_written_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_month_begin_date {
    label: "Prescription Transaction Written Month Begin Date"
    description: "Prescription Transaction Written Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_written_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_month_end_date {
    label: "Prescription Transaction Written Month End Date"
    description: "Prescription Transaction Written Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_written_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_weeks_in_month {
    label: "Prescription Transaction Written Weeks In Month"
    description: "Prescription Transaction Written Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_written_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_quarter_begin_date {
    label: "Prescription Transaction Written Quarter Begin Date"
    description: "Prescription Transaction Written Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_written_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_quarter_end_date {
    label: "Prescription Transaction Written Quarter End Date"
    description: "Prescription Transaction Written Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_written_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_weeks_in_quarter {
    label: "Prescription Transaction Written Weeks In Quarter"
    description: "Prescription Transaction Written Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_written_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_year_begin_date {
    label: "Prescription Transaction Written Year Begin Date"
    description: "Prescription Transaction Written Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_written_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_year_end_date {
    label: "Prescription Transaction Written Year End Date"
    description: "Prescription Transaction Written Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_written_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_weeks_in_year {
    label: "Prescription Transaction Written Weeks In Year"
    description: "Prescription Transaction Written Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_written_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_leap_year_flag {
    label: "Prescription Transaction Written Leap Year Flag"
    description: "Prescription Transaction Written Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_written_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_day_of_quarter {
    label: "Prescription Transaction Written Day Of Quarter"
    description: "Prescription Transaction Written Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_written_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Transaction Written Date"
  }

  dimension: rx_tx_written_cust_day_of_year {
    label: "Prescription Transaction Written Day Of Year"
    description: "Prescription Transaction Written Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_written_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Transaction Written Date"
  }

  #Prescription Transaction Source Create Date fiscal timeframes. Dimensions name are added with cust (Custom) key word to differentiate from default timeframe date column.
  dimension_group: rx_tx_source_create_cust {
    label: "Prescription Transaction Source Create"
    description: "Prescription Transaction Source Create Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: time
    timeframes: [date]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension: rx_tx_source_create_cust_calendar_date {
    label: "Prescription Transaction Source Create Date"
    description: "Prescription Transaction Source Create Date"
    type: date
    hidden: yes
    sql: ${rx_tx_source_create_cust_timeframes.calendar_date} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_chain_id {
    label: "Prescription Transaction Source Create Chain ID"
    description: "Prescription Transaction Source Create Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_source_create_cust_timeframes.chain_id} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_calendar_owner_chain_id {
    label: "Prescription Transaction Source Create Calendar Owner Chain ID"
    description: "Calendar is of this Chain ID"
    type: number
    hidden: yes
    sql: ${rx_tx_source_create_cust_timeframes.calendar_owner_chain_id} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_yesno {
    label: "Prescription Transaction Source Create (Yes/No)"
    group_label: "Prescription Transaction Source Create Date"
    description: "Yes/No flag indicating if a prescription has Source Create Date. Example output 'Yes'" #[ERXLPS-2054]
    type: string
    can_filter: yes
    case: {
      when: {
        sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP IS NOT NULL ;;
        label: "Yes"
      }

      when: {
        sql: true ;;
        label: "No"
      }
    }
  }

  dimension: rx_tx_source_create_cust_day_of_week {
    label: "Prescription Transaction Source Create Day Of Week"
    description: "Prescription Transaction Source Create Day Of Week Full Name. Example output 'Monday'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_source_create_cust_timeframes.day_of_week} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_day_of_month {
    label: "Prescription Transaction Source Create Day Of Month"
    description: "Prescription Transaction Source Create Day Of Month. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_source_create_cust_timeframes.day_of_month} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_week_of_year {
    label: "Prescription Transaction Source Create Week Of Year"
    description: "Prescription Transaction Source Create Week Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_source_create_cust_timeframes.week_of_year} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_month_num {
    label: "Prescription Transaction Source Create Month Num"
    description: "Prescription Transaction Source Create Month Of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_source_create_cust_timeframes.month_num} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_month {
    label: "Prescription Transaction Source Create Month"
    description: "Prescription Transaction Source Create Month. Example output '2017-01'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_source_create_cust_timeframes.month} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_quarter_of_year {
    label: "Prescription Transaction Source Create Quarter Of Year"
    description: "Prescription Transaction Source Create Quarter Of Year. Example output 'Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_source_create_cust_timeframes.quarter_of_year} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_quarter {
    label: "Prescription Transaction Source Create Quarter"
    description: "Prescription Transaction Source Create Quarter. Example output '2017-Q1'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_source_create_cust_timeframes.quarter} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_year {
    label: "Prescription Transaction Source Create Year"
    description: "Prescription Transaction Source Create Year. Example output '2017'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_source_create_cust_timeframes.year} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_day_of_week_index {
    label: "Prescription Transaction Source Create Day Of Week Index"
    description: "Prescription Transaction Source Create Day Of Week Index. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_source_create_cust_timeframes.day_of_week_index} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_week_begin_date {
    label: "Prescription Transaction Source Create Week Begin Date" #[ERXLPS-1229] - Label name change.
    description: "Prescription Transaction Source Create Week Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_source_create_cust_timeframes.week_begin_date} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_week_end_date {
    label: "Prescription Transaction Source Create Week End Date"
    description: "Prescription Transaction Source Create Week End Date. Example output '2017-01-19'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_source_create_cust_timeframes.week_end_date} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_week_of_quarter {
    label: "Prescription Transaction Source Create Week Of Quarter"
    description: "Prescription Transaction Source Create Week of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_source_create_cust_timeframes.week_of_quarter} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_month_begin_date {
    label: "Prescription Transaction Source Create Month Begin Date"
    description: "Prescription Transaction Source Create Month Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_source_create_cust_timeframes.month_begin_date} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_month_end_date {
    label: "Prescription Transaction Source Create Month End Date"
    description: "Prescription Transaction Source Create Month End Date. Example output '2017-01-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_source_create_cust_timeframes.month_end_date} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_weeks_in_month {
    label: "Prescription Transaction Source Create Weeks In Month"
    description: "Prescription Transaction Source Create Weeks In Month. Example output '4'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_source_create_cust_timeframes.weeks_in_month} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_quarter_begin_date {
    label: "Prescription Transaction Source Create Quarter Begin Date"
    description: "Prescription Transaction Source Create Quarter Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_source_create_cust_timeframes.quarter_begin_date} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_quarter_end_date {
    label: "Prescription Transaction Source Create Quarter End Date"
    description: "Prescription Transaction Source Create Quarter End Date. Example output '2017-03-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_source_create_cust_timeframes.quarter_end_date} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_weeks_in_quarter {
    label: "Prescription Transaction Source Create Weeks In Quarter"
    description: "Prescription Transaction Source Create Weeks In Quarter. Example output '13'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_source_create_cust_timeframes.weeks_in_quarter} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_year_begin_date {
    label: "Prescription Transaction Source Create Year Begin Date"
    description: "Prescription Transaction Source Create Year Begin Date. Example output '2017-01-13'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_source_create_cust_timeframes.year_begin_date} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_year_end_date {
    label: "Prescription Transaction Source Create Year End Date"
    description: "Prescription Transaction Source Create Year End Date. Example output '2017-12-31'" #[ERXLPS-2054]
    type: date
    sql: ${rx_tx_source_create_cust_timeframes.year_end_date} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_weeks_in_year {
    label: "Prescription Transaction Source Create Weeks In Year"
    description: "Prescription Transaction Source Create Weeks In Year. Example output '52'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_source_create_cust_timeframes.weeks_in_year} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_leap_year_flag {
    label: "Prescription Transaction Source Create Leap Year Flag"
    description: "Prescription Transaction Source Create Leap Year Flag. Example output 'N'" #[ERXLPS-2054]
    type: string
    sql: ${rx_tx_source_create_cust_timeframes.leap_year_flag} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_day_of_quarter {
    label: "Prescription Transaction Source Create Day Of Quarter"
    description: "Prescription Transaction Source Create Day of Quarter. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_source_create_cust_timeframes.day_of_quarter} ;;
    group_label: "Prescription Transaction Source Create Date"
  }

  dimension: rx_tx_source_create_cust_day_of_year {
    label: "Prescription Transaction Source Create Day Of Year"
    description: "Prescription Transaction Source Create Day of Year. Example output '1'" #[ERXLPS-2054]
    type: number
    sql: ${rx_tx_source_create_cust_timeframes.day_of_year} ;;
    group_label: "Prescription Transaction Source Create Date"
  }
  ####################################################################################################### Measures ####################################################################################################

  measure: sum_rx_tx_base_cost {
    label: "Prescription Total Base Cost"
    description: "Total dollar amount the cost base was for this transaction of the drug filled. System Generated"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: sum
    sql: ${TABLE}.RX_TX_BASE_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_rx_tx_compound_fee {
    label: "Prescription Total Compound Fee"
    description: "Total compound preparation charges. User entered. Compound rate multiplied by compound time"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: sum
    sql: ${TABLE}.RX_TX_COMPOUND_FEE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #Owed Quantity is coming from eps_line_item.line_item_owed_quantity. This measure is duplicate for eps_line_item.item_owed_quantity measure.
  measure: sum_rx_tx_owed_quantity {
    label: "Prescription Total Owed Quantity"
    description: "Total number of units (quantity) of the drug that are owed to the patient. Auto-calculated via client"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: sum
    sql: ${TABLE}.RX_TX_OWED_QUANTITY ;;
    value_format: "#,##0.00"
  }

  measure: sum_rx_tx_sig_per_day {
    label: "Prescription Total SIG Per Day"
    description: "Total number of times the drug is taken per day . User entered via client"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: sum
    sql: ${TABLE}.RX_TX_SIG_PER_DAY ;;
    value_format: "#,##0.00"
  }

  measure: sum_rx_tx_sig_per_dose {
    label: "Prescription Total SIG Per Dose"
    description: "Total number of dosage units that must be taken or given per administration of the drug. User entered via client"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: sum
    sql: ${TABLE}.RX_TX_SIG_PER_DOSE ;;
    value_format: "#,##0.00"
  }

  measure: sum_rx_tx_up_charge {
    label: "Prescription Total Up Charge"
    description: "Total amount by which the cost base (for the drug filled) was adjusted by a base cost table (third party prescription only). System Generated"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: sum
    sql: ${TABLE}.RX_TX_UP_CHARGE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_rx_tx_uc_price {
    label: "Prescription U & C Price"
    description: "Total Usual & Customary pricing of the Prescription Transaction"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: sum
    sql: ${TABLE}.RX_TX_UC_PRICE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXLPS-910] Sales related measure added here. Once these measures called from Sales explore sum_distinct will be applied to produce correct results.
  measure: sum_sales_rx_tx_manual_acquisition_cost {
    label: "Total Prescription Manual Acquisition Cost"
    group_label: "Acquisition Cost"
    description: "Total prescription manual acquisition cost"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${eps_rx_tx.rx_tx_manual_acquisition_cost_reference} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [sales.sales_transaction_level_drill_path*]
  }

  measure: avg_sales_rx_tx_manual_acquisition_cost {
    label: "Avg Prescription Manual Acquisition Cost"
    group_label: "Acquisition Cost"
    description: "Average prescription manual acquisition cost"
    type: average
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN COALESCE(${eps_rx_tx.rx_tx_manual_acquisition_cost_reference},0) END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_rx_tx_professional_fee {
    label: "Prescription Total Professional Fee"
    group_label: "Other Measures"
    description: "Total of any additional fees included in the price of this transaction, outside of the normal pricing calculation"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${eps_rx_tx.rx_tx_professional_fee_reference} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [sales.sales_transaction_level_drill_path*]
  }

  measure: avg_sales_rx_tx_professional_fee {
    label: "Prescription Average Professional Fee"
    group_label: "Other Measures"
    description: "Average of any additional fees included in the price of this transaction, outside of the normal pricing calculation"
    type: average
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN COALESCE(${eps_rx_tx.rx_tx_professional_fee_reference},0) END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_sales_rx_tx_intended_quantity {
    label: "Prescription Intended Quantity"
    group_label: "Quantity"
    description: "The original quantity that the customer requested for this transaction"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${eps_rx_tx.rx_tx_intended_quantity_reference} END ;;
    value_format: "###0.00"
    drill_fields: [sales.sales_transaction_level_drill_path*]
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_sales_rx_tx_original_quantity {
    label: "Prescription Original Quantity"
    group_label: "Quantity"
    description: "Original quantity on the transaction before credit return"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${eps_rx_tx.rx_tx_original_quantity_reference} END ;;
    value_format: "###0.00"
    drill_fields: [sales.sales_transaction_level_drill_path*]
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_sales_rx_tx_prescribed_quantity {
    label: "Prescription Prescribed Quantity"
    group_label: "Quantity"
    description: "Number of units (quantity) of the drug the doctor ordered"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${eps_rx_tx.rx_tx_prescribed_quantity_reference} END ;;
    value_format: "###0.00"
    drill_fields: [sales.sales_transaction_level_drill_path*]
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_sales_rx_tx_requested_price_to_quantity {
    label: "Prescription Requested Price To Quantity"
    group_label: "Quantity"
    description: "The requested dollar amount of the prescription that the patient would like to purchase"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${eps_rx_tx.rx_tx_requested_price_to_quantity_reference} END ;;
    value_format: "###0.00"
    drill_fields: [sales.sales_transaction_level_drill_path*]
  }

  measure: sum_sales_rx_tx_pos_overridden_net_paid {
    label: "Prescription POS Overridden Net Paid"
    group_label: "Price Override"
    description: "Total overridden net pay amount in the POS system, when it is a different amount than the patient net pay amount sent in the transaction request from EPS"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${eps_rx_tx.rx_tx_pos_overridden_net_paid_reference} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [sales.sales_transaction_level_drill_path*]
  }

  measure: avg_sales_rx_tx_pos_overridden_net_paid {
    label: "Avg Prescription POS Overridden Net Paid"
    group_label: "Price Override"
    description: "Average overridden net pay amount in the POS system, when it is a different amount than the patient net pay amount sent in the transaction request from EPS"
    type: average
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN COALESCE(${eps_rx_tx.rx_tx_pos_overridden_net_paid_reference},0) END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_sales_rx_tx_fill_quantity {
    label: "Prescription Fill Quantity"
    group_label: "Quantity"
    description: "Total Quantity (number of units) of the drug dispensed"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${eps_rx_tx.rx_tx_fill_quantity_reference} END ;;
    value_format: "###0.00"
    drill_fields: [sales.sales_transaction_level_drill_path*]
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_sales_rx_tx_fill_quantity_tp {
    label: "T/P Prescription Fill Quantity"
    group_label: "Quantity"
    description: "Total Fill Quantity of the T/P Prescription Transaction"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' AND ${eps_rx_tx.rx_tx_tp_bill_reference} = 'Y' THEN ${eps_rx_tx.rx_tx_fill_quantity_tp_reference} END ;;
    value_format: "###0.00"
    drill_fields: [sales.sales_transaction_level_drill_path*]
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_sales_rx_tx_fill_quantity_cash {
    label: "Cash Prescription Fill Quantity"
    group_label: "Quantity"
    description: "Total Fill Quantity of the Cash Prescription Transaction"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' AND ${eps_rx_tx.rx_tx_tp_bill_reference} = 'N' THEN ${eps_rx_tx.rx_tx_fill_quantity_cash_reference} END ;;
    value_format: "###0.00"
    drill_fields: [sales.sales_transaction_level_drill_path*]
  }

  measure: sum_sales_rx_tx_original_price {
    label: "Prescription Original Price"
    group_label: "Other Price"
    description: "Total Original Price of the Prescription Transaction"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${eps_rx_tx.rx_tx_original_price_reference} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [sales.sales_transaction_level_drill_path*]
  }

  measure: sum_sales_rx_tx_base_cost {
    label: "Prescription Total Base Cost"
    group_label: "Other Measures"
    description: "Total dollar amount the cost base was for this transaction of the drug filled. System Generated"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${eps_rx_tx.rx_tx_base_cost_reference} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [sales.sales_transaction_level_drill_path*]
  }

  measure: sum_sales_rx_tx_compound_fee {
    label: "Prescription Total Compound Fee"
    group_label: "Other Measures"
    description: "Total compound preparation charges. User entered. Compound rate multiplied by compound time"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${eps_rx_tx.rx_tx_compound_fee_reference} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [sales.sales_transaction_level_drill_path*]
  }

  measure: sum_sales_rx_tx_sig_per_day {
    label: "Prescription Total SIG Per Day"
    group_label: "SIG"
    description: "Total number of times the drug is taken per day . User entered via client"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${eps_rx_tx.rx_tx_sig_per_day_reference} END ;;
    value_format: "#,##0.00"
    drill_fields: [sales.sales_transaction_level_drill_path*]
  }

  measure: sum_sales_rx_tx_sig_per_dose {
    label: "Prescription Total SIG Per Dose"
    group_label: "SIG"
    description: "Total number of dosage units that must be taken or given per administration of the drug. User entered via client"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${eps_rx_tx.rx_tx_sig_per_dose_reference} END ;;
    value_format: "#,##0.00"
    drill_fields: [sales.sales_transaction_level_drill_path*]
  }

  measure: sum_sales_rx_tx_up_charge {
    label: "Prescription Total Up Charge"
    group_label: "Other Measures"
    description: "Total amount by which the cost base (for the drug filled) was adjusted by a base cost table (third party prescription only). System Generated"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${eps_rx_tx.rx_tx_up_charge_reference} END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [sales.sales_transaction_level_drill_path*]
  }

  measure: sum_sales_rx_tx_owed_quantity {
    label: "Prescription Total Owed Quantity"
    group_label: "Quantity"
    description: "Total number of units (quantity) of the drug that are owed to the patient. Auto-calculated via client"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' THEN ${eps_rx_tx.rx_tx_owed_quantity_reference} END ;;
    value_format: "#,##0.00"
    drill_fields: [sales.sales_transaction_level_drill_path*]
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_sales_rx_tx_prescribed_quantity_tp {
    label: "T/P Prescription Prescribed Quantity"
    group_label: "Quantity"
    description: "Number of units (quantity) of the drug the doctor ordered for Third Party transactions"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' AND ${eps_rx_tx.rx_tx_tp_bill_reference} = 'Y' THEN ${eps_rx_tx.rx_tx_prescribed_quantity_tp_reference} END ;;
    value_format: "###0.00"
    drill_fields: [sales.sales_transaction_level_drill_path*]
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_sales_rx_tx_prescribed_quantity_cash {
    label: "Cash Prescription Prescribed Quantity"
    group_label: "Quantity"
    description: "Number of units (quantity) of the drug the doctor ordered for Cash transactions"
    type: sum
    sql: CASE WHEN (${sales.adjudicated_flg} = 'Y' or ${sales.sold_flg} = 'Y') AND ${report_calendar_global.type} = 'TY' AND ${eps_rx_tx.rx_tx_tp_bill_reference} = 'N' THEN ${eps_rx_tx.rx_tx_prescribed_quantity_cash_reference} END ;;
    value_format: "###0.00"
    drill_fields: [sales.sales_transaction_level_drill_path*]
  }

############################################# #[ERX-3514] Gap Time Measures and Dimensions #####################################

  filter: source_task {
    label: "Source Task Name"
    description: "Task in the workflow from where gap time for target task is calculated"
    type: string
    suggestions: [
      "ORDER_ENTRY",
      "DATA_ENTRY",
      "DATA_VERIFICATION",
      "ESCRIPT_DATA_ENTRY",
      "FILL",
      "PRODUCT_VERIFICATION",
      "WILL_CALL",
      "RX_FILLING",
      "DUR_DISPLAY",
      "INVISIBLE_FILL",
      "TP_EXCEPTION2",
      "RF_TP_EXCEPTION",
      "TP_EXCEPTION"
    ]
    full_suggestions: yes
    view_label: "Task History - Gap Time"
  }

  filter: target_task {
    label: "Target Task Name"
    description: "Task in the workflow till which gap time from source task is calculated"
    type: string
    suggestions: [
      "ORDER_ENTRY",
      "DATA_ENTRY",
      "DATA_VERIFICATION",
      "ESCRIPT_DATA_ENTRY",
      "FILL",
      "PRODUCT_VERIFICATION",
      "WILL_CALL",
      "RX_FILLING",
      "DUR_DISPLAY",
      "INVISIBLE_FILL",
      "TP_EXCEPTION2",
      "RF_TP_EXCEPTION",
      "TP_EXCEPTION"
    ]
    full_suggestions: yes
    view_label: "Task History - Gap Time"
  }

  ################End of [ERX-3514] added dimensions and measures for gap time calculations ############################

  #--------------------------------------------- [ERX-6185] new filter for base vs archive table selection ----------------------------------------------
  filter: active_archive_filter {
    label: "Analysis From"
    type: string
    suggestions: ["Active Tables (Past 48 Complete Months Data)", "Archive Tables"]
    default_value: "Active Tables (Past 48 Complete Months Data)"
    #[ERX-6185] set hidden to no to enable the filter
    hidden: yes
  }

  dimension: active_archive_filter_input {
    hidden: yes
    type: string
    sql:  {% parameter active_archive_filter %} ;;
  }
  #------------------------------------------- END [ERX-6185] new filter for base vs archive table selection --------------------------------------------

  ####################################################################################################### End of Measures ####################################################################################################

  ########################################################################################################## End of 4.8.000 New columns #############################################################################################

  dimension: store_setting_cf_enable_prior_tx_reportable_sales {
    label: "Prescription Transaction Store Setting Code at Reportable sales"
    description: "Store setting information provided at the time of Reportable sales. This field is EPS only!!!"
    type:  string
    hidden: yes
    sql: etl_manager.fn_get_value_as_of_date(${store_setting_hist_cf_enable_listagg.store_setting_hist}, date_part(epoch_nanosecond, ${TABLE}.RX_TX_REPORTABLE_SALES_DATE),'N') ;;
  }

  ####################################################################################### Sets ##################################################################

  set: explore_rx_4_6_000_sf_deployment_candidate_list {
    fields: [
      rx_tx_admin_rebilled,
      rx_tx_allow_price_override,
      rx_tx_brand_manually_selected,
      rx_tx_competitive_priced,
      rx_tx_controlled_substance_escript,
      rx_tx_counseling_rph_employee_number,
      rx_tx_counseling_rph_initials,
      rx_tx_custom_reported_date_date,
      rx_tx_custom_reported_date_day_of_month,
      rx_tx_custom_reported_date_day_of_week,
      rx_tx_custom_reported_date_day_of_week_index,
      rx_tx_custom_reported_date_hour_of_day,
      rx_tx_custom_reported_date_hour2,
      rx_tx_custom_reported_date_minute15,
      rx_tx_custom_reported_date_month,
      rx_tx_custom_reported_date_month_num,
      rx_tx_custom_reported_date_quarter,
      rx_tx_custom_reported_date_quarter_of_year,
      rx_tx_custom_reported_date_time,
      rx_tx_custom_reported_date_time_of_day,
      rx_tx_custom_reported_date_week,
      rx_tx_custom_reported_date_week_of_year,
      rx_tx_custom_reported_date_year,
      rx_tx_custom_reported_date,
      rx_tx_custom_sig,
      rx_tx_ddid_used_by_drug_selection,
      rx_tx_de_initials,
      rx_tx_different_generic,
      rx_tx_dob_override_employee_number,
      rx_tx_dob_override_reason_id,
      rx_tx_dob_override_time_date,
      rx_tx_dob_override_time_day_of_month,
      rx_tx_dob_override_time_day_of_week,
      rx_tx_dob_override_time_day_of_week_index,
      rx_tx_dob_override_time_hour_of_day,
      rx_tx_dob_override_time_hour2,
      rx_tx_dob_override_time_minute15,
      rx_tx_dob_override_time_month,
      rx_tx_dob_override_time_month_num,
      rx_tx_dob_override_time_quarter,
      rx_tx_dob_override_time_quarter_of_year,
      rx_tx_dob_override_time_time,
      rx_tx_dob_override_time_time_of_day,
      rx_tx_dob_override_time_week,
      rx_tx_dob_override_time_week_of_year,
      rx_tx_dob_override_time_year,
      rx_tx_dob_override_time,
      rx_tx_dv_initials,
      rx_tx_epr_synch_version,
      #rx_tx_fill_location, [ERXLPS-1514] commented out as gap-time functionality uses  a filter on this field
      rx_tx_generic_manually_selected,
      rx_tx_gpi_used_by_drug_selection,
      rx_tx_intended_days_supply,
      sum_rx_tx_intended_quantity,
      rx_tx_keep_same_drug,
      rx_tx_last_epr_synch_date,
      rx_tx_last_epr_synch_day_of_month,
      rx_tx_last_epr_synch_day_of_week,
      rx_tx_last_epr_synch_day_of_week_index,
      rx_tx_last_epr_synch_hour_of_day,
      rx_tx_last_epr_synch_hour2,
      rx_tx_last_epr_synch_minute15,
      rx_tx_last_epr_synch_month,
      rx_tx_last_epr_synch_month_num,
      rx_tx_last_epr_synch_quarter,
      rx_tx_last_epr_synch_quarter_of_year,
      rx_tx_last_epr_synch_time,
      rx_tx_last_epr_synch_time_of_day,
      rx_tx_last_epr_synch_week,
      rx_tx_last_epr_synch_week_of_year,
      rx_tx_last_epr_synch_year,
      rx_tx_last_epr_synch,
      rx_tx_manual_acquisition_drug_dispensed,
      rx_tx_medicare_notice,
      rx_tx_missing_date_date,
      rx_tx_missing_date_day_of_month,
      rx_tx_missing_date_day_of_week,
      rx_tx_missing_date_day_of_week_index,
      rx_tx_missing_date_hour_of_day,
      rx_tx_missing_date_hour2,
      rx_tx_missing_date_minute15,
      rx_tx_missing_date_month,
      rx_tx_missing_date_month_num,
      rx_tx_missing_date_quarter,
      rx_tx_missing_date_quarter_of_year,
      rx_tx_missing_date_time,
      rx_tx_missing_date_time_of_day,
      rx_tx_missing_date_week,
      rx_tx_missing_date_week_of_year,
      rx_tx_missing_date_year,
      rx_tx_missing_date,
      rx_tx_mobile_services_channel,
      rx_tx_new_ddid_authorized_by_emp_number,
      rx_tx_no_sales_tax,
      sum_rx_tx_original_quantity,
      rx_tx_otc_taxable_indicator,
      rx_tx_patient_request_brand_generic,
      rx_tx_patient_requested_price,
      rx_tx_pc_ready_date_date,
      rx_tx_pc_ready_date_day_of_month,
      rx_tx_pc_ready_date_day_of_week,
      rx_tx_pc_ready_date_day_of_week_index,
      rx_tx_pc_ready_date_hour_of_day,
      rx_tx_pc_ready_date_hour2,
      rx_tx_pc_ready_date_minute15,
      rx_tx_pc_ready_date_month,
      rx_tx_pc_ready_date_month_num,
      rx_tx_pc_ready_date_quarter,
      rx_tx_pc_ready_date_quarter_of_year,
      rx_tx_pc_ready_date_time,
      rx_tx_pc_ready_date_time_of_day,
      rx_tx_pc_ready_date_week,
      rx_tx_pc_ready_date_week_of_year,
      rx_tx_pc_ready_date_year,
      rx_tx_pc_ready_date,
      rx_tx_pickup_signature_not_required,
      rx_tx_pos_invoice_number,
      rx_tx_pos_reason_for_void,
      sum_rx_tx_prescribed_quantity,
      rx_tx_price_override_reason,
      rx_tx_pv_employee_number,
      #rx_tx_refill_source, [ERXLPS-896] Exposed in WF Explore and commented in set.
      rx_tx_register_number,
      rx_tx_replace_date_date,
      rx_tx_replace_date_day_of_month,
      rx_tx_replace_date_day_of_week,
      rx_tx_replace_date_day_of_week_index,
      rx_tx_replace_date_hour_of_day,
      rx_tx_replace_date_hour2,
      rx_tx_replace_date_minute15,
      rx_tx_replace_date_month,
      rx_tx_replace_date_month_num,
      rx_tx_replace_date_quarter,
      rx_tx_replace_date_quarter_of_year,
      rx_tx_replace_date_time,
      rx_tx_replace_date_time_of_day,
      rx_tx_replace_date_week,
      rx_tx_replace_date_week_of_year,
      rx_tx_replace_date_year,
      rx_tx_replace_date,
      rx_tx_relationship_to_patient,
      sum_rx_tx_requested_price_to_quantity,
      rx_tx_require_relation_to_patient,
      #[ERXLPS-2186] Exposing return_to_stock_date in WF Explore.
      #rx_tx_return_to_stock_date_date,
      #rx_tx_return_to_stock_date_day_of_month,
      #rx_tx_return_to_stock_date_day_of_week,
      #rx_tx_return_to_stock_date_day_of_week_index,
      #rx_tx_return_to_stock_date_hour_of_day,
      #rx_tx_return_to_stock_date_hour2,
      #rx_tx_return_to_stock_date_minute15,
      #rx_tx_return_to_stock_date_month,
      #rx_tx_return_to_stock_date_month_num,
      #rx_tx_return_to_stock_date_quarter,
      #rx_tx_return_to_stock_date_quarter_of_year,
      #rx_tx_return_to_stock_date_time,
      #rx_tx_return_to_stock_date_time_of_day,
      #rx_tx_return_to_stock_date_week,
      #rx_tx_return_to_stock_date_week_of_year,
      #rx_tx_return_to_stock_date_year,
      #rx_tx_return_to_stock_date,
      rx_tx_rx_com_down,
      rx_tx_rx_stolen,
      rx_tx_sent_to_ehr,
      rx_tx_specialty_pa,
      rx_tx_specialty_pa_status,
      rx_tx_state_report_status,
      rx_tx_tx_user_modified,
      rx_tx_using_compound_plan_pricing,
      rx_tx_using_percent_of_brand,
      rx_tx_dispensed_drug_ndc,
      sum_rx_tx_manual_acquisition_cost,
      avg_rx_tx_manual_acquisition_cost,
      sum_rx_tx_overridden_price_amount,
      avg_rx_tx_overridden_price_amount,
      sum_rx_tx_professional_fee,
      avg_rx_tx_professional_fee
    ]
  }

  set: explore_tp_transmit_queue_candidate_list {
    fields: [
      count,
      sum_price,
      rx_tx_refill_number,
      rx_tx_tx_number,
      rx_tx_pos_sold,
      rx_tx_pos_sold_time,
      rx_tx_pos_sold_date,
      rx_tx_pos_sold_week,
      rx_tx_pos_sold_month,
      rx_tx_pos_sold_month_num,
      rx_tx_pos_sold_year,
      rx_tx_pos_sold_quarter,
      rx_tx_pos_sold_quarter_of_year,
      rx_tx_pos_sold_hour_of_day,
      rx_tx_pos_sold_time_of_day,
      rx_tx_pos_sold_hour2,
      rx_tx_pos_sold_minute15,
      rx_tx_pos_sold_day_of_week,
      rx_tx_pos_sold_week_of_year,
      rx_tx_pos_sold_day_of_week_index,
      rx_tx_pos_sold_day_of_month,
      rx_tx_reportable_sales,
      rx_tx_reportable_sales_time,
      rx_tx_reportable_sales_date,
      rx_tx_reportable_sales_week,
      rx_tx_reportable_sales_month,
      rx_tx_reportable_sales_month_num,
      rx_tx_reportable_sales_year,
      rx_tx_reportable_sales_quarter,
      rx_tx_reportable_sales_quarter_of_year,
      rx_tx_reportable_sales_hour_of_day,
      rx_tx_reportable_sales_time_of_day,
      rx_tx_reportable_sales_hour2,
      rx_tx_reportable_sales_minute15,
      rx_tx_reportable_sales_day_of_week,
      rx_tx_reportable_sales_week_of_year,
      rx_tx_reportable_sales_day_of_week_index,
      rx_tx_reportable_sales_day_of_month,
      rx_tx_returned,
      rx_tx_returned_time,
      rx_tx_returned_date,
      rx_tx_returned_week,
      rx_tx_returned_month,
      rx_tx_returned_month_num,
      rx_tx_returned_year,
      rx_tx_returned_quarter,
      rx_tx_returned_quarter_of_year,
      rx_tx_returned_hour_of_day,
      rx_tx_returned_time_of_day,
      rx_tx_returned_hour2,
      rx_tx_returned_minute15,
      rx_tx_returned_day_of_week,
      rx_tx_returned_week_of_year,
      rx_tx_returned_day_of_week_index,
      rx_tx_returned_day_of_month,
      will_call_arrival,
      will_call_arrival_time,
      will_call_arrival_date,
      will_call_arrival_week,
      will_call_arrival_month,
      will_call_arrival_month_num,
      will_call_arrival_year,
      will_call_arrival_quarter,
      will_call_arrival_quarter_of_year,
      will_call_arrival_hour_of_day,
      will_call_arrival_time_of_day,
      will_call_arrival_hour2,
      will_call_arrival_minute15,
      will_call_arrival_day_of_week,
      will_call_arrival_week_of_year,
      will_call_arrival_day_of_week_index,
      will_call_arrival_day_of_month,
      rx_tx_will_call_picked_up,
      rx_tx_will_call_picked_up_time,
      rx_tx_will_call_picked_up_date,
      rx_tx_will_call_picked_up_week,
      rx_tx_will_call_picked_up_month,
      rx_tx_will_call_picked_up_month_num,
      rx_tx_will_call_picked_up_year,
      rx_tx_will_call_picked_up_quarter,
      rx_tx_will_call_picked_up_quarter_of_year,
      rx_tx_will_call_picked_up_hour_of_day,
      rx_tx_will_call_picked_up_time_of_day,
      rx_tx_will_call_picked_up_hour2,
      rx_tx_will_call_picked_up_minute15,
      rx_tx_will_call_picked_up_day_of_week,
      rx_tx_will_call_picked_up_week_of_year,
      rx_tx_will_call_picked_up_day_of_week_index,
      rx_tx_will_call_picked_up_day_of_month,
      rx_tx_fill,
      rx_tx_fill_time,
      rx_tx_fill_date,
      rx_tx_fill_week,
      rx_tx_fill_month,
      rx_tx_fill_month_num,
      rx_tx_fill_year,
      rx_tx_fill_quarter,
      rx_tx_fill_quarter_of_year,
      rx_tx_fill_hour_of_day,
      rx_tx_fill_time_of_day,
      rx_tx_fill_hour2,
      rx_tx_fill_minute15,
      rx_tx_fill_day_of_week,
      rx_tx_fill_week_of_year,
      rx_tx_fill_day_of_week_index,
      rx_tx_fill_day_of_month,

      #ERXLPS-386 new dimensions
      rx_tx_fill_quantity,
      rx_tx_price,
      rx_tx_uc_price
    ]
  }

  set: explore_rx_4_8_000_sf_deployment_candidate_list {
    fields: [
      rx_tx_auto_counting_system_priority,
      sum_rx_tx_base_cost,
      rx_tx_cashier_name,
      rx_tx_central_fill_cutoff,
      rx_tx_central_fill_cutoff_time,
      rx_tx_central_fill_cutoff_date,
      rx_tx_central_fill_cutoff_week,
      rx_tx_central_fill_cutoff_month,
      rx_tx_central_fill_cutoff_month_num,
      rx_tx_central_fill_cutoff_year,
      rx_tx_central_fill_cutoff_quarter,
      rx_tx_central_fill_cutoff_quarter_of_year,
      rx_tx_central_fill_cutoff_hour_of_day,
      rx_tx_central_fill_cutoff_time_of_day,
      rx_tx_central_fill_cutoff_hour2,
      rx_tx_central_fill_cutoff_minute15,
      rx_tx_central_fill_cutoff_day_of_week,
      rx_tx_central_fill_cutoff_week_of_year,
      rx_tx_central_fill_cutoff_day_of_week_index,
      rx_tx_central_fill_cutoff_day_of_month,
      rx_tx_charge,
      sum_rx_tx_compound_fee,
      rx_tx_counseling_choice,
      rx_tx_days_supply,
      rx_tx_days_supply_basis,

      #- rx_tx_dispensed_drug_ndc #Dimesion exists prior to 48000. Check with Kumaran
      rx_tx_drug_expiration,
      rx_tx_drug_expiration_time,
      rx_tx_drug_expiration_date,
      rx_tx_drug_expiration_week,
      rx_tx_drug_expiration_month,
      rx_tx_drug_expiration_month_num,
      rx_tx_drug_expiration_year,
      rx_tx_drug_expiration_quarter,
      rx_tx_drug_expiration_quarter_of_year,
      rx_tx_drug_expiration_hour_of_day,
      rx_tx_drug_expiration_time_of_day,
      rx_tx_drug_expiration_hour2,
      rx_tx_drug_expiration_minute15,
      rx_tx_drug_expiration_day_of_week,
      rx_tx_drug_expiration_week_of_year,
      rx_tx_drug_expiration_day_of_week_index,
      rx_tx_drug_expiration_day_of_month,
      rx_tx_drug_image_key,
      rx_tx_drug_image_start,
      rx_tx_drug_image_start_time,
      rx_tx_drug_image_start_date,
      rx_tx_drug_image_start_week,
      rx_tx_drug_image_start_month,
      rx_tx_drug_image_start_month_num,
      rx_tx_drug_image_start_year,
      rx_tx_drug_image_start_quarter,
      rx_tx_drug_image_start_quarter_of_year,
      rx_tx_drug_image_start_hour_of_day,
      rx_tx_drug_image_start_time_of_day,
      rx_tx_drug_image_start_hour2,
      rx_tx_drug_image_start_minute15,
      rx_tx_drug_image_start_day_of_week,
      rx_tx_drug_image_start_week_of_year,
      rx_tx_drug_image_start_day_of_week_index,
      rx_tx_drug_image_start_day_of_month,
      rx_tx_drug_schedule,
      rx_tx_exclude_from_batch_fill,
      rx_tx_exclude_from_mar,
      rx_tx_exclude_from_prescriber_order,
      rx_tx_follow_up,
      rx_tx_follow_up_time,
      rx_tx_follow_up_date,
      rx_tx_follow_up_week,
      rx_tx_follow_up_month,
      rx_tx_follow_up_month_num,
      rx_tx_follow_up_year,
      rx_tx_follow_up_quarter,
      rx_tx_follow_up_quarter_of_year,
      rx_tx_follow_up_hour_of_day,
      rx_tx_follow_up_time_of_day,
      rx_tx_follow_up_hour2,
      rx_tx_follow_up_minute15,
      rx_tx_follow_up_day_of_week,
      rx_tx_follow_up_week_of_year,
      rx_tx_follow_up_day_of_week_index,
      rx_tx_follow_up_day_of_month,
      rx_tx_group_code,
      rx_tx_host_retrieval,
      rx_tx_host_retrieval_time,
      rx_tx_host_retrieval_date,
      rx_tx_host_retrieval_week,
      rx_tx_host_retrieval_month,
      rx_tx_host_retrieval_month_num,
      rx_tx_host_retrieval_year,
      rx_tx_host_retrieval_quarter,
      rx_tx_host_retrieval_quarter_of_year,
      rx_tx_host_retrieval_hour_of_day,
      rx_tx_host_retrieval_time_of_day,
      rx_tx_host_retrieval_hour2,
      rx_tx_host_retrieval_minute15,
      rx_tx_host_retrieval_day_of_week,
      rx_tx_host_retrieval_week_of_year,
      rx_tx_host_retrieval_day_of_week_index,
      rx_tx_host_retrieval_day_of_month,
      rx_tx_icd9_code,
      rx_tx_icd9_type,
      rx_tx_sig_language,
      rx_tx_manufacturer,
      rx_tx_mar_page_position,
      rx_tx_mar_sort_order,
      rx_tx_ncpdp_daw,
      rx_tx_new_rx_tx_id,
      rx_tx_old_rx_tx_id,
      rx_tx_note,
      rx_tx_number_of_labels,
      rx_tx_off_site,
      sum_rx_tx_owed_quantity,
      rx_tx_pac_med,
      rx_tx_photo_id_address,
      rx_tx_photo_id_birth,
      rx_tx_photo_id_birth_time,
      rx_tx_photo_id_birth_date,
      rx_tx_photo_id_birth_week,
      rx_tx_photo_id_birth_month,
      rx_tx_photo_id_birth_month_num,
      rx_tx_photo_id_birth_year,
      rx_tx_photo_id_birth_quarter,
      rx_tx_photo_id_birth_quarter_of_year,
      rx_tx_photo_id_birth_hour_of_day,
      rx_tx_photo_id_birth_time_of_day,
      rx_tx_photo_id_birth_hour2,
      rx_tx_photo_id_birth_minute15,
      rx_tx_photo_id_birth_day_of_week,
      rx_tx_photo_id_birth_week_of_year,
      rx_tx_photo_id_birth_day_of_week_index,
      rx_tx_photo_id_birth_day_of_month,
      rx_tx_photo_id_city,
      rx_tx_photo_id_expire,
      rx_tx_photo_id_expire_time,
      rx_tx_photo_id_expire_date,
      rx_tx_photo_id_expire_week,
      rx_tx_photo_id_expire_month,
      rx_tx_photo_id_expire_month_num,
      rx_tx_photo_id_expire_year,
      rx_tx_photo_id_expire_quarter,
      rx_tx_photo_id_expire_quarter_of_year,
      rx_tx_photo_id_expire_hour_of_day,
      rx_tx_photo_id_expire_time_of_day,
      rx_tx_photo_id_expire_hour2,
      rx_tx_photo_id_expire_minute15,
      rx_tx_photo_id_expire_day_of_week,
      rx_tx_photo_id_expire_week_of_year,
      rx_tx_photo_id_expire_day_of_week_index,
      rx_tx_photo_id_expire_day_of_month,
      rx_tx_photo_id_number,
      rx_tx_photo_id_pickup_dropoff_qualifier,
      rx_tx_photo_id_postal_code,
      rx_tx_photo_id_state,
      rx_tx_photo_id_type,
      rx_tx_picked_up,
      rx_tx_pickup_first_name,
      rx_tx_pickup_last_name,
      rx_tx_pickup_middle_name,
      rx_tx_pos_barcode_number,
      rx_tx_physician_order_page_position,
      rx_tx_physician_order_sort_order,
      rx_tx_prescriber_transmitted,
      rx_tx_pv_initials,
      rx_tx_rems_dispensing,
      rx_tx_require_pickup_id_address,
      rx_tx_require_pickup_id_birth_date,
      rx_tx_require_pickup_id_city,
      rx_tx_require_pickup_id_expiration,
      rx_tx_require_pickup_id_middle_name,
      rx_tx_require_pickup_id_name,
      rx_tx_require_pickup_id_number,
      rx_tx_require_pickup_id_postal_code,
      rx_tx_require_pickup_id_state,
      rx_tx_require_pickup_id_type,
      rx_tx_route_of_administration_id,
      rx_tx_rph_employee_number_of_record,
      rx_tx_rx_match_key,
      rx_tx_safety_cap,
      rx_tx_sig_code,
      sum_rx_tx_sig_per_day,
      sum_rx_tx_sig_per_dose,
      rx_tx_sig_prn,
      rx_tx_sig_text,
      rx_tx_site_of_administration,
      rx_tx_stop,
      rx_tx_stop_time,
      rx_tx_stop_date,
      rx_tx_stop_week,
      rx_tx_stop_month,
      rx_tx_stop_month_num,
      rx_tx_stop_year,
      rx_tx_stop_quarter,
      rx_tx_stop_quarter_of_year,
      rx_tx_stop_hour_of_day,
      rx_tx_stop_time_of_day,
      rx_tx_stop_hour2,
      rx_tx_stop_minute15,
      rx_tx_stop_day_of_week,
      rx_tx_stop_week_of_year,
      rx_tx_stop_day_of_week_index,
      rx_tx_stop_day_of_month,
      rx_tx_submitted_prescriber_dea,
      rx_tx_submitted_prescriber_npi,
      sum_rx_tx_up_charge,
      rx_tx_usual,
      #rx_tx_written,
      #rx_tx_written_time,
      #rx_tx_written_date,
      #rx_tx_written_week,
      #rx_tx_written_month,
      #rx_tx_written_month_num,
      #rx_tx_written_year,
      #rx_tx_written_quarter,
      #rx_tx_written_quarter_of_year,
      #rx_tx_written_hour_of_day,
      #rx_tx_written_time_of_day,
      #rx_tx_written_hour2,
      #rx_tx_written_minute15,
      #rx_tx_written_day_of_week,
      #rx_tx_written_week_of_year,
      #rx_tx_written_day_of_week_index,
      #rx_tx_written_day_of_month,
      rx_tx_consent_by_first_name,
      rx_tx_consent_by_last_name,
      rx_tx_consent_by_middle_name,
      rx_tx_consent_by_relation_code,
      rx_tx_partial_fill_approved,
      source_create,
      source_create_time,
      source_create_date,
      source_create_week,
      source_create_month,
      source_create_month_num,
      source_create_year,
      source_create_quarter,
      source_create_quarter_of_year,
      source_create_hour_of_day,
      source_create_time_of_day,
      source_create_hour2,
      source_create_minute15,
      source_create_day_of_week,
      source_create_week_of_year,
      source_create_day_of_week_index,
      source_create_day_of_month
    ]
  }

  set: explore_sales_candidate_list {
    fields: [
      rx_tx_tx_number,
      rx_tx_refill_number,
      rx_tx_counseling_rph_employee_number,
      rx_tx_counseling_rph_initials,
      rx_tx_ddid_used_by_drug_selection,
      rx_tx_de_initials,
      rx_tx_dob_override_employee_number,
      rx_tx_dv_initials,
      rx_tx_epr_synch_version,
      rx_tx_gpi_used_by_drug_selection,
      rx_tx_mobile_services_channel,
      rx_tx_new_ddid_authorized_by_emp_number,
      rx_tx_pos_invoice_number,
      rx_tx_pos_reason_for_void,
      rx_tx_pv_employee_number,
      rx_tx_register_number,
      rx_tx_tx_status,
      rx_tx_fill_status,
      rx_tx_drug_dispensed,
      rx_tx_admin_rebilled,
      rx_tx_allow_price_override,
      rx_tx_brand_manually_selected,
      rx_tx_competitive_priced,
      rx_tx_controlled_substance_escript,
      rx_tx_custom_sig,
      rx_tx_different_generic,
      rx_tx_fill_location,
      rx_tx_generic_manually_selected,
      rx_tx_keep_same_drug,
      rx_tx_manual_acquisition_drug_dispensed,
      rx_tx_medicare_notice,
      rx_tx_no_sales_tax,
      rx_tx_otc_taxable_indicator,
      rx_tx_patient_request_brand_generic,
      rx_tx_patient_requested_price,
      rx_tx_pickup_signature_not_required,
      rx_tx_price_override_reason,
      rx_tx_refill_source,
      rx_tx_relationship_to_patient,
      rx_tx_require_relation_to_patient,
      rx_tx_rx_com_down,
      rx_tx_rx_stolen,
      rx_tx_sent_to_ehr,
      rx_tx_specialty_pa,
      rx_tx_specialty_pa_status,
      rx_tx_state_report_status,
      rx_tx_tx_user_modified,
      rx_tx_using_compound_plan_pricing,
      rx_tx_using_percent_of_brand,

      # Uses EDW.D_STORE_DRUG to retrieve the NDC that was dispensed, based on the DRUG_DISPENSED. Logic Used - select max(store_drug_ndc) from edw.d_store_drug where chain_id = ${chain_id} and nhin_store_id = ${nhin_store_id} and drug_id = DECODE(${TABLE}.RX_TX_DRUG_DISPENSED,'G',${eps_rx_tx.rx_tx_drug_generic_id},DECODE(${TABLE}.RX_TX_DRUG_DISPENSED,'B',${eps_rx_tx.rx_tx_drug_brand_id},${eps_rx_tx.rx_tx_compound_id})))
      rx_tx_dispensed_drug_ndc,
      rx_tx_is_340_b,
      rx_tx_partial_fill_bill_type,
      rx_tx_partial_fill_status,
      rx_tx_pos_status,
      rx_tx_rx_credit_initiator,
      rx_tx_tp_bill,
      return_to_stock_yesno,
      rx_tx_intended_days_supply,

      #[ERXLPS-652] Starts Here. Commenting measure from eps_rx_tx view. After TP Transmit Queue integreation into Sales explore, pulling eps_rx_tx view measure are providing incorrect results. The below measures are created in sales view and removing from slaes candidate list.
      #- sum_rx_tx_manual_acquisition_cost
      #- avg_rx_tx_manual_acquisition_cost
      #- sum_rx_tx_professional_fee
      #- avg_rx_tx_professional_fee
      #- sum_rx_tx_intended_quantity
      #- sum_rx_tx_original_quantity
      #- sum_rx_tx_prescribed_quantity
      #- sum_rx_tx_requested_price_to_quantity
      #- sum_rx_tx_pos_overridden_net_paid
      #- avg_rx_tx_pos_overridden_net_paid
      #- sum_rx_tx_fill_quantity
      #- sum_rx_tx_original_price
      #[ERXLPS-652] Ends Here. Commenting measure from eps_rx_tx view. After TP Transmit Queue integreation into Sales explore, pulling eps_rx_tx view measure are providing incorrect results. The below measures are created in sales view and removing from slaes candidate list.
      #     - rx_tx_generic_acquisition_cost      # referenced directly in sales explore as TY/LY calculation would be required against these fields
      #     - rx_tx_brand_acquisition_cost        # referenced directly in sales explore as TY/LY calculation would be required against these fields
      #     - rx_tx_generic_discount              # referenced directly in sales explore as TY/LY calculation would be required against these fields
      #     - rx_tx_brand_discount                # referenced directly in sales explore as TY/LY calculation would be required against these fields
      #     - rx_tx_brand_price                   # referenced directly in sales explore as TY/LY calculation would be required against these fields
      #     - rx_tx_generic_price                 # referenced directly in sales explore as TY/LY calculation would be required against these fields
      #     - return_to_stock_count               # Field is reference directly in Sales as return to stock needs to be handled differently based on HISTORT or NO HISTORY selection
      #     - return_to_stock_sales               # Field is reference directly in Sales as return to stock needs to be handled differently based on HISTORT or NO HISTORY selection
      #     - on_time                             # Uses eps_order_entry to get the order_entry_promised_time
      #     - is_on_time                          # references on_time to determine if the rxtx met the promised time

      # ERXLPS-258 Changes (Note: Additional Date related fields would be extended in the future release as additional setup has to be done with respect to Sales/Fiscal explore)
      rx_tx_auto_counting_system_priority,
      rx_tx_cashier_name,
      rx_tx_charge,
      rx_tx_counseling_choice,
      rx_tx_days_supply,
      rx_tx_days_supply_basis,
      rx_tx_drug_schedule,
      rx_tx_exclude_from_batch_fill,
      rx_tx_exclude_from_mar,
      rx_tx_exclude_from_prescriber_order,
      rx_tx_group_code,
      rx_tx_icd9_code,
      rx_tx_icd9_type,
      rx_tx_sig_language,
      rx_tx_manufacturer,
      rx_tx_mar_page_position,
      rx_tx_mar_sort_order,
      rx_tx_ncpdp_daw,
      rx_tx_new_rx_tx_id,
      rx_tx_old_rx_tx_id,
      rx_tx_note,
      rx_tx_number_of_labels,
      rx_tx_off_site,
      rx_tx_pac_med,
      rx_tx_photo_id_address,
      rx_tx_photo_id_city,
      rx_tx_photo_id_number,
      rx_tx_photo_id_pickup_dropoff_qualifier,
      rx_tx_photo_id_postal_code,
      rx_tx_photo_id_state,
      rx_tx_photo_id_type,
      rx_tx_picked_up,
      rx_tx_pickup_first_name,
      rx_tx_pickup_last_name,
      rx_tx_pickup_middle_name,
      rx_tx_pos_barcode_number,
      rx_tx_physician_order_page_position,
      rx_tx_physician_order_sort_order,
      rx_tx_prescriber_transmitted,
      rx_tx_pv_initials,
      rx_tx_rems_dispensing,
      rx_tx_require_pickup_id_address,
      rx_tx_require_pickup_id_birth_date,
      rx_tx_require_pickup_id_city,
      rx_tx_require_pickup_id_expiration,
      rx_tx_require_pickup_id_middle_name,
      rx_tx_require_pickup_id_name,
      rx_tx_require_pickup_id_number,
      rx_tx_require_pickup_id_postal_code,
      rx_tx_require_pickup_id_state,
      rx_tx_require_pickup_id_type,
      rx_tx_route_of_administration_id,
      rx_tx_rph_employee_number_of_record,
      rx_tx_rx_match_key,
      rx_tx_safety_cap,
      rx_tx_sig_code,
      rx_tx_sig_prn,
      rx_tx_sig_text,
      rx_tx_site_of_administration,
      rx_tx_submitted_prescriber_dea,
      rx_tx_submitted_prescriber_npi,
      rx_tx_usual,
      rx_tx_consent_by_first_name,
      rx_tx_consent_by_last_name,
      rx_tx_consent_by_middle_name,
      rx_tx_consent_by_relation_code,
      rx_tx_partial_fill_approved,

      #[ERXLPS-652] Starts Here. Commenting measure from eps_rx_tx view. After TP Transmit Queue integreation into Sales explore, pulling eps_rx_tx view measure are providing incorrect results. The below measures are created in sales view and removing from slaes candidate list.
      #- sum_rx_tx_base_cost
      #- sum_rx_tx_compound_fee
      #- sum_rx_tx_sig_per_day
      #- sum_rx_tx_sig_per_dose
      #- sum_rx_tx_up_charge
      #- sum_rx_tx_owed_quantity
      #[ERXLPS-652] Ends Here. Commenting measure from eps_rx_tx view. After TP Transmit Queue integreation into Sales explore, pulling eps_rx_tx view measure are providing incorrect results. The below measures are created in sales view and removing from slaes candidate list.
      # ERXLPS-643 - Removed sum measures and added number measures to sales set, in order to sum in sales view so number does not change when LY analysis is turned on. Also Added Yes No price override dimension
      rx_tx_price_override_yesno,
      #[ERXLPS-910] - New sales measures added to sales candidate list
      sum_sales_rx_tx_manual_acquisition_cost,
      avg_sales_rx_tx_manual_acquisition_cost,
      sum_sales_rx_tx_professional_fee,
      avg_sales_rx_tx_professional_fee,
      sum_sales_rx_tx_intended_quantity,
      sum_sales_rx_tx_original_quantity,
      sum_sales_rx_tx_prescribed_quantity,
      sum_sales_rx_tx_requested_price_to_quantity,
      sum_sales_rx_tx_pos_overridden_net_paid,
      avg_sales_rx_tx_pos_overridden_net_paid,
      sum_sales_rx_tx_fill_quantity,
      sum_sales_rx_tx_fill_quantity_tp,
      sum_sales_rx_tx_fill_quantity_cash,
      sum_sales_rx_tx_original_price,
      sum_sales_rx_tx_base_cost,
      sum_sales_rx_tx_compound_fee,
      sum_sales_rx_tx_sig_per_day,
      sum_sales_rx_tx_sig_per_dose,
      sum_sales_rx_tx_up_charge,
      sum_sales_rx_tx_owed_quantity,
      sum_sales_rx_tx_prescribed_quantity_tp,
      sum_sales_rx_tx_prescribed_quantity_cash
    ]
  }

  #- rx_tx_overridden_price_amount  #[ERXLPS-724] - Commenting from eps_rx_tx. Removed as measure and created as dimension to refere in other views. Currently reference in sales view.
  #- rx_tx_uc_price_measure #[ERXLPS-724] - Commenting the below measure from eps_rx_tx. This base column added in sales view sql and below measure is not required in eps_rx_tx.
  # ERXLPS-271 Changes
  #[ERXLPS-652] Starts Here. Commenting measure from eps_rx_tx view. After TP Transmit Queue integreation into Sales explore, pulling eps_rx_tx view measure are providing incorrect results. The below measures are created in sales view and removing from slaes candidate list.
  #- sum_rx_tx_prescribed_quantity_tp
  #- sum_rx_tx_prescribed_quantity_cash
  #- sum_rx_tx_fill_quantity_tp
  #- sum_rx_tx_fill_quantity_cash
  #[ERXLPS-652] Starts Here. Commenting measure from eps_rx_tx view. After TP Transmit Queue integreation into Sales explore, pulling eps_rx_tx view measure are providing incorrect results. The below measures are created in sales view and removing from slaes candidate list.

  set: explore_bi_demo_sales_candidate_list {
    fields: [
      rx_tx_tx_number,
      rx_tx_refill_number,
      rx_tx_ddid_used_by_drug_selection,
      rx_tx_epr_synch_version,
      rx_tx_gpi_used_by_drug_selection,
      rx_tx_mobile_services_channel,
      rx_tx_pos_reason_for_void,
      rx_tx_tx_status,
      rx_tx_fill_status,
      rx_tx_drug_dispensed,
      rx_tx_admin_rebilled,
      rx_tx_allow_price_override,
      rx_tx_brand_manually_selected,
      rx_tx_competitive_priced,
      rx_tx_controlled_substance_escript,
      rx_tx_different_generic,
      rx_tx_fill_location,
      rx_tx_generic_manually_selected,
      rx_tx_keep_same_drug,
      rx_tx_manual_acquisition_drug_dispensed,
      rx_tx_medicare_notice,
      rx_tx_no_sales_tax,
      rx_tx_otc_taxable_indicator,
      rx_tx_patient_request_brand_generic,
      rx_tx_patient_requested_price,
      rx_tx_pickup_signature_not_required,
      rx_tx_price_override_reason,
      rx_tx_refill_source,
      rx_tx_relationship_to_patient,
      rx_tx_require_relation_to_patient,
      rx_tx_rx_com_down,
      rx_tx_rx_stolen,
      rx_tx_sent_to_ehr,
      rx_tx_specialty_pa,
      rx_tx_specialty_pa_status,
      rx_tx_state_report_status,
      rx_tx_using_compound_plan_pricing,
      rx_tx_using_percent_of_brand,

      # Uses EDW.D_STORE_DRUG to retrieve the NDC that was dispensed, based on the DRUG_DISPENSED. Logic Used - select max(store_drug_ndc) from edw.d_store_drug where chain_id = ${chain_id} and nhin_store_id = ${nhin_store_id} and drug_id = DECODE(${TABLE}.RX_TX_DRUG_DISPENSED,'G',${eps_rx_tx.rx_tx_drug_generic_id},DECODE(${TABLE}.RX_TX_DRUG_DISPENSED,'B',${eps_rx_tx.rx_tx_drug_brand_id},${eps_rx_tx.rx_tx_compound_id})))
      rx_tx_dispensed_drug_ndc,
      rx_tx_is_340_b,
      rx_tx_partial_fill_bill_type,
      rx_tx_partial_fill_status,
      rx_tx_pos_status,
      rx_tx_rx_credit_initiator,
      rx_tx_tp_bill,
      return_to_stock_yesno,
      rx_tx_intended_days_supply,
      sum_rx_tx_manual_acquisition_cost,
      avg_rx_tx_manual_acquisition_cost,
      sum_rx_tx_overridden_price_amount,
      avg_rx_tx_overridden_price_amount,
      sum_rx_tx_professional_fee,
      avg_rx_tx_professional_fee,
      sum_rx_tx_intended_quantity,
      sum_rx_tx_original_quantity,
      sum_rx_tx_prescribed_quantity,
      sum_rx_tx_requested_price_to_quantity,
      sum_rx_tx_pos_overridden_net_paid,
      avg_rx_tx_pos_overridden_net_paid,
      sum_rx_tx_fill_quantity,
      sum_rx_tx_original_price,

      #- sum_rx_tx_uc_price #[ERXLPS-778] - Corresponding measure created in bi_demo_sales view.
      rx_tx_auto_counting_system_priority,
      rx_tx_charge,
      rx_tx_counseling_choice,
      rx_tx_days_supply,
      rx_tx_days_supply_basis,
      rx_tx_drug_schedule,
      rx_tx_exclude_from_batch_fill,
      rx_tx_exclude_from_mar,
      rx_tx_exclude_from_prescriber_order,
      rx_tx_group_code,
      rx_tx_icd9_code,
      rx_tx_icd9_type,
      rx_tx_mar_page_position,
      rx_tx_mar_sort_order,
      rx_tx_ncpdp_daw,
      rx_tx_new_rx_tx_id,
      rx_tx_old_rx_tx_id,
      rx_tx_number_of_labels,
      rx_tx_off_site,
      rx_tx_pac_med,
      rx_tx_physician_order_page_position,
      rx_tx_physician_order_sort_order,
      rx_tx_prescriber_transmitted,
      rx_tx_rems_dispensing,
      rx_tx_route_of_administration_id,
      rx_tx_rx_match_key,
      rx_tx_safety_cap,
      rx_tx_site_of_administration,
      rx_tx_usual,
      rx_tx_consent_by_relation_code,
      rx_tx_partial_fill_approved,
      sum_rx_tx_base_cost,
      sum_rx_tx_compound_fee,
      sum_rx_tx_sig_per_day,
      sum_rx_tx_sig_per_dose,
      sum_rx_tx_up_charge,
      sum_rx_tx_owed_quantity,

      # ERXLPS-271 Changes
      sum_rx_tx_prescribed_quantity_tp,
      sum_rx_tx_prescribed_quantity_cash,
      sum_rx_tx_fill_quantity_tp,
      sum_rx_tx_fill_quantity_cash,

      # ERXLPS-675 Changes adding to explore_bi_demo_sales_candidate_list
      rx_tx_written,
      rx_tx_written_time,
      rx_tx_written_date,
      rx_tx_written_week,
      rx_tx_written_month,
      rx_tx_written_month_num,
      rx_tx_written_year,
      rx_tx_written_quarter,
      rx_tx_written_quarter_of_year,
      rx_tx_written_hour_of_day,
      rx_tx_written_time_of_day,
      rx_tx_written_hour2,
      rx_tx_written_minute15,
      rx_tx_written_day_of_week,
      rx_tx_written_week_of_year,
      rx_tx_written_day_of_week_index,
      rx_tx_written_day_of_month,
      rx_tx_drug_image_key #[ERXLPS-1055]
    ]
  }

  set: explore_rx_4_11_history_candidate_list {
    fields: [
      rx_tx_will_call_picked_up_date,
      sum_rx_tx_fill_quantity

    ]
  }

  #[ERXLPS-1521]
  set: explore_rx_4_11_history_at_fill_candidate_list {
    fields: [
      rx_tx_fill_date,
      sum_rx_tx_fill_quantity_at_fill
    ]
  }

  #[ERXLPS-910] New set created to exclude sales specific measures from other explores
  set: explore_sales_specific_candidate_list {
    fields: [
      sum_sales_rx_tx_manual_acquisition_cost,
      avg_sales_rx_tx_manual_acquisition_cost,
      sum_sales_rx_tx_professional_fee,
      avg_sales_rx_tx_professional_fee,
      sum_sales_rx_tx_intended_quantity,
      sum_sales_rx_tx_original_quantity,
      sum_sales_rx_tx_prescribed_quantity,
      sum_sales_rx_tx_requested_price_to_quantity,
      sum_sales_rx_tx_pos_overridden_net_paid,
      avg_sales_rx_tx_pos_overridden_net_paid,
      sum_sales_rx_tx_fill_quantity,
      sum_sales_rx_tx_fill_quantity_tp,
      sum_sales_rx_tx_fill_quantity_cash,
      sum_sales_rx_tx_original_price,
      sum_sales_rx_tx_base_cost,
      sum_sales_rx_tx_compound_fee,
      sum_sales_rx_tx_sig_per_day,
      sum_sales_rx_tx_sig_per_dose,
      sum_sales_rx_tx_up_charge,
      sum_sales_rx_tx_owed_quantity,
      sum_sales_rx_tx_prescribed_quantity_tp,
      sum_sales_rx_tx_prescribed_quantity_cash
    ]
  }

  #[ERX-3514] : New set created to exclude gap time measures from other explores
  set:  gap_time_measures_candidate_list {
    fields: [
      source_task,
      target_task
    ]
  }

  set:  bi_demo_specific_candidate_list {
    fields: [
      bi_demo_prescription_fill_duration,
      bi_demo_start,
      bi_demo_sum_fill_duration,
      bi_demo_avg_fill_duration,
      bi_demo_median_fill_duration,
      bi_demo_max_fill_duration,
      bi_demo_min_fill_duration,
      bi_demo_start_time,
      bi_demo_start_date,
      bi_demo_start_week,
      bi_demo_start_month,
      bi_demo_start_month_num,
      bi_demo_start_year,
      bi_demo_start_quarter,
      bi_demo_start_quarter_of_year,
      bi_demo_start_hour_of_day,
      bi_demo_start_time_of_day,
      bi_demo_start_hour2,
      bi_demo_start_minute15,
      bi_demo_start_day_of_week,
      bi_demo_start_week_of_year,
      bi_demo_start_day_of_week_index,
      bi_demo_start_day_of_month,
      bi_demo_is_on_time_fifteen,
      bi_demo_time_in_will_call,
      bi_demo_sum_time_in_will_call,
      bi_demo_avg_time_in_will_call,
      bi_demo_median_time_in_will_call,
      bi_demo_max_time_in_will_call,
      bi_demo_min_time_in_will_call
    ]
  }

  #ERXDWPS-7253 - Sync EPS RX_TX to EDW
  set:  exclude_eps_rx_tx_fields {
    fields: [
      rx_tx_dispensing_rules_state,
      rx_tx_prescriber_license_state,
      rx_tx_prescriber_license_number,
      rx_tx_wait_for_pa_rx_tx_id,
      rx_tx_cii_partial_dispensed_count,
      rx_tx_alignment_fill_days_supply,
      rx_tx_alignment_fill_type,
      rx_tx_is_alignment_fill_request,
      rx_tx_immunization_share_flag,
      rx_tx_pmp_opioid_treatment_type,
      rx_tx_require_id_pickup_dropoff_qualifier,
      rx_tx_pv_double_count_performed,
      rx_tx_change_billing ,
      rx_tx_last_foreground_rph_employee_number,
      rx_tx_ship_to_provider_address_only,
      rx_tx_tax_code_id,
      rx_tx_initial_rx_tx_id,
      rx_tx_subsequent_rx_tx_id,
      rx_tx_used_in_insulin_pump,
      sum_rx_tx_patient_pay_amount,
      sum_rx_tx_expected_completion_patient_pay_amount,
      rx_tx_counseling_completion_time,
      rx_tx_counseling_completion_date,
      rx_tx_counseling_completion_week,
      rx_tx_counseling_completion_month,
      rx_tx_counseling_completion_month_num,
      rx_tx_counseling_completion_year,
      rx_tx_counseling_completion_quarter,
      rx_tx_counseling_completion_quarter_of_year,
      rx_tx_counseling_completion,
      rx_tx_counseling_completion_hour_of_day,
      rx_tx_counseling_completion_time_of_day,
      rx_tx_counseling_completion_hour2,
      rx_tx_counseling_completion_minute15,
      rx_tx_counseling_completion_day_of_week,
      rx_tx_counseling_completion_day_of_month,
      rx_tx_network_plan_bill,
      rx_tx_network_plan_bill_time,
      rx_tx_network_plan_bill_date,
      rx_tx_network_plan_bill_week,
      rx_tx_network_plan_bill_month,
      rx_tx_network_plan_bill_month_num,
      rx_tx_network_plan_bill_year,
      rx_tx_network_plan_bill_quarter,
      rx_tx_network_plan_bill_quarter_of_year,
      rx_tx_network_plan_bill,
      rx_tx_network_plan_bill_hour_of_day,
      rx_tx_network_plan_bill_time_of_day,
      rx_tx_network_plan_bill_hour2,
      rx_tx_network_plan_bill_minute15,
      rx_tx_network_plan_bill_day_of_week,
      rx_tx_network_plan_bill_day_of_month
  ]
}

set: exploredx_eps_rx_tx_analysis_cal_timeframes {
  fields: [
      reportable_sales_date,
      rpt_sales_calendar_date,
      rpt_sales_chain_id,
      rpt_sales_calendar_owner_chain_id,
      rpt_sales_yesno,
      rpt_sales_day_of_week,
      rpt_sales_day_of_month,
      rpt_sales_week_of_year,
      rpt_sales_month_num,
      rpt_sales_month,
      rpt_sales_quarter_of_year,
      rpt_sales_quarter,
      rpt_sales_year,
      rpt_sales_day_of_week_index,
      rpt_sales_week_begin_date,
      rpt_sales_week_end_date,
      rpt_sales_week_of_quarter,
      rpt_sales_month_begin_date,
      rpt_sales_month_end_date,
      rpt_sales_weeks_in_month,
      rpt_sales_quarter_begin_date,
      rpt_sales_quarter_end_date,
      rpt_sales_weeks_in_quarter,
      rpt_sales_year_begin_date,
      rpt_sales_year_end_date,
      rpt_sales_weeks_in_year,
      rpt_sales_leap_year_flag,
      rpt_sales_day_of_quarter,
      rpt_sales_day_of_year,
      sold_date,
      sold_calendar_date,
      sold_chain_id,
      sold_calendar_owner_chain_id,
      sold_yesno,
      sold_day_of_week,
      sold_day_of_month,
      sold_week_of_year,
      sold_month_num,
      sold_month,
      sold_quarter_of_year,
      sold_quarter,
      sold_year,
      sold_day_of_week_index,
      sold_week_begin_date,
      sold_week_end_date,
      sold_week_of_quarter,
      sold_month_begin_date,
      sold_month_end_date,
      sold_weeks_in_month,
      sold_quarter_begin_date,
      sold_quarter_end_date,
      sold_weeks_in_quarter,
      sold_year_begin_date,
      sold_year_end_date,
      sold_weeks_in_year,
      sold_leap_year_flag,
      sold_day_of_quarter,
      sold_day_of_year,
      rx_tx_start_cust_date,
      rx_tx_start_cust_calendar_date,
      rx_tx_start_cust_chain_id,
      rx_tx_start_cust_calendar_owner_chain_id,
      rx_tx_start_cust_yesno,
      rx_tx_start_cust_day_of_week,
      rx_tx_start_cust_day_of_month,
      rx_tx_start_cust_week_of_year,
      rx_tx_start_cust_month_num,
      rx_tx_start_cust_month,
      rx_tx_start_cust_quarter_of_year,
      rx_tx_start_cust_quarter,
      rx_tx_start_cust_year,
      rx_tx_start_cust_day_of_week_index,
      rx_tx_start_cust_week_begin_date,
      rx_tx_start_cust_week_end_date,
      rx_tx_start_cust_week_of_quarter,
      rx_tx_start_cust_month_begin_date,
      rx_tx_start_cust_month_end_date,
      rx_tx_start_cust_weeks_in_month,
      rx_tx_start_cust_quarter_begin_date,
      rx_tx_start_cust_quarter_end_date,
      rx_tx_start_cust_weeks_in_quarter,
      rx_tx_start_cust_year_begin_date,
      rx_tx_start_cust_year_end_date,
      rx_tx_start_cust_weeks_in_year,
      rx_tx_start_cust_leap_year_flag,
      rx_tx_start_cust_day_of_quarter,
      rx_tx_start_cust_day_of_year,
      rx_tx_fill_cust_date,
      rx_tx_fill_cust_calendar_date,
      rx_tx_fill_cust_chain_id,
      rx_tx_fill_cust_calendar_owner_chain_id,
      rx_tx_fill_cust_yesno,
      rx_tx_fill_cust_day_of_week,
      rx_tx_fill_cust_day_of_month,
      rx_tx_fill_cust_week_of_year,
      rx_tx_fill_cust_month_num,
      rx_tx_fill_cust_month,
      rx_tx_fill_cust_quarter_of_year,
      rx_tx_fill_cust_quarter,
      rx_tx_fill_cust_year,
      rx_tx_fill_cust_day_of_week_index,
      rx_tx_fill_cust_week_begin_date,
      rx_tx_fill_cust_week_end_date,
      rx_tx_fill_cust_week_of_quarter,
      rx_tx_fill_cust_month_begin_date,
      rx_tx_fill_cust_month_end_date,
      rx_tx_fill_cust_weeks_in_month,
      rx_tx_fill_cust_quarter_begin_date,
      rx_tx_fill_cust_quarter_end_date,
      rx_tx_fill_cust_weeks_in_quarter,
      rx_tx_fill_cust_year_begin_date,
      rx_tx_fill_cust_year_end_date,
      rx_tx_fill_cust_weeks_in_year,
      rx_tx_fill_cust_leap_year_flag,
      rx_tx_fill_cust_day_of_quarter,
      rx_tx_fill_cust_day_of_year,
      rx_tx_pos_sold_cust_date,
      rx_tx_pos_sold_cust_calendar_date,
      rx_tx_pos_sold_cust_chain_id,
      rx_tx_pos_sold_cust_calendar_owner_chain_id,
      rx_tx_pos_sold_cust_yesno,
      rx_tx_pos_sold_cust_day_of_week,
      rx_tx_pos_sold_cust_day_of_month,
      rx_tx_pos_sold_cust_week_of_year,
      rx_tx_pos_sold_cust_month_num,
      rx_tx_pos_sold_cust_month,
      rx_tx_pos_sold_cust_quarter_of_year,
      rx_tx_pos_sold_cust_quarter,
      rx_tx_pos_sold_cust_year,
      rx_tx_pos_sold_cust_day_of_week_index,
      rx_tx_pos_sold_cust_week_begin_date,
      rx_tx_pos_sold_cust_week_end_date,
      rx_tx_pos_sold_cust_week_of_quarter,
      rx_tx_pos_sold_cust_month_begin_date,
      rx_tx_pos_sold_cust_month_end_date,
      rx_tx_pos_sold_cust_weeks_in_month,
      rx_tx_pos_sold_cust_quarter_begin_date,
      rx_tx_pos_sold_cust_quarter_end_date,
      rx_tx_pos_sold_cust_weeks_in_quarter,
      rx_tx_pos_sold_cust_year_begin_date,
      rx_tx_pos_sold_cust_year_end_date,
      rx_tx_pos_sold_cust_weeks_in_year,
      rx_tx_pos_sold_cust_leap_year_flag,
      rx_tx_pos_sold_cust_day_of_quarter,
      rx_tx_pos_sold_cust_day_of_year,
      rx_tx_returned_cust_date,
      rx_tx_returned_cust_calendar_date,
      rx_tx_returned_cust_chain_id,
      rx_tx_returned_cust_calendar_owner_chain_id,
      rx_tx_returned_cust_yesno,
      rx_tx_returned_cust_day_of_week,
      rx_tx_returned_cust_day_of_month,
      rx_tx_returned_cust_week_of_year,
      rx_tx_returned_cust_month_num,
      rx_tx_returned_cust_month,
      rx_tx_returned_cust_quarter_of_year,
      rx_tx_returned_cust_quarter,
      rx_tx_returned_cust_year,
      rx_tx_returned_cust_day_of_week_index,
      rx_tx_returned_cust_week_begin_date,
      rx_tx_returned_cust_week_end_date,
      rx_tx_returned_cust_week_of_quarter,
      rx_tx_returned_cust_month_begin_date,
      rx_tx_returned_cust_month_end_date,
      rx_tx_returned_cust_weeks_in_month,
      rx_tx_returned_cust_quarter_begin_date,
      rx_tx_returned_cust_quarter_end_date,
      rx_tx_returned_cust_weeks_in_quarter,
      rx_tx_returned_cust_year_begin_date,
      rx_tx_returned_cust_year_end_date,
      rx_tx_returned_cust_weeks_in_year,
      rx_tx_returned_cust_leap_year_flag,
      rx_tx_returned_cust_day_of_quarter,
      rx_tx_returned_cust_day_of_year,
      rx_tx_will_call_arrival_cust_date,
      rx_tx_will_call_arrival_cust_calendar_date,
      rx_tx_will_call_arrival_cust_chain_id,
      rx_tx_will_call_arrival_cust_calendar_owner_chain_id,
      rx_tx_will_call_arrival_cust_yesno,
      rx_tx_will_call_arrival_cust_day_of_week,
      rx_tx_will_call_arrival_cust_day_of_month,
      rx_tx_will_call_arrival_cust_week_of_year,
      rx_tx_will_call_arrival_cust_month_num,
      rx_tx_will_call_arrival_cust_month,
      rx_tx_will_call_arrival_cust_quarter_of_year,
      rx_tx_will_call_arrival_cust_quarter,
      rx_tx_will_call_arrival_cust_year,
      rx_tx_will_call_arrival_cust_day_of_week_index,
      rx_tx_will_call_arrival_cust_week_begin_date,
      rx_tx_will_call_arrival_cust_week_end_date,
      rx_tx_will_call_arrival_cust_week_of_quarter,
      rx_tx_will_call_arrival_cust_month_begin_date,
      rx_tx_will_call_arrival_cust_month_end_date,
      rx_tx_will_call_arrival_cust_weeks_in_month,
      rx_tx_will_call_arrival_cust_quarter_begin_date,
      rx_tx_will_call_arrival_cust_quarter_end_date,
      rx_tx_will_call_arrival_cust_weeks_in_quarter,
      rx_tx_will_call_arrival_cust_year_begin_date,
      rx_tx_will_call_arrival_cust_year_end_date,
      rx_tx_will_call_arrival_cust_weeks_in_year,
      rx_tx_will_call_arrival_cust_leap_year_flag,
      rx_tx_will_call_arrival_cust_day_of_quarter,
      rx_tx_will_call_arrival_cust_day_of_year,
      rx_tx_custom_reported_cust_date,
      rx_tx_custom_reported_cust_calendar_date,
      rx_tx_custom_reported_cust_chain_id,
      rx_tx_custom_reported_cust_calendar_owner_chain_id,
      rx_tx_custom_reported_cust_yesno,
      rx_tx_custom_reported_cust_day_of_week,
      rx_tx_custom_reported_cust_day_of_month,
      rx_tx_custom_reported_cust_week_of_year,
      rx_tx_custom_reported_cust_month_num,
      rx_tx_custom_reported_cust_month,
      rx_tx_custom_reported_cust_quarter_of_year,
      rx_tx_custom_reported_cust_quarter,
      rx_tx_custom_reported_cust_year,
      rx_tx_custom_reported_cust_day_of_week_index,
      rx_tx_custom_reported_cust_week_begin_date,
      rx_tx_custom_reported_cust_week_end_date,
      rx_tx_custom_reported_cust_week_of_quarter,
      rx_tx_custom_reported_cust_month_begin_date,
      rx_tx_custom_reported_cust_month_end_date,
      rx_tx_custom_reported_cust_weeks_in_month,
      rx_tx_custom_reported_cust_quarter_begin_date,
      rx_tx_custom_reported_cust_quarter_end_date,
      rx_tx_custom_reported_cust_weeks_in_quarter,
      rx_tx_custom_reported_cust_year_begin_date,
      rx_tx_custom_reported_cust_year_end_date,
      rx_tx_custom_reported_cust_weeks_in_year,
      rx_tx_custom_reported_cust_leap_year_flag,
      rx_tx_custom_reported_cust_day_of_quarter,
      rx_tx_custom_reported_cust_day_of_year,
      rx_tx_dob_override_cust_date,
      rx_tx_dob_override_cust_calendar_date,
      rx_tx_dob_override_cust_chain_id,
      rx_tx_dob_override_cust_calendar_owner_chain_id,
      rx_tx_dob_override_cust_yesno,
      rx_tx_dob_override_cust_day_of_week,
      rx_tx_dob_override_cust_day_of_month,
      rx_tx_dob_override_cust_week_of_year,
      rx_tx_dob_override_cust_month_num,
      rx_tx_dob_override_cust_month,
      rx_tx_dob_override_cust_quarter_of_year,
      rx_tx_dob_override_cust_quarter,
      rx_tx_dob_override_cust_year,
      rx_tx_dob_override_cust_day_of_week_index,
      rx_tx_dob_override_cust_week_begin_date,
      rx_tx_dob_override_cust_week_end_date,
      rx_tx_dob_override_cust_week_of_quarter,
      rx_tx_dob_override_cust_month_begin_date,
      rx_tx_dob_override_cust_month_end_date,
      rx_tx_dob_override_cust_weeks_in_month,
      rx_tx_dob_override_cust_quarter_begin_date,
      rx_tx_dob_override_cust_quarter_end_date,
      rx_tx_dob_override_cust_weeks_in_quarter,
      rx_tx_dob_override_cust_year_begin_date,
      rx_tx_dob_override_cust_year_end_date,
      rx_tx_dob_override_cust_weeks_in_year,
      rx_tx_dob_override_cust_leap_year_flag,
      rx_tx_dob_override_cust_day_of_quarter,
      rx_tx_dob_override_cust_day_of_year,
      rx_tx_last_epr_synch_cust_date,
      rx_tx_last_epr_synch_cust_calendar_date,
      rx_tx_last_epr_synch_cust_chain_id,
      rx_tx_last_epr_synch_cust_calendar_owner_chain_id,
      rx_tx_last_epr_synch_cust_yesno,
      rx_tx_last_epr_synch_cust_day_of_week,
      rx_tx_last_epr_synch_cust_day_of_month,
      rx_tx_last_epr_synch_cust_week_of_year,
      rx_tx_last_epr_synch_cust_month_num,
      rx_tx_last_epr_synch_cust_month,
      rx_tx_last_epr_synch_cust_quarter_of_year,
      rx_tx_last_epr_synch_cust_quarter,
      rx_tx_last_epr_synch_cust_year,
      rx_tx_last_epr_synch_cust_day_of_week_index,
      rx_tx_last_epr_synch_cust_week_begin_date,
      rx_tx_last_epr_synch_cust_week_end_date,
      rx_tx_last_epr_synch_cust_week_of_quarter,
      rx_tx_last_epr_synch_cust_month_begin_date,
      rx_tx_last_epr_synch_cust_month_end_date,
      rx_tx_last_epr_synch_cust_weeks_in_month,
      rx_tx_last_epr_synch_cust_quarter_begin_date,
      rx_tx_last_epr_synch_cust_quarter_end_date,
      rx_tx_last_epr_synch_cust_weeks_in_quarter,
      rx_tx_last_epr_synch_cust_year_begin_date,
      rx_tx_last_epr_synch_cust_year_end_date,
      rx_tx_last_epr_synch_cust_weeks_in_year,
      rx_tx_last_epr_synch_cust_leap_year_flag,
      rx_tx_last_epr_synch_cust_day_of_quarter,
      rx_tx_last_epr_synch_cust_day_of_year,
      rx_tx_missing_cust_date,
      rx_tx_missing_cust_calendar_date,
      rx_tx_missing_cust_chain_id,
      rx_tx_missing_cust_calendar_owner_chain_id,
      rx_tx_missing_cust_yesno,
      rx_tx_missing_cust_day_of_week,
      rx_tx_missing_cust_day_of_month,
      rx_tx_missing_cust_week_of_year,
      rx_tx_missing_cust_month_num,
      rx_tx_missing_cust_month,
      rx_tx_missing_cust_quarter_of_year,
      rx_tx_missing_cust_quarter,
      rx_tx_missing_cust_year,
      rx_tx_missing_cust_day_of_week_index,
      rx_tx_missing_cust_week_begin_date,
      rx_tx_missing_cust_week_end_date,
      rx_tx_missing_cust_week_of_quarter,
      rx_tx_missing_cust_month_begin_date,
      rx_tx_missing_cust_month_end_date,
      rx_tx_missing_cust_weeks_in_month,
      rx_tx_missing_cust_quarter_begin_date,
      rx_tx_missing_cust_quarter_end_date,
      rx_tx_missing_cust_weeks_in_quarter,
      rx_tx_missing_cust_year_begin_date,
      rx_tx_missing_cust_year_end_date,
      rx_tx_missing_cust_weeks_in_year,
      rx_tx_missing_cust_leap_year_flag,
      rx_tx_missing_cust_day_of_quarter,
      rx_tx_missing_cust_day_of_year,
      rx_tx_pc_ready_cust_date,
      rx_tx_pc_ready_cust_calendar_date,
      rx_tx_pc_ready_cust_chain_id,
      rx_tx_pc_ready_cust_calendar_owner_chain_id,
      rx_tx_pc_ready_cust_yesno,
      rx_tx_pc_ready_cust_day_of_week,
      rx_tx_pc_ready_cust_day_of_month,
      rx_tx_pc_ready_cust_week_of_year,
      rx_tx_pc_ready_cust_month_num,
      rx_tx_pc_ready_cust_month,
      rx_tx_pc_ready_cust_quarter_of_year,
      rx_tx_pc_ready_cust_quarter,
      rx_tx_pc_ready_cust_year,
      rx_tx_pc_ready_cust_day_of_week_index,
      rx_tx_pc_ready_cust_week_begin_date,
      rx_tx_pc_ready_cust_week_end_date,
      rx_tx_pc_ready_cust_week_of_quarter,
      rx_tx_pc_ready_cust_month_begin_date,
      rx_tx_pc_ready_cust_month_end_date,
      rx_tx_pc_ready_cust_weeks_in_month,
      rx_tx_pc_ready_cust_quarter_begin_date,
      rx_tx_pc_ready_cust_quarter_end_date,
      rx_tx_pc_ready_cust_weeks_in_quarter,
      rx_tx_pc_ready_cust_year_begin_date,
      rx_tx_pc_ready_cust_year_end_date,
      rx_tx_pc_ready_cust_weeks_in_year,
      rx_tx_pc_ready_cust_leap_year_flag,
      rx_tx_pc_ready_cust_day_of_quarter,
      rx_tx_pc_ready_cust_day_of_year,
      rx_tx_replace_cust_date,
      rx_tx_replace_cust_calendar_date,
      rx_tx_replace_cust_chain_id,
      rx_tx_replace_cust_calendar_owner_chain_id,
      rx_tx_replace_cust_yesno,
      rx_tx_replace_cust_day_of_week,
      rx_tx_replace_cust_day_of_month,
      rx_tx_replace_cust_week_of_year,
      rx_tx_replace_cust_month_num,
      rx_tx_replace_cust_month,
      rx_tx_replace_cust_quarter_of_year,
      rx_tx_replace_cust_quarter,
      rx_tx_replace_cust_year,
      rx_tx_replace_cust_day_of_week_index,
      rx_tx_replace_cust_week_begin_date,
      rx_tx_replace_cust_week_end_date,
      rx_tx_replace_cust_week_of_quarter,
      rx_tx_replace_cust_month_begin_date,
      rx_tx_replace_cust_month_end_date,
      rx_tx_replace_cust_weeks_in_month,
      rx_tx_replace_cust_quarter_begin_date,
      rx_tx_replace_cust_quarter_end_date,
      rx_tx_replace_cust_weeks_in_quarter,
      rx_tx_replace_cust_year_begin_date,
      rx_tx_replace_cust_year_end_date,
      rx_tx_replace_cust_weeks_in_year,
      rx_tx_replace_cust_leap_year_flag,
      rx_tx_replace_cust_day_of_quarter,
      rx_tx_replace_cust_day_of_year,
      rx_tx_return_to_stock_cust_date,
      rx_tx_return_to_stock_cust_calendar_date,
      rx_tx_return_to_stock_cust_chain_id,
      rx_tx_return_to_stock_cust_calendar_owner_chain_id,
      rx_tx_return_to_stock_cust_yesno,
      rx_tx_return_to_stock_cust_day_of_week,
      rx_tx_return_to_stock_cust_day_of_month,
      rx_tx_return_to_stock_cust_week_of_year,
      rx_tx_return_to_stock_cust_month_num,
      rx_tx_return_to_stock_cust_month,
      rx_tx_return_to_stock_cust_quarter_of_year,
      rx_tx_return_to_stock_cust_quarter,
      rx_tx_return_to_stock_cust_year,
      rx_tx_return_to_stock_cust_day_of_week_index,
      rx_tx_return_to_stock_cust_week_begin_date,
      rx_tx_return_to_stock_cust_week_end_date,
      rx_tx_return_to_stock_cust_week_of_quarter,
      rx_tx_return_to_stock_cust_month_begin_date,
      rx_tx_return_to_stock_cust_month_end_date,
      rx_tx_return_to_stock_cust_weeks_in_month,
      rx_tx_return_to_stock_cust_quarter_begin_date,
      rx_tx_return_to_stock_cust_quarter_end_date,
      rx_tx_return_to_stock_cust_weeks_in_quarter,
      rx_tx_return_to_stock_cust_year_begin_date,
      rx_tx_return_to_stock_cust_year_end_date,
      rx_tx_return_to_stock_cust_weeks_in_year,
      rx_tx_return_to_stock_cust_leap_year_flag,
      rx_tx_return_to_stock_cust_day_of_quarter,
      rx_tx_return_to_stock_cust_day_of_year,
      rx_tx_counseling_completion_cust_date,
      rx_tx_counseling_completion_cust_calendar_date,
      rx_tx_counseling_completion_cust_chain_id,
      rx_tx_counseling_completion_cust_calendar_owner_chain_id,
      rx_tx_counseling_completion_cust_yesno,
      rx_tx_counseling_completion_cust_day_of_week,
      rx_tx_counseling_completion_cust_day_of_month,
      rx_tx_counseling_completion_cust_week_of_year,
      rx_tx_counseling_completion_cust_month_num,
      rx_tx_counseling_completion_cust_month,
      rx_tx_counseling_completion_cust_quarter_of_year,
      rx_tx_counseling_completion_cust_quarter,
      rx_tx_counseling_completion_cust_year,
      rx_tx_counseling_completion_cust_day_of_week_index,
      rx_tx_counseling_completion_cust_week_begin_date,
      rx_tx_counseling_completion_cust_week_end_date,
      rx_tx_counseling_completion_cust_week_of_quarter,
      rx_tx_counseling_completion_cust_month_begin_date,
      rx_tx_counseling_completion_cust_month_end_date,
      rx_tx_counseling_completion_cust_weeks_in_month,
      rx_tx_counseling_completion_cust_quarter_begin_date,
      rx_tx_counseling_completion_cust_quarter_end_date,
      rx_tx_counseling_completion_cust_weeks_in_quarter,
      rx_tx_counseling_completion_cust_year_begin_date,
      rx_tx_counseling_completion_cust_year_end_date,
      rx_tx_counseling_completion_cust_weeks_in_year,
      rx_tx_counseling_completion_cust_leap_year_flag,
      rx_tx_counseling_completion_cust_day_of_quarter,
      rx_tx_counseling_completion_cust_day_of_year,
      rx_tx_network_plan_bill_cust_date,
      rx_tx_network_plan_bill_cust_calendar_date,
      rx_tx_network_plan_bill_cust_chain_id,
      rx_tx_network_plan_bill_cust_calendar_owner_chain_id,
      rx_tx_network_plan_bill_cust_yesno,
      rx_tx_network_plan_bill_cust_day_of_week,
      rx_tx_network_plan_bill_cust_day_of_month,
      rx_tx_network_plan_bill_cust_week_of_year,
      rx_tx_network_plan_bill_cust_month_num,
      rx_tx_network_plan_bill_cust_month,
      rx_tx_network_plan_bill_cust_quarter_of_year,
      rx_tx_network_plan_bill_cust_quarter,
      rx_tx_network_plan_bill_cust_year,
      rx_tx_network_plan_bill_cust_day_of_week_index,
      rx_tx_network_plan_bill_cust_week_begin_date,
      rx_tx_network_plan_bill_cust_week_end_date,
      rx_tx_network_plan_bill_cust_week_of_quarter,
      rx_tx_network_plan_bill_cust_month_begin_date,
      rx_tx_network_plan_bill_cust_month_end_date,
      rx_tx_network_plan_bill_cust_weeks_in_month,
      rx_tx_network_plan_bill_cust_quarter_begin_date,
      rx_tx_network_plan_bill_cust_quarter_end_date,
      rx_tx_network_plan_bill_cust_weeks_in_quarter,
      rx_tx_network_plan_bill_cust_year_begin_date,
      rx_tx_network_plan_bill_cust_year_end_date,
      rx_tx_network_plan_bill_cust_weeks_in_year,
      rx_tx_network_plan_bill_cust_leap_year_flag,
      rx_tx_network_plan_bill_cust_day_of_quarter,
      rx_tx_network_plan_bill_cust_day_of_year,
      rx_tx_central_fill_cutoff_cust_date,
      rx_tx_central_fill_cutoff_cust_calendar_date,
      rx_tx_central_fill_cutoff_cust_chain_id,
      rx_tx_central_fill_cutoff_cust_calendar_owner_chain_id,
      rx_tx_central_fill_cutoff_cust_yesno,
      rx_tx_central_fill_cutoff_cust_day_of_week,
      rx_tx_central_fill_cutoff_cust_day_of_month,
      rx_tx_central_fill_cutoff_cust_week_of_year,
      rx_tx_central_fill_cutoff_cust_month_num,
      rx_tx_central_fill_cutoff_cust_month,
      rx_tx_central_fill_cutoff_cust_quarter_of_year,
      rx_tx_central_fill_cutoff_cust_quarter,
      rx_tx_central_fill_cutoff_cust_year,
      rx_tx_central_fill_cutoff_cust_day_of_week_index,
      rx_tx_central_fill_cutoff_cust_week_begin_date,
      rx_tx_central_fill_cutoff_cust_week_end_date,
      rx_tx_central_fill_cutoff_cust_week_of_quarter,
      rx_tx_central_fill_cutoff_cust_month_begin_date,
      rx_tx_central_fill_cutoff_cust_month_end_date,
      rx_tx_central_fill_cutoff_cust_weeks_in_month,
      rx_tx_central_fill_cutoff_cust_quarter_begin_date,
      rx_tx_central_fill_cutoff_cust_quarter_end_date,
      rx_tx_central_fill_cutoff_cust_weeks_in_quarter,
      rx_tx_central_fill_cutoff_cust_year_begin_date,
      rx_tx_central_fill_cutoff_cust_year_end_date,
      rx_tx_central_fill_cutoff_cust_weeks_in_year,
      rx_tx_central_fill_cutoff_cust_leap_year_flag,
      rx_tx_central_fill_cutoff_cust_day_of_quarter,
      rx_tx_central_fill_cutoff_cust_day_of_year,
      rx_tx_drug_expiration_cust_date,
      rx_tx_drug_expiration_cust_calendar_date,
      rx_tx_drug_expiration_cust_chain_id,
      rx_tx_drug_expiration_cust_calendar_owner_chain_id,
      rx_tx_drug_expiration_cust_yesno,
      rx_tx_drug_expiration_cust_day_of_week,
      rx_tx_drug_expiration_cust_day_of_month,
      rx_tx_drug_expiration_cust_week_of_year,
      rx_tx_drug_expiration_cust_month_num,
      rx_tx_drug_expiration_cust_month,
      rx_tx_drug_expiration_cust_quarter_of_year,
      rx_tx_drug_expiration_cust_quarter,
      rx_tx_drug_expiration_cust_year,
      rx_tx_drug_expiration_cust_day_of_week_index,
      rx_tx_drug_expiration_cust_week_begin_date,
      rx_tx_drug_expiration_cust_week_end_date,
      rx_tx_drug_expiration_cust_week_of_quarter,
      rx_tx_drug_expiration_cust_month_begin_date,
      rx_tx_drug_expiration_cust_month_end_date,
      rx_tx_drug_expiration_cust_weeks_in_month,
      rx_tx_drug_expiration_cust_quarter_begin_date,
      rx_tx_drug_expiration_cust_quarter_end_date,
      rx_tx_drug_expiration_cust_weeks_in_quarter,
      rx_tx_drug_expiration_cust_year_begin_date,
      rx_tx_drug_expiration_cust_year_end_date,
      rx_tx_drug_expiration_cust_weeks_in_year,
      rx_tx_drug_expiration_cust_leap_year_flag,
      rx_tx_drug_expiration_cust_day_of_quarter,
      rx_tx_drug_expiration_cust_day_of_year,
      rx_tx_drug_image_start_cust_date,
      rx_tx_drug_image_start_cust_calendar_date,
      rx_tx_drug_image_start_cust_chain_id,
      rx_tx_drug_image_start_cust_calendar_owner_chain_id,
      rx_tx_drug_image_start_cust_yesno,
      rx_tx_drug_image_start_cust_day_of_week,
      rx_tx_drug_image_start_cust_day_of_month,
      rx_tx_drug_image_start_cust_week_of_year,
      rx_tx_drug_image_start_cust_month_num,
      rx_tx_drug_image_start_cust_month,
      rx_tx_drug_image_start_cust_quarter_of_year,
      rx_tx_drug_image_start_cust_quarter,
      rx_tx_drug_image_start_cust_year,
      rx_tx_drug_image_start_cust_day_of_week_index,
      rx_tx_drug_image_start_cust_week_begin_date,
      rx_tx_drug_image_start_cust_week_end_date,
      rx_tx_drug_image_start_cust_week_of_quarter,
      rx_tx_drug_image_start_cust_month_begin_date,
      rx_tx_drug_image_start_cust_month_end_date,
      rx_tx_drug_image_start_cust_weeks_in_month,
      rx_tx_drug_image_start_cust_quarter_begin_date,
      rx_tx_drug_image_start_cust_quarter_end_date,
      rx_tx_drug_image_start_cust_weeks_in_quarter,
      rx_tx_drug_image_start_cust_year_begin_date,
      rx_tx_drug_image_start_cust_year_end_date,
      rx_tx_drug_image_start_cust_weeks_in_year,
      rx_tx_drug_image_start_cust_leap_year_flag,
      rx_tx_drug_image_start_cust_day_of_quarter,
      rx_tx_drug_image_start_cust_day_of_year,
      rx_tx_follow_up_cust_date,
      rx_tx_follow_up_cust_calendar_date,
      rx_tx_follow_up_cust_chain_id,
      rx_tx_follow_up_cust_calendar_owner_chain_id,
      rx_tx_follow_up_cust_yesno,
      rx_tx_follow_up_cust_day_of_week,
      rx_tx_follow_up_cust_day_of_month,
      rx_tx_follow_up_cust_week_of_year,
      rx_tx_follow_up_cust_month_num,
      rx_tx_follow_up_cust_month,
      rx_tx_follow_up_cust_quarter_of_year,
      rx_tx_follow_up_cust_quarter,
      rx_tx_follow_up_cust_year,
      rx_tx_follow_up_cust_day_of_week_index,
      rx_tx_follow_up_cust_week_begin_date,
      rx_tx_follow_up_cust_week_end_date,
      rx_tx_follow_up_cust_week_of_quarter,
      rx_tx_follow_up_cust_month_begin_date,
      rx_tx_follow_up_cust_month_end_date,
      rx_tx_follow_up_cust_weeks_in_month,
      rx_tx_follow_up_cust_quarter_begin_date,
      rx_tx_follow_up_cust_quarter_end_date,
      rx_tx_follow_up_cust_weeks_in_quarter,
      rx_tx_follow_up_cust_year_begin_date,
      rx_tx_follow_up_cust_year_end_date,
      rx_tx_follow_up_cust_weeks_in_year,
      rx_tx_follow_up_cust_leap_year_flag,
      rx_tx_follow_up_cust_day_of_quarter,
      rx_tx_follow_up_cust_day_of_year,
      rx_tx_host_retrieval_cust_date,
      rx_tx_host_retrieval_cust_calendar_date,
      rx_tx_host_retrieval_cust_chain_id,
      rx_tx_host_retrieval_cust_calendar_owner_chain_id,
      rx_tx_host_retrieval_cust_yesno,
      rx_tx_host_retrieval_cust_day_of_week,
      rx_tx_host_retrieval_cust_day_of_month,
      rx_tx_host_retrieval_cust_week_of_year,
      rx_tx_host_retrieval_cust_month_num,
      rx_tx_host_retrieval_cust_month,
      rx_tx_host_retrieval_cust_quarter_of_year,
      rx_tx_host_retrieval_cust_quarter,
      rx_tx_host_retrieval_cust_year,
      rx_tx_host_retrieval_cust_day_of_week_index,
      rx_tx_host_retrieval_cust_week_begin_date,
      rx_tx_host_retrieval_cust_week_end_date,
      rx_tx_host_retrieval_cust_week_of_quarter,
      rx_tx_host_retrieval_cust_month_begin_date,
      rx_tx_host_retrieval_cust_month_end_date,
      rx_tx_host_retrieval_cust_weeks_in_month,
      rx_tx_host_retrieval_cust_quarter_begin_date,
      rx_tx_host_retrieval_cust_quarter_end_date,
      rx_tx_host_retrieval_cust_weeks_in_quarter,
      rx_tx_host_retrieval_cust_year_begin_date,
      rx_tx_host_retrieval_cust_year_end_date,
      rx_tx_host_retrieval_cust_weeks_in_year,
      rx_tx_host_retrieval_cust_leap_year_flag,
      rx_tx_host_retrieval_cust_day_of_quarter,
      rx_tx_host_retrieval_cust_day_of_year,
      rx_tx_photo_id_birth_cust_date,
      rx_tx_photo_id_birth_cust_calendar_date,
      rx_tx_photo_id_birth_cust_chain_id,
      rx_tx_photo_id_birth_cust_calendar_owner_chain_id,
      rx_tx_photo_id_birth_cust_yesno,
      rx_tx_photo_id_birth_cust_day_of_week,
      rx_tx_photo_id_birth_cust_day_of_month,
      rx_tx_photo_id_birth_cust_week_of_year,
      rx_tx_photo_id_birth_cust_month_num,
      rx_tx_photo_id_birth_cust_month,
      rx_tx_photo_id_birth_cust_quarter_of_year,
      rx_tx_photo_id_birth_cust_quarter,
      rx_tx_photo_id_birth_cust_year,
      rx_tx_photo_id_birth_cust_day_of_week_index,
      rx_tx_photo_id_birth_cust_week_begin_date,
      rx_tx_photo_id_birth_cust_week_end_date,
      rx_tx_photo_id_birth_cust_week_of_quarter,
      rx_tx_photo_id_birth_cust_month_begin_date,
      rx_tx_photo_id_birth_cust_month_end_date,
      rx_tx_photo_id_birth_cust_weeks_in_month,
      rx_tx_photo_id_birth_cust_quarter_begin_date,
      rx_tx_photo_id_birth_cust_quarter_end_date,
      rx_tx_photo_id_birth_cust_weeks_in_quarter,
      rx_tx_photo_id_birth_cust_year_begin_date,
      rx_tx_photo_id_birth_cust_year_end_date,
      rx_tx_photo_id_birth_cust_weeks_in_year,
      rx_tx_photo_id_birth_cust_leap_year_flag,
      rx_tx_photo_id_birth_cust_day_of_quarter,
      rx_tx_photo_id_birth_cust_day_of_year,
      rx_tx_photo_id_expire_cust_date,
      rx_tx_photo_id_expire_cust_calendar_date,
      rx_tx_photo_id_expire_cust_chain_id,
      rx_tx_photo_id_expire_cust_calendar_owner_chain_id,
      rx_tx_photo_id_expire_cust_yesno,
      rx_tx_photo_id_expire_cust_day_of_week,
      rx_tx_photo_id_expire_cust_day_of_month,
      rx_tx_photo_id_expire_cust_week_of_year,
      rx_tx_photo_id_expire_cust_month_num,
      rx_tx_photo_id_expire_cust_month,
      rx_tx_photo_id_expire_cust_quarter_of_year,
      rx_tx_photo_id_expire_cust_quarter,
      rx_tx_photo_id_expire_cust_year,
      rx_tx_photo_id_expire_cust_day_of_week_index,
      rx_tx_photo_id_expire_cust_week_begin_date,
      rx_tx_photo_id_expire_cust_week_end_date,
      rx_tx_photo_id_expire_cust_week_of_quarter,
      rx_tx_photo_id_expire_cust_month_begin_date,
      rx_tx_photo_id_expire_cust_month_end_date,
      rx_tx_photo_id_expire_cust_weeks_in_month,
      rx_tx_photo_id_expire_cust_quarter_begin_date,
      rx_tx_photo_id_expire_cust_quarter_end_date,
      rx_tx_photo_id_expire_cust_weeks_in_quarter,
      rx_tx_photo_id_expire_cust_year_begin_date,
      rx_tx_photo_id_expire_cust_year_end_date,
      rx_tx_photo_id_expire_cust_weeks_in_year,
      rx_tx_photo_id_expire_cust_leap_year_flag,
      rx_tx_photo_id_expire_cust_day_of_quarter,
      rx_tx_photo_id_expire_cust_day_of_year,
      rx_tx_stop_cust_date,
      rx_tx_stop_cust_calendar_date,
      rx_tx_stop_cust_chain_id,
      rx_tx_stop_cust_calendar_owner_chain_id,
      rx_tx_stop_cust_yesno,
      rx_tx_stop_cust_day_of_week,
      rx_tx_stop_cust_day_of_month,
      rx_tx_stop_cust_week_of_year,
      rx_tx_stop_cust_month_num,
      rx_tx_stop_cust_month,
      rx_tx_stop_cust_quarter_of_year,
      rx_tx_stop_cust_quarter,
      rx_tx_stop_cust_year,
      rx_tx_stop_cust_day_of_week_index,
      rx_tx_stop_cust_week_begin_date,
      rx_tx_stop_cust_week_end_date,
      rx_tx_stop_cust_week_of_quarter,
      rx_tx_stop_cust_month_begin_date,
      rx_tx_stop_cust_month_end_date,
      rx_tx_stop_cust_weeks_in_month,
      rx_tx_stop_cust_quarter_begin_date,
      rx_tx_stop_cust_quarter_end_date,
      rx_tx_stop_cust_weeks_in_quarter,
      rx_tx_stop_cust_year_begin_date,
      rx_tx_stop_cust_year_end_date,
      rx_tx_stop_cust_weeks_in_year,
      rx_tx_stop_cust_leap_year_flag,
      rx_tx_stop_cust_day_of_quarter,
      rx_tx_stop_cust_day_of_year,
      rx_tx_written_cust_date,
      rx_tx_written_cust_calendar_date,
      rx_tx_written_cust_chain_id,
      rx_tx_written_cust_calendar_owner_chain_id,
      rx_tx_written_cust_yesno,
      rx_tx_written_cust_day_of_week,
      rx_tx_written_cust_day_of_month,
      rx_tx_written_cust_week_of_year,
      rx_tx_written_cust_month_num,
      rx_tx_written_cust_month,
      rx_tx_written_cust_quarter_of_year,
      rx_tx_written_cust_quarter,
      rx_tx_written_cust_year,
      rx_tx_written_cust_day_of_week_index,
      rx_tx_written_cust_week_begin_date,
      rx_tx_written_cust_week_end_date,
      rx_tx_written_cust_week_of_quarter,
      rx_tx_written_cust_month_begin_date,
      rx_tx_written_cust_month_end_date,
      rx_tx_written_cust_weeks_in_month,
      rx_tx_written_cust_quarter_begin_date,
      rx_tx_written_cust_quarter_end_date,
      rx_tx_written_cust_weeks_in_quarter,
      rx_tx_written_cust_year_begin_date,
      rx_tx_written_cust_year_end_date,
      rx_tx_written_cust_weeks_in_year,
      rx_tx_written_cust_leap_year_flag,
      rx_tx_written_cust_day_of_quarter,
      rx_tx_written_cust_day_of_year,
      rx_tx_source_create_cust_date,
      rx_tx_source_create_cust_calendar_date,
      rx_tx_source_create_cust_chain_id,
      rx_tx_source_create_cust_calendar_owner_chain_id,
      rx_tx_source_create_cust_yesno,
      rx_tx_source_create_cust_day_of_week,
      rx_tx_source_create_cust_day_of_month,
      rx_tx_source_create_cust_week_of_year,
      rx_tx_source_create_cust_month_num,
      rx_tx_source_create_cust_month,
      rx_tx_source_create_cust_quarter_of_year,
      rx_tx_source_create_cust_quarter,
      rx_tx_source_create_cust_year,
      rx_tx_source_create_cust_day_of_week_index,
      rx_tx_source_create_cust_week_begin_date,
      rx_tx_source_create_cust_week_end_date,
      rx_tx_source_create_cust_week_of_quarter,
      rx_tx_source_create_cust_month_begin_date,
      rx_tx_source_create_cust_month_end_date,
      rx_tx_source_create_cust_weeks_in_month,
      rx_tx_source_create_cust_quarter_begin_date,
      rx_tx_source_create_cust_quarter_end_date,
      rx_tx_source_create_cust_weeks_in_quarter,
      rx_tx_source_create_cust_year_begin_date,
      rx_tx_source_create_cust_year_end_date,
      rx_tx_source_create_cust_weeks_in_year,
      rx_tx_source_create_cust_leap_year_flag,
      rx_tx_source_create_cust_day_of_quarter,
      rx_tx_source_create_cust_day_of_year
    ]
  }

  set: exploredx_eps_rx_tx_looker_default_timeframes {
    fields: [
      start_time,
      start_date,
      start_week,
      start_month,
      start_month_num,
      start_year,
      start_quarter,
      start_quarter_of_year,
      start,
      start_hour_of_day,
      start_time_of_day,
      start_hour2,
      start_minute15,
      start_day_of_week,
      start_week_of_year,
      start_day_of_week_index,
      start_day_of_month,
      rx_tx_will_call_picked_up_time,
      rx_tx_will_call_picked_up_date,
      rx_tx_will_call_picked_up_week,
      rx_tx_will_call_picked_up_month,
      rx_tx_will_call_picked_up_month_num,
      rx_tx_will_call_picked_up_year,
      rx_tx_will_call_picked_up_quarter,
      rx_tx_will_call_picked_up_quarter_of_year,
      rx_tx_will_call_picked_up,
      rx_tx_will_call_picked_up_hour_of_day,
      rx_tx_will_call_picked_up_time_of_day,
      rx_tx_will_call_picked_up_hour2,
      rx_tx_will_call_picked_up_minute15,
      rx_tx_will_call_picked_up_day_of_week,
      rx_tx_will_call_picked_up_week_of_year,
      rx_tx_will_call_picked_up_day_of_week_index,
      rx_tx_will_call_picked_up_day_of_month,
      rx_tx_reportable_sales_time,
      rx_tx_reportable_sales_date,
      rx_tx_reportable_sales_week,
      rx_tx_reportable_sales_month,
      rx_tx_reportable_sales_month_num,
      rx_tx_reportable_sales_year,
      rx_tx_reportable_sales_quarter,
      rx_tx_reportable_sales_quarter_of_year,
      rx_tx_reportable_sales,
      rx_tx_reportable_sales_hour_of_day,
      rx_tx_reportable_sales_time_of_day,
      rx_tx_reportable_sales_hour2,
      rx_tx_reportable_sales_minute15,
      rx_tx_reportable_sales_day_of_week,
      rx_tx_reportable_sales_week_of_year,
      rx_tx_reportable_sales_day_of_week_index,
      rx_tx_reportable_sales_day_of_month,
      rx_tx_fill_time,
      rx_tx_fill_date,
      rx_tx_fill_week,
      rx_tx_fill_month,
      rx_tx_fill_month_num,
      rx_tx_fill_year,
      rx_tx_fill_quarter,
      rx_tx_fill_quarter_of_year,
      rx_tx_fill,
      rx_tx_fill_hour_of_day,
      rx_tx_fill_time_of_day,
      rx_tx_fill_hour2,
      rx_tx_fill_minute15,
      rx_tx_fill_day_of_week,
      rx_tx_fill_week_of_year,
      rx_tx_fill_day_of_week_index,
      rx_tx_fill_day_of_month,
      rx_tx_pos_sold_time,
      rx_tx_pos_sold_date,
      rx_tx_pos_sold_week,
      rx_tx_pos_sold_month,
      rx_tx_pos_sold_month_num,
      rx_tx_pos_sold_year,
      rx_tx_pos_sold_quarter,
      rx_tx_pos_sold_quarter_of_year,
      rx_tx_pos_sold,
      rx_tx_pos_sold_hour_of_day,
      rx_tx_pos_sold_time_of_day,
      rx_tx_pos_sold_hour2,
      rx_tx_pos_sold_minute15,
      rx_tx_pos_sold_day_of_week,
      rx_tx_pos_sold_week_of_year,
      rx_tx_pos_sold_day_of_week_index,
      rx_tx_pos_sold_day_of_month,
      rx_tx_returned_time,
      rx_tx_returned_date,
      rx_tx_returned_week,
      rx_tx_returned_month,
      rx_tx_returned_month_num,
      rx_tx_returned_year,
      rx_tx_returned_quarter,
      rx_tx_returned_quarter_of_year,
      rx_tx_returned,
      rx_tx_returned_hour_of_day,
      rx_tx_returned_time_of_day,
      rx_tx_returned_hour2,
      rx_tx_returned_minute15,
      rx_tx_returned_day_of_week,
      rx_tx_returned_week_of_year,
      rx_tx_returned_day_of_week_index,
      rx_tx_returned_day_of_month,
      will_call_arrival_time,
      will_call_arrival_date,
      will_call_arrival_week,
      will_call_arrival_month,
      will_call_arrival_month_num,
      will_call_arrival_year,
      will_call_arrival_quarter,
      will_call_arrival_quarter_of_year,
      will_call_arrival,
      will_call_arrival_hour_of_day,
      will_call_arrival_time_of_day,
      will_call_arrival_hour2,
      will_call_arrival_minute15,
      will_call_arrival_day_of_week,
      will_call_arrival_week_of_year,
      will_call_arrival_day_of_week_index,
      will_call_arrival_day_of_month,
      rx_tx_custom_reported_date_time,
      rx_tx_custom_reported_date_date,
      rx_tx_custom_reported_date_week,
      rx_tx_custom_reported_date_month,
      rx_tx_custom_reported_date_month_num,
      rx_tx_custom_reported_date_year,
      rx_tx_custom_reported_date_quarter,
      rx_tx_custom_reported_date_quarter_of_year,
      rx_tx_custom_reported_date,
      rx_tx_custom_reported_date_hour_of_day,
      rx_tx_custom_reported_date_time_of_day,
      rx_tx_custom_reported_date_hour2,
      rx_tx_custom_reported_date_minute15,
      rx_tx_custom_reported_date_day_of_week,
      rx_tx_custom_reported_date_week_of_year,
      rx_tx_custom_reported_date_day_of_week_index,
      rx_tx_custom_reported_date_day_of_month,
      rx_tx_dob_override_time_time,
      rx_tx_dob_override_time_date,
      rx_tx_dob_override_time_week,
      rx_tx_dob_override_time_month,
      rx_tx_dob_override_time_month_num,
      rx_tx_dob_override_time_year,
      rx_tx_dob_override_time_quarter,
      rx_tx_dob_override_time_quarter_of_year,
      rx_tx_dob_override_time,
      rx_tx_dob_override_time_hour_of_day,
      rx_tx_dob_override_time_time_of_day,
      rx_tx_dob_override_time_hour2,
      rx_tx_dob_override_time_minute15,
      rx_tx_dob_override_time_day_of_week,
      rx_tx_dob_override_time_week_of_year,
      rx_tx_dob_override_time_day_of_week_index,
      rx_tx_dob_override_time_day_of_month,
      rx_tx_last_epr_synch_time,
      rx_tx_last_epr_synch_date,
      rx_tx_last_epr_synch_week,
      rx_tx_last_epr_synch_month,
      rx_tx_last_epr_synch_month_num,
      rx_tx_last_epr_synch_year,
      rx_tx_last_epr_synch_quarter,
      rx_tx_last_epr_synch_quarter_of_year,
      rx_tx_last_epr_synch,
      rx_tx_last_epr_synch_hour_of_day,
      rx_tx_last_epr_synch_time_of_day,
      rx_tx_last_epr_synch_hour2,
      rx_tx_last_epr_synch_minute15,
      rx_tx_last_epr_synch_day_of_week,
      rx_tx_last_epr_synch_week_of_year,
      rx_tx_last_epr_synch_day_of_week_index,
      rx_tx_last_epr_synch_day_of_month,
      rx_tx_missing_date_time,
      rx_tx_missing_date_date,
      rx_tx_missing_date_week,
      rx_tx_missing_date_month,
      rx_tx_missing_date_month_num,
      rx_tx_missing_date_year,
      rx_tx_missing_date_quarter,
      rx_tx_missing_date_quarter_of_year,
      rx_tx_missing_date,
      rx_tx_missing_date_hour_of_day,
      rx_tx_missing_date_time_of_day,
      rx_tx_missing_date_hour2,
      rx_tx_missing_date_minute15,
      rx_tx_missing_date_day_of_week,
      rx_tx_missing_date_week_of_year,
      rx_tx_missing_date_day_of_week_index,
      rx_tx_missing_date_day_of_month,
      rx_tx_pc_ready_date_time,
      rx_tx_pc_ready_date_date,
      rx_tx_pc_ready_date_week,
      rx_tx_pc_ready_date_month,
      rx_tx_pc_ready_date_month_num,
      rx_tx_pc_ready_date_year,
      rx_tx_pc_ready_date_quarter,
      rx_tx_pc_ready_date_quarter_of_year,
      rx_tx_pc_ready_date,
      rx_tx_pc_ready_date_hour_of_day,
      rx_tx_pc_ready_date_time_of_day,
      rx_tx_pc_ready_date_hour2,
      rx_tx_pc_ready_date_minute15,
      rx_tx_pc_ready_date_day_of_week,
      rx_tx_pc_ready_date_week_of_year,
      rx_tx_pc_ready_date_day_of_week_index,
      rx_tx_pc_ready_date_day_of_month,
      rx_tx_replace_date_time,
      rx_tx_replace_date_date,
      rx_tx_replace_date_week,
      rx_tx_replace_date_month,
      rx_tx_replace_date_month_num,
      rx_tx_replace_date_year,
      rx_tx_replace_date_quarter,
      rx_tx_replace_date_quarter_of_year,
      rx_tx_replace_date,
      rx_tx_replace_date_hour_of_day,
      rx_tx_replace_date_time_of_day,
      rx_tx_replace_date_hour2,
      rx_tx_replace_date_minute15,
      rx_tx_replace_date_day_of_week,
      rx_tx_replace_date_week_of_year,
      rx_tx_replace_date_day_of_week_index,
      rx_tx_replace_date_day_of_month,
      rx_tx_return_to_stock_date_time,
      rx_tx_return_to_stock_date_date,
      rx_tx_return_to_stock_date_week,
      rx_tx_return_to_stock_date_month,
      rx_tx_return_to_stock_date_month_num,
      rx_tx_return_to_stock_date_year,
      rx_tx_return_to_stock_date_quarter,
      rx_tx_return_to_stock_date_quarter_of_year,
      rx_tx_return_to_stock_date,
      rx_tx_return_to_stock_date_hour_of_day,
      rx_tx_return_to_stock_date_time_of_day,
      rx_tx_return_to_stock_date_hour2,
      rx_tx_return_to_stock_date_minute15,
      rx_tx_return_to_stock_date_day_of_week,
      rx_tx_return_to_stock_date_week_of_year,
      rx_tx_return_to_stock_date_day_of_week_index,
      rx_tx_return_to_stock_date_day_of_month,
      rx_tx_counseling_completion_time,
      rx_tx_counseling_completion_date,
      rx_tx_counseling_completion_week,
      rx_tx_counseling_completion_month,
      rx_tx_counseling_completion_month_num,
      rx_tx_counseling_completion_year,
      rx_tx_counseling_completion_quarter,
      rx_tx_counseling_completion_quarter_of_year,
      rx_tx_counseling_completion,
      rx_tx_counseling_completion_hour_of_day,
      rx_tx_counseling_completion_time_of_day,
      rx_tx_counseling_completion_hour2,
      rx_tx_counseling_completion_minute15,
      rx_tx_counseling_completion_day_of_week,
      rx_tx_counseling_completion_day_of_month,
      rx_tx_network_plan_bill_time,
      rx_tx_network_plan_bill_date,
      rx_tx_network_plan_bill_week,
      rx_tx_network_plan_bill_month,
      rx_tx_network_plan_bill_month_num,
      rx_tx_network_plan_bill_year,
      rx_tx_network_plan_bill_quarter,
      rx_tx_network_plan_bill_quarter_of_year,
      rx_tx_network_plan_bill,
      rx_tx_network_plan_bill_hour_of_day,
      rx_tx_network_plan_bill_time_of_day,
      rx_tx_network_plan_bill_hour2,
      rx_tx_network_plan_bill_minute15,
      rx_tx_network_plan_bill_day_of_week,
      rx_tx_network_plan_bill_day_of_month,
      rx_tx_central_fill_cutoff_time,
      rx_tx_central_fill_cutoff_date,
      rx_tx_central_fill_cutoff_week,
      rx_tx_central_fill_cutoff_month,
      rx_tx_central_fill_cutoff_month_num,
      rx_tx_central_fill_cutoff_year,
      rx_tx_central_fill_cutoff_quarter,
      rx_tx_central_fill_cutoff_quarter_of_year,
      rx_tx_central_fill_cutoff,
      rx_tx_central_fill_cutoff_hour_of_day,
      rx_tx_central_fill_cutoff_time_of_day,
      rx_tx_central_fill_cutoff_hour2,
      rx_tx_central_fill_cutoff_minute15,
      rx_tx_central_fill_cutoff_day_of_week,
      rx_tx_central_fill_cutoff_week_of_year,
      rx_tx_central_fill_cutoff_day_of_week_index,
      rx_tx_central_fill_cutoff_day_of_month,
      rx_tx_drug_expiration_time,
      rx_tx_drug_expiration_date,
      rx_tx_drug_expiration_week,
      rx_tx_drug_expiration_month,
      rx_tx_drug_expiration_month_num,
      rx_tx_drug_expiration_year,
      rx_tx_drug_expiration_quarter,
      rx_tx_drug_expiration_quarter_of_year,
      rx_tx_drug_expiration,
      rx_tx_drug_expiration_hour_of_day,
      rx_tx_drug_expiration_time_of_day,
      rx_tx_drug_expiration_hour2,
      rx_tx_drug_expiration_minute15,
      rx_tx_drug_expiration_day_of_week,
      rx_tx_drug_expiration_week_of_year,
      rx_tx_drug_expiration_day_of_week_index,
      rx_tx_drug_expiration_day_of_month,
      rx_tx_drug_image_start_time,
      rx_tx_drug_image_start_date,
      rx_tx_drug_image_start_week,
      rx_tx_drug_image_start_month,
      rx_tx_drug_image_start_month_num,
      rx_tx_drug_image_start_year,
      rx_tx_drug_image_start_quarter,
      rx_tx_drug_image_start_quarter_of_year,
      rx_tx_drug_image_start,
      rx_tx_drug_image_start_hour_of_day,
      rx_tx_drug_image_start_time_of_day,
      rx_tx_drug_image_start_hour2,
      rx_tx_drug_image_start_minute15,
      rx_tx_drug_image_start_day_of_week,
      rx_tx_drug_image_start_week_of_year,
      rx_tx_drug_image_start_day_of_week_index,
      rx_tx_drug_image_start_day_of_month,
      rx_tx_follow_up_time,
      rx_tx_follow_up_date,
      rx_tx_follow_up_week,
      rx_tx_follow_up_month,
      rx_tx_follow_up_month_num,
      rx_tx_follow_up_year,
      rx_tx_follow_up_quarter,
      rx_tx_follow_up_quarter_of_year,
      rx_tx_follow_up,
      rx_tx_follow_up_hour_of_day,
      rx_tx_follow_up_time_of_day,
      rx_tx_follow_up_hour2,
      rx_tx_follow_up_minute15,
      rx_tx_follow_up_day_of_week,
      rx_tx_follow_up_week_of_year,
      rx_tx_follow_up_day_of_week_index,
      rx_tx_follow_up_day_of_month,
      rx_tx_host_retrieval_time,
      rx_tx_host_retrieval_date,
      rx_tx_host_retrieval_week,
      rx_tx_host_retrieval_month,
      rx_tx_host_retrieval_month_num,
      rx_tx_host_retrieval_year,
      rx_tx_host_retrieval_quarter,
      rx_tx_host_retrieval_quarter_of_year,
      rx_tx_host_retrieval,
      rx_tx_host_retrieval_hour_of_day,
      rx_tx_host_retrieval_time_of_day,
      rx_tx_host_retrieval_hour2,
      rx_tx_host_retrieval_minute15,
      rx_tx_host_retrieval_day_of_week,
      rx_tx_host_retrieval_week_of_year,
      rx_tx_host_retrieval_day_of_week_index,
      rx_tx_host_retrieval_day_of_month,
      rx_tx_photo_id_birth_time,
      rx_tx_photo_id_birth_date,
      rx_tx_photo_id_birth_week,
      rx_tx_photo_id_birth_month,
      rx_tx_photo_id_birth_month_num,
      rx_tx_photo_id_birth_year,
      rx_tx_photo_id_birth_quarter,
      rx_tx_photo_id_birth_quarter_of_year,
      rx_tx_photo_id_birth,
      rx_tx_photo_id_birth_hour_of_day,
      rx_tx_photo_id_birth_time_of_day,
      rx_tx_photo_id_birth_hour2,
      rx_tx_photo_id_birth_minute15,
      rx_tx_photo_id_birth_day_of_week,
      rx_tx_photo_id_birth_week_of_year,
      rx_tx_photo_id_birth_day_of_week_index,
      rx_tx_photo_id_birth_day_of_month,
      rx_tx_photo_id_expire_time,
      rx_tx_photo_id_expire_date,
      rx_tx_photo_id_expire_week,
      rx_tx_photo_id_expire_month,
      rx_tx_photo_id_expire_month_num,
      rx_tx_photo_id_expire_year,
      rx_tx_photo_id_expire_quarter,
      rx_tx_photo_id_expire_quarter_of_year,
      rx_tx_photo_id_expire,
      rx_tx_photo_id_expire_hour_of_day,
      rx_tx_photo_id_expire_time_of_day,
      rx_tx_photo_id_expire_hour2,
      rx_tx_photo_id_expire_minute15,
      rx_tx_photo_id_expire_day_of_week,
      rx_tx_photo_id_expire_week_of_year,
      rx_tx_photo_id_expire_day_of_week_index,
      rx_tx_photo_id_expire_day_of_month,
      rx_tx_stop_time,
      rx_tx_stop_date,
      rx_tx_stop_week,
      rx_tx_stop_month,
      rx_tx_stop_month_num,
      rx_tx_stop_year,
      rx_tx_stop_quarter,
      rx_tx_stop_quarter_of_year,
      rx_tx_stop,
      rx_tx_stop_hour_of_day,
      rx_tx_stop_time_of_day,
      rx_tx_stop_hour2,
      rx_tx_stop_minute15,
      rx_tx_stop_day_of_week,
      rx_tx_stop_week_of_year,
      rx_tx_stop_day_of_week_index,
      rx_tx_stop_day_of_month,
      rx_tx_written_time,
      rx_tx_written_date,
      rx_tx_written_week,
      rx_tx_written_month,
      rx_tx_written_month_num,
      rx_tx_written_year,
      rx_tx_written_quarter,
      rx_tx_written_quarter_of_year,
      rx_tx_written,
      rx_tx_written_hour_of_day,
      rx_tx_written_time_of_day,
      rx_tx_written_hour2,
      rx_tx_written_minute15,
      rx_tx_written_day_of_week,
      rx_tx_written_week_of_year,
      rx_tx_written_day_of_week_index,
      rx_tx_written_day_of_month,
      source_create_time,
      source_create_date,
      source_create_week,
      source_create_month,
      source_create_month_num,
      source_create_year,
      source_create_quarter,
      source_create_quarter_of_year,
      source_create,
      source_create_hour_of_day,
      source_create_time_of_day,
      source_create_hour2,
      source_create_minute15,
      source_create_day_of_week,
      source_create_week_of_year,
      source_create_day_of_week_index,
      source_create_day_of_month
    ]
  }
}
