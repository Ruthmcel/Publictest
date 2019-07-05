view: store_address {
  label: "Pharmacy"
  sql_table_name: EDW.D_STORE_ADDRESS ;;

  dimension: chain_id {
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    #X# hide:true
    description: "Identification number assinged to a store by NHIN, under each customer chain"
    primary_key: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_address_state {
    label: "Pharmacy State Abbreviation"
    sql: ${TABLE}.STORE_ADDRESS_STATE ;;
  }
}
