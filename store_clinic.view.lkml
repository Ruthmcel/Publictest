view: store_clinic {
  label: "Clinic"
  sql_table_name: EDW.D_CLINIC ;;

  dimension: store_clinic_unique_key {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${clinic_id} || '@' || ${source_system_id} ;;
  }

  dimension: source_system_id {
    label: "Source System ID"
    description: "Unique ID number identifying a BI source system"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: CLINIC"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: CLINIC"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: clinic_id {
    label: "Clinic Id"
    description: "Unique Id number identifying this record. EPS Table: CLINIC"
    type: number
    hidden: yes
    sql: ${TABLE}.CLINIC_ID ;;
  }

######################## END OF PK/FK REFRENCES ########################

  dimension: clinic_edi_script_version {
    label: "Clinic Edi Script Version"
    description: "EDI SCRIPT Version that this prescriber e-script system uses for e-prescribing. EPS Table: CLINIC"
    type: string
    sql: ${TABLE}.CLINIC_EDI_SCRIPT_VERSION ;;
  }

  dimension: clinic_hin {
    label: "Clinic Hin"
    description: "Healthcare Industry Number is an identifier assigned by HIBCC to uniquely identify health care facilities,their locations,and departments within them. EPS Table: CLINIC"
    type: string
    sql: ${TABLE}.CLINIC_HIN ;;
  }

  dimension: clinic_escript_clinic_number {
    label: "Clinic Escript Clinic Number"
    description: "E-script clinic ID number. EPS Table: CLINIC"
    type: string
    sql: ${TABLE}.CLINIC_ESCRIPT_CLINIC_NUMBER ;;
  }

  dimension: clinic_dea_number {
    label: "Clinic Dea Number"
    description: "The DEA_NUM field is the column associated with a Clinic specific DEA or NCPDP Provider number. EPS Table: CLINIC"
    type: string
    sql: ${TABLE}.CLINIC_DEA_NUMBER ;;
  }

  dimension: clinic_federal_tax_number {
    label: "Clinic Federal Tax Number"
    description: "The FEDERAL_TAX_NUM is the field that stores the Clinic's federal tax ID number assigned for tax purposes by the Federal Government. EPS Table: CLINIC"
    type: string
    sql: ${TABLE}.CLINIC_FEDERAL_TAX_NUMBER ;;
  }

  dimension: clinic_contact_preference_code {
    label: "Clinic Contact Preference Code"
    description: "Preferred method of contact for clinic. EPS Table: CLINIC"
    type: number
    sql: CASE WHEN ${TABLE}.CLINIC_CONTACT_PREFERENCE_CODE is null THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.CLINIC_CONTACT_PREFERENCE_CODE = '1' THEN 'PHONE'
              WHEN ${TABLE}.CLINIC_CONTACT_PREFERENCE_CODE = '2' THEN 'EMAIL'
              WHEN ${TABLE}.CLINIC_CONTACT_PREFERENCE_CODE = '3' THEN 'FAX'
              WHEN ${TABLE}.CLINIC_CONTACT_PREFERENCE_CODE = '5' THEN 'ERX'
              WHEN ${TABLE}.CLINIC_CONTACT_PREFERENCE_CODE = '6' THEN 'WEB'
              WHEN ${TABLE}.CLINIC_CONTACT_PREFERENCE_CODE = '7' THEN 'IVR'
              ELSE TO_CHAR(${TABLE}.CLINIC_CONTACT_PREFERENCE_CODE)
         END ;;
  }

  dimension: clinic_name {
    label: "Clinic Name"
    description: "The Name of the Clinic. EPS Table: CLINIC"
    type: string
    sql: ${TABLE}.CLINIC_NAME ;;
  }

  dimension: clinic_department_name {
    label: "Clinic Department Name"
    description: "The specific department within the clinic that a prescriber works in. EPS Table: CLINIC"
    type: string
    sql: ${TABLE}.CLINIC_DEPARTMENT_NAME ;;
  }

  dimension_group: clinic_deactivate_date {
    label: "Clinic Deactivate Date"
    description: "Date a clinic record was or should be deactivated. EPS Table: CLINIC"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.CLINIC_DEACTIVATE_DATE ;;
  }

  dimension: clinic_do_not_override_contact_flag {
    label: "Clinic Do Not Override Contact Flag"
    description: "Used to indicate the system to never allow the contact preference to be overridden by the user. EPS Table: CLINIC"
    type: string
    sql: CASE WHEN ${TABLE}.CLINIC_DO_NOT_OVERRIDE_CONTACT_FLAG = 'Y' THEN 'YES'
              WHEN ${TABLE}.CLINIC_DO_NOT_OVERRIDE_CONTACT_FLAG = 'N' THEN 'NO'
              ELSE TO_CHAR(${TABLE}.CLINIC_DO_NOT_OVERRIDE_CONTACT_FLAG)
         END ;;
  }

  dimension: clinic_do_not_fax_refill_requests_flag {
    label: "Clinic Do Not Fax Refill Requests Flag"
    description: "This is used to tell the system to never send a refill request to a doctor via fax. EPS Table: CLINIC"
    type: string
    sql: CASE WHEN ${TABLE}.CLINIC_DO_NOT_FAX_REFILL_REQUESTS_FLAG = 'Y' THEN 'YES'
              WHEN ${TABLE}.CLINIC_DO_NOT_FAX_REFILL_REQUESTS_FLAG = 'N' THEN 'NO'
              ELSE TO_CHAR(${TABLE}.CLINIC_DO_NOT_FAX_REFILL_REQUESTS_FLAG)
         END ;;
  }

  dimension: clinic_disallow_edi_refill_requests_flag {
    label: "Clinic Disallow Edi Refill Requests Flag"
    description: "This is used to tell the system to never send a refill request to a doctor via eScript. EPS Table: CLINIC"
    type: string
    sql: CASE WHEN ${TABLE}.CLINIC_DISALLOW_EDI_REFILL_REQUESTS_FLAG = 'Y' THEN 'YES'
              WHEN ${TABLE}.CLINIC_DISALLOW_EDI_REFILL_REQUESTS_FLAG = 'N' THEN 'NO'
              ELSE TO_CHAR(${TABLE}.CLINIC_DISALLOW_EDI_REFILL_REQUESTS_FLAG)
         END ;;
  }

  dimension: clinic_disallow_phone_refill_requests_flag {
    label: "Clinic Disallow Phone Refill Requests Flag"
    description: "This flag determines if a prescriber does not allow phone refill requests at this clinic. EPS Table: CLINIC"
    type: string
    sql: CASE WHEN ${TABLE}.CLINIC_DISALLOW_PHONE_REFILL_REQUESTS_FLAG = 'Y' THEN 'YES'
              WHEN ${TABLE}.CLINIC_DISALLOW_PHONE_REFILL_REQUESTS_FLAG = 'N' THEN 'NO'
              ELSE TO_CHAR(${TABLE}.CLINIC_DISALLOW_PHONE_REFILL_REQUESTS_FLAG)
         END ;;
  }

  dimension: address_id {
    label: "Address Id"
    description: "ID that links the entered address (stored in the address table) back to the associated clinic. EPS Table: CLINIC"
    type: number
    hidden: yes
    sql: ${TABLE}.ADDRESS_ID ;;
  }

  dimension: clinic_office_phone_id {
    label: "Clinic Office Phone Id"
    description: "The ID of the PHONE record containing the main office phone number associated with this clinic. EPS Table: CLINIC"
    type: number
    hidden: yes
    sql: ${TABLE}.CLINIC_OFFICE_PHONE_ID ;;
  }

  dimension: clinic_alternate_phone_id {
    label: "Clinic Alternate Phone Id"
    description: "The ID of the PHONE record containing the alternate phone number associated with this clinic. EPS Table: CLINIC"
    type: number
    hidden: yes
    sql: ${TABLE}.CLINIC_ALTERNATE_PHONE_ID ;;
  }

  dimension: clinic_fax_phone_id {
    label: "Clinic Fax Phone Id"
    description: "The ID of the PHONE record containing the fax phone number associated with this clinic. EPS Table: CLINIC"
    type: number
    hidden: yes
    sql: ${TABLE}.CLINIC_FAX_PHONE_ID ;;
  }

  dimension: clinic_refill_request_phone_id {
    label: "Clinic Refill Request Phone Id"
    description: "The ID of the PHONE record containing the refill request phone number associated with this clinic. The Phone number is entered by the user via the UI when setting up the clinic. EPS Table: CLINIC"
    type: number
    hidden: yes
    sql: ${TABLE}.CLINIC_REFILL_REQUEST_PHONE_ID ;;
  }

  dimension_group: source_create_timestamp {
    label: "Source Create Timestamp"
    description: "This is the date and time that the record was created. This date is used for central data analysis. EPS Table: CLINIC"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_CREATE_TIMESTAMP ;;
  }

  dimension_group: source_timestamp {
    label: "Source Timestamp"
    description: "This is the date and time that the record was last updated. This date is used for central data analysis. EPS Table: CLINIC"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }
}
