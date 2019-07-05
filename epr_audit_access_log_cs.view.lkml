view: epr_audit_access_log_cs {
  sql_table_name: EPS.AUDIT_ACCESS_LOG ;;

  dimension: id {
    label: "Audit Access Log ID"
    description: "Unique ID number identifying each record"
    primary_key: yes
    hidden:  yes
    type: number
    sql: ${TABLE}.ID ;;
  }

  dimension: chain_id {
    hidden: yes
    label: "Chain ID"
    description: "Unique assigned ID number for each customer chain."
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    hidden: yes
    label: "NHIN Store ID"
    description: "Identification number assinged to a store by NHIN, under each customer chain"
    type: number
    sql: ${TABLE}.NHIN_ID ;;
  }

  dimension: user_code {
    label: "Code"
    group_label: "User Info"
    description: "User code as provided by the remote system"
    type: string
    sql: ${TABLE}.CODE ;;
  }

  dimension: user_id {
    label: "ID"
    group_label: "User Info"
    description: "ID of the user on the remote client"
    type: string
    sql: ${TABLE}.USER_ID ;;
  }

  dimension: user_initials {
    label: "Initials"
    group_label: "User Info"
    description: "Initials of the user on the remote client"
    type: string
    sql: ${TABLE}.INITIALS ;;
  }

  dimension: user_license_number {
    label: "License Number"
    group_label: "User Info"
    description: "License number of the user on the remote client"
    type: string
    sql: ${TABLE}.LICENSE_NUMBER ;;
  }

  dimension: user_first_name {
    label: "First Name"
    group_label: "User Info"
    description: "First name of the user on the remote client"
    type: string
    sql: ${TABLE}.FIRST_NAME ;;
  }

  dimension: user_last_name {
    label: "Last Name"
    group_label: "User Info"
    description: "Last name of the user on the remote client"
    type: string
    sql: ${TABLE}.LAST_NAME ;;
  }

  dimension: middle_name {
    label: "Middle Name"
    group_label: "User Info"
    description: "Middle name of the user on the remote client"
    type: string
    sql: ${TABLE}.MIDDLE_NAME ;;
  }

  dimension: service {
    label: "Service"
    description: "Type of request that was received by the system"
    type: string
    sql: ${TABLE}.SERVICE ;;
    # Turned off suggestion to uncessarily scan Audit Access Log table for distinct Service. The Service would be potentially submitted via a Master Audit Access Service file.
    suggestions: ["false"]
  }

  dimension: status {
    label: "Status"
    description: "Indicates the 'success' or 'failure' of a transaction that passed through the system"
    type: string
    sql: ${TABLE}.STATUS ;;
    suggestions: ["SUCCESS", "FAILURE"]
  }

  dimension: software_version_number {
    label: "Software Version Number"
    description: "Version of the software the remote client is running"
    type: string
    sql: ${TABLE}.SOFTWARE_VERSION_NUMBER ;;
  }

  dimension: message_version_number {
    label: "Message Version Number"
    description: "Version number of the message set used for this communication between client and server"
    type: number
    sql: ${TABLE}.MESSAGE_VERSION_NUMBER ;;
  }

  dimension: pdx_message_id {
    label: "PDX Message ID"
    description: "Stores the value if a Message ID is provided in the message sent by the client"
    type: string
    sql: ${TABLE}.PDX_MESSAGE_ID ;;
  }

  dimension: client_ip {
    label: "Client IP"
    description: "The IP address of the remote system."
    type: string
    sql: ${TABLE}.CLIENT_IP ;;
  }

  dimension: client_id_type {
    hidden: yes
    label: "Client ID Type"
    description: "Type of ID that was provided in the Client ID field. Valid Values are: NHIN"
    type: string
    sql: ${TABLE}.CLIENT_ID_TYPE ;;
  }

  dimension: request_content_size {
    label: "Message Request"
    group_label: "Content Size"
    description: "Total size of the saved request in the AUDIT_MESSAGE_CONTENT"
    type: number
    sql: ${TABLE}.REQUEST_CONTENT_SIZE ;;
  }

  dimension: response_content_size {
    label: "Message Response"
    group_label: "Content Size"
    description: "Total size of the saved response in the AUDIT_MESSAGE_CONTENT"
    type: number
    sql: ${TABLE}.RESPONSE_CONTENT_SIZE ;;
  }

  dimension: hash_value {
    hidden: yes
    label: "Hash Value"
    description: "Set to improve indexing performance"
    type: number
    sql: ${TABLE}.HASH_VALUE ;;
  }

  dimension_group: outgoing {
    label: "Outgoing Message"
    description: "The server date/time recorded when all processing is complete and the system is about to send the response to the client"
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.OUTGOING_TIMESTAMP ;;
  }

  #     sql: FROM_TZ(${TABLE}.OUTGOING_TIMESTAMP,'UTC') at TIME zone 'US/Central' # timezone conversion not applied currently.

  dimension_group: incoming {
    label: "Incoming Message"
    description: "The server date/time recorded when the message was first received and before it had been processed in any way"
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.INCOMING_TIMESTAMP ;;
  }

  dimension_group: after_appserver {
    label: "After Appserver"
    description: "The date/time recorded by the system after completing the main transaction but before final processing and XML translation"
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.AFTER_APPSERVER_TIMESTAMP ;;
  }

  dimension_group: before_appserver {
    label: "Before Appserver"
    description: "The date/time recorded by the server after XML translation and initial preparation is complete and just before beginning 'real' work on the request"
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.BEFORE_APPSERVER_TIMESTAMP ;;
  }

  dimension_group: audit_in_central_timezone {
    label: "Audit (In Central)"
    description: "The date/time recorded during the creating of the audit record. This field will be primary used for displaying the results in US/Central. NOTE: Do not use this field for any filtering purposes for performance reasons."
    type: time
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
    sql: ${TABLE}.AUDIT_TIMESTAMP AT TIME ZONE 'US/Central' ;;
  }

  dimension_group: audit {
    label: "Audit"
    description: "The date/time recorded during the creating of the audit record"
    type: time
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
    sql: ${TABLE}.AUDIT_TIMESTAMP ;;
  }

  measure: avg_response_time {
    label: "Average Response Time"
    description: "The Average Time taken to send a response back to the client based on the incoming message timestamp. It's the difference of Incoming and Outgoing Message Timestamp, measured in seconds"
    type: number
    sql: avg(EXTRACT (DAY    FROM (outgoing_timestamp-incoming_timestamp))*24*60*60 + EXTRACT (HOUR   FROM (outgoing_timestamp-incoming_timestamp))*60*60 + EXTRACT (MINUTE FROM (outgoing_timestamp-incoming_timestamp))*60 + EXTRACT (SECOND FROM (outgoing_timestamp-incoming_timestamp))) ;;
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
    type: number
    sql: median(EXTRACT (DAY    FROM (outgoing_timestamp-incoming_timestamp))*24*60*60 + EXTRACT (HOUR   FROM (outgoing_timestamp-incoming_timestamp))*60*60 + EXTRACT (MINUTE FROM (outgoing_timestamp-incoming_timestamp))*60 + EXTRACT (SECOND FROM (outgoing_timestamp-incoming_timestamp))) ;;
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
    type: number
    sql: min(EXTRACT (DAY    FROM (outgoing_timestamp-incoming_timestamp))*24*60*60 + EXTRACT (HOUR   FROM (outgoing_timestamp-incoming_timestamp))*60*60 + EXTRACT (MINUTE FROM (outgoing_timestamp-incoming_timestamp))*60 + EXTRACT (SECOND FROM (outgoing_timestamp-incoming_timestamp))) ;;
    value_format: "#,##0.0000 \" Sec\""
  }

  measure: max_response_time {
    label: "Maximum Response Time"
    description: "The Maximum Time taken to send a response back to the client based on the incoming message timestamp. It's the difference of Incoming and Outgoing Message Timestamp, measured in seconds"
    type: number
    sql: max(EXTRACT (DAY    FROM (outgoing_timestamp-incoming_timestamp))*24*60*60 + EXTRACT (HOUR   FROM (outgoing_timestamp-incoming_timestamp))*60*60 + EXTRACT (MINUTE FROM (outgoing_timestamp-incoming_timestamp))*60 + EXTRACT (SECOND FROM (outgoing_timestamp-incoming_timestamp))) ;;
    value_format: "#,##0.0000 \" Sec\""
  }

  measure: count {
    label: "Audit Record Count"
    description: "Total Audit Log Records"
    type: number
    sql: count(*) ;;
    drill_fields: [
      id,
      audit_time,
      chain_id,
      ars_chain_cs.chain_name,
      nhin_store_id,
      epr_service_types_cs_edw.service,
      epr_service_types_cs_edw.service_name,
      ars_store_cs.store_number,
      ars_store_cs.store_name,
      ars_store_cs.client_type,
      ars_store_cs.client_version,
      message_version_number,
      incoming_time,
      outgoing_time,
      avg_response_time,
      status
    ]
    value_format: "#,###"
  }
}
