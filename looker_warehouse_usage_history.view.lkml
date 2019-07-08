view: looker_warehouse_usage_history {
  derived_table: {
    sql: -- derived sql to determine Snowflake warehouse utilization for users connected via Looker
       SELECT
        DISTINCT
               TRIM(CASE WHEN instance_identifier = 'exploredx' and user_email in ('djolly@pdxinc.com','kbibelhausen@pdxinc.com','jmeshanski@pdxinc.com')
               THEN 'Freds External User'
               ELSE role
               END) AS role, -- All View Ony roles are mapped under "External User" by chain
               TRIM(CASE WHEN instance_identifier = 'exploredx' and user_email in ('djolly@pdxinc.com','kbibelhausen@pdxinc.com','jmeshanski@pdxinc.com')
               THEN 'Freds'
               WHEN SUBSTRING(role,1,POSITION('External', role, 0)-1) =''
               THEN 'PDX'
               ELSE SUBSTRING(role,1,POSITION('External', role, 0)-1)
               END) as chain,
               query_created_hour,
               --TRIM(user_email) as user_email,
               hours_used
        FROM
        (
        SELECT replace(data_record:"role.name"::string,'View Only ') AS role,
               data_record:"history.created_time"::timestamp_ntz(0) as query_created_time,
               data_record:"user.email"::string as user_email,
               DATE_TRUNC('hour',  data_record:"history.created_time"::timestamp_ntz(0))  as query_created_hour,
               CAST(1 AS INT) AS hours_used,
               TO_DATE(process_timestamp) as process_timestamp,
               instance_identifier
               /*RANK() OVER(PARTITION BY data_record:"role.name"::string ORDER BY TO_DATE(process_timestamp) DESC) as rnk*/
        FROM REPORT_TEMP.LOOKER_REPORT_DATA
        ) src
       ;;
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: string
#     sql: ${role} ||'@'|| ${user_email} ||'@'|| ${query_created_time
    sql: ${role} ||'@'|| ${query_created_time};;
  }

  dimension: role {
          label: "Role"
          description: "Looker Roles"
          type: string
          sql: ${TABLE}.ROLE ;;
  }

  dimension: chain {
    label: "Chain"
    description: "Displays Customer Name"
    type: string
    sql: ${TABLE}.CHAIN ;;
  }

  dimension_group: query_created {
    label: "Query Created"
    description: "Date/Time Query was initiated by user"
    type: time
    timeframes: []
    sql: ${TABLE}.QUERY_CREATED_HOUR ;;
  }

#   dimension: user_email {
#     label: "User Email"
#     description: "Looker User Email"
#     type: string
#     sql: ${TABLE}.USER_EMAIL ;;
#   }

  measure: hours_used {
  label: "Hours Used"
  description: "Indicates 1, if a query was initiate by a user during a specific hour."
  type: sum # max is used to avoid showing overstated hours, if 9 users have used the warehouse during the same time interval.
  sql: CAST(1 AS INT);;
  }
}
