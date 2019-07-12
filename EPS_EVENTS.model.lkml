label: "EPS Events Using AVRO"

connection: "thelook"

# include all the views
include: "avro_*.view"

# This will be used when adding lookML Dashboards. Commented this as LookML dashboard was added for TurnRx TRX-3091
#include: "*.dashboard"

# Caching Parameter
persist_for: "24 hours"

# sets the week start day to Sunday. This will set all week-related timeframes to start on Sunday across the entire model. This affects the week, day_of_week, and day_of_week_index timeframes, as well as filtering on weeks.
week_start_day: sunday

############################################################ Things to know in this model ######################################################################
#### Note: 1. This model is built to test the ability to read AVRO data directly in Looker
#### Note: 2. This model is built using the avro_eps_workflow view file which reads information from ETL_MANAGER.WORKFLOW_AVRO table
#################################################################################################################################################################


########################################################### Explores ############################################################################################
explore: avro_eps_workflow {
  label: "Workflow"
}

################################################################################################################################################################

# This model as it was created from a Proof of Concept prespective to see if looker can directly talk to AVRO data in Snowflake and the the answer is YES !!!!
