view: sales_eps_rx_tx {
  # [ERXLPS-1020] - New view with sales_eps_rx_tx created for eps_rx_tx.
  # sales view sold_flg, adjudicated_flg and report_calendar_global.type added along with transmit_queue column to unique_key to produce correct results fr sales measures.
  sql_table_name:
  {% if _explore._name == 'sales' %}
    {% assign active_archive_filter_input_value = sales.active_archive_filter_input._sql | slice: 1,7 | downcase %}
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
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_tx_id} ||'@'|| ${sales.sold_flg} ||'@'|| ${sales.adjudicated_flg} ||'@'|| ${report_calendar_global.type} ;; #ERXLPS-1649
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

  dimension: rx_tx_refill_number {
    label: "Prescription Refill Number"
    description: "Refill number of the transaction"
    type: number
    sql: ${TABLE}.RX_TX_REFILL_NUMBER ;;
    value_format: "#,##0"
  }

  dimension: rx_tx_partial_rx_tx_id {
    label: "Prescription Transaction Partial Fill ID"
    description: "Unique Prescription Transaction ID number of the partial fill Prescription Transaction record of a partially filled transaction within a pharmacy chain"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_PARTIAL_RX_TX_ID ;;
  }

  dimension: rx_tx_completion_rx_tx_id {
    label: "Prescription Transaction Completion Fill ID"
    description: "Unique Prescription Transaction ID number identifying an completion fill Prescription Transaction record of a partially filled transaction within a pharmacy chain"
    type: number
    hidden: yes
    sql: ${TABLE}.RX_TX_COMPLETION_RX_TX_ID ;;
  }

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

  #[ERXLPS-1055] - modified value format precision from 4 to 2.
  dimension: rx_tx_fill_quantity {
    label: "Prescription Fill Quantity"
    description: "Quantity (number of units) of the drug dispensed. (This field should only be used for grouping or filtering. Example: if you want to see Transaction Disp by Qty 30, 60, etc... )"
    type: number
    #hidden: true
    sql: ${TABLE}.rx_tx_fill_quantity ;;
    value_format: "###0.00"
  }


  dimension: rx_tx_days_supply {
    label: "Prescription Days Supply"
    type: number
    sql: ${TABLE}.RX_TX_DAYS_SUPPLY ;;
  }

  dimension: rx_tx_partial_fill_bill_type_reference {
    label: "Prescription Transaction Partial Fill Bill Type Reference"
    type: string
    hidden: yes
    sql: ${TABLE}.RX_TX_PARTIAL_FILL_BILL_TYPE ;;
  }

}
