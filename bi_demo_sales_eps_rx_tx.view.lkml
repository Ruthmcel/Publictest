view: bi_demo_sales_eps_rx_tx {
  # [ERXLPS-1020] - New view with sales_eps_rx_tx created for eps_rx_tx.
  # sales view sold_flg, adjudicated_flg and report_calendar_global.type added along with transmit_queue column to unique_key to produce correct results fr sales measures.
  sql_table_name: EDW.F_RX_TX_LINK ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_id} ||'@'|| ${bi_demo_sales.sold_flg} ||'@'|| ${bi_demo_sales.adjudicated_flg} ;; #ERXLPS-1649
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
    description: "Unique ID number identifying an Transanction record within a pharmacy chain"
    type: number
    hidden: yes
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

  # used to join store drug table
  # ERXLPS-1351 Search and replace all view files to use EDW materialized columns from RX_TX_LINK
  dimension: rx_tx_drug_id {
    label: "Prescription Transaction Drug ID"
    type: string
    hidden: yes
    sql: ${TABLE}.RX_TX_DRUG_DISPENSED_ID ;;
  }

# [ERX-2586] created this dimension for join with Hist tables
  # ERXLPS-1351 Search and replace all view files to use EDW materialized columns from RX_TX_LINK
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
    hidden: yes #[ERXLPS-1436] - PHI Data. Not exposed in DEMO Model.
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
    description: "Yes/No flag indicating if the competitive pricing was used when transaction was priced"
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
    description: "Yes/No flag indicating if indicated SIG is a custom SIG. This means that the user typed the SIG manually or they used a SIG code and manually added additional SIG text"
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
    hidden: yes #[ERXLPS-1436] - PHI Data. Not exposed in DEMO Model.

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

  dimension: prescription_fill_duration {
    label: "Prescription Transaction Time to Will Call"
    description: "This is the difference in minutes between 'Prescription Start Date/Time' and 'Will Call Arrival Time' for a Prescription Transaction for a Pharmacy Chain"
    type: number
    sql: CASE WHEN DATEDIFF(MINUTE,${start_time},${will_call_arrival_time}) <= 0 THEN NULL ELSE DATEDIFF(MINUTE,${start_time},${will_call_arrival_time}) END ;;
  }

  # For use with BI_DEMO / CUSTOMER_DEMO Model only. Dimension is a duplication of "prescription_fill_duration"
  dimension: bi_demo_prescription_fill_duration {
    label: "Prescription Transaction Time to Will Call"
    description: "This is the difference in minutes between 'Prescription Start Date/Time' and 'Will Call Arrival Time' for a Prescription Transaction for a Pharmacy Chain"
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

  dimension_group: start {
    label: "Prescription Transaction Start"
    description: "Date/Time that a Prescription Transaction was started based on the Data Entry or Order Entry process"
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
  dimension_group: bi_demo_start {
    label: "Prescription Transaction Start"
    description: "Date/Time that a Prescription Transaction was started based on the Data Entry or Order Entry process"
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

  dimension: return_to_stock_yesno {
    label: "Prescription Transaction Return to Stock"
    description: " Yes/No field indicating if the transaction made it to 'Will Call' after PV was completed, then are credit returned/cancelled"
    type: yesno
    sql: ${rx_tx_returned_date} IS NOT NULL AND ${will_call_arrival_date} IS NOT NULL AND ${rx_tx_will_call_picked_up_date} IS NULL ;;
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
    sql: CASE WHEN ${rx_tx_active} = 'Yes' THEN DECODE(${TABLE}.RX_TX_RETURNED_DATE,NULL,${TABLE}.RX_TX_PRICE,NVL(${TABLE}.RX_TX_ORIGINAL_PRICE,0)) END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: return_to_stock_count {
    label: "Prescription Transaction Return to Stock Count"
    description: "The number of scripts that made to 'Will Call' after PV was completed, then are credit returned/cancelled"
    type: number
    #  ERXLPS-208 Change: Removed condition ${eps_task_history.task_history_task_action} = 'COMPLETE' AND ${eps_task_history.task_history_status} = 'COMPLETE_PRODUCT_VERIFICATION'. This condition also eliminates addition join to task_history and added will_call_arrival_date IS NOT NULL
    sql: COUNT(DISTINCT(CASE WHEN ${rx_tx_returned_date} IS NOT NULL AND ${will_call_arrival_date} IS NOT NULL AND ${rx_tx_will_call_picked_up_date} IS NULL THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_id}) END)) ;;
    value_format: "#,##0"
  }

  measure: return_to_stock_sales {
    label: "Prescription Transaction Return to Stock Sales"
    description: "The total sales or the original prescription price that made to 'Will Call' after PV was completed, then are credit returned/cancelled"
    type: number
    #  ERXLPS-208 Change: Removed condition ${eps_task_history.task_history_task_action} = 'COMPLETE' AND ${eps_task_history.task_history_status} = 'COMPLETE_PRODUCT_VERIFICATION' This condition also eliminates addition join to task_history and added will_call_arrival_date IS NOT NULL
    sql: SUM(DISTINCT(CASE WHEN ${rx_tx_returned_date} IS NOT NULL AND ${will_call_arrival_date} IS NOT NULL AND ${rx_tx_will_call_picked_up_date} IS NULL THEN ${TABLE}.RX_TX_ORIGINAL_PRICE END)) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_rx_tx_manual_acquisition_cost {
    label: "Total Prescription Manual Acquisition Cost"
    description: "Total prescription manual acquisition cost"
    #[ERXLPS-652] changed from sum to sum_distinct. Should use sum_distinct like ohter measures which were referenced earlier in bi_demo_sales.
    type: sum_distinct
    sql: ${TABLE}.RX_TX_MANUAL_ACQUISITION_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_rx_tx_manual_acquisition_cost {
    label: "Avg Prescription Manual Acquisition Cost"
    description: "Average prescription manual acquisition cost"
    #[ERXLPS-652] changed from avg to avg_distinct. Should use sum_distinct like ohter measures which were referenced earlier in bi_demo_sales.
    type: average_distinct
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
    #[ERXLPS-652] changed from sum to sum_distinct. Should use sum_distinct like ohter measures which were referenced earlier in bi_demo_sales.
    type: sum_distinct
    sql: ${TABLE}.RX_TX_PROFESSIONAL_FEE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_rx_tx_professional_fee {
    label: "Prescription Average Professional Fee"
    description: "Average of any additional fees included in the price of this transaction, outside of the normal pricing calculation"
    #[ERXLPS-652] changed from avg to avg_distinct. Should use sum_distinct like ohter measures which were referenced earlier in bi_demo_sales.
    type: average_distinct
    sql: ${TABLE}.RX_TX_PROFESSIONAL_FEE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  # The following are being commented and are part of US50297. They need to be tested as part of that US before promoting / deploying
  # 12/18/16 -- Removed the Comments for the Time to Will Call Measures. Leadership is requesting that these are available for Demo on Tuesday 12/20
  measure: sum_fill_duration {
    label: "Total Prescription Time to Will Call (Minutes)"
    description: "Total time taken to fill a Prescription from Start to Will Call Arrival. Value is displayed in Minutes. Calculation Used: Prescription Transaction Start Time - Will Call Arrival Time, for the same Prescription Transaction under a pharmacy chain"
    type: number
    sql: SUM(${prescription_fill_duration}) ;;
    value_format: "#,##0.00"
  }

  measure: avg_fill_duration {
    label: "Average Prescription Time to Will Call (Minutes)"
    description: "Average time taken to fill a Prescription from Start to Will Call Arrival. Value is displayed in Minutes. Calculation Used: Prescription Transaction Start Time - Will Call Arrival Time, for the same Prescription Transaction under a pharmacy chain"
    type: number
    sql: AVG(${prescription_fill_duration}) ;;
    value_format: "#,##0.00"
  }

  measure: median_fill_duration {
    label: "Median Prescription Time to Will Call (Minutes)"
    description: "Median time taken to fill a Prescription from Start to Will Call Arrival. Value is displayed in Minutes. Calculation Used: Prescription Transaction Start Time - Will Call Arrival Time, for the same Prescription Transaction under a pharmacy chain"
    type: number
    sql: MEDIAN(${prescription_fill_duration}) ;;
    value_format: "#,##0.00"
  }

  measure: max_fill_duration {
    label: "Max Prescription Time to Will Call (Minutes)"
    description: "Max time taken to fill a Prescription from Start to Will Call Arrival. Value is displayed in Minutes. Calculation Used: Prescription Transaction Start Time - Will Call Arrival Time, for the same Prescription Transaction under a pharmacy chain"
    type: number
    sql: MAX(${prescription_fill_duration}) ;;
    value_format: "#,##0.00"
  }

  measure: min_fill_duration {
    label: "Min Prescription Time to Will Call (Minutes)"
    description: "Min time taken to fill a Prescription from Start to Will Call Arrival. Value is displayed in Minutes. Calculation Used: Prescription Transaction Start Time - Will Call Arrival Time, for the same Prescription Transaction under a pharmacy chain"
    type: number
    sql: MIN(${prescription_fill_duration}) ;;
    value_format: "#,##0.00"
  }

  # ==================================== DUPLICATED MEASURES ============================================ #
  # The Following Time to Will Call Measures are duplicated from immediately above. They are for the CUSTOMER DEMO Model as it uses a different view / join
  measure: bi_demo_sum_fill_duration {
    label: "Total Prescription Time to Will Call (Minutes)"
    description: "Total time taken to fill a Prescription from Start to Will Call Arrival. Value is displayed in Minutes. Calculation Used: Prescription Transaction Start Time - Will Call Arrival Time, for the same Prescription Transaction under a pharmacy chain"
    type: number
    sql: SUM(${bi_demo_prescription_fill_duration}) ;;
    value_format: "#,##0.00"
  }

  measure: bi_demo_avg_fill_duration {
    label: "Average Prescription Time to Will Call (Minutes)"
    description: "Average time taken to fill a Prescription from Start to Will Call Arrival. Value is displayed in Minutes. Calculation Used: Prescription Transaction Start Time - Will Call Arrival Time, for the same Prescription Transaction under a pharmacy chain"
    type: number
    sql: AVG(${bi_demo_prescription_fill_duration}) ;;
    value_format: "#,##0.00"
  }

  measure: bi_demo_median_fill_duration {
    label: "Median Prescription Time to Will Call (Minutes)"
    description: "Median time taken to fill a Prescription from Start to Will Call Arrival. Value is displayed in Minutes. Calculation Used: Prescription Transaction Start Time - Will Call Arrival Time, for the same Prescription Transaction under a pharmacy chain"
    type: number
    sql: MEDIAN(${bi_demo_prescription_fill_duration}) ;;
    value_format: "#,##0.00"
  }

  measure: bi_demo_max_fill_duration {
    label: "Max Prescription Time to Will Call (Minutes)"
    description: "Max time taken to fill a Prescription from Start to Will Call Arrival. Value is displayed in Minutes. Calculation Used: Prescription Transaction Start Time - Will Call Arrival Time, for the same Prescription Transaction under a pharmacy chain"
    type: number
    sql: MAX(${bi_demo_prescription_fill_duration}) ;;
    value_format: "#,##0.00"
  }

  measure: bi_demo_min_fill_duration {
    label: "Min Prescription Time to Will Call (Minutes)"
    description: "Min time taken to fill a Prescription from Start to Will Call Arrival. Value is displayed in Minutes. Calculation Used: Prescription Transaction Start Time - Will Call Arrival Time, for the same Prescription Transaction under a pharmacy chain"
    type: number
    sql: MIN(${bi_demo_prescription_fill_duration}) ;;
    value_format: "#,##0.00"
  }

  # =================================== END DUPLICATED "Time to Will Call" MEASURES ========================================== #

  ## ERXLPS-799 - Time spent "IN" Will Call measure

  dimension: time_in_will_call {
    label: "Prescription Time Spent in Will Call (Hours)"
    description: "The time a prescription spent in Will Call. Value is displayed in Hours. Calculation Used: The difference between Prescription Transaction Will Call Arrival Time, and Prescription Transaction Will Call Pick-up Time"
    #hidden: true # Exposed to add ability to limit negative numbers due to POS DE with picked up time
    type: number
    sql: (DATEDIFF(MINUTE,${will_call_arrival_time}, ${rx_tx_will_call_picked_up_time})/60) ;;
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
    type: sum_distinct
    sql: ${TABLE}.RX_TX_INTENDED_QUANTITY ;;
    value_format: "###0.00"
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_rx_tx_original_quantity {
    label: "Prescription Original Quantity"
    description: "Original quantity on the transaction before credit return"
    type: sum_distinct
    sql: ${TABLE}.RX_TX_ORIGINAL_QUANTITY ;;
    value_format: "###0.00"
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_rx_tx_prescribed_quantity {
    label: "Prescription Prescribed Quantity"
    description: "Number of units (quantity) of the drug the doctor ordered"
    type: sum_distinct
    sql: ${TABLE}.RX_TX_PRESCRIBED_QUANTITY ;;
    value_format: "###0.00"
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_rx_tx_prescribed_quantity_tp {
    label: "T/P Prescription Prescribed Quantity"
    description: "Number of units (quantity) of the drug the doctor ordered for Third Party transactions"
    type: sum_distinct
    sql: CASE WHEN ${rx_tx_tp_bill_reference} = 'Y' THEN ${TABLE}.RX_TX_PRESCRIBED_QUANTITY END ;;
    value_format: "###0.00"
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_rx_tx_prescribed_quantity_cash {
    label: "Cash Prescription Prescribed Quantity"
    description: "Number of units (quantity) of the drug the doctor ordered for Cash transactions"
    type: sum_distinct
    sql: CASE WHEN ${rx_tx_tp_bill_reference} = 'N' THEN ${TABLE}.RX_TX_PRESCRIBED_QUANTITY END ;;
    value_format: "###0.00"
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_rx_tx_requested_price_to_quantity {
    label: "Prescription Requested Price To Quantity"
    description: "The requested dollar amount of the prescription that the patient would like to purchase"
    type: sum_distinct
    sql: ${TABLE}.RX_TX_REQUESTED_PRICE_TO_QUANTITY ;;
    value_format: "###0.00"
  }

  measure: sum_rx_tx_pos_overridden_net_paid {
    label: "Prescription POS Overridden Net Paid"
    description: "Total overridden net pay amount in the POS system, when it is a different amount than the patient net pay amount sent in the transaction request from EPS"
    type: sum_distinct
    sql: ${TABLE}.RX_TX_POS_OVERRIDDEN_NET_PAID ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_rx_tx_pos_overridden_net_paid {
    label: "Avg Prescription POS Overridden Net Paid"
    description: "Average overridden net pay amount in the POS system, when it is a different amount than the patient net pay amount sent in the transaction request from EPS"
    type: average_distinct
    sql: COALESCE(${TABLE}.RX_TX_POS_OVERRIDDEN_NET_PAID,0) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_rx_tx_original_price {
    label: "Prescription Original Price"
    description: "Total Original Price of the Prescription Transaction"
    type: sum_distinct
    sql: COALESCE(${TABLE}.RX_TX_ORIGINAL_PRICE,0) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_rx_tx_fill_quantity {
    label: "Prescription Fill Quantity"
    description: "Total Quantity (number of units) of the drug dispensed"
    type: sum_distinct
    sql: ${TABLE}.RX_TX_FILL_QUANTITY ;;
    value_format: "###0.00"
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_rx_tx_fill_quantity_tp {
    label: "T/P Prescription Fill Quantity"
    description: "Total Fill Quantity of the T/P Prescription Transaction"
    type: sum_distinct
    sql: CASE WHEN ${rx_tx_tp_bill_reference} = 'Y' THEN ${TABLE}.RX_TX_FILL_QUANTITY END ;;
    value_format: "###0.00"
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_rx_tx_fill_quantity_cash {
    label: "Cash Prescription Fill Quantity"
    description: "Total Fill Quantity of the Cash Prescription Transaction"
    type: sum_distinct
    sql: CASE WHEN ${rx_tx_tp_bill_reference} = 'N' THEN ${TABLE}.RX_TX_FILL_QUANTITY END ;;
    value_format: "###0.00"
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

  #dimension: rx_tx_manual_acquisition_cost_reference {
  #  type: number
  #  hidden: yes
  #  sql: ${TABLE}.RX_TX_MANUAL_ACQUISITION_COST ;;
  #}

  #dimension: rx_tx_professional_fee_reference {
  #  type: number
  #  hidden: yes
  #  sql: ${TABLE}.RX_TX_PROFESSIONAL_FEE ;;
  #}

  #dimension: rx_tx_intended_quantity_reference {
  #  type: number
  #  hidden: yes
  #  sql: ${TABLE}.RX_TX_INTENDED_QUANTITY ;;
  #}

  #dimension: rx_tx_original_quantity_reference {
  #  type: number
  #  hidden: yes
  #  sql: ${TABLE}.RX_TX_ORIGINAL_QUANTITY ;;
  #}

  #dimension: rx_tx_prescribed_quantity_reference {
  #  type: number
  #  hidden: yes
  #  sql: ${TABLE}.RX_TX_PRESCRIBED_QUANTITY ;;
  #}

  #dimension: rx_tx_requested_price_to_quantity_reference {
  #  type: number
  #  hidden: yes
  #  sql: ${TABLE}.RX_TX_REQUESTED_PRICE_TO_QUANTITY ;;
  #}

  #dimension: rx_tx_pos_overridden_net_paid_reference {
  #  type: number
  #  hidden: yes
  #  sql: ${TABLE}.RX_TX_POS_OVERRIDDEN_NET_PAID ;;
  #}

  #dimension: rx_tx_fill_quantity_reference {
  #  type: number
  #  hidden: yes
  #  sql: ${TABLE}.RX_TX_FILL_QUANTITY ;;
  #}

  #dimension: rx_tx_fill_quantity_tp_reference {
  #  type: number
  #  hidden: yes
  #  sql: CASE WHEN ${rx_tx_tp_bill_reference} = 'Y' THEN ${TABLE}.RX_TX_FILL_QUANTITY END ;;
  #}

  #dimension: rx_tx_fill_quantity_cash_reference {
  #  type: number
  #  hidden: yes
  #  sql: CASE WHEN ${rx_tx_tp_bill_reference} = 'N' THEN ${TABLE}.RX_TX_FILL_QUANTITY END ;;
  #}

  #dimension: rx_tx_original_price_reference {
  #  type: number
  #  hidden: yes
  #  sql: ${TABLE}.RX_TX_ORIGINAL_PRICE ;;
  #}

  #dimension: rx_tx_base_cost_reference {
  #  type: number
  #  hidden: yes
  #  sql: ${TABLE}.RX_TX_BASE_COST ;;
  #}

  #dimension: rx_tx_compound_fee_reference {
  #  type: number
  #  hidden: yes
  #  sql: ${TABLE}.RX_TX_COMPOUND_FEE ;;
  #}

  #dimension: rx_tx_sig_per_day_reference {
  #  type: number
  #  hidden: yes
  #  sql: ${TABLE}.RX_TX_SIG_PER_DAY ;;
  #}

  #dimension: rx_tx_sig_per_dose_reference {
  #  type: number
  #  hidden: yes
  #  sql: ${TABLE}.RX_TX_SIG_PER_DOSE ;;
  #}

  #dimension: rx_tx_up_charge_reference {
  #  type: number
  #  hidden: yes
  #  sql: ${TABLE}.RX_TX_UP_CHARGE ;;
  #}

  #dimension: rx_tx_owed_quantity_reference {
  #  type: number
  #  hidden: yes
  #  sql: ${TABLE}.RX_TX_OWED_QUANTITY ;;
  #}

  #dimension: rx_tx_prescribed_quantity_tp_reference {
  #  type: number
  #  hidden: yes
  #  sql: CASE WHEN ${eps_rx_tx.rx_tx_tp_bill_reference} = 'Y' THEN ${TABLE}.RX_TX_PRESCRIBED_QUANTITY END ;;
  #}

  #dimension: rx_tx_prescribed_quantity_cash_reference {
  #  type: number
  #  hidden: yes
  #  sql: CASE WHEN ${eps_rx_tx.rx_tx_tp_bill_reference} = 'N' THEN ${TABLE}.RX_TX_PRESCRIBED_QUANTITY END ;;
  #}

  #[ERXLPS-724] - New dimension added to reference in other views. Right now this is beign reference in sales view to calculate dollar amount based on fill and credit return
  #dimension: rx_tx_overridden_price_amount_reference {
  #  hidden: yes
  #  type: number
  #  sql: ${TABLE}.RX_TX_OVERRIDDEN_PRICE_AMOUNT ;;
  #}

  #[ERXLPS-724] - New dimension added to reference in other views. Right now this is beign reference in sales view to calculate dollar amount based on fill and credit return
  dimension: rx_tx_uc_price_reference {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_UC_PRICE ;;
  }

  #[ERXLPS-1055] Date reference dimensions for the remaining F_RX_TX_LINK date columns. Start here...
  dimension: rx_tx_pos_sold_reference {
    hidden: yes
    label: "Prescription Transaction POS Sold"
    description: "Date/Time the transaction was sold from the POS system. It is set upon the receipt of a POSSoldRequest from the POS system. This field is EPS only!!!"
    sql: ${TABLE}.RX_TX_POS_SOLD_DATE ;;
  }

  dimension: rx_tx_custom_reported_reference {
    hidden: yes
    label: "Prescription Transaction Custom Reported"
    description: "Date/time the record was reported on the Meijer Sales Report"
    sql: ${TABLE}.RX_TX_CUSTOM_REPORTED_DATE ;;
  }

  dimension: rx_tx_dob_override_reference {
    hidden: yes
    label: "Prescription Transaction DOB Override"
    description: "Date/time that the Override of the DOB was completed during DOB verification prompted at will call screen"
    sql: ${TABLE}.RX_TX_DOB_OVERRIDE_TIME ;;
  }

  dimension: rx_tx_last_epr_synch_reference {
    hidden: yes
    label: "Prescription Transaction Last EPR Synch"
    description: "Date/time when the EPS SYNC occurs and EPR sends a successful response"
    sql: ${TABLE}.RX_TX_LAST_EPR_SYNCH ;;
  }

  dimension: rx_tx_missing_reference {
    hidden: yes
    label: "Prescription Transaction Missing"
    description: "Date/time when the user reported that prescription missing"
    sql: ${TABLE}.RX_TX_MISSING_DATE ;;
  }

  dimension: rx_tx_pc_ready_reference {
    hidden: yes
    label: "Prescription Transaction PC Ready"
    description: "Date/time of when the prescription was marked as Patient Accepted Counseling"
    sql: ${TABLE}.RX_TX_PC_READY_DATE ;;
  }

  dimension: rx_tx_replace_reference {
    hidden: yes
    label: "Prescription Transaction Replace"
    description: "Date application replaced missing/stolen prescription filling"
    sql: ${TABLE}.RX_TX_REPLACE_DATE ;;
  }

  dimension: rx_tx_central_fill_cutoff_reference {
    hidden: yes
    label: "Prescription Transaction Central Fill Cutoff"
    description: "The cut-off date that the prescription must be transmitted to the fulfillment site by so that the prescription can be delivered by the promised date. System generated depending upon time and date of prescription"
    sql: ${TABLE}.RX_TX_CENTRAL_FILL_CUTOFF_DATE ;;
  }

  dimension: rx_tx_drug_expiration_reference {
    hidden: yes
    label: "Prescription Transaction Drug Expiration"
    description: "Dispensed drug's expiration date. system generated or user entered"
    sql: ${TABLE}.RX_TX_DRUG_EXPIRATION_DATE ;;
  }

  dimension: rx_tx_drug_image_start_reference {
    hidden: yes
    label: "Prescription Transaction Drug Image Start"
    description: "Date the drug image was added to the Medi-Span database. Medi-Span DIB"
    sql: ${TABLE}.RX_TX_DRUG_IMAGE_START_DATE ;;
  }

  dimension: rx_tx_follow_up_reference {
    hidden: yes
    label: "Prescription Transaction Follow Up"
    description: "Date of prescription follow-up. System Generated"
    sql: ${TABLE}.RX_TX_FOLLOW_UP_DATE ;;
  }

  dimension: rx_tx_host_retrieval_reference {
    hidden: yes
    label: "Prescription Transaction Host Retrieval"
    description: "Date Host retrieved the transaction record. System Generated when transaction record is retrieved"
    sql: ${TABLE}.RX_TX_HOST_RETRIEVAL_DATE ;;
  }

  dimension: rx_tx_photo_id_birth_reference {
    hidden: yes
    label: "Prescription Transaction Photo Identifier Birth"
    description: "Date of birth of the person dropping off or picking up the prescription. User input"
    sql: ${TABLE}.RX_TX_PHOTO_ID_BIRTH_DATE ;;
  }

  dimension: rx_tx_photo_id_expire_reference {
    hidden: yes
    label: "Prescription Transaction Photo Identifier Expire"
    description: "The expiration date on photographic identification card, which was presented at drop off or pick up. User entered"
    sql: ${TABLE}.RX_TX_PHOTO_ID_EXPIRE_DATE ;;
  }

  dimension: rx_tx_stop_reference {
    hidden: yes
    label: "Prescription Transaction Stop"
    description: "Nursing home or institutional stop date. (The date that the patient should stop receiving medication)"
    sql: ${TABLE}.RX_TX_STOP_DATE ;;
  }

  dimension: rx_tx_source_create_reference {
    hidden: yes
    label: "Prescription Transaction Source Create"
    description: "Date/Time that the record was created. This date is used for central data analysis. Oracle generated timestamp when the insert is made in the database"
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }
  #[ERXLPS-1055] Date reference dimensions for the remaining F_RX_TX_LINK date columns. End here...
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
    description: "First name of the person of the person consenting to the administration of this immunization"
    type: string
    sql: ${TABLE}.RX_TX_CONSENT_BY_FIRST_NAME ;;
  }

  dimension: rx_tx_consent_by_last_name {
    label: "Prescription Consent By Last Name"
    description: "Last name of the person of the person consenting to the administration of this immunization"
    type: string
    sql: ${TABLE}.RX_TX_CONSENT_BY_LAST_NAME ;;
  }

  dimension: rx_tx_consent_by_middle_name {
    label: "Prescription Consent By Middle Name"
    description: "Middle name of the person of the person consenting to the administration of this immunization"
    type: string
    sql: ${TABLE}.RX_TX_CONSENT_BY_MIDDLE_NAME ;;
  }

  dimension: rx_tx_consent_by_relation_code {
    label: "Prescription Consent By Relation Code"
    description: "3 Character Relationship code identifying the relationship of the person consenting to the administration of this immunization"
    type: string
    sql: ${TABLE}.RX_TX_CONSENT_BY_RELATION_CODE ;;
  }

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
    description: "Date the doctor wrote the prescription. User entered"
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
    description: "Additional qualifier for the ID contained in AIR05. System Generated depeding on user entry"
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

  ########################################################################################### End of YES/NO & CASE WHEN fields ###############################################################################################

  ####################################################################################################### Measures ####################################################################################################

  measure: sum_rx_tx_base_cost {
    label: "Prescription Total Base Cost"
    description: "Total dollar amount the cost base was for this transaction of the drug filled. System Generated"
    #[ERXLPS-652] changed from sum to sum_distinct. Should use sum_distinct like ohter measures which were referenced earlier in bi_demo_sales.
    type: sum_distinct
    sql: ${TABLE}.RX_TX_BASE_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_rx_tx_compound_fee {
    label: "Prescription Total Compound Fee"
    description: "Total compound preparation charges. User entered. Compound rate multiplied by compound time"
    #[ERXLPS-652] changed from sum to sum_distinct. Should use sum_distinct like ohter measures which were referenced earlier in bi_demo_sales.
    type: sum_distinct
    sql: ${TABLE}.RX_TX_COMPOUND_FEE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #Owed Quantity is coming from eps_line_item.line_item_owed_quantity. This measure is duplicate for eps_line_item.item_owed_quantity measure.
  measure: sum_rx_tx_owed_quantity {
    label: "Prescription Total Owed Quantity"
    description: "Total number of units (quantity) of the drug that are owed to the patient. Auto-calculated via client"
    #[ERXLPS-652] changed from sum to sum_distinct. Should use sum_distinct like ohter measures which were referenced earlier in bi_demo_sales.
    type: sum_distinct
    sql: ${TABLE}.RX_TX_OWED_QUANTITY ;;
    value_format: "#,##0.00"
  }

  measure: sum_rx_tx_sig_per_day {
    label: "Prescription Total SIG Per Day"
    description: "Total number of times the drug is taken per day . User entered via client"
    #[ERXLPS-652] changed from sum to sum_distinct. Should use sum_distinct like ohter measures which were referenced earlier in bi_demo_sales.
    type: sum_distinct
    sql: ${TABLE}.RX_TX_SIG_PER_DAY ;;
    value_format: "#,##0.00"
  }

  measure: sum_rx_tx_sig_per_dose {
    label: "Prescription Total SIG Per Dose"
    description: "Total number of dosage units that must be taken or given per administration of the drug. User entered via client"
    #[ERXLPS-652] changed from sum to sum_distinct. Should use sum_distinct like ohter measures which were referenced earlier in bi_demo_sales.
    type: sum_distinct
    sql: ${TABLE}.RX_TX_SIG_PER_DOSE ;;
    value_format: "#,##0.00"
  }

  measure: sum_rx_tx_up_charge {
    label: "Prescription Total Up Charge"
    description: "Total amount by which the cost base (for the drug filled) was adjusted by a base cost table (third party prescription only). System Generated"
    #[ERXLPS-652] changed from sum to sum_distinct. Should use sum_distinct like ohter measures which were referenced earlier in bi_demo_sales.
    type: sum_distinct
    sql: ${TABLE}.RX_TX_UP_CHARGE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_rx_tx_uc_price {
    label: "Prescription U & C Price"
    description: "Total Usual & Customary pricing of the Prescription Transaction"
    type: sum_distinct
    sql: ${TABLE}.RX_TX_UC_PRICE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ## ERXLPS-643 - Need the U & C Price to not sum over last year when LY Analsysis is turned on, changing exposed UC Price in Sales view (removed the UC price measure above this one from the sales set, and added this one)
  #[ERXLPS-724] - Commenting the below measure from eps_rx_tx. This base column added in sales view sql and below measure is not required in eps_rx_tx.
  #- measure: rx_tx_uc_price_measure
  #  label: 'Prescription U & C Price'
  # description: "Usual & Customary pricing of the Prescription Transaction. (This field should only be used for grouping or filtering. Example: if you want to see U&C pricing of $50, $100,etc... )"
  #  type: number
  #  hidden: true
  #  sql: ${TABLE}.RX_TX_UC_PRICE
  #  value_format: '$#,##0.00;($#,##0.00)'

  #[ERXLPS-910] Sales related measure added here. Once these measures called from Sales explore sum_distinct will be applied to produce correct results.
  measure: sum_sales_rx_tx_manual_acquisition_cost {
    label: "Total Prescription Manual Acquisition Cost"
    group_label: "Acquisition Cost"
    description: "Total prescription manual acquisition cost"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.rx_tx_manual_acquisition_cost END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
  }

  measure: avg_sales_rx_tx_manual_acquisition_cost {
    label: "Avg Prescription Manual Acquisition Cost"
    group_label: "Acquisition Cost"
    description: "Average prescription manual acquisition cost"
    type: average
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN COALESCE(${TABLE}.rx_tx_manual_acquisition_cost,0) END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_sales_rx_tx_professional_fee {
    label: "Prescription Total Professional Fee"
    group_label: "Other Measures"
    description: "Total of any additional fees included in the price of this transaction, outside of the normal pricing calculation"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.rx_tx_professional_fee END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
  }

  measure: avg_sales_rx_tx_professional_fee {
    label: "Prescription Average Professional Fee"
    group_label: "Other Measures"
    description: "Average of any additional fees included in the price of this transaction, outside of the normal pricing calculation"
    type: average
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN COALESCE(${TABLE}.rx_tx_professional_fee,0) END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_sales_rx_tx_intended_quantity {
    label: "Prescription Intended Quantity"
    group_label: "Quantity"
    description: "The original quantity that the customer requested for this transaction"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.rx_tx_intended_quantity END ;;
    value_format: "###0.00"
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_sales_rx_tx_original_quantity {
    label: "Prescription Original Quantity"
    group_label: "Quantity"
    description: "Original quantity on the transaction before credit return"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.rx_tx_original_quantity END ;;
    value_format: "###0.00"
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_sales_rx_tx_prescribed_quantity {
    label: "Prescription Prescribed Quantity"
    group_label: "Quantity"
    description: "Number of units (quantity) of the drug the doctor ordered"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.rx_tx_prescribed_quantity END ;;
    value_format: "###0.00"
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_sales_rx_tx_requested_price_to_quantity {
    label: "Prescription Requested Price To Quantity"
    group_label: "Quantity"
    description: "The requested dollar amount of the prescription that the patient would like to purchase"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.rx_tx_requested_price_to_quantity END ;;
    value_format: "###0.00"
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
  }

  measure: sum_sales_rx_tx_pos_overridden_net_paid {
    label: "Prescription POS Overridden Net Paid"
    group_label: "Price Override"
    description: "Total overridden net pay amount in the POS system, when it is a different amount than the patient net pay amount sent in the transaction request from EPS"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.rx_tx_pos_overridden_net_paid END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
  }

  measure: avg_sales_rx_tx_pos_overridden_net_paid {
    label: "Avg Prescription POS Overridden Net Paid"
    group_label: "Price Override"
    description: "Average overridden net pay amount in the POS system, when it is a different amount than the patient net pay amount sent in the transaction request from EPS"
    type: average
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN COALESCE(${TABLE}.rx_tx_pos_overridden_net_paid,0) END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_sales_rx_tx_fill_quantity {
    label: "Prescription Fill Quantity"
    group_label: "Quantity"
    description: "Total Quantity (number of units) of the drug dispensed"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.rx_tx_fill_quantity END ;;
    value_format: "###0.00"
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_sales_rx_tx_fill_quantity_tp {
    label: "T/P Prescription Fill Quantity"
    group_label: "Quantity"
    description: "Total Fill Quantity of the T/P Prescription Transaction"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  AND ${rx_tx_tp_bill_reference} = 'Y' THEN ${TABLE}.rx_tx_fill_quantity END ;;
    value_format: "###0.00"
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_sales_rx_tx_fill_quantity_cash {
    label: "Cash Prescription Fill Quantity"
    group_label: "Quantity"
    description: "Total Fill Quantity of the Cash Prescription Transaction"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  AND ${rx_tx_tp_bill_reference} = 'N' THEN ${TABLE}.rx_tx_fill_quantity END ;;
    value_format: "###0.00"
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
  }

  measure: sum_sales_rx_tx_original_price {
    label: "Prescription Original Price"
    group_label: "Other Price"
    description: "Total Original Price of the Prescription Transaction"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.rx_tx_original_price END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
  }

  measure: sum_sales_rx_tx_base_cost {
    label: "Prescription Total Base Cost"
    group_label: "Other Measures"
    description: "Total dollar amount the cost base was for this transaction of the drug filled. System Generated"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.rx_tx_base_cost END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
  }

  measure: sum_sales_rx_tx_compound_fee {
    label: "Prescription Total Compound Fee"
    group_label: "Other Measures"
    description: "Total compound preparation charges. User entered. Compound rate multiplied by compound time"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.rx_tx_compound_fee END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
  }

  measure: sum_sales_rx_tx_sig_per_day {
    label: "Prescription Total SIG Per Day"
    group_label: "SIG"
    description: "Total number of times the drug is taken per day . User entered via client"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.rx_tx_sig_per_day END ;;
    value_format: "#,##0.00"
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
  }

  measure: sum_sales_rx_tx_sig_per_dose {
    label: "Prescription Total SIG Per Dose"
    group_label: "SIG"
    description: "Total number of dosage units that must be taken or given per administration of the drug. User entered via client"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.rx_tx_sig_per_dose END ;;
    value_format: "#,##0.00"
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
  }

  measure: sum_sales_rx_tx_up_charge {
    label: "Prescription Total Up Charge"
    group_label: "Other Measures"
    description: "Total amount by which the cost base (for the drug filled) was adjusted by a base cost table (third party prescription only). System Generated"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.rx_tx_up_charge END ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
  }

  measure: sum_sales_rx_tx_owed_quantity {
    label: "Prescription Total Owed Quantity"
    group_label: "Quantity"
    description: "Total number of units (quantity) of the drug that are owed to the patient. Auto-calculated via client"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.rx_tx_owed_quantity END ;;
    value_format: "#,##0.00"
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_sales_rx_tx_prescribed_quantity_tp {
    label: "T/P Prescription Prescribed Quantity"
    group_label: "Quantity"
    description: "Number of units (quantity) of the drug the doctor ordered for Third Party transactions"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  AND ${rx_tx_tp_bill_reference} = 'Y' THEN ${TABLE}.rx_tx_prescribed_quantity END ;;
    value_format: "###0.00"
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
  }

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  measure: sum_sales_rx_tx_prescribed_quantity_cash {
    label: "Cash Prescription Prescribed Quantity"
    group_label: "Quantity"
    description: "Number of units (quantity) of the drug the doctor ordered for Cash transactions"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  AND ${rx_tx_tp_bill_reference} = 'N' THEN ${TABLE}.rx_tx_prescribed_quantity END ;;
    value_format: "###0.00"
    drill_fields: [bi_demo_sales.sales_transaction_level_drill_path*]
  }

# [ERXLPS-1383]: Added SBMO Script count measure
  measure: total_sbmo_script_count {
    label: "SBMO Script Count"
    description: "SBMO Script Count"
    type: count_distinct
    sql: case when ${TABLE}.RX_TX_FILL_LOCATION in ('M' , 'C')
              then ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_id} ||'@'|| ${bi_demo_sales.sold_flg} ||'@'|| ${bi_demo_sales.adjudicated_flg}
              else null end;;
    value_format: "#,##0;(#,##0)"
  }

  ####################################################################################################### End of Measures ####################################################################################################

  ########################################################################################################## End of 4.8.000 New columns #############################################################################################

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
      rx_tx_fill_location,
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
      rx_tx_refill_source,
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
      rx_tx_return_to_stock_date_date,
      rx_tx_return_to_stock_date_day_of_month,
      rx_tx_return_to_stock_date_day_of_week,
      rx_tx_return_to_stock_date_day_of_week_index,
      rx_tx_return_to_stock_date_hour_of_day,
      rx_tx_return_to_stock_date_hour2,
      rx_tx_return_to_stock_date_minute15,
      rx_tx_return_to_stock_date_month,
      rx_tx_return_to_stock_date_month_num,
      rx_tx_return_to_stock_date_quarter,
      rx_tx_return_to_stock_date_quarter_of_year,
      rx_tx_return_to_stock_date_time,
      rx_tx_return_to_stock_date_time_of_day,
      rx_tx_return_to_stock_date_week,
      rx_tx_return_to_stock_date_week_of_year,
      rx_tx_return_to_stock_date_year,
      rx_tx_return_to_stock_date,
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
      rx_tx_counseling_rph_employee_number,
      rx_tx_dob_override_employee_number,
      rx_tx_epr_synch_version,
      rx_tx_mobile_services_channel,
      rx_tx_new_ddid_authorized_by_emp_number,
      rx_tx_pos_reason_for_void,
      rx_tx_pv_employee_number,
      rx_tx_register_number,
      rx_tx_custom_sig,
      rx_tx_relationship_to_patient,
      rx_tx_sent_to_ehr,
      rx_tx_state_report_status,
      rx_tx_dispensed_drug_ndc,
      #return_to_stock_yesno, #[ERXLPS-2315] This dimension is exposed from sales view in Sales explore.
      rx_tx_auto_counting_system_priority,
      rx_tx_cashier_name,
      rx_tx_manufacturer,
      rx_tx_mar_page_position,
      rx_tx_mar_sort_order,
      rx_tx_note,
      rx_tx_number_of_labels,
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
      rx_tx_physician_order_page_position,
      rx_tx_physician_order_sort_order,
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
      rx_tx_rph_employee_number_of_record,
      rx_tx_rx_match_key,
      rx_tx_sig_code,
      rx_tx_sig_text,
      rx_tx_site_of_administration,
      rx_tx_consent_by_first_name,
      rx_tx_consent_by_last_name,
      rx_tx_consent_by_middle_name,
      rx_tx_consent_by_relation_code,
      rx_tx_drug_image_key, #[ERXLPS-1055]
      sum_sales_rx_tx_sig_per_day,
      sum_sales_rx_tx_sig_per_dose
    ]
  }

  set: explore_bi_demo_sales_candidate_list {
    fields: [
      rx_tx_epr_synch_version,
      rx_tx_mobile_services_channel,
      rx_tx_pos_reason_for_void,
      rx_tx_relationship_to_patient,
      rx_tx_sent_to_ehr,
      rx_tx_state_report_status,
      rx_tx_dispensed_drug_ndc,
      #return_to_stock_yesno, #[ERXLPS-2315] This dimension is exposed from sales view in Sales explore.
      rx_tx_auto_counting_system_priority,
      rx_tx_mar_page_position,
      rx_tx_mar_sort_order,
      rx_tx_number_of_labels,
      rx_tx_physician_order_page_position,
      rx_tx_physician_order_sort_order,
      rx_tx_rx_match_key,
      rx_tx_site_of_administration,
      sum_sales_rx_tx_sig_per_day,
      sum_sales_rx_tx_sig_per_dose,
      total_sbmo_script_count
    ]
  }


  set: explore_rx_4_11_history_candidate_list {
    fields: [
      rx_tx_will_call_picked_up_date,
      sum_rx_tx_fill_quantity

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

}
