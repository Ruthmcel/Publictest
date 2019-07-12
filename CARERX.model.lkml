label: "Care Rx"

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

############################################################ Things to know in this model ######################################################################
#### Note: 1. All explores shown below are extended from explore.base_cs.lookml master file
#### Note: 2. Currently this model will not include access_filter_fields so All customer data across this Model can be accessible
#################################################################################################################################################################


########################################################### Explores ############################################################################################

explore: carerx_chain {
  label: "Chain"
  view_name: carerx_chain
  description: "The Chain Explore displays information related to Chains in Care Rx regardless of whether they are linked to Programs or Sessions."
}

explore: carerx_program {
  label: "Program"
  view_name: carerx_program
  description: "The Program Explore displays information related to Care Rx Programs regardless of whether they are linked to Patients or Sessions."
}

###### PATIENT EXPLORE ######

explore: carerx_patient {
  extends: [carerx_patient_base]
}

###### PATIENT THRID PARTY EXPLORE ######

explore: carerx_patient_third_party {
  extends: [carerx_patient_third_party_base]
}

###### PATIENT PROGRAM SESSION EXPLORE ######

explore: carerx_patient_program_session {
  extends: [carerx_patient_program_session_base]
}

################################################################################################################################################################
