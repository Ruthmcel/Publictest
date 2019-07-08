view: poc_rx_tx_link {
 sql_table_name: EDW.F_RX_TX_LINK ;;

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

  dimension: rx_tx_presc_clinic_link_id {
    label: "Prescription Transaction Clinic Link ID"
    description: "Unique ID that links this record to a specific PRESCRIBER_CLINIC_LINK record, which identifies the Prescriber for this transaction for this transaction within a pharmacy chain"
    type: string
    hidden: yes
    sql: ${TABLE}.RX_TX_PRESC_CLINIC_LINK_ID ;;
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

  measure: count {
    label: "Fill Count"
    description: "Prescription Fill Count"
    type: number
    #hidden: yes
    sql: COUNT(DISTINCT(${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_id})) ;; #ERXLPS-1649
    value_format: "#,##0"
  }

  measure: sum_rx_tx_prescribed_quantity {
    label: "Prescription Prescribed Quantity"
    description: "Number of units (quantity) of the drug the doctor ordered"
    #[ERXLPS-1345] change type to sum. Another set of views are created for sales explore and sum_distinct is not required.
    type: sum
    hidden: yes
    sql: ${TABLE}.RX_TX_PRESCRIBED_QUANTITY ;;
    value_format: "###0.00"
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

    dimension: rx_tx_dispensed_drug_ndc {
    label: "Prescription Dispensed Drug NDC"
    description: "National Drug Code (US) or DIN (Canada) for the dispensed drug. User entered/scanned into client"
    type: string
    sql: ${TABLE}.RX_TX_DISPENSED_DRUG_NDC;;
  }

  dimension: rx_tx_reportable_sales {
    label: "Prescription Reportable Sales Date"
    description: "Used to record the date when a TP script was adjudicated. For cash scripts, it is set when DE is completed"
    type: date
    sql: ${TABLE}.RX_TX_REPORTABLE_SALES_DATE ;;
  }

  dimension: rx_tx_returned {
    label: "Prescription Returned Date"
    description: "Date/Time Credit Return on the transaction is performed"
    type: date
    sql: ${TABLE}.RX_TX_RETURNED_DATE ;;
  }

  dimension: rx_tx_return_to_stock_date {
    label: "Prescription Return To Stock Date"
    description: "Date prescription was returned to stock. The returned to stock date can be populated by a (1) Sold/Picked Up Credit Return, (2) a Will Call/Not Picked Up Return to Stock, or (3) a return from the RTS Utility. This field is EPS only!!!"
    type: date
    sql: ${TABLE}.RX_TX_RETURN_TO_STOCK_DATE ;;
  }

  dimension: rx_tx_will_call_picked_up {
    label: "Prescription Will Call PickedUp Date"
    description: "Date/time that a prescription was sold out of Will Call by a user or by a POS system "
    type: date
    sql: ${TABLE}.RX_TX_WILL_CALL_PICKED_UP_DATE ;;
  }

  dimension: rx_tx_fill {
    label: "Prescription Filled"
    description: "Date prescription was filled Date"
    type: date
    sql: ${TABLE}.RX_TX_FILL_DATE ;;
  }

   }
