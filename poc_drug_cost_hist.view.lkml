view: poc_drug_cost_hist {
  derived_table: {
                  sql:
                  SELECT
    NDC,
    DRUG_NAME,
    COST_TYPE,
    PACK,
    UNIT_PRICE,
    PACK_PRICE,
    CHANGE_DATE,
    change_flag_cal_date_period,
    MAX_UNIT_PRICE,
    MIN_UNIT_PRICE,
    count_num,
    CASE WHEN change_flag_cal_date_period = 'YES' Then NULL
    WHEN (SUM(CHNAGE_COUNT) over(Partition BY NDC,DRUG_NAME,COST_TYPE,PACK))= 0 THEN 'N'
    WHEN (SUM(CHNAGE_COUNT) over(Partition BY NDC,DRUG_NAME,COST_TYPE,PACK))> 0 THEN 'Y' END
    AS COUNT_CHANGES_FLAG,
    CASE
        WHEN min_row_num = 1
        THEN UNIT_PRICE
        ELSE NULL
    END AS START_UNIT_PRICE,
    CASE
        WHEN max_row_num = 1
        THEN UNIT_PRICE
        ELSE NULL
    END AS END_UNIT_PRICE
FROM
    (
        SELECT
            NDC,
            DRUG_NAME,
            CASE
                WHEN COST_TYPE ='A'
                THEN 'AWP'
                WHEN COST_TYPE = 'W'
                THEN 'WAC'
                ELSE NULL
            END COST_TYPE,
            PACK,
            UNIT_PRICE,
            PACK_PRICE,
            CHANGE_DATE,
            {% parameter change_flag_cal_date_period %} change_flag_cal_date_period,
            count(NDC) over(Partition BY NDC,DRUG_NAME,COST_TYPE,PACK) AS count_num,
            MAX(UNIT_PRICE) over(Partition BY NDC,DRUG_NAME,COST_TYPE,PACK) AS MAX_UNIT_PRICE,
            MIN(UNIT_PRICE) over(Partition BY NDC,DRUG_NAME,COST_TYPE,PACK) AS MIN_UNIT_PRICE,
            Row_number() over (Partition BY NDC,DRUG_NAME,COST_TYPE,PACK ORDER BY CHANGE_DATE ASC )
            min_row_num,
            Row_number() over (Partition BY NDC,DRUG_NAME,COST_TYPE,PACK ORDER BY CHANGE_DATE DESC
            ) max_row_num,
            CASE
                WHEN (LEAD(UNIT_PRICE) over (Partition BY NDC,DRUG_NAME,COST_TYPE,PACK ORDER BY
                        CHANGE_DATE ASC) - UNIT_PRICE) IS NULL
                OR  (LEAD(UNIT_PRICE) over (Partition BY NDC,DRUG_NAME,COST_TYPE,PACK ORDER BY
                        CHANGE_DATE ASC) - UNIT_PRICE) = '0.0'
                THEN 0
                ELSE 1
            END CHNAGE_COUNT
        FROM
            public.nhin_drug_changes
            WHERE CHANGE_DATE between {% date_start drug_cost_change_date_period %} and {% date_end drug_cost_change_date_period %}
            ) DRUG_COST_HIST

    ;;
}

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${ndc} || '@' || ${cost_type} ;;
  }


  filter: drug_cost_change_date_period {
    label: "Drug Cost Change Date Period"
    description: "Patient New to Therapy Date Period"
    type: date
    default_value: "1 month ago for 1 month"
  }

  filter: change_flag_cal_date_period {
    label: "Change Flag Calculate"
    #description: "Patient New to Therapy Date Period"
    type: string
    #hidden: yes
    default_value: "NO"
    sql: ${TABLE}.change_flag_cal_date_period ;;
    suggestions: ["YES", "NO"]
  }


  dimension: ndc {
    label: "NDC"
    type: string
    sql: ${TABLE}.NDC ;;
  }

  dimension: cost_type {
    label: "Cost Type"
    type: string
    sql: ${TABLE}.COST_TYPE ;;
  }

  dimension: pack_size {
    label: "Pack Size"
    type: string
    sql: ${TABLE}.PACK ;;
  }

  dimension: dim_max_count_num_flag {
    label: "Price Increase Flag"
    type: string
    sql: ${TABLE}.COUNT_CHANGES_FLAG ;;
  }


  measure: count_num {
    hidden: yes
    type: count_distinct
    sql: ${TABLE}.count_num ;;
  }

  measure: max_count_num_flag {
    label: "Price Increase Flag"
    type: string
    hidden: yes
    sql: CASE
              WHEN max(${TABLE}.COUNT_CHANGES_FLAG) = 0 THEN 'N'
              WHEN max(${TABLE}.COUNT_CHANGES_FLAG) > 0 THEN 'Y'
              ELSE NULL END ;;
  }
  #WHEN ${TABLE}.change_flag_cal_date_period = 'YES' then NULL

  measure: max_unit_price {
    label: "Max Unit Price"
    type: max
    sql: ${TABLE}.UNIT_PRICE ;;
  }
  measure: min_unit_price {
    label: "Min Unit Price"
    type: max
    sql: ${TABLE}.UNIT_PRICE ;;
  }

  measure: start_unit_price {
    label: "Start Unit Price"
    type: max
    sql: ${TABLE}.START_UNIT_PRICE ;;
  }
  measure: end_unit_price {
    label: "End Unit Price"
    type: max
    sql: ${TABLE}.END_UNIT_PRICE ;;
  }

  measure: max_pack_price {
    label: "Max Pack Price"
    type: max
    hidden: yes
    sql: ${TABLE}.PACK_PRICE ;;
  }
  measure: min_pack_price {
    label: "Min Pack Price"
    type: min
    hidden: yes
    sql: ${TABLE}.PACK_PRICE ;;
  }

  measure: sum_unit_price {
    label: "Total Unit Price"
    type: sum
    sql: ${TABLE}.UNIT_PRICE ;;
  }

  measure: sum_pack_price {
    label: "Sum Pack Price"
    type: sum
    hidden: yes
    sql: ${TABLE}.PACK_PRICE ;;
  }

  measure: avg_pack_price {
    label: "Avg Pack Price"
    type: number
    hidden: yes
    sql: COALESCE(${sum_pack_price}/NULLIF(${count_num},0),0);;
  }

  measure: avg_unit_price {
    label: "Avg Unit Price"
    type: number
    sql: COALESCE(${sum_unit_price}/NULLIF(${count_num},0),0);;
  }

 }
