connection: "thelook"

# include the base lookml file if not a view file
include: "explore.base_carerx_dss"

# included only ar_* views and other views which are used in base explore joins
include: "carerx_*.view"
include: "chain.view"
include: "store.view"
include: "store_alignment.view"

# include all dashboards in this project
include: "carerxdss_*.dashboard"

label: "CareRx - Application Embed"

# sets the week start day to Sunday. This will set all week-related timeframes to start on Sunday across the entire model. This affects the week, day_of_week, and day_of_week_index timeframes, as well as filtering on weeks.
week_start_day: sunday

# Does not convert values to upper case for data search
case_sensitive: yes

persist_for: "24 hours"

# extending from base explore.
explore: carerx_clinical_session_patient_interview {
  extends: [carerx_clinical_session_patient_interview_base]
}
