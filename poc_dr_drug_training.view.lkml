view: poc_dr_drug_training {
    derived_table: {
      sql:
          with month_calendar as
          --SQL to generate first day of month from 2015 -2017
          (select distinct date_trunc('month', calendar_date) calendar_date
                  from ( SELECT TO_DATE(DATEADD(DAY,SEQ4(),TRUNC(TO_DATE(TO_TIMESTAMP('2015-01-01 12:00:00')),'DAY'))) AS CALENDAR_DATE FROM TABLE(GENERATOR(rowCount => 1080)))
                  where calendar_date < date_trunc('year',current_date())
          ),
          drug_awp_changes as (
             select ndc,
                    substr(ndc,1,9) ndc9,
                    drug_name,
                    cost_type,
                    pack,
                    change_date,
                    --pack_price,
                    date_trunc('month', change_date) awp_change_month,
                    lead(date_trunc('month', change_date),1) over(partition by ndc, drug_name, cost_type, pack order by change_date asc) next_awp_change_month,
                    substr(ndc,1,5) mfr,
                    case when date_trunc('month', change_date) = first_awp_change_change_date then 'N' else 'Y' end awp_change_flag,
                    --lag(pack_price,1) over(partition by ndc, drug_name, cost_type, pack order by change_date asc)  previous_awp_pack_price,
                    nvl(trunc((pack_price - lag(pack_price,1) over(partition by ndc, drug_name, cost_type, pack order by change_date asc))/(lag(pack_price,1) over(partition by ndc, drug_name, cost_type, pack order by change_date asc))*100,2),0) pct_awp_pack_price_change,
                    awp_changes_in_month
              from ( select ndc,
                            drug_name,
                            cost_type,
                            pack,
                            change_date,
                            unit_price pack_price, --unit_price column has pack_price values
                            max(change_date) over(partition by ndc, drug_name, cost_type, pack, date_trunc('month',change_date)) max_awp_change_date_in_month,
                            min(date_trunc('month',change_date)) over(partition by ndc, drug_name, cost_type, pack) first_awp_change_change_date,
                            count(*) over(partition by ndc, drug_name, cost_type, pack, date_trunc('month',change_date)) awp_changes_in_month
                      from public.nhin_drug_changes
                      where cost_type = 'A'
                   ) where change_date = max_awp_change_date_in_month --filter applied to get the latest change in a month for AWP cost
            ),
          drug_awp_changes_final as (
            select d.ndc,
                   substr(d.ndc,1,9) ndc9,
                   d.drug_name, --d.cost_type,
                   d.pack,
                   d.awp_change_month,
                   d.mfr,
                   case when d.awp_change_month = m.calendar_date then awp_change_flag else 'N' end awp_change_flag,
                   case when d.awp_change_month = m.calendar_date then d.pct_awp_pack_price_change else 0 end pct_awp_pack_price_change,
                   d.awp_changes_in_month,
                   m.calendar_date
            from drug_awp_changes d,
            month_calendar m
            where m.calendar_date >= d.awp_change_month --display months only from the first change of awp cost
            and m.calendar_date < nvl(d.next_awp_change_month, date_trunc('year',current_date()))
          ),
          drug_wac_changes as (
             select ndc,
                    substr(ndc,1,9) ndc9,
                    drug_name,
                    cost_type,
                    pack,
                    change_date,
                    --pack_price,
                    date_trunc('month', change_date) wac_change_month,
                    lead(date_trunc('month', change_date),1) over(partition by ndc, drug_name, cost_type, pack order by change_date asc) next_wac_change_month,
                    substr(ndc,1,5) mfr,
                    case when date_trunc('month', change_date) = first_wac_change_change_date then 'N' else 'Y' end wac_change_flag,
                    --lag(pack_price,1) over(partition by ndc, drug_name, cost_type, pack order by change_date asc)  previous_wac_pack_price,
                    nvl(trunc((pack_price - lag(pack_price,1) over(partition by ndc, drug_name, cost_type, pack order by change_date asc))/(lag(pack_price,1) over(partition by ndc, drug_name, cost_type, pack order by change_date asc))*100,2),0) pct_wac_pack_price_change,
                    wac_changes_in_month
              from ( select ndc,
                            drug_name,
                            cost_type,
                            pack,
                            change_date,
                            unit_price pack_price, --unit_price column has pack_price values
                            max(change_date) over(partition by ndc, drug_name, cost_type, pack, date_trunc('month',change_date)) max_wac_change_date_in_month,
                            min(date_trunc('month',change_date)) over(partition by ndc, drug_name, cost_type, pack) first_wac_change_change_date,
                            count(*) over(partition by ndc, drug_name, cost_type, pack, date_trunc('month',change_date)) wac_changes_in_month
                      from public.nhin_drug_changes
                      where cost_type = 'W'
                   ) where change_date = max_wac_change_date_in_month --filter applied to get the latest change in a month for AWP cost
            ),
          drug_wac_changes_final as (
            select d.ndc,
                   substr(d.ndc,1,9) ndc9,
                   d.drug_name, --d.cost_type,
                   d.pack,
                   d.wac_change_month,
                   d.mfr,
                   case when d.wac_change_month = m.calendar_date then wac_change_flag else 'N' end wac_change_flag,
                   case when d.wac_change_month = m.calendar_date then d.pct_wac_pack_price_change else 0 end pct_wac_pack_price_change,
                   d.wac_changes_in_month,
                   m.calendar_date
            from drug_wac_changes d,
            month_calendar m
            where m.calendar_date >= d.wac_change_month --display months only from the first change of awp cost
            and m.calendar_date < nvl(d.next_wac_change_month, date_trunc('year',current_date()))
          )
          select seq8() row_identifier,
                 'NDC-'||coalesce(dac.ndc, dwc.ndc) drug_ndc,
                 'NDC9-'||coalesce(dac.ndc9, dwc.ndc9) drug_ndc9,
                 coalesce(dac.drug_name, dwc.drug_name) drug_name,
                 coalesce(dac.pack, dwc.pack) drug_pack_size,
                 'MFR-'||coalesce(dac.mfr, dwc.mfr) drug_manufacturer,
                 coalesce(dac.calendar_date, dwc.calendar_date) drug_change_date,
                 dac.awp_change_flag drug_awp_change_flag,
                 dac.pct_awp_pack_price_change drug_pct_awp_pack_price_change,
                 --dac.awp_changes_in_month drug_awp_changes_in_month,
                 case when dac.awp_change_flag = 'Y' then dac.awp_changes_in_month else 0 end drug_awp_changes_in_month,
                 dwc.wac_change_flag drug_wac_change_flag,
                 dwc.pct_wac_pack_price_change drug_pct_wac_pack_price_change,
                 --dwc.wac_changes_in_month drug_wac_changes_in_month
                 case when dwc.wac_change_flag = 'Y' then dwc.wac_changes_in_month else 0 end drug_wac_changes_in_month
          from drug_awp_changes_final dac
          full outer join drug_wac_changes_final dwc
          on dac.ndc = dwc.ndc and dac.drug_name = dwc.drug_name and dac.pack = dwc.pack and dac.calendar_date = dwc.calendar_date
          order by dac.ndc, dwc.ndc, dac.calendar_date, dwc.calendar_date
           ;;
    }

    dimension: row_identifier {
      type:  number
      label: "Drug Row Identifier"
      sql: ${TABLE}.ROW_IDENTIFIER;;
    }

    dimension: drug_ndc {
      type: string
      description: "Drug NDC"
      label: "Drug NDC"
      sql: SUBSTR(${TABLE}.DRUG_NDC,5) ;;
    }

    dimension: drug_ndc9 {
      type: string
      description: "Drug NDC9"
      label: "Drug NDC9"
      sql: SUBSTR(${TABLE}.DRUG_NDC9,6) ;;
    }

    dimension: drug_name {
      type: string
      description: "Drug Name"
      label: "Drug Name"
      sql: ${TABLE}.DRUG_NAME ;;
    }

    dimension: drug_pack_size {
      type: number
      description: "Drug Pack Size"
      label: "Drug Pack Size"
      sql: ${TABLE}.DRUG_PACK_SIZE ;;
    }

    dimension: drug_manufacturer {
      type: string
      description: "Drug Manufacturer"
      label: "Drug Manufacturer"
      sql: ${TABLE}.DRUG_MANUFACTURER ;;
    }

    dimension_group: drug_change {
      type: time
      timeframes: [date]
      description: "Drug Change Date."
      label: "Drug Change"
      sql: ${TABLE}.DRUG_CHANGE_DATE ;;
    }

    dimension: drug_awp_change_flag {
      type: yesno
      description: "Drug AWP Price Change"
      label: "Drug AWP Price Change"
      sql: ${TABLE}.DRUG_AWP_CHANGE_FLAG = 'Y' ;;
    }

    dimension: drug_pct_awp_pack_price_change {
      type: number
      description: "Drug AWP Pack Price Change %"
      label: "Drug AWP Pack Price Change %"
      sql: ${TABLE}.DRUG_PCT_AWP_PACK_PRICE_CHANGE ;;
    }

    dimension: drug_awp_changes_in_month {
      type: number
      description: "Drug AWP Changes in Month"
      label: "Drug AWP Changes in Month"
      sql: ${TABLE}.DRUG_AWP_CHANGES_IN_MONTH ;;
    }

    dimension: drug_wac_change_flag {
      type: yesno
      description: "Drug WAC Price Change"
      label: "Drug WAC Price Change"
      sql: ${TABLE}.DRUG_WAC_CHANGE_FLAG = 'Y' ;;
    }

    dimension: drug_pct_wac_pack_price_change {
      type: number
      description: "Drug WAC Pack Price Change %"
      label: "Drug WAC Pack Price Change %"
      sql: ${TABLE}.DRUG_PCT_WAC_PACK_PRICE_CHANGE ;;
    }

    dimension: drug_wac_changes_in_month {
      type: number
      description: "Drug WAC Changes in Month"
      label: "Drug WAC Changes in Month"
      sql: ${TABLE}.DRUG_WAC_CHANGES_IN_MONTH ;;
    }
  }
