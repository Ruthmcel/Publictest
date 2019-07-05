view: login_history {
  sql_table_name: etl_manager.login_history ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${login_history_id} ;;
  }

  ######################################################################################################### Dimensions ###########################################################################################################

  dimension: login_history_id {
    label: "Login History Id"
    description: "Event’s unique id"
    type: string
    sql: ${TABLE}.login_history_id ;;
  }

  dimension_group: login_timestamp {
    label: "Login Time"
    description: "Date/Time of the event occurrence"
    type: time
    timeframes: [
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
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.login_timestamp ;;
  }

  dimension: type {
    label: "Event Type"
    description: "Event type, such as LOGIN for authentication events"
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: user_name {
    label: "User Name"
    description: "User associated with this event"
    type: string
    sql: ${TABLE}.user_name ;;
  }

  dimension: client_ip {
    label: "Client IP"
    description: "IP address where the request originated from"
    type: string
    sql: ${TABLE}.client_ip ;;
  }

  dimension: reported_client_type {
    label: "Reported Client Type"
    description: "Reported type of the client software, such as JDBC_DRIVER, ODBC_DRIVER etc. This information is not authenticated"
    type: string
    sql: ${TABLE}.reported_client_type ;;
  }

  dimension: reported_client_version {
    label: "Reported Client Version"
    description: "Reported version of the client software. This information is not authenticated"
    type: string
    sql: ${TABLE}.reported_client_version ;;
  }

  dimension: first_authentication_factor {
    label: "First Authentication Factor"
    description: "Method used to authenticate the user (the first factor, if using multi factor authentication)"
    type: number
    sql: ${TABLE}.first_authentication_factor ;;
  }

  dimension: second_authentication_factor {
    label: "Second Authentication Factor"
    description: "The second factor, if using multi factor authentication or NULL otherwise"
    type: string
    sql: ${TABLE}.second_authentication_factor ;;
  }

  dimension: is_success {
    label: "Is Success"
    description: "Whether the user’s request was successful or not"
    type: string
    sql: ${TABLE}.is_success ;;
  }

  dimension: error_code {
    label: "Error Code"
    description: "Error code, if the request was not successful"
    type: string
    sql: ${TABLE}.error_code ;;
  }

  dimension: error_message {
    label: "Error Message"
    description: "Error message returned to the user, if the request was not successful."
    type: string
    sql: ${TABLE}.error_message ;;
  }

  dimension: related_login_history_id {
    label: "Related Login History Id"
    description: "Reserved for future use"
    type: string
    sql: ${TABLE}.related_login_history_id ;;
  }
}
