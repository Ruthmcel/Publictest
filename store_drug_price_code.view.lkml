view: store_drug_price_code {
  #[ERXLPS-1051] - Added only the required dimensions to get prescription transaction price code information.
  label: "Drug Price Code"
  sql_table_name: EDW.D_STORE_PRICE_CODE ;;

  dimension: primary_key {
    hidden: yes
    type: string
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${price_code_id} ;; #ERXLPS-1649
  }

  ################################################################# Foreign Key refresnces ############################################

  dimension: chain_id {
    type: number
    hidden: yes
    label: "Chain ID"
    description: "CHAIN_ID is a unique assigned ID number for each customer chain"
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    type: number
    hidden: yes
    label: "Nhin Store ID"
    description: "NHIN account number which uniquely identifies the store with NHIN"
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: price_code_id {
    type: number
    hidden: yes
    label: "Drug Price Code ID"
    description: "Unique ID number identifying each record in this table"
    sql: ${TABLE}.PRICE_CODE_ID ;;
  }

  dimension: source_system_id {
    type: number
    hidden: yes
    label: "Source System ID"
    description: "Unique ID number identifying an BI source system"
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: drug_cost_type_id {
    type: number
    hidden: yes
    label: "Drug Cost Type ID"
    description: "Unique ID of a record in the DRUG_COST_TYPE table which indicates the cost base to use. Set by the user who creates the price code on the host or the EPS application. This is a drop down list that is system generated based on the available cost bases."
    sql: ${TABLE}.DRUG_COST_TYPE_ID ;;
  }

  dimension: alternate_drug_cost_type_id {
    type: number
    hidden: yes
    label: "Alternate Drug Cost Type ID"
    description: "Unique ID of a record in the ALT_DRUG_COST_TYPE table which indicates the alternate cost base to use. Set by the user who creates the price code on the host or the EPS application."
    sql: ${TABLE}.ALTERNATE_DRUG_COST_TYPE_ID ;;
  }

  dimension: tax_id {
    type: number
    hidden: yes
    label: "Tax ID"
    description: "Unique ID of a TAX table that this record is linked to. Set by the user who creates the price code on the host or the EPS application"
    sql: ${TABLE}.TAX_ID ;;
  }

  dimension: basecost_id {
    type: number
    hidden: yes
    label: "Basecost ID"
    description: "Unique ID of a record in the BASECOST table which indicates how the cost base used in this price code should be calculated. Set by the user who creates the price code on the host or the EPS application."
    sql: ${TABLE}.BASECOST_ID ;;
  }

  dimension: rounding_id {
    type: number
    hidden: yes
    label: "Rounding ID"
    description: "Unique ID of a record in the ROUNDING table which indicates how the price code will round the final price of the prescription.  Set by the user who creates the price code on the host or the EPS application."
    sql: ${TABLE}.ROUNDING_ID ;;
  }


  ######################################################################### dimensions #####################################################
  #[ERXLPS-2448] - Populating price reion from store_setting table. Modified datatype from number to string.
  dimension: price_code_region {
    type: string
    label: "Drug Price Code Region"
    description: "Pharmacy Drug Price Region. Price Region value setup in Store Settings. EPS Table Name: STORE_SETTINGS."
    sql: ${store_setting_price_code_region.store_setting_value} ;;
  }

  dimension: price_code {
    type: string
    label: "Drug Price Code"
    description: "User defined code that identifies the price code record. This field is set on the host when the price code updates are applied to the EPS server. This field can also be set by a store user who has access to create a price code. May not be one of the following characters: *, $, or + May be up to three characters long."
    sql: ${TABLE}.PRICE_CODE ;;
  }

  dimension: price_code_type {
    type: string
    label: "Drug Price Code Type"
    description: "Indicates what the Cost column in the Price Code Values table represents. This field is set on the host when the price code updates are applied to the EPS server.  This field can also be set by a store user who has access to create a price code."
    sql: CASE WHEN ${TABLE}.PRICE_CODE_TYPE = '0' THEN 'COST'
              WHEN ${TABLE}.PRICE_CODE_TYPE = '1' THEN 'QUANTITY'
              WHEN ${TABLE}.PRICE_CODE_TYPE = '2' THEN 'DAY SUPPLY'
              WHEN ${TABLE}.PRICE_CODE_TYPE = '3' THEN 'QTY-PRICE'
              WHEN ${TABLE}.PRICE_CODE_TYPE = '4' THEN 'UNIT COST'
              ELSE TO_CHAR(${TABLE}.PRICE_CODE_TYPE)
         END ;;
  }

  dimension: price_code_description {
    type: string
    label: "Drug Price Code Description"
    description: "Free-format name for the price record. This field is set on the host when the price code updates are applied to the EPS server. This field can also be set by a store user who has access to create a price code."
    sql: ${TABLE}.PRICE_CODE_DESCRIPTION ;;
  }

  dimension: price_code_low_cost_flag {
    type: yesno
    label: "Drug Price Code Low Cost"
    description: "Yes/No Flag indicating whether to compare the costs calculated using the DRUG_COST_TYPE and the ALT_DRUG_COST_TYPE and then use the lower of the two. Set by the user who creates the price code on the host or the EPS application."
    sql: ${TABLE}.PRICE_CODE_LOW_COST_FLAG = 'Y' ;;
  }

  dimension: price_code_cost_precentabe {
    type: number
    label: "Drug Price Code Cost Percentage"
    description: "Percentage of cost base to use to calculate cost for price. Set by the user who creates the price code on the host or the EPS application"
    sql: ${TABLE}.PRICE_CODE_COST_PERCENTAGE ;;
  }

  dimension: price_code_minimum_amount {
    type: number
    label: "Drug Price Code Minimum Amount"
    description: "Minimum price you want for any prescription priced using this record. Set by the user who creates the price code on the host or the EPS application."
    sql: ${TABLE}.PRICE_CODE_MINIMUM_AMOUNT ;;
  }

  dimension: price_code_round_amount {
    type: number
    label: "Drug Price Code Round Amount"
    description: "Field that determines how the system rounds the price. Set by the user who creates the price code on the host or the EPS application."
    sql: ${TABLE}.PRICE_CODE_ROUND_AMOUNT ;;
  }

  dimension: price_code_generic_percentage {
    type: number
    label: "Drug Price Code Generic Percentage"
    description: "Percent of the brand drug's retail price that is to be used to price a substitute drug. Set by the user who creates the price code on the host or the EPS application."
    sql: ${TABLE}.PRICE_CODE_GENERIC_PERCENTAGE ;;
  }

  dimension: price_code_bubble_fee {
    type: number
    label: "Drug Price Code Bubble Fee"
    description: "An additional fee charged as a bubble fee for nursing home unit dose prescriptions. Set by the user who creates the price code on the host or the EPS application."
    sql: ${TABLE}.PRICE_CODE_BUBBLE_FEE ;;
  }

  dimension: price_code_fee_first_flag {
    type: yesno
    label: "Drug Price Code Fee First"
    description: "Yes/No Flag that tells the system in what order to use the % Markup and $ Fee columns of the PRICE CODE VALUES table on this record. Set by the user who creates the price code on the host or the EPS application."
    sql: ${TABLE}.PRICE_CODE_FEE_FIRST_FLAG = 'Y' ;;
  }

  dimension: price_code_interpolate_flag {
    type: yesno
    label: "Drug Price Code Interpolate"
    description: "Yes/No Flag indicating how the system uses the variable fee table. Set by the user who creates the price code on the host or the EPS application."
    sql: ${TABLE}.PRICE_CODE_INTERPOLATE_FLAG = 'Y' ;;
  }

  dimension: price_code_allow_override_flag {
    type: yesno
    label: "Drug Price Code Allow Override"
    description: "Yes/No Flag indicating if the system lets the user override the price that the system calculated for the prescription during data entry. Set by the user who creates the price code on the host or the EPS application."
    sql: ${TABLE}.PRICE_CODE_ALLOW_OVERRIDE_FLAG = 'Y' ;;
  }

  dimension: price_code_allow_competitive_pricing_flag {
    type: yesno
    label: "Drug Price Code Allow Competitive Pricing"
    description: "Yes/No Flag indicating if the competitive zone pricing setup in the DRUG COMPETITIVE PRICING table can override a price calculated by this price record. Set by the user who creates the price code on the host or the EPS application."
    sql: ${TABLE}.PRICE_CODE_ALLOW_COMPETITIVE_PRICING_FLAG = 'Y' ;;
  }

  dimension: price_code_sig_dose_flag {
    type: yesno
    label: "Drug Price Code SIG Code"
    description: "Yes/No Flag indicating how the system calculates the unit dose fee.  Set by the user who creates the price code on the host or the EPS application."
    sql: ${TABLE}.PRICE_CODE_SIG_DOSE_FLAG = 'Y' ;;
  }

  dimension: price_code_group_code {
    type: string
    label: "Drug Price Code Group Code"
    description: "Field used to group Price record for reporting purposes. Set by the user who creates the price code on the host or the EPS application."
    sql: ${TABLE}.PRICE_CODE_GROUP_CODE ;;
  }

  dimension: price_code_discount_flag {
    type: yesno
    label: "Drug Price Code Discount"
    description: "Yes/No Flag indicating if the system allows patient discounts from the patient's record when using this price code. Set by the user who creates the price code on the host or the EPS application."
    sql: ${TABLE}.PRICE_CODE_DISCOUNT_FLAG = 'Y' ;;
  }

  dimension: price_code_tax_exempt_flag {
    type: yesno
    label: "Drug Price Code Tax Exempt"
    description: "Yes/No Flag indicating that when this price code is used that no tax will be calculated on the prescription. Set by the user who creates the price code on the host or the EPS application."
    sql: ${TABLE}.PRICE_CODE_TAX_EXEMPT_FLAG = 'Y' ;;
  }

  dimension: price_code_allow_reference_Pricing_flag {
    type: yesno
    label: "Drug Price Code Allow Reference Pricing"
    description: "Yes/No Flag indicting if the price code can use reference pricing or not. Set by the user who creates the price code on the host or the EPS application."
    sql: ${TABLE}.PRICE_CODE_ALLOW_REFERENCE_PRICING_FLAG = 'Y' ;;
  }

  #[ERXLPS-946] - Added price_code_deleted dimension to use it in join conditions.
  dimension: price_code_deleted{
    type: string
    hidden: yes
    label: "Drug Price Code Deleted"
    description: "Price code deleted(Y/N)"
    sql: ${TABLE}.PRICE_CODE_DELETED ;;
  }

  ############################################# Date dimensions ##########################################
  dimension_group: store_price_code_source_timestamp {
    label: "Drug Price Code Last Update"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    description: "Date/Time at which the record was last updated in the source application."
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  dimension_group: store_price_code_source_create_timestamp {
    label: "Drug Price Code Source Create"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,week_of_year,day_of_week_index,day_of_month]
    description: "Date/Time the record was created in source table."
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  ############################################### Measures #######################################################
  measure: store_drug_price_count {
    label: "Drug Price Code Count"
    description: "Drug Price Code Count."
    type: count
  }
}
