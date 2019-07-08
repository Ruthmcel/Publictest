view: store_prescriber {
  label: "Store Prescriber"
  sql_table_name: EDW.D_STORE_PRESCRIBER ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${store_prescriber_id} || '@' || ${source_system_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: PRESCRIBER"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: PRESCRIBER"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: store_prescriber_id {
    label: "Store Prescriber Id"
    description: "Unique Id number identifying this record. EPS Table: PRESCRIBER"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PRESCRIBER_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    description: "Unique ID number identifying a BI source system. EPS Table: PRESCRIBER"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: store_prescriber_last_name {
    label: "Store Prescriber Last Name"
    description: "Prescriber's last name. EPS Table: PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_LAST_NAME ;;
  }

  dimension: store_prescriber_first_name {
    label: "Store Prescriber First Name"
    description: "Prescriber's first name. EPS Table: PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_FIRST_NAME ;;
  }

  dimension: store_prescriber_middle_name {
    label: "Store Prescriber Middle Name"
    description: "Prescriber's middle name. EPS Table: PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_MIDDLE_NAME ;;
  }

  dimension: store_prescriber_dea_number {
    label: "Store Prescriber Dea Number"
    description: "ID assigned to a Prescriber by the Drug Enforcement Agency (DEA) and is unique to a prescriber within a specific state in which they prescribe. Prescribers at an institution will be assigned a DEA Suffix and then combined with the DEA Number of the institution. EPS Table: PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_DEA_NUMBER ;;
  }

  dimension: store_prescriber_daw_code {
    label: "Store Prescriber Daw Code"
    description: "Default Dispense as Written Code (DAW) code to use when filling prescriptions written by prescriber. EPS Table: PRESCRIBER"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_PRESCRIBER_DAW_CODE is null THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PRESCRIBER_DAW_CODE = '0' THEN '0 - ALLOW SUBSTITUTION'
              WHEN ${TABLE}.STORE_PRESCRIBER_DAW_CODE = '1' THEN '1 - DISPENSE AS WRITTEN'
              WHEN ${TABLE}.STORE_PRESCRIBER_DAW_CODE = '2' THEN '2 - SUBSTITUTION ALLOWED- PATIENT REQUESTED'
              WHEN ${TABLE}.STORE_PRESCRIBER_DAW_CODE = '3' THEN '3 - SUBSTITUTION ALLOWED - PHARMACIST SELECTED'
              WHEN ${TABLE}.STORE_PRESCRIBER_DAW_CODE = '4' THEN '4 - SUBSTITUTION ALLOWED- GENERIC NOT IN STOCK'
              WHEN ${TABLE}.STORE_PRESCRIBER_DAW_CODE = '5' THEN '5 - SUBSTITUTION ALLOWED- BRAND AS GENERIC'
              WHEN ${TABLE}.STORE_PRESCRIBER_DAW_CODE = '6' THEN '6 - OVERRIDE'
              WHEN ${TABLE}.STORE_PRESCRIBER_DAW_CODE = '7' THEN '7 - DISPENSE AS WRITTEN- BRAND MANDATED'
              WHEN ${TABLE}.STORE_PRESCRIBER_DAW_CODE = '8' THEN '8 - SUBSTITUTION ALLOWED- GENERIC NOT AVAILABLE'
              WHEN ${TABLE}.STORE_PRESCRIBER_DAW_CODE = '9' THEN '9 - SUBSTITUTION ALLOWED- PLAN REQUESTED BRAND/OTHER'
              ELSE TO_CHAR(${TABLE}.STORE_PRESCRIBER_DAW_CODE)
         END ;;
  }

  dimension: store_prescriber_specialty_code {
    label: "Store Prescriber Specialty Code"
    description: "code representing prescriber specialty in a certain area of their field. EPS Table: PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_SPECIALTY_CODE ;;
  }

  dimension_group: store_prescriber_deactivate {
    label: "Store Prescriber Deactivate"
    description: "Date/Time a prescriber record was or should be deactivated. EPS Table: PRESCRIBER"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_PRESCRIBER_DEACTIVATE_DATE ;;
  }

  dimension: store_prescriber_disallow_autofill_flag {
    label: "Store Prescriber Disallow Autofill Flag"
    description: "Flag indicating if prescriptions filled using a prescriber record are eligible for auto fill. EPS Table: PRESCRIBER"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_PRESCRIBER_DISALLOW_AUTOFILL_FLAG = 'Y' THEN 'Y - DISALLOW AUTOFILL'
              WHEN ${TABLE}.STORE_PRESCRIBER_DISALLOW_AUTOFILL_FLAG = 'N' THEN 'N - ALLOW AUTOFILL'
              ELSE TO_CHAR(${TABLE}.STORE_PRESCRIBER_DISALLOW_AUTOFILL_FLAG)
         END ;;
  }

  dimension: store_prescriber_upin {
    label: "Store Prescriber Upin"
    description: "The UPIN or Unique Physician Identification Number with six character alpha number field used by Medicare to identify Prescribers in the US. EPS Table: PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_UPIN ;;
  }

  dimension: store_prescriber_speed_code {
    label: "Store Prescriber Speed Code"
    description: "Mnemonic code representing a prescriber record made up of the first 4 characters of the prescriber last name plus the first 2 characters of the prescriber first name plus a 2 digit number for converted records or a sequential number for newly added records. EPS Table: PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_SPEED_CODE ;;
  }

  dimension: store_prescriber_probation_code {
    label: "Store Prescriber Probation Code"
    description: "Flag indicating the drug schedule for which a prescriber is on probation and prescriptions using prescriber record should not be filled. EPS Table: PRESCRIBER"
    type: string
    sql: CASE WHEN ${TABLE}.STORE_PRESCRIBER_PROBATION_CODE is null THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_PRESCRIBER_PROBATION_CODE = 'Y' THEN 'Y - PREVENT FILL OF ALL DRUG SCHEDULES'
              WHEN ${TABLE}.STORE_PRESCRIBER_PROBATION_CODE = '1' THEN '1 - PREVENT FILL OF SCHEDULE 1 DRUGS'
              WHEN ${TABLE}.STORE_PRESCRIBER_PROBATION_CODE = '2' THEN '2 - PREVENT FILL OF SCHEDULE 2 OR LESS DRUGS'
              WHEN ${TABLE}.STORE_PRESCRIBER_PROBATION_CODE = '3' THEN '3 - PREVENT FILL OF SCHEDULE 3 OR LESS DRUGS'
              WHEN ${TABLE}.STORE_PRESCRIBER_PROBATION_CODE = '4' THEN '4 - PREVENT FILL OF SCHEDULE 4 OR LESS DRUGS'
              WHEN ${TABLE}.STORE_PRESCRIBER_PROBATION_CODE = '5' THEN '5 - PREVENT FILL OF SCHEDULE 5 OR LESS DRUGS'
              WHEN ${TABLE}.STORE_PRESCRIBER_PROBATION_CODE = 'A' THEN 'A - PREVENT FILL OF SCHEDULE 8 OR LESS DRUGS'
              WHEN ${TABLE}.STORE_PRESCRIBER_PROBATION_CODE = 'B' THEN 'B - PREVENT FILL OF SCHEDULE 8 OR LESS DRUGS'
              WHEN ${TABLE}.STORE_PRESCRIBER_PROBATION_CODE = 'C' THEN 'C - PREVENT FILL OF SCHEDULE 8 OR LESS DRUGS'
              WHEN ${TABLE}.STORE_PRESCRIBER_PROBATION_CODE = 'E' THEN 'E - PREVENT FILL OF SCHEDULE 8 OR LESS DRUGS'
              WHEN ${TABLE}.STORE_PRESCRIBER_PROBATION_CODE = 'O' THEN 'O - PREVENT FILL OF SCHEDULE 8 OR LESS DRUGS'
              WHEN ${TABLE}.STORE_PRESCRIBER_PROBATION_CODE = 'D' THEN 'D - PREVENT FILL OF SCHEDULE 6 OR LESS DRUGS'
              WHEN ${TABLE}.STORE_PRESCRIBER_PROBATION_CODE = 'F' THEN 'F - PREVENT FILL OF SCHEDULE 6 OR LESS DRUGS'
              WHEN ${TABLE}.STORE_PRESCRIBER_PROBATION_CODE = 'G' THEN 'G - PREVENT FILL OF SCHEDULE 4 OR LESS DRUGS'
              WHEN ${TABLE}.STORE_PRESCRIBER_PROBATION_CODE = 'T' THEN 'T - PREVENT FILL OF SCHEDULE 4 OR LESS DRUGS'
              WHEN ${TABLE}.STORE_PRESCRIBER_PROBATION_CODE = 'N' THEN 'N - PREVENT FILL OF SCHEDULE 2 OR LESS DRUGS'
              ELSE TO_CHAR(${TABLE}.STORE_PRESCRIBER_PROBATION_CODE)
         END ;;
  }

  dimension: store_prescriber_hcid {
    label: "Store Prescriber Hcid"
    description: "Prescribers Healthcare Identifcation Number (HCID). EPS Table: PRESCRIBER"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PRESCRIBER_HCID ;;
  }

  dimension: store_prescriber_federal_tax_number {
    label: "Store Prescriber Federal Tax Number"
    description: "Federal tax ID number. EPS Table: PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_FEDERAL_TAX_NUMBER ;;
  }

  dimension: store_prescriber_npi_number {
    label: "Store Prescriber Npi Number"
    description: "Prescriber's National Provider ID. EPS Table: PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_NPI_NUMBER ;;
  }

  dimension: store_prescriber_nhin_id {
    label: "Store Prescriber Nhin Id"
    description: "The NHIN_ID column is a Prescriber ID number assigned by NHIN when using the Prescriber file on host where you can pull down prescribers to your local system. EPS Table: PRESCRIBER"
    type: string
    hidden: yes
    sql: ${TABLE}.STORE_PRESCRIBER_NHIN_ID ;;
  }

  dimension: store_prescriber_group_code {
    label: "Store Prescriber Group Code"
    description: "Free format code representing prescriber group that is mainly used for reporting purposes. EPS Table: PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_GROUP_CODE ;;
  }

  dimension_group: store_prescriber_nhin_retire {
    label: "Store Prescriber Nhin Retire"
    description: "Prescriber retirement date/time as provided by NHIN. EPS Table: PRESCRIBER"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_PRESCRIBER_NHIN_RETIRE_DATE ;;
  }

  dimension_group: store_prescriber_nhin_decease {
    label: "Store Prescriber Nhin Decease"
    description: "Populated by NHIN For Kaiser, this value will be populated from CPM and/or a user can manually enter the date. EPS Table: PRESCRIBER"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.STORE_PRESCRIBER_NHIN_DECEASE_DATE ;;
  }

  dimension: store_prescriber_medicare_number {
    label: "Store Prescriber Medicare Number"
    description: "Prescriber's Medicare ID for a specific state. EPS Table: PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_MEDICARE_NUMBER ;;
  }

  dimension: store_prescriber_blue_cross_number {
    label: "Store Prescriber Blue Cross Number"
    description: "Prescriber's Blue Cross ID number assigned by BCBS. This ID can be used when submitting items through insurance. EPS Table: PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_BLUE_CROSS_NUMBER ;;
    hidden: yes
  }

  dimension: store_prescriber_blue_shield_number {
    label: "Store Prescriber Blue Shield Number"
    description: "Prescriber's Blue Shield ID number assigned by BCBS. This ID can be used when submitting items through insurance. EPS Table: PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_BLUE_SHIELD_NUMBER ;;
    hidden: yes
  }

  dimension: store_prescriber_champus_number {
    label: "Store Prescriber Champus Number"
    description: "Prescriber's Champus Insurance ID number. Now called CHAMPVA and is tailored to the Department of Defense insurance. EPS Table: PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_CHAMPUS_NUMBER ;;
    hidden: yes
  }

  dimension: store_prescriber_home_phone_id {
    label: "Store Prescriber Home Phone Id"
    description: "Prescriber's home phone. EPS Table: PRESCRIBER"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PRESCRIBER_HOME_PHONE_ID ;;
  }

  dimension: store_prescriber_mobile_phone_id {
    label: "Store Prescriber Mobile Phone Id"
    description: "Prescriber's mobile phone number. EPS Table: PRESCRIBER"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PRESCRIBER_MOBILE_PHONE_ID ;;
  }

  dimension: store_prescriber_pager_phone_id {
    label: "Store Prescriber Pager Phone Id"
    description: "Prescriber's pager phone number. EPS Table: PRESCRIBER"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PRESCRIBER_PAGER_PHONE_ID ;;
  }

  dimension: store_prescriber_taxonomy_code {
    label: "Store Prescriber Taxonomy Code"
    description: "A specialty code to indicate a prescribers specialty during claim adjudication. This is a very old field and is not used anymore. EPS Table: PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_TAXONOMY_CODE ;;
  }

  dimension: store_prescriber_degree_type_id {
    label: "Store Prescriber Degree Type Id"
    description: "Field used to indicate the prescriber's degree. EPS Table: PRESCRIBER"
    type: number
    hidden: yes
    sql: ${TABLE}.STORE_PRESCRIBER_DEGREE_TYPE_ID ;;
  }

  dimension: store_prescriber_corporate_probation {
    label: "Store Prescriber Corporate Probation"
    description: "Flag to set the prescriber as on probation from corporate (at a chain level). EPS Table: PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_CORPORATE_PROBATION ;;
  }

  dimension: store_prescriber_waiver_identifier {
    label: "Store Prescriber Waiver Identifier"
    description: "Stores a prescriber's suboxone number. EPS Table: PRESCRIBER"
    type: string
    sql: ${TABLE}.STORE_PRESCRIBER_WAIVER_IDENTIFIER ;;
  }

  dimension: store_prescriber_disallow_escript_retries_flag {
    label: "Store Prescriber Disallow Escript Retries Flag"
    description: "A flag indicating if the prescriber wants to accept the eScript Retries feature of the application. EPS Table: PRESCRIBER"
    type: yesno
    sql: ${TABLE}.STORE_PRESCRIBER_DISALLOW_ESCRIPT_RETRIES_FLAG ;;
  }

  dimension_group: source_create_timestamp {
    label: "Store Prescriber Create"
    description: "Date/Time at which the record was created in the source application. EPS Table: PRESCRIBER"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: source_timestamp {
    label: "Store Prescriber Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: PRESCRIBER"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

}
