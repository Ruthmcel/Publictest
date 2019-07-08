view: bi_demo_sales_eps_tx_tp_dur {
  sql_table_name: EDW.F_TX_TP_DUR ;;

  dimension: primary_key {
    hidden: yes
    type: number
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_tp_dur_id} ||'@'|| ${bi_demo_sales.sold_flg} ||'@'|| ${bi_demo_sales.adjudicated_flg}  ;; #ERXLPS-1649
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "CHAIN_ID is the NHIN assigned ID number to uniquely identify the chain owning this RX_TX record"
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN"
    hidden: yes
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: tx_tp_dur_id {
    label: "DUR ID"
    description: "Unique identifier for each record"
    hidden: yes
    type: number
    sql: ${TABLE}.TX_TP_DUR_ID ;;
  }

  dimension: source_system_id {
    label: "Source System ID"
    description: "Unique ID number identifying a BI source system"
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: tx_tp_dur_claim_counter {
    label: "DUR Claim Counter"
    description: "TP DUR record counter or sequence number"
    type: number
    sql: ${TABLE}.TX_TP_DUR_CLAIM_COUNTER ;;
  }

  dimension: tx_tp_dur_reason_code  {
    label: "DUR Reason Code "
    description: "Conflict code"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_DUR_REASON_CODE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_DUR_REASON_CODE') ;;
    suggestions: [
      "NOT SPECIFIED",
      "ADDITIONAL DRUG NEEDED",
      "PRESCRIPTION AUTHENTICATION",
      "ADVERSE DRUG REACTION",
      "ADDITIVE TOXICITY",
      "CHRONIC DISEASE MANAGEMENT",
      "CALL HELP DESK",
      "PATIENT COMPLAINT/SYMPTOM",
      "DRUG-ALLERGY",
      "DRUG-DISEASE (INFERRED)",
      "DRUG-DRUG INTERACTION",
      "DRUG-FOOD INTERACTION",
      "DRUG INCOMPATIBILITY",
      "DRUG-LAB CONFLICT",
      "APPARENT DRUG MISUSE",
      "TOBACCO USE",
      "PATIENT EDUCATION/INSTRUCTION",
      "OVERUSE",
      "EXCESSIVE QUANTITY",
      "HIGH DOSE",
      "IATROGENIC CONDITION",
      "INGREDIENT DUPLICATION",
      "LOW DOSE",
      "LOCK IN RECIPIENT",
      "UNDERUSE",
      "DRUG-DISEASE (REPORTED)",
      "INSUFFICIENT DURATION",
      "MISSING INFORMATION/CLARIFICATION",
      "EXCESSIVE DURATION",
      "DRUG NOT AVAILABLE",
      "NON-COVERED DRUG PURCHASE",
      "NEW DISEASE/DIAGNOSIS",
      "NON-FORMULARY DRUG",
      "UNNECESSARY DRUG",
      "NEW PATIENT PROCESSING",
      "LACTATION/NURSING INTERACTION",
      "INSUFFICIENT QUANTITY",
      "ALCOHOL CONFLICT",
      "DRUG-AGE",
      "PATIENT QUESTION/CONCERN",
      "DRUG-PREGNANCY",
      "PREVENTIVE HEALTH CARE",
      "PRESCRIBER CONSULTATION",
      "PLAN PROTOCOL",
      "PRIOR ADVERSE REACTION",
      "PRODUCT SELECTION OPPORTUNITY",
      "SUSPECTED ENVIRONMENTAL RISK",
      "HEALTH PROVIDER REFERRAL",
      "SUBOPTIMAL COMPLIANCE",
      "SUBOPTIMAL DRUG/INDICATION",
      "SIDE EFFECT",
      "SUBOPTIMAL DOSAGE FORM",
      "SUBOPTIMAL REGIMEN",
      "DRUG-GENDER",
      "THERAPEUTIC",
      "LABORATORY TEST NEEDED",
      "PAYER/PROCESSOR QUESTION"
    ]
  }

  dimension: tx_tp_dur_clinical_sig_code  {
    label: "DUR Clinical SIG Code "
    description: "Severity index code"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_DUR_CLINICAL_SIG_CODE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_DUR_CLINICAL_SIG_CODE') ;;
    suggestions: [
      "NOT SPECIFIED",
      "MAJOR",
      "MODERATE",
      "MINOR"
    ]
  }

  dimension: tx_tp_dur_other_pharmacy_flag {
    label: "DUR Other Pharmacy Flag"
    description: "Flag indicating the pharmacy that filled the prescription responsible for the TP DUR conflict"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_DUR_OTHER_PHARMACY_FLAG AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_DUR_OTHER_PHARMACY_FLAG') ;;
    suggestions: [
      "NOT SPECIFIED",
      "YOUR (SAME) PHARMACY",
      "OTHER PHARMACY SAME CHAIN",
      "OTHER PHARMACY"
    ]
  }

  dimension_group: tx_tp_dur_previous_fill {
    label: "DUR Previous Fill"
    description: "Date/Time conflict prescription was previously filled"
    type: time
    sql: ${TABLE}.TX_TP_DUR_PREVIOUS_FILL_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  measure: sum_tx_tp_dur_previous_fill_quantity {
    label: "DUR Previous Fill Quantity"
    description: "Total quantity dispensed when the conflicting prescription was filled"
    type: sum
    sql: CASE WHEN (${bi_demo_sales.adjudicated_flg} = 'Y' or ${bi_demo_sales.sold_flg} = 'Y')  THEN ${TABLE}.TX_TP_DUR_PREVIOUS_FILL_QUANTITY END ;;
    value_format: "###0.00"
  }

  dimension: tx_tp_dur_database_flag {
    label: "DUR Database Flag"
    description: "Code used to indicate the database used in determining a TP DUR conflict"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_DUR_DATABASE_FLAG AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_DUR_DATABASE_FLAG') ;;
    suggestions: [
      "MINOR",
      "NOT SPECIFIED",
      "FDB",
      "MEDI SPAN",
      "REDBOOK",
      "PROCESSOR DEVELOPED",
      "OTHER"

    ]
  }

  dimension: tx_tp_dur_other_prescriber_flag {
    label: "DUR Other Prescriber Flag"
    description: "Flag indicating the prescriber who has prescribed the drug responsible for the TP DUR conflict"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_DUR_OTHER_PRESCRIBER_FLAG AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_DUR_OTHER_PRESCRIBER_FLAG') ;;
    suggestions: [
      "NOT SPECIFIED",
      "SAME PRESCRIBER",
      "OTHER PRESCRIBER"
    ]
  }

  dimension: tx_tp_dur_fredd_text  {
    label: "DUR Fredd Text "
    description: "Additional information regarding a TP DUR"
    type: string
    sql: ${TABLE}.TX_TP_DUR_FREDD_TEXT  ;;
  }

  dimension: tx_tp_dur_alert_level_code {
    label: "DUR Alert Level Code"
    description: "Identifies whether this DUR displays as Critical or Informational"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(CAST(${TABLE}.TX_TP_DUR_ALERT_LEVEL_CODE AS VARCHAR),'NULL') AND MC.EDW_COLUMN_NAME = 'TX_TP_DUR_ALERT_LEVEL_CODE') ;;
    suggestions: [
      "NOT SPECIFIED",
      "CRITICAL",
      "INFORMATIONAL",
      "MINOR"
    ]
  }

  dimension: tx_tp_dur_override {
    label: "DUR Override"
    description: "Identifies whether this DUR has been overridden"
    type: yesno
    sql: ${TABLE}.TX_TP_DUR_OVERRIDE_FLAG = 'Y' ;;
  }

  dimension: tx_tp_dur_applicable {
    label: "DUR Applicable"
    description: "Identifies whether this DUR is still valid on subsequent DUR runs for the same transaction"
    type: yesno
    sql: ${TABLE}.TX_TP_DUR_APPLICABLE_FLAG = 'Y' ;;
  }

  dimension: tx_tp_dur_additional_text  {
    label: "DUR Additional Text"
    description: "Notes/Comments that are additional to other columns"
    type: string
    sql: ${TABLE}.TX_TP_DUR_ADDITIONAL_TEXT  ;;
  }

  dimension: tx_tp_id {
    label: "ID"
    description: "TX_TP record to which a TP_DUR record is related"
    hidden: yes
    type: number
    sql: ${TABLE}.TX_TP_ID ;;
  }

  dimension: tx_tp_transmit_queue_id {
    label: "Transmit Queue ID"
    description: "Transmit claim queue number to which a TP DUR record is related"
    hidden: yes
    type: number
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_ID ;;
  }

  dimension: tx_tp_dur_override_user_id {
    label: "DUR Override User ID"
    description: "Employee number of the user who overrode this DUR"
    type: number
    hidden: yes
    sql: ${TABLE}.TX_TP_DUR_OVERRIDE_USER_ID ;;
  }

  dimension_group: source_timestamp {
    label: "Source Timestamp"
    description: "This is the date and time at which the record was last updated in the source application."
    type: time
    hidden: yes
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }
}
