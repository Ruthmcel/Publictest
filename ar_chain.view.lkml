view: ar_chain {
  label: "Chain"
  sql_table_name: EDW.D_CHAIN ;;

  dimension: chain_id {
    type: number
    primary_key: yes
    label: "Chain ID"
    description: "Unique number assigned to PDX Inc. Accounting to identify a Chain or a Store"
    sql: ${TABLE}.CHAIN_ID ;;
  }

  #################################################################################################### Foreign Key References ####################################################################################

  dimension: chain_src_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_SRC_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: chain_customer_type_id {
    type: number
    hidden: yes
    description: "Identifies the type of a chain/customer (HQ or chain)"
    sql: ${TABLE}.CHAIN_CUSTOMER_TYPE_ID ;;
  }

  dimension: chain_eligible_opt_type_id {
    type: number
    hidden: yes
    description: "Identifies the different eligible opt (ACTIVE/DEACTIVATED) using the AR NHIN TYPE information of a chain or customer"
    sql: ${TABLE}.CHAIN_ELIGIBLE_OPT_TYPE_ID ;;
  }

  dimension: chain_shipment_type_id {
    type: number
    hidden: yes
    description: "Identifies the different Shipment Type (OVERNIGHT, 2 DAY, GROUND, PRIORITY O/N) using the AR NHIN TYPE information of a chain/customer"
    sql: ${TABLE}.CHAIN_SHIPMENT_TYPE_ID ;;
  }

  dimension: chain_shipper_type_id {
    type: number
    hidden: yes
    description: "Identifies the Shipper (UPS, FEDEX) using the AR NHIN TYPE information of a chain/customer"
    sql: ${TABLE}.CHAIN_SHIPPER_TYPE_ID ;;
  }

  dimension: chain_last_update_user_identifier {
    type: number
    description: "ID of the user who last updated this record"
    sql: ${TABLE}.CHAIN_LAST_UPDATE_USER_IDENTIFIER ;;
    value_format: "####"
  }

  #################################################################################################### End of Foreign Key References #########################################################################

  ################################################################################################## Dimensions ################################################################################################

  dimension: chain_name {
    type: string
    description: "Name of the Chain/Customer"
    sql: ${TABLE}.CHAIN_NAME ;;
  }

  dimension: chain_open_or_closed {
    type: string
    description: "Flag that indicates if a chain is open or closed.All closed chains will hold CHAIN_ELIGIBLE_OPT_TYPE_ID value as 204"

    case: {
      when: {
        sql: ${TABLE}.CHAIN_ELIGIBLE_OPT_TYPE_ID = 204 ;;
        label: "Closed"
      }

      #${TABLE}.CHAIN_ELIGIBLE_OPT_TYPE_ID != 204
      when: {
        sql: true ;;
        label: "Open"
      }
    }

    alpha_sort: no
  }

  dimension: chain_customer_code {
    label: "Customer Code"
    type: string
    description: "Customer Code associated to a chain"
    sql: ${TABLE}.CHAIN_CUSTOMER_CODE ;;
  }

  dimension: chain_common_group_code {
    label: "Common Group Code"
    type: string
    description: "Common Group Code associated to a chain"
    sql: ${TABLE}.CHAIN_COMMON_GROUP_CODE ;;
  }

  dimension: chain_ship_code {
    label: "Ship Code"
    type: string
    description: "Shipment Code of the customer as registered in the AR system"
    sql: ${TABLE}.CHAIN_SHIP_CODE ;;
  }

  dimension: chain_report_pattern {
    label: "Report Pattern"
    type: string
    description: "Used for AR internal reporting purposes"
    sql: ${TABLE}.CHAIN_REPORT_PATTERN ;;
  }

  dimension: chain_transport_id {
    label: "Transport ID"
    type: number
    description: "Transport ID of the Chain"
    sql: ${TABLE}.CHAIN_TRANSPORT_ID ;;
    value_format: "####"
  }

  dimension: chain_customer_type {
    label: "Customer Type"
    type: string
    description: "Identifies the type of a chain/customer"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${chain_customer_type_id}) ;;
  }

  dimension: chain_eligible_opt_type {
    label: "Eligible Option"
    type: string
    description: "Identifies the different eligible option of a chain or customer"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${chain_eligible_opt_type_id}) ;;
  }

  dimension: chain_shipment_type {
    label: "Shipment Type"
    type: string
    description: "Identifies the different Shipment Type information of a chain/customer"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${chain_shipment_type_id}) ;;
  }

  dimension: chain_shipper_type {
    label: "Shipper Type"
    type: string
    description: "Identifies the Shipper information of a chain/customer"
    sql: (select max(nhin_type_description) from edw.d_nhin_type t where t.nhin_type_id = ${chain_shipper_type_id}) ;;
  }

  ################################################################################################## End of Dimensions #########################################################################################

  ################################################################################################## Measures ################################################################################################

  measure: count {
    label: "Chain Count"
    type: count
    value_format: "#,##0"
    drill_fields: [chain_name]
  }
}

################################################################################################## End of Measures ################################################################################################
