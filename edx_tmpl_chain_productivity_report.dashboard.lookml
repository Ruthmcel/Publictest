- dashboard: edx_tmpl_chain_productivity_report
  title: Productivity Report
  layout: newspaper
  elements:
  - title: Productivity Report
    name: Productivity Report
    model: PDX_CUSTOMER_DSS
    explore: eps_task_history
    type: table
    fields:
    - store.store_number
    - eps_task_history.task_history_task_name
    - store_user.store_user_first_name
    - store_user.store_user_last_name
    - eps_task_history.count
    - eps_task_history.avg_task_time
    filters:
      eps_task_history.task_history_task_action: COMPLETE,%FINISH%
      eps_task_history.task_history_status: "-%REJECT%,-%CANCEL%,-%UNDO^_MOVE%,-%PUTBACK%,-%NOTIFY%,-AUTOMATIC^_TIMEOUT,-OTHER,-KILL,-EXCEPTION,-REVERSE,-REPLACE^_MISSING"
      eps_task_history.task_history_user_employee_number: "-NULL,-01221"
      eps_task_history.task_history_action_current_date: 1 days ago for 1 days
    sorts:
    - eps_task_history.count desc
    limit: 500
    total: true
    query_timezone: America/Chicago
    listen: {}
    row: 0
    col: 0
    width: 24
    height: 10
