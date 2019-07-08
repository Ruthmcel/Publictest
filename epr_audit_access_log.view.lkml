view: epr_audit_access_log {


  label: "Audit Access Log"
  sql_table_name: edw.F_AUDIT_ACCESS_LOG ;;

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${audit_access_log_id} ||'@'|| ${audit_access_log_audit_time} ;; #ERXLPS-1649
  }

  ################################################################## Foreign Key references##############################
  dimension: chain_id {
    label: "Chain Id"
    type: number
    description: "Identification number assinged to each customer chain by NHIN"
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: audit_access_log_nhin_id {
    label: "NHID ID "
    hidden: yes
    description: "NHIN_ID is the clientId / nhinId of the remote client."
    type: number
    sql: ${TABLE}.AUDIT_ACCESS_LOG_NHIN_ID ;;
  }

  dimension: audit_access_log_id {
    label: "Audit Access Log Id"
    type: number
    description: "Unique ID number identifying each record"
    hidden: yes
    sql: ${TABLE}.AUDIT_ACCESS_LOG_ID ;;
  }

  dimension: source_system_id {
    label: "Source System Id"
    type: number
    description: "Unique ID number identifying an BI source sytem (0 - HOST, 1 - ECC, 2 - SEC_ADMIN,   3 - EPR, 4 - EPS, 5 - ARS, 6 - NHIN)"
    hidden: yes
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: service_id {
    label: "Service Id"
    type: number
    description: "SERVICE is the type of request that was received by the system."
    hidden: yes
    sql: ${TABLE}.SERVICE_ID ;;
  }

  dimension: audit_access_log_hash_value {
    label: "Hash Value "
    hidden: yes
    description: "Set to improve indexing performance"
    type: number
    sql: ${TABLE}.AUDIT_ACCESS_LOG_HASH_VALUE ;;
  }

  ############################################################## Dimensions ######################################################

  dimension_group: audit_access_log_incoming {
    label: "Incoming Message"
    description: "Date/Time of the server when the message was first received and before it had been processed in any way"
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
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.AUDIT_ACCESS_LOG_INCOMING_TIMESTAMP ;;
  }

  dimension_group: audit_access_log_outgoing {
    label: "Outgoing Message"
    description: "Date/Time of the server when all processing is complete and the system is about to send the response to the client"
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
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.AUDIT_ACCESS_LOG_OUTGOING_TIMESTAMP ;;
  }

  dimension_group: audit_access_log_before_application_server {
    label: "Before Appserver"
    description: "Date/Time recorded by the server after XML translation and initial prep is complete and just before beginning 'real' work on the request"
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
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.AUDIT_ACCESS_LOG_BEFORE_APPLICATION_SERVER_TIMESTAMP ;;
  }

  dimension_group: audit_access_log_after_application_server {
    label: "After Appserver"
    description: "Date/Time of the system after completing the main transaction but before final processing and XML translation."
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
    sql: ${TABLE}.AUDIT_ACCESS_LOG_AFTER_APPLICATION_SERVER_TIMESTAMP ;;
  }

  dimension_group: audit_access_log_audit {
    label: "Audit"
    type: time
    description: "Date/Time recorded during audit record creation"
    timeframes: [
      time,
      date,
      week,
      month,
      hour,
      minute15,
      minute2,
      minute3
    ]
    sql: ${TABLE}.AUDIT_ACCESS_LOG_AUDIT_TIMESTAMP ;;
  }

  dimension: audit_access_log_pdx_message_id {
    label: "Pdx Message Id"
    description: "Stores the value if a Message ID is provided in the message sent by the client"
    type: string
    sql: ${TABLE}.AUDIT_ACCESS_LOG_PDX_MESSAGE_ID ;;
  }

  dimension: audit_access_log_client_ip {
    label: "Client IP "
    description: "The IP address of the remote system"
    type: string
    sql: ${TABLE}.AUDIT_ACCESS_LOG_CLIENT_IP ;;
  }

  dimension: audit_access_log_client_id_type {
    label: "Client ID Type"
    description: "Type of ID that was provided in the Client ID field. Valid Values are: NHIN"
    type: string
    sql: ${TABLE}.AUDIT_ACCESS_LOG_CLIENT_ID_TYPE ;;
  }

  dimension: audit_access_log_status {
    label: "Status"
    description: "Indicates the 'success' or 'failure' of a transaction that passed through the system"
    type: string
    sql: ${TABLE}.AUDIT_ACCESS_LOG_STATUS ;;
    suggestions: ["SUCCESS", "FAILURE"]
  }

  dimension: audit_access_log_audit_mode {
    label: "Audit Mode"
    description: "Audit Access Log Audit Mode"
    type: string
    sql: ${TABLE}.AUDIT_ACCESS_LOG_AUDIT_MODE ;;
  }

  dimension: audit_access_log_code {
    label: "Code"
    description: "User code as provided by the remote system"
    type: string
    sql: ${TABLE}.AUDIT_ACCESS_LOG_CODE ;;
  }

  dimension: audit_access_log_first_name {
    label: "First Name "
    description: "First name of the user on the remote client"
    group_label: "User Info"
    type: string
    sql: ${TABLE}.AUDIT_ACCESS_LOG_FIRST_NAME ;;
  }

  dimension: audit_access_log_middle_name {
    label: "Middle Name "
    group_label: "User Info"
    description: "Middle name of the user on the remote client"
    type: string
    sql: ${TABLE}.AUDIT_ACCESS_LOG_MIDDLE_NAME ;;
  }

  dimension: audit_access_log_last_name {
    label: "Last Name "
    group_label: "User Info"
    description: "Last name of the user on the remote client"
    type: string
    sql: ${TABLE}.AUDIT_ACCESS_LOG_LAST_NAME ;;
  }

  dimension: audit_access_log_initials {
    label: "Initials "
    group_label: "User Info"
    description: "Initials of the user on the remote client"
    type: string
    sql: ${TABLE}.AUDIT_ACCESS_LOG_INITIALS ;;
  }

  dimension: audit_access_log_user_id {
    label: "User ID "
    group_label: "User Info"
    description: "User ID of the user on the remote client"
    type: string
    sql: ${TABLE}.AUDIT_ACCESS_LOG_USER_ID ;;
  }

  dimension: audit_access_log_license_number {
    label: "License Number"
    group_label: "User Info"
    description: "License number of the user on the remote client"
    type: string
    sql: ${TABLE}.AUDIT_ACCESS_LOG_LICENSE_NUMBER ;;
  }

  dimension: audit_access_log_software_version_number {
    label: "Software Version Number"
    description: "Version of the software the remote client is running"
    type: string
    sql: ${TABLE}.AUDIT_ACCESS_LOG_SOFTWARE_VERSION_NUMBER ;;
  }

  dimension: audit_access_log_message_version_number {
    label: "Message Version Number "
    description: "Version number of the message set used for this communication between client and server"
    type: number
    sql: ${TABLE}.AUDIT_ACCESS_LOG_MESSAGE_VERSION_NUMBER ;;
  }

  dimension: audit_access_log_request_content_size {
    label: "Message Request"
    group_label: "Content Size"
    description: "Total size of the saved request in the AUDIT_MESSAGE_CONTENT"
    type: number
    sql: ${TABLE}.AUDIT_ACCESS_LOG_REQUEST_CONTENT_SIZE ;;
  }

  dimension: audit_access_log_response_content_size {
    label: "Message Response"
    group_label: "Content Size"
    description: "Total size of the saved response in the AUDIT_MESSAGE_CONTENT"
    type: number
    sql: ${TABLE}.AUDIT_ACCESS_LOG_RESPONSE_CONTENT_SIZE ;;
  }

  dimension: audit_access_log_database_instance {
    label: "Database Instance"
    description: "Instance of the database"
    type: number
    sql: ${TABLE}.AUDIT_ACCESS_LOG_DATABASE_INSTANCE ;;
  }

  dimension: audit_access_log_database_session_id {
    label: "Database Session ID"
    description: "ID of the database session"
    type: number
    sql: ${TABLE}.AUDIT_ACCESS_LOG_DATABASE_SESSION_ID ;;
  }

  dimension: audit_access_log_lcr_id {
    label: "LCR ID"
    description: "Unique ID populated during the data load process that identifies the record"
    type: number
    hidden: yes
    sql: ${TABLE}.AUDIT_ACCESS_LOG_LCR_ID ;;
  }

  dimension_group: source_timestamp {
    label: "Source Timestamp"
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
    hidden: yes
    description: "This is the date and time at which the record was last updated in the source application"
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
  }

  ############################################# Measures #####################################################

  measure: avg_response_time {
    label: "Average Response Time"
    description: "The Average Time taken to send a response back to the client based on the incoming message timestamp. It's the difference of Incoming and Outgoing Message Timestamp, measured in seconds"
    type: average
    sql: ${TABLE}.RESPONSE_TIME;;
    value_format: "#,##0.0000 \" Sec\""
    html: {% if value < 1.5 %}
        <b><p style="color: green; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
      {% else %}
        <b><p style="color: red; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
      {% endif %}
      ;;
  }

  measure: median_response_time {
    label: "Median Response Time"
    description: "The Median Time taken to send a response back to the client based on the incoming message timestamp. It's the difference of Incoming and Outgoing Message Timestamp, measured in seconds"
    type: median
    sql: ${TABLE}.RESPONSE_TIME;;
    value_format: "#,##0.0000 \" Sec\""
    html: {% if value < 1.5 %}
        <b><p style="color: green; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
      {% else %}
        <b><p style="color: red; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
      {% endif %}
      ;;
  }

  measure: min_response_time {
    label: "Minimum Response Time"
    description: "The Minimum Time taken to send a response back to the client based on the incoming message timestamp. It's the difference of Incoming and Outgoing Message Timestamp, measured in seconds"
    type: min
    sql: ${TABLE}.RESPONSE_TIME;;
    value_format: "#,##0.0000 \" Sec\""
  }

  measure: max_response_time {
    label: "Maximum Response Time"
    description: "The Maximum Time taken to send a response back to the client based on the incoming message timestamp. It's the difference of Incoming and Outgoing Message Timestamp, measured in seconds"
    type: max
    sql: ${TABLE}.RESPONSE_TIME;;
    value_format: "#,##0.0000 \" Sec\""
  }

  measure: count {
    label: "Audit Record Count"
    description: "Total Audit Log Records"
    type: count
    value_format: "#,##0"
    drill_fields: [
      audit_access_log_id,
      audit_access_log_audit_time,
      chain_id,
      chain.chain_name,
      audit_access_log_nhin_id,
      epr_service_type.service_id,
      epr_service_type.service_name,
      store.store_number,
      store.store_name,
      store.client_type,
      store.client_version,
      audit_access_log_message_version_number,
      audit_access_log_incoming_time,
      audit_access_log_outgoing_time,
      avg_response_time,
      audit_access_log_status
    ]
  }

############################################# Sets #####################################################

  set: explore_rx_audit_access_log_4_13_candidate_list {
    fields: [
      chain_id,
      audit_access_log_id,
      source_system_id,
      audit_access_log_pdx_message_id,
      audit_access_log_client_ip,
      audit_access_log_client_id_type,
      audit_access_log_nhin_id,
      audit_access_log_status,
      audit_access_log_audit_mode,
      audit_access_log_code,
      audit_access_log_first_name,
      audit_access_log_middle_name,
      audit_access_log_last_name,
      audit_access_log_initials,
      audit_access_log_user_id,
      audit_access_log_license_number,
      audit_access_log_software_version_number,
      audit_access_log_message_version_number,
      audit_access_log_request_content_size,
      audit_access_log_response_content_size,
      audit_access_log_hash_value,
      audit_access_log_database_instance,
      audit_access_log_database_session_id,
      service_id,
      audit_access_log_lcr_id,
      source_timestamp
    ]
  }
}
