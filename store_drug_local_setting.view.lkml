view: store_drug_local_setting {
  sql_table_name: EDW.F_DRUG_LOCAL_SETTING ;;

  dimension: drug_id {
    type: number
    hidden: yes
    label: "Drug Local Pharmacy Setting Drug ID"
    # one to one relationship with drug
    sql: ${TABLE}.DRUG_ID ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${drug_id} ;; #ERXLPS-1649
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

  #################################################################################################### Dimensions #####################################################################################################

  dimension: drug_local_setting_baker_cassette {
    type: number
    label: "Drug Basker Cassette"
    description: "The cassette number for a Baker cassette device.  Used by Baker cassette interface"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_BAKER_CASSETTE ;;
  }

  dimension: drug_local_setting_baker_cell {
    type: number
    label: "Drug Baker Cell"
    description: "Baker Cell (automated capsule/tablet counter) number for this drug"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_BAKER_CELL ;;
  }

  dimension: drug_local_setting_bay {
    type: string
    label: "Drug Bay"
    description: "Bay in which the drug is located"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_BAY ;;
  }

  dimension: drug_local_setting_bin {
    type: string
    label: "Drug Bin"
    description: "Bin in which the drug is located"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_BIN ;;
  }

  dimension: drug_local_setting_rack {
    type: string
    label: "Drug Rack"
    description: "Rack on which the drug is located"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_RACK ;;
  }

  dimension: drug_local_setting_shelf_location {
    type: string
    label: "Drug Shelf Location"
    description: "Shelf on which the drug is located"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_SHELF_LOCATION ;;
  }

  dimension: drug_local_setting_category {
    type: string
    label: "Drug Category"
    description: "Code representing a drug category"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_CATEGORY ;;
  }

  dimension: drug_local_setting_class {
    type: string
    label: "Drug Class"
    description: "Used to group drug records for reports or processing, such as a therapeutic class"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_CLASS ;;
  }

  dimension: drug_local_setting_drug_image_key {
    type: string
    label: "Drug Image Key"
    description: "DIB filename of the drug image associated with this drug record. Populated based on the image selected the last time this product was dispensed at Fill. Displayed as the default image until Fill user selects a different image when this product is dispensed"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_DRUG_IMAGE_KEY ;;
  }

  dimension: drug_local_setting_group_code {
    type: string
    label: "Drug Group Code"
    description: "Group of drug for reports"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_GROUP_CODE ;;
  }

  dimension: drug_local_setting_lot_number {
    type: string
    label: "Drug Lot Number"
    description: "Number from the bottle given by the manufacturer that identifies the production lot of a given drug"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_LOT_NUMBER ;;
  }

  dimension: drug_local_setting_manufacturer {
    type: string
    label: "Drug Manufacturer"
    description: "Name of the drug's manufacturer"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_MANUFACTURER ;;
  }

  dimension: drug_local_setting_subgroup {
    type: string
    label: "Drug Sub Group"
    description: "Code representing a sub grouping of drugs"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_SUBGROUP ;;
  }

  dimension: deleted {
    hidden: yes
    type: string
    label: "Drug Local Pharmacy Setting Deleted"
    # Y/N flag as in database is used so a customer can update the record accordingly, if this entity is consumed as-is to the customer
    description: "Y/N Flag indicating if the drug local setting was deleted from the source system"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_DELETED ;;
  }

  ########################################################################################################### DATE/TIME specific Fields ################################################################################

  dimension_group: drug_local_setting_discontinue {
    label: "Drug Discontinue"
    description: "Date to discontinue use of this drug"
    type: time
    sql: ${TABLE}.DRUG_LOCAL_SETTING_DISCONTINUE_DATE ;;
  }

  dimension_group: drug_local_setting_expiration {
    label: "Drug Expiration"
    description: "Date this drug's effectiveness expires (from the medication stock bottle)"
    type: time
    sql: ${TABLE}.DRUG_LOCAL_SETTING_EXPIRATION_DATE ;;
  }

  dimension_group: drug_local_setting_image_imprint_start {
    label: "Drug Image Imprint Start"
    description: "Date that the drug's imprint or image became available"
    type: time
    sql: ${TABLE}.DRUG_LOCAL_SETTING_IMAGE_IMPRINT_START_DATE ;;
  }

  dimension_group: drug_local_setting_last_count {
    label: "Drug Last Count"
    description: "Date which holds the last time the drug was counted."
    type: time
    sql: ${TABLE}.DRUG_LOCAL_SETTING_LAST_COUNT_DATE ;;
  }

  dimension_group: drug_local_setting_last_dib_sync {
    label: "Drug Last DIB Sync"
    description: "Date the Drug was last updated by a DIB update"
    type: time
    sql: ${TABLE}.DRUG_LOCAL_SETTING_LAST_DIB_SYNC_DATE ;;
  }

  dimension_group: drug_local_setting_last_fill {
    label: "Drug Last Fill Rx"
    description: "Date this record was last used to fill a prescription"
    type: time
    sql: ${TABLE}.DRUG_LOCAL_SETTING_LAST_FILL_DATE ;;
  }

  dimension_group: drug_local_setting_source_create {
    label: "Drug Local Setting Source Create"
    description: "Date and time at which the record was created in the source application"
    type: time
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  ########################################################################################################### YES/NO fields ###############################################################################################

  dimension: drug_local_setting_auto_dispense {
    label: "Drug Auto Dispense"
    description: "Yes/No Flag indicating if the drug is available in an automatic filling system"
    type: yesno
    sql: ${TABLE}.DRUG_LOCAL_SETTING_AUTO_DISPENSE = 'Y' ;;
  }

  dimension: drug_local_setting_manual_acquisition_drug {
    label: "Drug Manual Acquisition"
    description: "Yes/No Flag indicating if this drug as a Manual ACQ Drug so that when dispensed, different pricing logic is applied in order to use a lower ACQ than what is currently on the drug"
    type: yesno
    sql: ${TABLE}.DRUG_LOCAL_SETTING_MANUAL_ACQUISITION_DRUG = 'Y' ;;
  }

  dimension: drug_local_setting_use_local_quantity_first {
    label: "Drug Use Local Quantity First"
    description: "Yes/No Flag EPS should force a local fill of the drug if the drug was previously returned to stock from Central Fill"
    type: yesno
    sql: ${TABLE}.DRUG_LOCAL_SETTING_USE_LOCAL_QUANTITY_FIRST = 'Y' ;;
  }

  ################################################################################################ SQL Case When Fields (Suggestions) ###############################################################################################

  dimension: drug_local_setting_nursing_home_hold {
    type: string
    label: "Drug Nursing Home Hold Flag"
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
    description: "On-hand inventory that shows how much of the drug is in the pharmacy"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_ON_HAND ;;
    value_format: "###0.0000"
  }

  dimension: drug_local_setting_returned_quantity_allocated {
    type: number
    hidden: yes
    label: "Total Drug Returned Quantity Allocated"
    description: "The quantity of the drug that is been allocated from returned quantity."
    sql: ${TABLE}.DRUG_LOCAL_SETTING_RETURNED_QUANTITY_ALLOCATED ;;
    value_format: "#,##0.00"
  }

  ####################################################################################################### End of Dimension #################################################################################################################

  ####################################################################################################### Measures #################################################################################################################

  measure: sum_drug_local_setting_on_hand {
    type: sum
    label: "Total Drug On Hand Quantity"
    description: "On-hand inventory that shows how much of the drug is in the pharmacy"
    sql: ${drug_local_setting_on_hand} ;;
    value_format: "#,##0.0000"
    drill_fields: [drug_on_hand_quantity_detail*]
  }

  measure: sum_drug_local_setting_returned_quantity_allocated {
    type: sum
    label: "Total Drug Returned Quantity Allocated"
    description: "The quantity of the drug that is been allocated from returned quantity."
    sql: ${drug_local_setting_returned_quantity_allocated} ;;
    value_format: "#,##0.0000"
  }

  measure: sum_drug_local_setting_on_hand_demo {
    type: sum
    label: "Total Drug On Hand Quantity"
    description: "On-hand inventory that shows how much of the drug is in the pharmacy"
    sql: ${drug_local_setting_on_hand} ;;
    value_format: "#,##0.0000"
    drill_fields: [drug_on_hand_quantity_demo_detail*]
  }

  measure: sum_drug_local_setting_on_hand_cost {
    type: sum
    label: "Total Drug On Hand Cost"
    description: "Dollar value is based on the current ACQ in the system at the time the report is run. Calcuation Used: ((Acquisition Cost (per pack size)/Drug Pack)*On Hand Quantity)"
    sql: ((${store_drug_cost_pivot.acq_cost_amount}/NULLIF(${store_drug.drug_pack},0))*${drug_local_setting_on_hand}) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_drug_local_setting_quantity_allocated {
    type: sum
    label: "Total Drug Quantity Allocated"
    description: "Amount of the drug that has been allocated by Data Entry"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_QUANTITY_ALLOCATED ;;
    value_format: "#,##0.0000"
  }

  measure: sum_drug_local_setting_returned_quantity {
    type: sum
    label: "Total Drug Returned Quantity"
    description: "Captures the quantity of a drug that is returned to stock"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_RETURNED_QUANTITY ;;
    value_format: "#,##0.0000"
  }

  measure: sum_drug_local_setting_acquisition_cost {
    type: sum
    label: "Total Drug ACQ Cost (per pack)"
    description: "True acquisition cost per pack for the stock that you have on the shelf"
    sql: ${TABLE}.DRUG_LOCAL_SETTING_ACQUISITION_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ##################################################################################### Templated Filters (Applied only for measures (so it could be applied in WHERE instead of HAVING clause ##############################################
  filter: drug_local_setting_on_hand_filter {
    label: "Total Drug On Hand Quantity"
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

  set: drug_on_hand_quantity_demo_detail {
    fields: [
      bi_demo_chain.chain_name,
      bi_demo_region.division,
      bi_demo_region.region,
      bi_demo_region.district,
      bi_demo_store.store_number,
      bi_demo_store.store_name,
      bi_demo_store_state_location.store_zip_code_primary_city,
      bi_demo_store_state_location.state_abbreviation,
      store_drug.ndc,
      store_drug.drug_name,
      store_drug_local_setting.sum_drug_local_setting_on_hand_demo,
      store_drug_local_setting.sum_drug_local_setting_on_hand_cost
    ]
  }
}
