view: store_application_exception {
  label: "Application Exception"
  sql_table_name: EDW.F_APPLICATION_EXCEPTION ;;

  dimension: primary_key {
    description: "Unique Identification number"
    type: string
    hidden: yes
    primary_key: yes
    sql: ${chain_id} || '@' || ${nhin_store_id} || '@' || ${application_exception_id} || '@' || ${source_system_id} ;;
  }

  dimension: chain_id {
    label: "Chain Id"
    description: "Identification number assinged to each customer chain by NHIN. EPS Table: APPLICATION_EXCEPTIONS"
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    label: "Nhin Store Id"
    description: "NHIN account number which uniquely identifies the store with NHIN. EPS Table: APPLICATION_EXCEPTIONS"
    type: number
    hidden: yes
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: application_exception_id {
    label: "Application Exception Id"
    description: "Unique Id number identifying this record. EPS Table: APPLICATION_EXCEPTIONS"
    type: number
    hidden: yes
    sql: ${TABLE}.APPLICATION_EXCEPTION_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    description: "Unique ID number identifying a BI source system. EPS Table: APPLICATION_EXCEPTIONS"
    type: number
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension_group: application_exception {
    label: "Application Exception"
    description: "Date and time the exception was encountered. EPS Table: APPLICATION_EXCEPTIONS"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.APPLICATION_EXCEPTION_DATE ;;
  }

  dimension: application_exception_message {
    label: "Application Exception Message"
    description: "Exception message that was written to the java console/log file. EPS Table: APPLICATION_EXCEPTIONS"
    type: string
    sql: ${TABLE}.APPLICATION_EXCEPTION_MESSAGE ;;
  }

  dimension: application_exception_comments {
    label: "Application Exception Comments"
    description: "Comment user had entered when some exceptions are displayed on screen. EPS Table: APPLICATION_EXCEPTIONS"
    type: string
    sql: ${TABLE}.APPLICATION_EXCEPTION_COMMENTS ;;
  }

  dimension: application_exception_task_identifier {
    label: "Application Exception Task Identifier"
    description: "Available workflow_token.ID at the time the exception is encountered. EPS Table: APPLICATION_EXCEPTIONS"
    type: number
    sql: ${TABLE}.APPLICATION_EXCEPTION_TASK_IDENTIFIER ;;
  }

  dimension: application_exception_user_login {
    label: "Application Exception User Login"
    description: "The login of the user who encountered the exception. EPS Table: APPLICATION_EXCEPTIONS"
    type: string
    sql: ${TABLE}.APPLICATION_EXCEPTION_USER_LOGIN ;;
  }

  dimension: application_exception_workstation {
    label: "Application Exception Workstation"
    description: "'Computer name'of the workstation that encountered the error. EPS Table: APPLICATION_EXCEPTIONS"
    type: string
    sql: ${TABLE}.APPLICATION_EXCEPTION_WORKSTATION ;;
  }

  dimension: application_exception_client_side_flag {
    label: "Application Exception Client Side Flag"
    description: "Flag indicating if the exception was server or client side. EPS Table: APPLICATION_EXCEPTIONS"
    type: string
    sql: CASE WHEN ${TABLE}.APPLICATION_EXCEPTION_CLIENT_SIDE_FLAG = '0' THEN '0 - SERVER'
              WHEN ${TABLE}.APPLICATION_EXCEPTION_CLIENT_SIDE_FLAG = '1' THEN '1 - CLIENT'
              ELSE TO_CHAR(${TABLE}.APPLICATION_EXCEPTION_CLIENT_SIDE_FLAG)
         END ;;
  }

  dimension: application_exception_is_db_exception_flag {
    label: "Application Exception Is Db Exception Flag"
    description: "Field which determines if the exception was due to a bad data being returned from a stored procedure. EPS Table: APPLICATION_EXCEPTIONS"
    type: string
    sql: CASE WHEN ${TABLE}.APPLICATION_EXCEPTION_IS_DB_EXCEPTION_FLAG = '0' THEN '0 - FALSE'
              WHEN ${TABLE}.APPLICATION_EXCEPTION_IS_DB_EXCEPTION_FLAG = '1' THEN '1 - TRUE'
              ELSE TO_CHAR(${TABLE}.APPLICATION_EXCEPTION_IS_DB_EXCEPTION_FLAG)
         END ;;
  }

  dimension: application_exception_employee_number {
    label: "Application Exception Employee Number"
    description: "Employee Number of user who encountered the exception. ***. EPS Table: APPLICATION_EXCEPTIONS"
    type: string
    sql: ${TABLE}.APPLICATION_EXCEPTION_EMPLOYEE_NUMBER ;;
  }

  dimension: application_exception_deleted {
    label: "Application Exception Deleted"
    description: "Value that indicates if the record has been deleted in the source table. EPS Table: APPLICATION_EXCEPTIONS"
    type: string
    sql: CASE WHEN ${TABLE}.APPLICATION_EXCEPTION_DELETED = 'N' THEN 'N - NO'
              WHEN ${TABLE}.APPLICATION_EXCEPTION_DELETED = 'Y' THEN 'Y - YES'
              ELSE TO_CHAR(${TABLE}.APPLICATION_EXCEPTION_DELETED)
         END ;;
  }

  dimension_group: source_timestamp {
    label: "Application Exception Last Update"
    description: "Date/Time at which the record was last updated in the source application. EPS Table: APPLICATION_EXCEPTIONS"
    type: time
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

}
