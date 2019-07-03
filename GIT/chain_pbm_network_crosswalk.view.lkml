view: chain_pbm_network_crosswalk {
# This view file is a short-term solution to categorize/group/bucket claims/transactions based on customers PBN-Network setup.
# Long term this may be replaced by a table that gets configured in AR which gets replicated in Snowflake. This is yet to be deemed.
# This table will be loaded by a put and a copy statement as shown below by connecting to snowsql in fp-bi-01
  sql_table_name: REPORT_TEMP.D_CHAIN_PBM_NETWORK_CROSSWALK ;;

#################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${chain_id} ||'@'|| ${bin} ||'@'|| ${pcn} ||'@'|| ${group};;
  }

  dimension: chain_id {
    hidden:  yes
    label: "Chain ID"
    description: "Identification number assigned to each customer chain by NHIN."
    type: number
    sql: ${TABLE}."CHAIN_ID" ;;
  }

  dimension: bin {
#     hidden:  yes
    label: "BIN"
    description: "ANSI BIN (Bank Identification Number) number associated with the NHIN Carrier and Plan combination."
    type: string
    sql: ${TABLE}."BIN" ;;
  }

  dimension: pcn {
#     hidden:  yes
    label: "PCN"
    description: "Processor Control Number associated with the NHIN Carrier and Plan combination."
    type: string
    sql: ${TABLE}."PCN" ;;
  }

  dimension: group {
#     hidden:  yes
    label: "Plan Group Code"
    description: "Group Code associated with the NHIN Carrier and Plan combination."
    type: string
    sql: ${TABLE}."GROUP" ;;
  }

  dimension: bin_pcn {
    label: "BIN/PCN"
    description: "Concatenated value of BIN (Bank Identification Number) and PCN (Processor Control Number)."
    type: string
    sql: ${TABLE}."BIN_PCN" ;;
  }

  dimension: bin_pcn_group {
    label: "BIN/PCN/GROUP"
    description: "Concatenated value of BIN (Bank Identification Number), PCN (Processor Control Number) and Plan Group Code."
    type: string
    sql: ${TABLE}."BIN_PCN_GROUP" ;;
  }

  dimension: category {
    description: "Customer defined Insurance Plan Type that relates to a Line of Business. (i.e. Medicaid, Commercial, etc.)."
    type: string
    sql: ${TABLE}."CATEGORY" ;;
  }

  dimension: governing_contract {
    description: "Customer specified identifier (ID/Code/Name) representing the Payer/PBM contract utilized to reimburse claim."
    type: string
    sql: ${TABLE}."GOVERNING_CONTRACT" ;;
  }

  dimension: group_name {
    description: "Customer defined BIN/PCN/GROUP grouping identifier."
    type: string
    sql: ${TABLE}."GROUP_NAME" ;;
  }

  dimension: payer {
    description: "Customer defined organization name associated to the BIN/PCN utilized to make a payment on a transaction."
    type: string
    sql: ${TABLE}."PAYER" ;;
  }

  dimension: payment_source_id {
    description: "Short Name/Code/ID associated with the Payment Source Description."
    type: string
    sql: ${TABLE}."PAYMENT_SOURCE_ID" ;;
  }

  dimension: payment_source_desc {
    label: "Payment Source Description"
    description: "Name associated with the organization responsible for payment on a claim."
    type: string
    sql: ${TABLE}."PAYMENT_SOURCE_DESCRIPTION" ;;
  }

  dimension: processor {
    description: "Customer defined name associated to the BIN utilized on a transaction. This can also be defined as the PBM."
    type: string
    sql: ${TABLE}."PROCESSOR" ;;
  }

  dimension: response_network_reimburse_id {
    description: "Customer provided field defined by the processor. The processor defined identifier which associates a member to the contract utilized to reimburse the claim. This identifier works in combination with the BIN/PCN/GROUP."
    type: string
    sql: ${TABLE}."RESPONSE_NETWORK_REIMBURSE_ID" ;;
  }
}
