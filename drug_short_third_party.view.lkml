view: drug_short_third_party {
  sql_table_name: EDW.D_DRUG_SHORT_THIRD_PARTY ;;

  dimension: chain_id {
    type: number
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN"
    hidden:  yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: ndc {
    type: string
    label: "NDC"
    hidden:  yes
    description: "Drug NDC"
    sql: ${TABLE}.NDC ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    # adding NVL condition because PK can contain Null in DB but looker cannot hold NULL value in PK as distinct key for measures.
    sql: ${chain_id} ||'@'|| ${ndc} ||'@'|| nvl(${drug_short_third_party_carrier_code},'#@@#') ||'@'|| nvl(${drug_short_third_party_plan_code},'#@@#') ||'@'|| nvl(${drug_short_third_party_plan_group_code},'#@@#') ;;
  }

  dimension: drug_short_third_party_carrier_code {
    type: string
    label: "Carrier Code"
    description: "Carrier ID Code"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_CARRIER_CODE ;;
  }

  dimension: drug_short_third_party_plan_code {
    type: string
    label: "Plan Code"
    description: "Plan Number"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_PLAN_CODE ;;
  }

  dimension: drug_short_third_party_plan_group_code {
    type: string
    label: "Plan Group Code"
    description: "Group Number"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_PLAN_GROUP_CODE ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    label: "Source System Id"
    description: "Unique ID number identifying a BI source system"
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: drug_short_third_party_generic_code {
    type: string
    label: "Generic Code"
    description: "Generic Indicator"
    case: {
      when: {
        sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_GENERIC_CODE = 0 ;;
        label: "BRAND"
      }

      when: {
        sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_GENERIC_CODE = 1 ;;
        label: "GENERIC"
      }

      when: {
        sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_GENERIC_CODE = 2 ;;
        label: "NO GENERIC"
      }
    }
  }

  dimension: drug_short_third_party_mac_flag {
    type: yesno
    label: "MAC"
    description: "Yes/No flag indicating MAC priced drug"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_MAC_FLAG = 'Y' ;;
  }

  dimension: drug_short_third_party_otc_flag {
    type: yesno
    label: "OTC"
    description: "Yes/No flag indicating OTC drug"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_OTC_FLAG = 'Y' ;;
  }

  dimension: drug_short_third_party_maintenance_flag {
    type: yesno
    label: "Maintenance"
    description: "Yes/No flag indicating maintenance drug"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_MAINTENANCE_FLAG = 'Y'  ;;
  }

  dimension: drug_short_third_party_ignore_therapeutic_restriction_flag {
    type: yesno
    label: "Ignore Therapeutic Restriction"
    description: "Yes/No flag indicating therapeutic restriction can be ignored for the drug"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_IGNORE_THERAPEUTIC_RESTRICTION_FLAG = 'Y'  ;;
  }

  dimension: drug_short_third_party_allow_update_flag {
    type: yesno
    label: "Allow Update"
    description: "Yes/No flag indicating batch update is allowed for the drug"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_ALLOW_UPDATE_FLAG = 'Y'  ;;
  }

  dimension: drug_short_third_party_supported_by_host_flag {
    type: yesno
    label: "Supported By Host Flag"
    description: "Yes/No flag indicating TP info is supported by Host for this drug"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_SUPPORTED_BY_HOST_FLAG = 'Y'  ;;
  }

  dimension_group: drug_short_third_party_last_update {
    type: time
    timeframes:
    [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month]
    label: "Last Update"
    description: "Date/Time the record last updated"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_LAST_UPDATE_DATE ;;
  }

  dimension_group: drug_short_third_party_last_host_update {
    type: time
    timeframes:
    [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month]
    label: "Last Host Update"
    description: "Date/Time the record last updated from Host"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_LAST_HOST_UPDATE_DATE ;;
  }

  dimension_group: drug_short_third_party_last_used {
    type: time
    timeframes:
    [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month]
    label: "Last Used"
    description: "Date/Time the record last used for Purging"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_LAST_USED_DATE ;;
  }

  dimension_group: drug_short_third_party_last_mac_update {
    type: time
    timeframes:
    [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month]
    label: "Last MAC Update"
    description: "Date/Time when MAC was last updated"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_LAST_MAC_UPDATE_DATE ;;
  }


  dimension: drug_short_third_party_restriction_1_flag {
    type: yesno
    label: "Restriction 1"
    description: "Yes/No flag indicating drug restriction is enabled"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_RESTRICTION_1_FLAG = 'Y'  ;;
  }

  dimension: drug_short_third_party_restriction_2_flag {
    type: yesno
    label: "Restriction 2 Flag"
    description: "Yes/No flag indicating drug restriction is enabled"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_RESTRICTION_2_FLAG = 'Y'  ;;
  }

  dimension: drug_short_third_party_restriction_3_flag {
    type: yesno
    label: "Restriction 3 Flag"
    description: "Yes/No flag indicating drug restriction is enabled"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_RESTRICTION_3_FLAG = 'Y'  ;;
  }

  dimension: drug_short_third_party_restriction_4_flag {
    type: yesno
    label: "Restriction 4 Flag"
    description: "Yes/No flag indicating drug restriction is enabled"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_RESTRICTION_4_FLAG = 'Y'  ;;
  }

  dimension: drug_short_third_party_restriction_5_flag {
    type: yesno
    label: "Restriction 5 Flag"
    description: "Yes/No flag indicating drug restriction is enabled"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_RESTRICTION_5_FLAG = 'Y'  ;;
  }

  dimension: drug_short_third_party_restriction_6_flag {
    type: yesno
    label: "Restriction 6 Flag"
    description: "Yes/No flag indicating drug restriction is enabled"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_RESTRICTION_6_FLAG = 'Y'  ;;
  }

  dimension: drug_short_third_party_restriction_7_flag {
    type: yesno
    label: "Restriction 7 Flag"
    description: "Yes/No flag indicating drug restriction is enabled"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_RESTRICTION_7_FLAG = 'Y'  ;;
  }

  dimension: drug_short_third_party_restriction_8_flag {
    type: yesno
    label: "Restriction 8 Flag"
    description: "Yes/No flag indicating drug restriction is enabled"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_RESTRICTION_8_FLAG = 'Y'  ;;
  }

  dimension: drug_short_third_party_restriction_9_flag {
    type: yesno
    label: "Restriction 9 Flag"
    description: "Yes/No flag indicating drug restriction is enabled"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_RESTRICTION_9_FLAG = 'Y'  ;;
  }

  dimension: drug_short_third_party_restriction_10_flag {
    type: yesno
    label: "Restriction 10 Flag"
    description: "Yes/No flag indicating drug restriction is enabled"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_RESTRICTION_10_FLAG = 'Y'  ;;
  }

  dimension: drug_short_third_party_restriction_11_flag {
    type: yesno
    label: "Restriction 11 Flag"
    description: "Yes/No flag indicating drug restriction is enabled"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_RESTRICTION_11_FLAG = 'Y'  ;;
  }

  dimension: drug_short_third_party_restriction_12_flag {
    type: yesno
    label: "Restriction 12 Flag"
    description: "Yes/No flag indicating drug restriction is enabled"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_RESTRICTION_12_FLAG = 'Y'  ;;
  }

  dimension: drug_short_third_party_restriction_13_flag {
    type: yesno
    label: "Restriction 13 Flag"
    description: "Yes/No flag indicating drug restriction is enabled"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_RESTRICTION_13_FLAG = 'Y'  ;;
  }

  dimension: drug_short_third_party_restriction_14_flag {
    type: yesno
    label: "Restriction 14 Flag"
    description: "Yes/No flag indicating drug restriction is enabled"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_RESTRICTION_14_FLAG = 'Y'  ;;
  }

  dimension: drug_short_third_party_restriction_15_flag {
    type: yesno
    label: "Restriction 15 Flag"
    description: "Yes/No flag indicating drug restriction is enabled"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_RESTRICTION_15_FLAG = 'Y'  ;;
  }

  dimension: drug_short_third_party_restriction_16_flag {
    type: yesno
    label: "Restriction 16 Flag"
    description: "Yes/No flag indicating drug restriction is enabled"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_RESTRICTION_16_FLAG = 'Y'  ;;
  }

  dimension: drug_short_third_party_deleted {
    type: yesno
    label: "Deleted"
    description: "Yes/No flag indicating drug short TP deleted"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_DELETED = 'Y'  ;;
  }

  measure: sum_drug_short_third_party_mac_cost_amount {
    type: sum
    label: "Total MAC Cost Amount"
    description: "Total MAC per pack"
    sql: ${TABLE}.DRUG_SHORT_THIRD_PARTY_MAC_COST_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: count {
    label: "Total Drug Short TPs"
    description: "Total TPs associated with the Drug"
    type: count
    value_format: "#,##0"
  }
  ################################################################################# Sets###################################################################################

  set: explore_rx_drug_short_tp_4_12_candidate_list {
    fields: [
      chain_id,
      ndc,
      drug_short_third_party_carrier_code,
      drug_short_third_party_plan_code,
      drug_short_third_party_plan_group_code,
      source_system_id,
      drug_short_third_party_generic_code,
      drug_short_third_party_mac_flag,
      drug_short_third_party_otc_flag,
      drug_short_third_party_maintenance_flag,
      drug_short_third_party_ignore_therapeutic_restriction_flag,
      drug_short_third_party_allow_update_flag,
      drug_short_third_party_supported_by_host_flag,
      sum_drug_short_third_party_mac_cost_amount,
      drug_short_third_party_restriction_1_flag,
      drug_short_third_party_restriction_2_flag,
      drug_short_third_party_restriction_3_flag,
      drug_short_third_party_restriction_4_flag,
      drug_short_third_party_restriction_5_flag,
      drug_short_third_party_restriction_6_flag,
      drug_short_third_party_restriction_7_flag,
      drug_short_third_party_restriction_8_flag,
      drug_short_third_party_restriction_9_flag,
      drug_short_third_party_restriction_10_flag,
      drug_short_third_party_restriction_11_flag,
      drug_short_third_party_restriction_12_flag,
      drug_short_third_party_restriction_13_flag,
      drug_short_third_party_restriction_14_flag,
      drug_short_third_party_restriction_15_flag,
      drug_short_third_party_restriction_16_flag,
      drug_short_third_party_deleted,
      drug_short_third_party_last_update,
      drug_short_third_party_last_update_time,
      drug_short_third_party_last_update_date,
      drug_short_third_party_last_update_week,
      drug_short_third_party_last_update_month,
      drug_short_third_party_last_update_month_num,
      drug_short_third_party_last_update_year,
      drug_short_third_party_last_update_quarter,
      drug_short_third_party_last_update_quarter_of_year,
      drug_short_third_party_last_update_hour_of_day,
      drug_short_third_party_last_update_time_of_day,
      drug_short_third_party_last_update_day_of_week,
      drug_short_third_party_last_update_week_of_year,
      drug_short_third_party_last_update_day_of_week_index,
      drug_short_third_party_last_update_day_of_month,
      drug_short_third_party_last_host_update,
      drug_short_third_party_last_host_update_time,
      drug_short_third_party_last_host_update_date,
      drug_short_third_party_last_host_update_week,
      drug_short_third_party_last_host_update_month,
      drug_short_third_party_last_host_update_month_num,
      drug_short_third_party_last_host_update_year,
      drug_short_third_party_last_host_update_quarter,
      drug_short_third_party_last_host_update_quarter_of_year,
      drug_short_third_party_last_host_update_hour_of_day,
      drug_short_third_party_last_host_update_time_of_day,
      drug_short_third_party_last_host_update_day_of_week,
      drug_short_third_party_last_host_update_week_of_year,
      drug_short_third_party_last_host_update_day_of_week_index,
      drug_short_third_party_last_host_update_day_of_month,
      drug_short_third_party_last_used,
      drug_short_third_party_last_used_time,
      drug_short_third_party_last_used_date,
      drug_short_third_party_last_used_week,
      drug_short_third_party_last_used_month,
      drug_short_third_party_last_used_month_num,
      drug_short_third_party_last_used_year,
      drug_short_third_party_last_used_quarter,
      drug_short_third_party_last_used_quarter_of_year,
      drug_short_third_party_last_used_hour_of_day,
      drug_short_third_party_last_used_time_of_day,
      drug_short_third_party_last_used_day_of_week,
      drug_short_third_party_last_used_week_of_year,
      drug_short_third_party_last_used_day_of_week_index,
      drug_short_third_party_last_used_day_of_month,
      drug_short_third_party_last_mac_update,
      drug_short_third_party_last_mac_update_time,
      drug_short_third_party_last_mac_update_date,
      drug_short_third_party_last_mac_update_week,
      drug_short_third_party_last_mac_update_month,
      drug_short_third_party_last_mac_update_month_num,
      drug_short_third_party_last_mac_update_year,
      drug_short_third_party_last_mac_update_quarter,
      drug_short_third_party_last_mac_update_quarter_of_year,
      drug_short_third_party_last_mac_update_hour_of_day,
      drug_short_third_party_last_mac_update_time_of_day,
      drug_short_third_party_last_mac_update_day_of_week,
      drug_short_third_party_last_mac_update_week_of_year,
      drug_short_third_party_last_mac_update_day_of_week_index,
      drug_short_third_party_last_mac_update_day_of_month,
      count
      ]
      }
}
