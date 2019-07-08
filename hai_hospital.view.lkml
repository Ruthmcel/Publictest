view: hai_hospital {
  sql_table_name: REPORT_TEMP.HAI_HOSPITAL ;;

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${provider_id}  ||'@'|| ${measure_id} ;;
  }

########################################################### Foreign Key References ###############################################

  dimension: provider_id {
    hidden:  yes
    type: string
    sql: ${TABLE}.PROVIDER_ID ;;
  }

  dimension: measure_id {
    type: string
    hidden:  yes
    sql: ${TABLE}.MEASURE_ID ;;
  }

################################################################################################################################

  dimension: address {
    type: string
    hidden:  yes
    sql: ${TABLE}.ADDRESS ;;
  }

  dimension: city {
    type: string
    hidden:  yes
    sql: ${TABLE}.CITY ;;
  }

  dimension: compared_to_national {
    type: string
    sql: ${TABLE}.COMPARED_TO_NATIONAL ;;
  }

  dimension: county_name {
    type: string
    sql: ${TABLE}.COUNTY_NAME ;;
  }

  dimension: footnote {
    type: string
    sql: ${TABLE}.FOOTNOTE ;;
  }

  dimension: hospital_name {
    type: string
    hidden:  yes
    sql: ${TABLE}.HOSPITAL_NAME ;;
  }

  dimension: measure_name {
    hidden:  yes
    type: string
    sql: ${TABLE}.MEASURE_NAME ;;
  }

  dimension: phone_number {
    type: string
    hidden:  yes
    sql: ${TABLE}.PHONE_NUMBER ;;
  }

  dimension: state {
    type: string
    hidden:  yes
    sql: ${TABLE}.STATE ;;
  }

  dimension: zip_code {
    type: zipcode
    hidden:  yes
    sql: ${TABLE}.ZIP_CODE ;;
  }

  measure: total_providers {
    hidden:  yes
    type: count
  }

