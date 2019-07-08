view: mds_print_transaction {
  sql_table_name: EDW.F_PRINT_TRANSACTION ;;
  # Bridge table to connect Documents and Transaction. This table will be used only for the join to avoid causing issues due to n-n relationships but objects under this view will never be exposed in a explore

  dimension: print_transaction_id {
    label: "Print Transaction ID"
    description: "Unique ID identifying a Print Transaction record in the MDS Print Transaction Table"
    hidden: yes
    type: number
    sql: ${TABLE}.PRINT_TRANSACTION_ID ;;
  }

  ################################################################################################## FOREIGN KEYS #################################################################################################

  dimension: document_identifier {
    label: "Transaction Document Identifier"
    # Foreign Key to mds_document view
    description: "Unique ID assigned to a Document. Documents could be located using this document identifer"
    hidden: yes
    type: string
    sql: ${TABLE}.DOCUMENT_IDENTIFIER ;;
  }

  dimension: program_code {
    label: "Transaction Program Code"
    # Foreign Key to mds_document view
    description: "Stores the Program Name"
    hidden: yes
    type: string
    sql: ${TABLE}.PROGRAM_CODE ;;
  }

  dimension: transaction_id {
    label: "Transaction ID"
    # Foreign Key to mds_transaction view
    description: "Unique ID number identifying a transaction record"
    hidden: yes
    type: number
    sql: ${TABLE}.TRANSACTION_ID ;;
  }

  ################################################################################################## META DATA #################################################################################################

  dimension: source_system_id {
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  ################################################################################################## DIMENSION #################################################################################################

  dimension: transaction_document_id {
    hidden: yes
    type: string
    sql: ${TABLE}.TRANSACTION_DOCUMENT_ID ;;
  }

  dimension: print_transaction_print_flag {
    label: "Print Transaction Print Flag"
    description: "Y/N flag to indicate if a document could be printed on a prescription transaction filling process"
    type: string
    suggestions: ["Y", "N"]
    full_suggestions: yes
  }

  measure: print_transaction_pdx_fee {
    label: "Print Transaction PDX fee"
    description: "PDX fee tied to the Program at the time of print transaction"
    type: sum
    sql: ${TABLE}.PRINT_TRANSACTION_PDX_FEE ;;
  }

  measure: print_transaction_pharmacy_fee {
    label: "Print Transaction Pharmacy fee"
    description: "Pharmacy fee tied to the Program at the time of print transaction"
    type: sum
    sql: ${TABLE}.PRINT_TRANSACTION_PHARMACY_FEE ;;
  }

  measure: print_transaction_manufacturer_bill_amount {
    label: "Print Transaction Manufacturer Bill Amount"
    description: "Manufacturer Bill Amount tied to the Program at the time of print transaction"
    type: sum
    sql: ${TABLE}.PRINT_TRANSACTION_MANUFACTURER_BILL_AMOUNT ;;
  }
}
