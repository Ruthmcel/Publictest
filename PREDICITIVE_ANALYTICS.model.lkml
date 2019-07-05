label: "Predictive Analytics POC"

connection: "snowflake_predictive_analytics_poc"

# include all views in this project
include: "poc_*.view"

include: "explore.base_dss"


persist_for: "24 hours"

# sets the week start day to Sunday. This will set all week-related timeframes to start on Sunday across the entire model. This affects the week, day_of_week, and day_of_week_index timeframes, as well as filtering on weeks.
week_start_day: sunday

# converts values to upper case for data search
case_sensitive: no

explore: prescriber_predictive_analytics {
  label: "Prescriber LTM"
  extends: [poc_prescriber_base]
}

explore: Drug_predictive_analytics {
  label: "Drug Predictive Analytics"
  extends: [poc_drug_base]
}

explore: Drug_predicted_results {
  label: "Drug Predicted Results"
  extends: [poc_drug_predictited_base]
  }

explore: prescriber_predicted_results {
  label: "Prescriber Predicted Results"
  view_name: poc_prescriber_predicted
  view_label: "Prescriber Predicted"
  fields: [
    ALL_FIELDS*
    ]

  join: poc_store_prescriber {
    view_label: "Store Prescriber"
    type: inner
    sql_on: ${poc_prescriber_predicted.unique_prescriber_identifier} = ${poc_store_prescriber.unique_prescriber_identifier} ;;
    relationship: one_to_many
  }

  join: poc_rx_tx_link {
    view_label: "Prescription Transaction"
    type: inner
    sql_on: ${poc_store_prescriber.chain_id} = ${poc_rx_tx_link.chain_id} AND ${poc_store_prescriber.nhin_store_id} = ${poc_rx_tx_link.nhin_store_id} and ${poc_store_prescriber.prescriber_clinic_id} = ${poc_rx_tx_link.rx_tx_presc_clinic_link_id}  and ${poc_store_prescriber.unique_presc_row_num} = 1;;
    relationship: many_to_one
  }

  join: poc_eps_rx {
    view_label: "Prescription"
    type: inner
    sql_on: ${poc_eps_rx.chain_id} = ${poc_rx_tx_link.chain_id} AND ${poc_eps_rx.nhin_store_id} = ${poc_rx_tx_link.nhin_store_id} and ${poc_eps_rx.rx_id} = ${poc_rx_tx_link.rx_id} ;;
    relationship: many_to_one
  }

}

explore: poc_dr_prescriber_predictive_analytics {
  label: "DR Prescriber Sales"
  extends: [poc_dr_prescriber_base]
}

explore: poc_dr_drug_Training_data{
  label: "DR Drug Training Data"
  extends: [poc_dr_drug_training_base]
}

explore: poc_dr_drug_predictive_analytics {
  label: "DR Drug Price Change Prediction"
  extends: [poc_dr_drug_base]
}

explore: poc_dr_drug_prediction_data {
  label: "DR Drug Prediction Data"
  extends: [poc_dr_drug_prediction_base]
}

explore: poc_dr_session_predictive_analytics {
  label: "DR Session Success Rate"
  extends: [poc_dr_mtm_session_base]
}
