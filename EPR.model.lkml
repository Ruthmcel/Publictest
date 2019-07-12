label: "Enterprise Pharmacy Record"

connection: "thelook"

# include all the views
include: "*.view"

# This will be used when adding lookML Dashboards. Commented this as LookML dashboard was added for TurnRx TRX-3091
#include: "*.dashboard"

# includes the base lookml file if not a view file
include: "explore.base_cs"

# Caching Parameter
persist_for: "4 hours"

# sets the week start day to Sunday. This will set all week-related timeframes to start on Sunday across the entire model. This affects the week, day_of_week, and day_of_week_index timeframes, as well as filtering on weeks.
week_start_day: sunday

# ERXDWPS-5795 Changes
access_grant: can_view_genrx_specific_fields {
  user_attribute: allowed_chain
  allowed_values: [ "553", ">0 AND <> 119080", ">0", "NOT NULL" ]
}

############################################################ Things to know in this model ######################################################################
#### Note: 1. All explores shown below are extended from explore.base_cs.lookml master file
#### Note: 2. Currently this model will not include access_filter_fields so All customer data across this Model can be accessible
#################################################################################################################################################################


########################################################### Explores ############################################################################################
explore: epr_audit_access_log_cs {
  extends: [epr_audit_access_log_cs_base]
}

################################################################################################################################################################
