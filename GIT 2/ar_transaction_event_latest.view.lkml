view: ar_transaction_event_latest {
  label: "Transaction Event"

  ## THIS DERIVED TABLE SHOULD BE REMOVED ONCE THE 'AROUT' TABLE IS SOURCED FROM THE AR DATABASE. THE AROUT TABLE STORES THE LATEST STATE OF THE CLAIM.
  ## WITHOUT THE LATEST STATE OF THE CLAIMS, THE MULTIPLE STATES OF THE SAME CLAIM ARE CAUSING REPORTS TO BE INACCURATE. THUS THE NEED FOR THIS DERIVED VIEW UNTIL 'AROUT' IS SOURCED - 7/2/2018

  derived_table: {
    sql:
          SELECT chain_id
                , transaction_event_id
                , source_system_id
                , transaction_event_nhin_store_id
                , transaction_event_plan_id
                , transaction_event_transaction_id
          FROM (
                  SELECT chain_id
                    , transaction_event_id
                    , source_system_id
                    , transaction_event_nhin_store_id
                    , transaction_event_plan_id
                    , transaction_event_transaction_id
                    , row_number () over (partition by chain_id, transaction_event_transaction_id order by transaction_event_status_date desc, transaction_event_id desc) rnk
                  FROM edw.f_transaction_event
                  WHERE {% condition ar_chain.chain_id %} CHAIN_ID {% endcondition %}
                )
          WHERE rnk = 1
        ;;
  }

   #################################################################################### Dimensions (Primary & Foreign Keys) ##############################################################################################################

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} ||'@'|| ${transaction_event_id} ;;
  }

  dimension: chain_id {
    hidden:  yes
    label: "Chain ID"
    description: "Identification number assigned to each customer chain by NHIN."
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: transaction_event_id {
    label: "Transaction Event ID"
    description: "Unique ID number assigned for each claim event processed by Production Cycle in the Absolute system "
    type: number
    sql: ${TABLE}.TRANSACTION_EVENT_ID ;;
  }

  dimension: source_system_id {
    hidden:  yes
    label: "Source System ID"
    description: "Unique ID number identifying a BI source system"
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: nhin_store_id {
    hidden:  yes
    label: "Nhin Store ID"
    description: "Unique ID Number assigned by NHIN accounting dept for each store"
    type: number
    sql: ${TABLE}.TRANSACTION_EVENT_NHIN_STORE_ID ;;
  }

  dimension: plan_id {
    hidden:  yes
    label: "Plan ID"
    description: "Unique ID number of the CARRIER CODE and  PLAN CODE combination in AR system"
    type: number
    sql: ${TABLE}.TRANSACTION_EVENT_PLAN_ID ;;
  }

  dimension: transaction_id {
    hidden:  yes
    label: "Transaction Event Transaction ID"
    description: "Unique ID number of the transaction associated with this claim"
    type: number
    sql: ${TABLE}.TRANSACTION_EVENT_TRANSACTION_ID ;;
  }

  dimension: transaction_event_current_state {
    label: "Current State Transaction Event"
    description: "Yes/No Flag indicating that the Transaction Event record is the latest event available for a claim, based on the Transaction Event Status Date"
    type: yesno
    sql: ${TABLE}.TRANSACTION_EVENT_ID IS NOT NULL ;;
  }

}
