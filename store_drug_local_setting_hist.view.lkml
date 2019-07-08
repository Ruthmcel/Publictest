view: store_drug_local_setting_hist {
# joined edw.f_drug_local_setting_hist with edw.d_date; to achieve on hand quantity, quantity allocated and other information for each chain, store and drug combination on each day
# it is achieved by performing point in time join (however it will give latest value of a day to be the value on that day)
  derived_table: {
    sql: select *
           from (select calendar_date as snapshot_date,
                        dlsh.*,
                        row_number() over(partition by chain_id,nhin_store_id,drug_id,d.calendar_date order by dlsh.source_timestamp desc) rnk
                   from edw.d_date d
                        left outer join edw.f_drug_local_setting_hist dlsh
                        on ( to_date(dlsh.source_timestamp) <= d.calendar_date )
                  where {% condition chain.chain_id %} dlsh.CHAIN_ID {% endcondition %}
                    and {% condition store.nhin_store_id %} dlsh.NHIN_STORE_ID {% endcondition %}
                    -- [ERXDWPS-1690] Added store_number filter to avoid scanning all chain/store records and minimize data buffer for derived view.
                    and dlsh.nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                                where source_system_id = 5
                                                  and {% condition chain.chain_id %} chain_id {% endcondition %}
                                                  and {% condition store.store_number %} store_number {% endcondition %})
                    and d.calendar_date >= dateadd('year',-2,current_date())  --- this should be replaced with templated filter on calendar_date/snapshot_date
                    and d.calendar_date <= current_date()
                 ) daily_setting
          where  daily_setting.rnk = 1
           ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${drug_id} ||'@'|| ${snapshot_date} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References #####################################################################################################

  dimension: chain_id {
    type: number
    label: "Drug Local Pharmacy Setting Chain ID"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    label: "Drug Local Pharmacy Setting NHIN STORE ID"
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: drug_id {
    type: number
    hidden: yes
    label: "Drug Local Pharmacy Setting Drug ID"
    # one to one relationship with drug
    sql: ${TABLE}.DRUG_ID ;;
  }
  #################################################################################################### Dimensions #####################################################################################################

  dimension: snapshot_date {
    type: date
    #group_label: "Pharmacy Drug"
    sql: ${TABLE}.SNAPSHOT_DATE ;;
  }

  dimension: drug_local_setting_baker_cassette {
    type: number
    label: "Drug Basker Cassette"
    group_label: "Pharmacy Drug"
    description: "The cassette number for a Baker cassette device.  Used by Baker cassette interface"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_BAKER_CASSETTE ;;
  }

  dimension: drug_local_setting_baker_cell {
    type: number
    label: "Drug Baker Cell"
    group_label: "Pharmacy Drug"
    description: "Baker Cell (automated capsule/tablet counter) number for this drug"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_BAKER_CELL ;;
  }

  dimension: drug_local_setting_bay {
    type: string
    label: "Drug Bay"
    group_label: "Pharmacy Drug"
    description: "Bay in which the drug is located"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_BAY ;;
  }

  dimension: drug_local_setting_bin {
    type: string
    label: "Drug Bin"
    group_label: "Pharmacy Drug"
    description: "Bin in which the drug is located"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_BIN ;;
  }

  dimension: drug_local_setting_rack {
    type: string
    label: "Drug Rack"
    group_label: "Pharmacy Drug"
    description: "Rack on which the drug is located"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_RACK ;;
  }

  dimension: drug_local_setting_shelf_location {
    type: string
    label: "Drug Shelf Location"
    group_label: "Pharmacy Drug"
    description: "Shelf on which the drug is located"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_SHELF_LOCATION ;;
  }

  dimension: drug_local_setting_category {
    type: string
    label: "Drug Category"
    group_label: "Pharmacy Drug"
    description: "Code representing a drug category"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_CATEGORY ;;
  }

  dimension: drug_local_setting_class {
    type: string
    label: "Drug Class"
    group_label: "Pharmacy Drug"
    description: "Used to group drug records for reports or processing, such as a therapeutic class"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_CLASS ;;
  }

  dimension: drug_local_setting_drug_image_key {
    type: string
    label: "Drug Image Key"
    group_label: "Pharmacy Drug"
    description: "DIB filename of the drug image associated with this drug record. Populated based on the image selected the last time this product was dispensed at Fill. Displayed as the default image until Fill user selects a different image when this product is dispensed"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_DRUG_IMAGE_KEY ;;
  }

  dimension: drug_local_setting_group_code {
    type: string
    label: "Drug Group Code"
    group_label: "Pharmacy Drug"
    description: "Group of drug for reports"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_GROUP_CODE ;;
  }

  dimension: drug_local_setting_lot_number {
    type: string
    label: "Drug Lot Number"
    group_label: "Pharmacy Drug"
    description: "Number from the bottle given by the manufacturer that identifies the production lot of a given drug"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_LOT_NUMBER ;;
  }

  dimension: drug_local_setting_manufacturer {
    type: string
    label: "Drug Manufacturer"
    group_label: "Pharmacy Drug"
    description: "Name of the drug's manufacturer"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_MANUFACTURER ;;
  }

  dimension: drug_local_setting_subgroup {
    type: string
    label: "Drug Sub Group"
    group_label: "Pharmacy Drug"
    description: "Code representing a sub grouping of drugs"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_SUBGROUP ;;
  }

  dimension: deleted {
    hidden: yes
    type: string
    label: "Drug Local Pharmacy Setting Deleted"
    group_label: "Pharmacy Drug"
    # Y/N flag as in database is used so a customer can update the record accordingly, if this entity is consumed as-is to the customer
    description: "Y/N Flag indicating if the drug local setting was deleted from the source system"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_DELETED ;;
  }

  ########################################################################################################### DATE/TIME specific Fields ################################################################################

  dimension_group: drug_local_setting_discontinue {
    label: "Drug Discontinue"
    description: "Date/Time to discontinue use of this drug"
    type: time
    timeframes: [
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
      day_of_month
    ]
    sql: ${TABLE}.DRUG_LOCAL_SETTING_DISCONTINUE_DATE ;;
  }

  dimension_group: drug_local_setting_expiration {
    label: "Drug Expiration"
    description: "Date/Time this drug's effectiveness expires (from the medication stock bottle)"
    type: time
    timeframes: [
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
      day_of_month
    ]
    sql: ${TABLE}.DRUG_LOCAL_SETTING_EXPIRATION_DATE ;;
  }

  dimension_group: drug_local_setting_image_imprint_start {
    label: "Drug Image Imprint Start"
    description: "Date/Time that the drug's imprint or image became available"
    type: time
    timeframes: [
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
      day_of_month
    ]
    sql: ${TABLE}.DRUG_LOCAL_SETTING_IMAGE_IMPRINT_START_DATE ;;
  }

  dimension_group: drug_local_setting_last_count {
    label: "Drug Last Count"
    description: "Date/Time which holds the last time the drug was counted."
    type: time
    timeframes: [
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
      day_of_month
    ]
    sql: ${TABLE}.DRUG_LOCAL_SETTING_LAST_COUNT_DATE ;;
  }

  dimension_group: drug_local_setting_last_dib_sync {
    label: "Drug Last DIB Sync"
    description: "Date/Time the Drug was last updated by a DIB update"
    type: time
    timeframes: [
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
      day_of_month
    ]
    sql: ${TABLE}.DRUG_LOCAL_SETTING_LAST_DIB_SYNC_DATE ;;
  }

  dimension_group: drug_local_setting_last_fill {
    label: "Drug Last Fill Rx"
    description: "Date/Time this record was last used to fill a prescription"
    type: time
    timeframes: [
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
      day_of_month
    ]
    sql: ${TABLE}.DRUG_LOCAL_SETTING_LAST_FILL_DATE ;;
  }

  ########################################################################################################### YES/NO fields ###############################################################################################

  dimension: drug_local_setting_auto_dispense {
    label: "Drug Auto Dispense"
    group_label: "Pharmacy Drug"
    description: "Yes/No Flag indicating if the drug is available in an automatic filling system"
    type: yesno
    sql: ${TABLE}.DRUG_LOCAL_SETTING_AUTO_DISPENSE = 'Y' ;;
  }

  dimension: drug_local_setting_manual_acquisition_drug {
    label: "Drug Manual Acquisition"
    group_label: "Pharmacy Drug"
    description: "Yes/No Flag indicating if this drug as a Manual ACQ Drug so that when dispensed, different pricing logic is applied in order to use a lower ACQ than what is currently on the drug"
    type: yesno
    sql: ${TABLE}.DRUG_LOCAL_SETTING_MANUAL_ACQUISITION_DRUG = 'Y' ;;
  }

  dimension: drug_local_setting_use_local_quantity_first {
    label: "Drug Use Local Quantity First"
    group_label: "Pharmacy Drug"
    description: "Yes/No Flag EPS should force a local fill of the drug if the drug was previously returned to stock from Central Fill"
    type: yesno
    sql: ${TABLE}.DRUG_LOCAL_SETTING_USE_LOCAL_QUANTITY_FIRST = 'Y' ;;
  }

  ################################################################################################ SQL Case When Fields (Suggestions) ###############################################################################################

  dimension: drug_local_setting_nursing_home_hold {
    type: string
    label: "Drug Nursing Home Hold Flag"
    group_label: "Pharmacy Drug"
    description: "Value which designates the NDC's DESI status, which is used to determine if a drug is effective, ineffective, or needing further study"

    case: {
      when: {
        sql: ${TABLE}.DRUG_LOCAL_SETTING_NURSING_HOME_HOLD = 'B' ;;
        label: "BATCH"
      }

      when: {
        sql: ${TABLE}.DRUG_LOCAL_SETTING_NURSING_HOME_HOLD = 'M' ;;
        label: "MAR"
      }

      when: {
        sql: ${TABLE}.DRUG_LOCAL_SETTING_NURSING_HOME_HOLD = 'Y' ;;
        label: "BOTH"
      }

      when: {
        sql: ${TABLE}.DRUG_LOCAL_SETTING_NURSING_HOME_HOLD = 'N' ;;
        label: "NO HOLD"
      }
    }
  }

  dimension: drug_local_setting_unavailable_locally {
    type: string
    label: "Drug Unavailable Locally"
    group_label: "Pharmacy Drug"
    description: "Flag that determines whether the drug can be dispensed locally"

    case: {
      when: {
        sql: ${TABLE}.DRUG_LOCAL_SETTING_UNAVAILABLE_LOCALLY = 'Y' ;;
        label: "FULFILLMENT FACILITY ONLY"
      }

      when: {
        sql: ${TABLE}.DRUG_LOCAL_SETTING_UNAVAILABLE_LOCALLY = 'N' ;;
        label: "AVAILABLE LOCALLY"
      }

      when: {
        sql: ${TABLE}.DRUG_LOCAL_SETTING_UNAVAILABLE_LOCALLY = 'B' ;;
        label: "BOTH"
      }
    }
  }

  dimension: drug_local_setting_on_hand {
    type: number
    # Used as a templated filter
    hidden: yes
    label: "Total Drug On Hand Quantity"
    group_label: "Pharmacy Drug"
    description: "On-hand inventory that shows how much of the drug is in the pharmacy"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_ON_HAND ;;
    value_format: "###0.0000"
  }

  ####################################################################################################### End of Dimension #################################################################################################################

  ####################################################################################################### Measures #################################################################################################################

  measure: sum_drug_local_setting_on_hand {
    type: sum
    label: "Total Drug On Hand Quantity"
    group_label: "Pharmacy Drug"
    description: "On-hand inventory that shows how much of the drug is in the pharmacy"
    sql: ${drug_local_setting_on_hand} ;;
    value_format: "#,##0.0000"
    drill_fields: [drug_on_hand_quantity_detail*]
  }

  measure: sum_drug_local_setting_quantity_allocated {
    type: sum
    label: "Total Drug Quantity Allocated"
    group_label: "Pharmacy Drug"
    description: "Amount of the drug that has been allocated by Data Entry"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_QUANTITY_ALLOCATED ;;
    value_format: "#,##0.0000"
  }

  measure: sum_drug_local_setting_returned_quantity {
    type: sum
    label: "Total Drug Returned Quantity"
    group_label: "Pharmacy Drug"
    description: "Captures the quantity of a drug that is returned to stock"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_RETURNED_QUANTITY ;;
    value_format: "#,##0.0000"
  }

  measure: sum_drug_local_setting_acquisition_cost {
    type: sum
    label: "Total Drug ACQ Cost (per pack)"
    group_label: "Pharmacy Drug"
    description: "True acquisition cost per pack for the stock that you have on the shelf"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_ACQUISITION_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ##################################################################################### Templated Filters (Applied only for measures (so it could be applied in WHERE instead of HAVING clause ##############################################
  filter: drug_local_setting_on_hand_filter {
    label: "Total Drug On Hand Quantity"
    group_label: "Pharmacy Drug"
    description: "On-hand inventory that shows how much of the drug is in the pharmacy"
    type: number
    sql: {% condition drug_local_setting_on_hand_filter %} ${drug_local_setting_on_hand} {% endcondition %}
      ;;
  }

  set: drug_on_hand_quantity_detail {
    fields: [
      chain.chain_name,
      store_alignment.division,
      store_alignment.region,
      store_alignment.district,

      #Changes made w.r.t ERXLPS-126
      store.store_number,
      store.store_name,
      store.store_city,
      store.store_state,
      store_drug.ndc,
      store_drug.drug_name,
      store_drug_local_setting.sum_drug_local_setting_on_hand,
      store_drug_local_setting.sum_drug_local_setting_on_hand_cost
    ]
  }

  set: explore_rx_4_11_drug_local_setting_hist {
    fields: [
      snapshot_date,
      drug_local_setting_baker_cell,
      drug_local_setting_bin,
      drug_local_setting_rack,
      drug_local_setting_shelf_location,
      drug_local_setting_category,
      drug_local_setting_class,
      drug_local_setting_drug_image_key,
      drug_local_setting_group_code,
      drug_local_setting_lot_number,
      drug_local_setting_manufacturer,
      drug_local_setting_subgroup,
      deleted,
      drug_local_setting_auto_dispense,
      drug_local_setting_manual_acquisition_drug,
      drug_local_setting_use_local_quantity_first,
      drug_local_setting_nursing_home_hold,
      drug_local_setting_unavailable_locally,
      drug_local_setting_on_hand,
      sum_drug_local_setting_on_hand,
      sum_drug_local_setting_quantity_allocated,
      sum_drug_local_setting_returned_quantity,
      sum_drug_local_setting_acquisition_cost,
      drug_local_setting_on_hand_filter,
      drug_local_setting_discontinue,
      drug_local_setting_discontinue_date,
      drug_local_setting_discontinue_week,
      drug_local_setting_discontinue_month,
      drug_local_setting_discontinue_month_num,
      drug_local_setting_discontinue_year,
      drug_local_setting_discontinue_quarter,
      drug_local_setting_discontinue_quarter_of_year,
      drug_local_setting_discontinue_hour_of_day,
      drug_local_setting_discontinue_time_of_day,
      drug_local_setting_discontinue_day_of_week,
      drug_local_setting_discontinue_week_of_year,
      drug_local_setting_discontinue_day_of_week_index,
      drug_local_setting_discontinue_day_of_month,
      drug_local_setting_expiration,
      drug_local_setting_expiration_date,
      drug_local_setting_expiration_week,
      drug_local_setting_expiration_month,
      drug_local_setting_expiration_month_num,
      drug_local_setting_expiration_year,
      drug_local_setting_expiration_quarter,
      drug_local_setting_expiration_quarter_of_year,
      drug_local_setting_expiration_hour_of_day,
      drug_local_setting_expiration_time_of_day,
      drug_local_setting_expiration_day_of_week,
      drug_local_setting_expiration_week_of_year,
      drug_local_setting_expiration_day_of_week_index,
      drug_local_setting_expiration_day_of_month,
      drug_local_setting_image_imprint_start,
      drug_local_setting_image_imprint_start_date,
      drug_local_setting_image_imprint_start_week,
      drug_local_setting_image_imprint_start_month,
      drug_local_setting_image_imprint_start_month_num,
      drug_local_setting_image_imprint_start_year,
      drug_local_setting_image_imprint_start_quarter,
      drug_local_setting_image_imprint_start_quarter_of_year,
      drug_local_setting_image_imprint_start_hour_of_day,
      drug_local_setting_image_imprint_start_time_of_day,
      drug_local_setting_image_imprint_start_day_of_week,
      drug_local_setting_image_imprint_start_week_of_year,
      drug_local_setting_image_imprint_start_day_of_week_index,
      drug_local_setting_image_imprint_start_day_of_month,
      drug_local_setting_last_count,
      drug_local_setting_last_count_date,
      drug_local_setting_last_count_week,
      drug_local_setting_last_count_month,
      drug_local_setting_last_count_month_num,
      drug_local_setting_last_count_year,
      drug_local_setting_last_count_quarter,
      drug_local_setting_last_count_quarter_of_year,
      drug_local_setting_last_count_hour_of_day,
      drug_local_setting_last_count_time_of_day,
      drug_local_setting_last_count_day_of_week,
      drug_local_setting_last_count_week_of_year,
      drug_local_setting_last_count_day_of_week_index,
      drug_local_setting_last_count_day_of_month,
      drug_local_setting_last_dib_sync,
      drug_local_setting_last_dib_sync_date,
      drug_local_setting_last_dib_sync_week,
      drug_local_setting_last_dib_sync_month,
      drug_local_setting_last_dib_sync_month_num,
      drug_local_setting_last_dib_sync_year,
      drug_local_setting_last_dib_sync_quarter,
      drug_local_setting_last_dib_sync_quarter_of_year,
      drug_local_setting_last_dib_sync_hour_of_day,
      drug_local_setting_last_dib_sync_time_of_day,
      drug_local_setting_last_dib_sync_day_of_week,
      drug_local_setting_last_dib_sync_week_of_year,
      drug_local_setting_last_dib_sync_day_of_week_index,
      drug_local_setting_last_dib_sync_day_of_month,
      drug_local_setting_last_fill,
      drug_local_setting_last_fill_date,
      drug_local_setting_last_fill_week,
      drug_local_setting_last_fill_month,
      drug_local_setting_last_fill_month_num,
      drug_local_setting_last_fill_year,
      drug_local_setting_last_fill_quarter,
      drug_local_setting_last_fill_quarter_of_year,
      drug_local_setting_last_fill_hour_of_day,
      drug_local_setting_last_fill_time_of_day,
      drug_local_setting_last_fill_day_of_week,
      drug_local_setting_last_fill_week_of_year,
      drug_local_setting_last_fill_day_of_week_index,
      drug_local_setting_last_fill_day_of_month,
      drug_local_setting_baker_cassette, #[ERXLPS-1566]
      drug_local_setting_bay #[ERXLPS-1566]
    ]
  }
}
