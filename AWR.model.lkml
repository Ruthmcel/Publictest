label: "Automatic Workload Repository"

connection: "oracle_epr"

# include all the views
include: "awr_*.view"

# This will be used when adding lookML Dashboards. Commented this as LookML dashboard was added for TurnRx TRX-3091
#include: "*.dashboard"

# includes the base lookml file if not a view file
include: "explore.base_cs"

# Caching Parameter
persist_for: "1 hour"

# sets the week start day to Sunday. This will set all week-related timeframes to start on Sunday across the entire model. This affects the week, day_of_week, and day_of_week_index timeframes, as well as filtering on weeks.
week_start_day: sunday

############################################################ Things to know in this model ######################################################################
#### Note: 1. All explores shown below are extended from explore.base_cs.lookml master file
#### Note: 2. Currently this model will not include access_filter_fields so All customer data across this Model can be accessible
#### Note: 3. This Model is specifically created to monitor and analyze AWR Data w.r.t to Interconnect Performance in a Clustered environment
#### Note: 4. Currently there is only one database NHINP in Oracle Production where Interconnect exists as Interconnect typically exists only in a RAC environment
#### Model added as part of ERXLPS-90 change
#################################################################################################################################################################


########################################################### Explores ############################################################################################
explore: awr_report {
  extends: [awr_report_base]
}

################################################################################################################################################################