#   measure: total_score {
#     type: sum
#     sql: ${TABLE}.SCORE ;;
#   }
#
#   measure: avg_score {
#     type: average
#     sql: ${TABLE}.SCORE ;;
#   }

  measure: avg_clabsi_select_ward {
    label: "Central line-associated bloodstream infections (CLABSI) in ICUs and select wards - Avg"
    type: average
    sql: CASE WHEN ${measure_id} IN ('HAI_1_SIR') THEN ${TABLE}.SCORE END;;
    html:
    {% if value > 1 %}
    <p><img src="https://findicons.com/files/icons/1692/32px_mania/32/misc_28.png" height=20 width=20>{{ rendered_value }}</p>
    {% elsif value < 1 %}
    <p><img src="https://findicons.com/files/icons/941/web_design/32/arrow_down.png" height=20 width=20>{{ rendered_value }}</p>
    {% else %}
    <p><img src="https://findicons.com/files/icons/1665/sweetie_basepack/16/16_circle_green.png" height=20 width=20>{{ rendered_value }}</p>
    {% endif %}
    ;;
    value_format: "#,##0.0000;(#,##0.0000)"
  }

  measure: median_clabsi_select_ward {
    label: "Central line-associated bloodstream infections (CLABSI) in ICUs and select wards - Median"
    type: median
    sql: CASE WHEN ${measure_id} IN ('HAI_1_SIR') THEN ${TABLE}.SCORE END;;
    html:
    {% if value > 1 %}
    <p><img src="https://findicons.com/files/icons/1692/32px_mania/32/misc_28.png" height=20 width=20>{{ rendered_value }}</p>
    {% elsif value < 1 %}
    <p><img src="https://findicons.com/files/icons/941/web_design/32/arrow_down.png" height=20 width=20>{{ rendered_value }}</p>
    {% else %}
    <p><img src="https://findicons.com/files/icons/1665/sweetie_basepack/16/16_circle_green.png" height=20 width=20>{{ rendered_value }}</p>
    {% endif %}
    ;;
    value_format: "#,##0.0000;(#,##0.0000)"
  }

  measure: avg_cauti_select_ward {
    label: "Catheter-associated urinary tract infections (CAUTI) in ICUs and select wards - Avg"
    type: average
    sql: CASE WHEN ${measure_id} IN ('HAI_2_SIR') THEN ${TABLE}.SCORE END;;
    html:
    {% if value > 1 %}
    <p><img src="https://findicons.com/files/icons/1692/32px_mania/32/misc_28.png" height=20 width=20>{{ rendered_value }}</p>
    {% elsif value < 1 %}
    <p><img src="https://findicons.com/files/icons/941/web_design/32/arrow_down.png" height=20 width=20>{{ rendered_value }}</p>
    {% else %}
    <p><img src="https://findicons.com/files/icons/1665/sweetie_basepack/16/16_circle_green.png" height=20 width=20>{{ rendered_value }}</p>
    {% endif %}
    ;;
    value_format: "#,##0.0000;(#,##0.0000)"
  }

  measure: median_cauti_select_ward {
    label: "Catheter-associated urinary tract infections (CAUTI) in ICUs and select wards - Median"
    type: median
    sql: CASE WHEN ${measure_id} IN ('HAI_2_SIR') THEN ${TABLE}.SCORE END;;
    html:
    {% if value > 1 %}
    <p><img src="https://findicons.com/files/icons/1692/32px_mania/32/misc_28.png" height=20 width=20>{{ rendered_value }}</p>
    {% elsif value < 1 %}
    <p><img src="https://findicons.com/files/icons/941/web_design/32/arrow_down.png" height=20 width=20>{{ rendered_value }}</p>
    {% else %}
    <p><img src="https://findicons.com/files/icons/1665/sweetie_basepack/16/16_circle_green.png" height=20 width=20>{{ rendered_value }}</p>
    {% endif %}
    ;;
    value_format: "#,##0.0000;(#,##0.0000)"
  }

  measure: avg_ssi_colon_surgery {
    label: "Surgical site infections (SSI) from colon surgery - Avg"
    type: average
    sql: CASE WHEN ${measure_id} IN ('HAI_3_SIR') THEN ${TABLE}.SCORE END;;
    html:
    {% if value > 1 %}
    <p><img src="https://findicons.com/files/icons/1692/32px_mania/32/misc_28.png" height=20 width=20>{{ rendered_value }}</p>
    {% elsif value < 1 %}
    <p><img src="https://findicons.com/files/icons/941/web_design/32/arrow_down.png" height=20 width=20>{{ rendered_value }}</p>
    {% else %}
    <p><img src="https://findicons.com/files/icons/1665/sweetie_basepack/16/16_circle_green.png" height=20 width=20>{{ rendered_value }}</p>
    {% endif %}
    ;;
    value_format: "#,##0.0000;(#,##0.0000)"
  }

  measure: median_ssi_colon_surgery {
    label: "Surgical site infections (SSI) from colon surgery - Median"
    type: median
    sql: CASE WHEN ${measure_id} IN ('HAI_3_SIR') THEN ${TABLE}.SCORE END;;
    html:
    {% if value > 1 %}
    <p><img src="https://findicons.com/files/icons/1692/32px_mania/32/misc_28.png" height=20 width=20>{{ rendered_value }}</p>
    {% elsif value < 1 %}
    <p><img src="https://findicons.com/files/icons/941/web_design/32/arrow_down.png" height=20 width=20>{{ rendered_value }}</p>
    {% else %}
    <p><img src="https://findicons.com/files/icons/1665/sweetie_basepack/16/16_circle_green.png" height=20 width=20>{{ rendered_value }}</p>
    {% endif %}
    ;;
    value_format: "#,##0.0000;(#,##0.0000)"
  }

  measure: avg_ssi_abdominal_hysterectomy {
    label: "Surgical site infections (SSI) from abdominal hysterectomy - Avg"
    type: average
    sql: CASE WHEN ${measure_id} IN ('HAI_4_SIR') THEN ${TABLE}.SCORE END;;
    html:
    {% if value > 1 %}
    <p><img src="https://findicons.com/files/icons/1692/32px_mania/32/misc_28.png" height=20 width=20>{{ rendered_value }}</p>
    {% elsif value < 1 %}
    <p><img src="https://findicons.com/files/icons/941/web_design/32/arrow_down.png" height=20 width=20>{{ rendered_value }}</p>
    {% else %}
    <p><img src="https://findicons.com/files/icons/1665/sweetie_basepack/16/16_circle_green.png" height=20 width=20>{{ rendered_value }}</p>
    {% endif %}
    ;;
    value_format: "#,##0.0000;(#,##0.0000)"
  }

  measure: median_ssi_abdominal_hysterectomy {
    label: "Surgical site infections (SSI) from abdominal hysterectomy - Median"
    type: median
    sql: CASE WHEN ${measure_id} IN ('HAI_4_SIR') THEN ${TABLE}.SCORE END;;
    html:
    {% if value > 1 %}
    <p><img src="https://findicons.com/files/icons/1692/32px_mania/32/misc_28.png" height=20 width=20>{{ rendered_value }}</p>
    {% elsif value < 1 %}
    <p><img src="https://findicons.com/files/icons/941/web_design/32/arrow_down.png" height=20 width=20>{{ rendered_value }}</p>
    {% else %}
    <p><img src="https://findicons.com/files/icons/1665/sweetie_basepack/16/16_circle_green.png" height=20 width=20>{{ rendered_value }}</p>
    {% endif %}
    ;;
    value_format: "#,##0.0000;(#,##0.0000)"
  }

  measure: avg_mrsa_blood_infection {
    label: "Methicillin-resistant Staphylococcus Aureus (MRSA) blood infections - Avg"
    type: average
    sql: CASE WHEN ${measure_id} IN ('HAI_5_SIR') THEN ${TABLE}.SCORE END;;
    html:
    {% if value > 1 %}
    <p><img src="https://findicons.com/files/icons/1692/32px_mania/32/misc_28.png" height=20 width=20>{{ rendered_value }}</p>
    {% elsif value < 1 %}
    <p><img src="https://findicons.com/files/icons/941/web_design/32/arrow_down.png" height=20 width=20>{{ rendered_value }}</p>
    {% else %}
    <p><img src="https://findicons.com/files/icons/1665/sweetie_basepack/16/16_circle_green.png" height=20 width=20>{{ rendered_value }}</p>
    {% endif %}
    ;;
    value_format: "#,##0.0000;(#,##0.0000)"
  }

  measure: median_mrsa_blood_infection {
    label: "Methicillin-resistant Staphylococcus Aureus (MRSA) blood infections - Median"
    type: median
    sql: CASE WHEN ${measure_id} IN ('HAI_5_SIR') THEN ${TABLE}.SCORE END;;
    html:
    {% if value > 1 %}
    <p><img src="https://findicons.com/files/icons/1692/32px_mania/32/misc_28.png" height=20 width=20>{{ rendered_value }}</p>
    {% elsif value < 1 %}
    <p><img src="https://findicons.com/files/icons/941/web_design/32/arrow_down.png" height=20 width=20>{{ rendered_value }}</p>
    {% else %}
    <p><img src="https://findicons.com/files/icons/1665/sweetie_basepack/16/16_circle_green.png" height=20 width=20>{{ rendered_value }}</p>
    {% endif %}
    ;;
    value_format: "#,##0.0000;(#,##0.0000)"
  }

  measure: avg_cdiff_intestinal_infection {
    label: "Clostridium difficile (C.diff.) intestinal infections - Avg"
    type: average
    sql: CASE WHEN ${measure_id} IN ('HAI_6_SIR') THEN ${TABLE}.SCORE END;;
    html:
    {% if value > 1 %}
    <p><img src="https://findicons.com/files/icons/1692/32px_mania/32/misc_28.png" height=20 width=20>{{ rendered_value }}</p>
    {% elsif value < 1 %}
    <p><img src="https://findicons.com/files/icons/941/web_design/32/arrow_down.png" height=20 width=20>{{ rendered_value }}</p>
    {% else %}
    <p><img src="https://findicons.com/files/icons/1665/sweetie_basepack/16/16_circle_green.png" height=20 width=20>{{ rendered_value }}</p>
    {% endif %}
    ;;
    value_format: "#,##0.0000;(#,##0.0000)"
  }

  measure: median_cdiff_intestinal_infection {
    label: "Clostridium difficile (C.diff.) intestinal infections - Median"
    type: median
    sql: CASE WHEN ${measure_id} IN ('HAI_6_SIR') THEN ${TABLE}.SCORE END;;
    html:
    {% if value > 1 %}
    <p><img src="https://findicons.com/files/icons/1692/32px_mania/32/misc_28.png" height=20 width=20>{{ rendered_value }}</p>
    {% elsif value < 1 %}
    <p><img src="https://findicons.com/files/icons/941/web_design/32/arrow_down.png" height=20 width=20>{{ rendered_value }}</p>
    {% else %}
    <p><img src="https://findicons.com/files/icons/1665/sweetie_basepack/16/16_circle_green.png" height=20 width=20>{{ rendered_value }}</p>
    {% endif %}
    ;;
    value_format: "#,##0.0000;(#,##0.0000)"
  }
}
