view: carerx_patient_tp {
  sql_table_name: MTM_CLINICAL.PATIENT_TP ;;

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  ######################################################################################### Foreign Key References #################################################################################################

  dimension: chain_id {
    hidden: yes
    label: "Chain ID"
    description: "The CareRx unique database ID of the chain that the Care Rx patient is linked to. This is NOT the Chain NHIN ID assigned by NHIN"
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: original_patient_id {
    hidden: yes
    label: "Patient Original ID"
    description: "The unique database ID of the patient that the Third Party coverage is linked to"
    type: number
    sql: ${TABLE}.ORIGINAL_PATIENT_ID ;;
  }

  dimension: third_party_id {
    hidden: yes
    label: "Third Party ID"
    description: "The unique database ID of the third party insurance that the patient coverage is for."
    type: number
    sql: ${TABLE}.THIRD_PARTY_ID ;;
  }

  ################################################################################################## Dimension #################################################################################################

  dimension: cardholder_identifier {
    label: "Cardholder ID Number"
    description: "The identification number assigned by the Third Party to the cardholder for this account"
    type: string
    sql: ${TABLE}.CARDHOLDER_IDENTIFIER ;;
  }

  dimension: plan_code {
    label: "Plan Code"
    description: "The code used by the third party to identify the plan for this account"
    type: string
    sql: ${TABLE}.PLAN_CODE ;;
  }

  dimension: group_code {
    label: "Plan Group Code"
    description: "The code used by the third party to identify the group for this account "
    type: string
    sql: ${TABLE}.GROUP_CODE ;;
  }

  dimension: person_code {
    label: "Plan Person Code"
    description: "The code used by the third party to identify a specific person on this account"
    type: string
    sql: ${TABLE}.PERSON_CODE ;;
  }

  dimension: coverage_type_flag {
    label: "Coverage Type Flag"
    description: "The type of the third party account. M = Medical account. P = Pharmacy account"
    type: string

    case: {
      when: {
        sql: ${TABLE}.COVERAGE_TYPE = 'M' ;;
        label: "MEDICAL"
      }

      when: {
        sql: ${TABLE}.COVERAGE_TYPE = 'M' ;;
        label: "PHARMACY"
      }

      when: {
        sql: ${TABLE}.COVERAGE_TYPE IS NULL ;;
        label: "UNKNOWN"
      }
    }
  }

  dimension: relation_code {
    label: "Plan Relation Code"
    description: "The code used by the third party to identify the relationship to the cardholder of the account"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RELATION_CODE = '1' ;;
        label: "CARDHOLDER"
      }

      when: {
        sql: ${TABLE}.RELATION_CODE = '2' ;;
        label: "SPOUSE"
      }

      when: {
        sql: ${TABLE}.RELATION_CODE = '3' ;;
        label: "CHILD"
      }

      when: {
        sql: ${TABLE}.RELATION_CODE = '4' ;;
        label: "OTHER"
      }

      when: {
        sql: ${TABLE}.RELATION_CODE IS NULL ;;
        label: "UNKNOWN"
      }
    }
  }

  dimension: cardholder_first_name {
    group_label: "Cardholder Name"
    label: "Cardholder First Name"
    description: "The first name of the cardholder of the third party account"
    type: string
    sql: ${TABLE}.CARDHOLDER_FIRST_NAME ;;
  }

  dimension: cardholder_last_name {
    group_label: "Cardholder Name"
    label: "Cardholder Last Name"
    description: "The Last name of the cardholder of the third party account"
    type: string
    sql: ${TABLE}.CARDHOLDER_LAST_NAME ;;
  }

  dimension: cardholder_address {
    group_label: "Cardholder Address"
    label: "Cardholder Address"
    description: "The billing address of the cardholder of the third party account"
    type: string
    sql: ${TABLE}.CARDHOLDER_ADDRESS ;;
  }

  dimension: cardholder_city {
    group_label: "Cardholder Address"
    label: "Cardholder City"
    description: "The city of the billing address for the cardholder of the third party account"
    type: string
    sql: ${TABLE}.CARDHOLDER_CITY ;;
  }

  dimension: cardholder_state {
    group_label: "Cardholder Address"
    label: "Cardholder State"
    description: "The state of the billing address for the cardholder of the third party account"
    type: string
    sql: ${TABLE}.CARDHOLDER_STATE ;;
  }

  dimension: cardholder_zip {
    group_label: "Cardholder Address"
    label: "Cardholder Zip Code"
    description: "The zip code of the billing address for the cardholder of the third party account"
    type: string
    sql: CASE WHEN LENGTH(${TABLE}.CARDHOLDER_ZIP) > 5 THEN SUBSTR(${TABLE}.CARDHOLDER_ZIP, 0, 5) || '-' || SUBSTR(${TABLE}.CARDHOLDER_ZIP, 6) ELSE ${TABLE}.CARDHOLDER_ZIP END ;;
  }

  dimension: cardholder_gender {
    label: "Cardholder Gender"
    description: "The gender of the cardholder of the third party account"
    type: string

    case: {
      when: {
        sql: ${TABLE}.CARDHOLDER_SEX = 'M' ;;
        label: "MALE"
      }

      when: {
        sql: ${TABLE}.CARDHOLDER_SEX = 'F' ;;
        label: "FEMALE"
      }

      when: {
        sql: NVL(${TABLE}.CARDHOLDER_SEX, 'U') = 'U' ;;
        label: "UNKNOWN"
      }
    }
  }

  ################################################################################################## Dimension Date / Time #################################################################################################

  dimension_group: cardholder_birth {
    label: "Cardholder DOB"
    description: "The Cardholders Date Of Birth"
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
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.CARDHOLDER_BIRTH_DATE ;;
  }

  dimension_group: tp_deactivated {
    label: "Cardholder Plan Deactivated"
    description: "The date/time that the third party account was deactivated"
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
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.DEACTIVATED_DATE ;;
  }

  ################################################################################################## Measures #################################################################################################

  measure: count {
    label: "TP Plan count"
    description: "Count of TP Plan and Cardholder records in the CareRx Patient Third Party table"
    type: count
    drill_fields: [plan_cardholder_information*]
  }

  ################################################################################################## SETS #################################################################################################

  set: plan_cardholder_information {
    fields: [
      cardholder_identifier,
      plan_code,
      group_code,
      coverage_type_flag,
      relation_code,
      cardholder_first_name,
      cardholder_last_name,
      cardholder_address,
      cardholder_city,
      cardholder_state,
      cardholder_zip
    ]
  }
}
