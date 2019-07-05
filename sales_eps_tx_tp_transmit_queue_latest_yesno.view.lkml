#ERXLPS-2455
view: sales_eps_tx_tp_transmit_queue_latest_yesno {
  derived_table: {
    sql: select chain_id,
                nhin_store_id,
                tx_tp_transmit_queue_id,
                tx_tp_id,
                rnk
           from ( select chain_id,
                         nhin_store_id,
                         tx_tp_transmit_queue_id,
                         tx_tp_id,
                         row_number() over (partition by chain_id, nhin_store_id, tx_tp_id order by tx_tp_transmit_queue_id desc) rnk
                    from edw.f_tx_tp_transmit_queue
                    where TX_TP_TRANSMIT_QUEUE_DELETED = 'N') ;;
  }

  dimension: tx_tp_transmit_queue_id {
    type: number
    hidden: yes
    label: "Transmit Queue ID"
    sql: ${TABLE}.TX_TP_TRANSMIT_QUEUE_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
    #Added tx_tp_id to UK. This is required now as we are integrating TP Transmit Queue into Sales explore. This will make sure sum_distinct is applied correctly while using measures from different measures.
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_tp_id} ||'@'|| ${tx_tp_transmit_queue_id} ||'@'|| ${sales.sold_flg} ||'@'|| ${sales.adjudicated_flg} ||'@'|| ${report_calendar_global.type} ;;
  }

  #################################################################################################### Foreign Key References #####################################################################################################

  dimension: chain_id {
    type: number
    label: "Transmit Queue Chain ID"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    label: "Transmit Queue NHIN STORE ID"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: tx_tp_id {
    label: "ID"
    hidden: yes
    type: number
    sql: ${TABLE}.TX_TP_ID ;;
  }

  dimension: latest_yesno_flag {
    label: "Claim Last Transmit Queue Record"
    description: "Yes/No Flag indicating last transmit queue record was that was transmitted"
    type: yesno
    sql: ${TABLE}.rnk = '1' ;;
  }

}
