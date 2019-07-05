view: mds_transaction_document {
  sql_table_name: EDW.F_TRANSACTION_DOCUMENT ;;
  # Bridge table to connect Documents and Transaction. This table will be used only for the join to avoid causing issues due to n-n relationships but objects under this view will never be exposed in a explore

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

  dimension: source_system_id {
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: transaction_document_id {
    hidden: yes
    type: string
    sql: ${TABLE}.TRANSACTION_DOCUMENT_ID ;;
  }
}
