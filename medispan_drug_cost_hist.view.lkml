view: medispan_drug_cost_hist {
  label: "Medi-Span Drug Cost Hist"
  sql_table_name: EDW.D_DRUG_COST_HIST ;;


  dimension: unique_key {
    hidden: yes
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${drug_cost_region} ||'@'|| ${ndc} ||'@'|| ${drug_cost_type_reference} ||'@'|| ${source_system_id} ||'@'|| ${drug_cost_hist_source_time} ;;
  }

  dimension: chain_id {
    type: number
    hidden: yes
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: drug_cost_region {
    hidden: yes
    type: number
    sql: ${TABLE}.DRUG_COST_REGION ;;
  }

  dimension: ndc {
    label: "Medi-Span Drug NDC"
    description: "Medi-Span Drug NDC associated with Medi-Span Drug Cost"
    type: string
    sql: ${TABLE}.NDC ;;
  }

  dimension: drug_cost_type_reference {
    label: "Medi-Span Drug Cost Type Code"
    description: "Medi-Span Drug Cost Type Code"
    type: string
    sql: ${TABLE}.DRUG_COST_TYPE ;;
  }

  dimension: drug_cost_type {
    label: "Medi-Span Drug Cost Type"
    description: "Medi-Span Drug Cost Type"
    type: string
    sql: CASE WHEN ${TABLE}.NDC IS NULL             THEN 'N/A'
              WHEN ${TABLE}.NDC IS NOT NULL
               AND ${TABLE}.DRUG_COST_TYPE IS NULL  THEN 'NULL - UNKNOWN'
              WHEN ${TABLE}.DRUG_COST_TYPE = 'A'    THEN 'A - AWP'
              WHEN ${TABLE}.DRUG_COST_TYPE = 'W'    THEN 'W - WAC'
              WHEN ${TABLE}.DRUG_COST_TYPE = 'C'    THEN 'C - DIRECT PRICING'
              WHEN ${TABLE}.DRUG_COST_TYPE = 'M'    THEN 'M - MAC'
              WHEN ${TABLE}.DRUG_COST_TYPE = '1'    THEN '1 - Average AWP'
              WHEN ${TABLE}.DRUG_COST_TYPE = 'G'    THEN 'G - Generic Equivalent Average Price'
              WHEN ${TABLE}.DRUG_COST_TYPE = 'NC'   THEN 'NC - NADAC CHAIN'
              WHEN ${TABLE}.DRUG_COST_TYPE = 'NI'   THEN 'NI - NADAC INDEPENDENT'
              WHEN ${TABLE}.DRUG_COST_TYPE = 'NS'   THEN 'NS - NADAC SPECIALITY'
              WHEN ${TABLE}.DRUG_COST_TYPE = 'NG'   THEN 'NG - NADAC GENERIC'
              WHEN ${TABLE}.DRUG_COST_TYPE = 'WA'   THEN 'WA - WEIGHTED AVERAGE AMP'
              WHEN ${TABLE}.DRUG_COST_TYPE = 'AF'   THEN 'AF - AF'
              WHEN ${TABLE}.DRUG_COST_TYPE = 'AAWP' THEN 'AAWP - AVERAGE AVERAGE WHOLESALE PRICE'
              WHEN ${TABLE}.DRUG_COST_TYPE = 'ACF'  THEN 'ACF - AFFORDABLE CARE ACT - FEDERAL UPPER LIMIT'
              WHEN ${TABLE}.DRUG_COST_TYPE = 'AWP'  THEN 'AWP - AVERAGE WHOLESALE PRICE'
              WHEN ${TABLE}.DRUG_COST_TYPE = 'DP'   THEN 'DP - DIRECT PRICE'
              WHEN ${TABLE}.DRUG_COST_TYPE = 'GEAP' THEN 'GEAP - GENERIC EQUIVALENT AVERAGE PRICE'
              WHEN ${TABLE}.DRUG_COST_TYPE = 'MAC'  THEN 'MAC - MAXIMUM ALLOWABLE COST'
              WHEN ${TABLE}.DRUG_COST_TYPE = 'NADC' THEN 'NADC - NATIONAL AVERAGE DRUG ACQUISITION COST CHAIN'
              WHEN ${TABLE}.DRUG_COST_TYPE = 'NADG' THEN 'NADG - NATIONAL AVERAGE DRUG ACQUISITION COST GENERIC'
              WHEN ${TABLE}.DRUG_COST_TYPE = 'NADI' THEN 'NADI - NATIONAL AVERAGE DRUG ACQUISITION COST INDEPENDENT'
              WHEN ${TABLE}.DRUG_COST_TYPE = 'NADS' THEN 'NADS - NATIONAL AVERAGE DRUG ACQUISITION COST SPECIALTY'
              WHEN ${TABLE}.DRUG_COST_TYPE = 'WAA'  THEN 'WAA - WEIGHTED AVERAGE - AVERAGE MANUFACTURER COST'
              WHEN ${TABLE}.DRUG_COST_TYPE = 'WAC'  THEN 'WAC - WHOLESALE ACQUISITION COST'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: ["NULL - UNKNOWN", "A - AWP", "W - WAC", "C - DIRECT PRICING", "M - MAC", "1 - Average AWP", "G - Generic Equivalent Average Price", "NC - NADAC CHAIN", "NI - NADAC INDEPENDENT", "NS - NADAC SPECIALITY", "NG - NADAC GENERIC", "WA - WEIGHTED AVERAGE AMP", "AF - AF", "AAWP - AVERAGE AVERAGE WHOLESALE PRICE", "ACF - AFFORDABLE CARE ACT - FEDERAL UPPER LIMIT", "AWP - AVERAGE WHOLESALE PRICE", "DP - DIRECT PRICE", "GEAP - GENERIC EQUIVALENT AVERAGE PRICE", "MAC - MAXIMUM ALLOWABLE COST", "NADC - NATIONAL AVERAGE DRUG ACQUISITION COST CHAIN", "NADG - NATIONAL AVERAGE DRUG ACQUISITION COST GENERIC", "NADI - NATIONAL AVERAGE DRUG ACQUISITION COST INDEPENDENT", "NADS - NATIONAL AVERAGE DRUG ACQUISITION COST SPECIALTY", "WAA - WEIGHTED AVERAGE - AVERAGE MANUFACTURER COST", "WAC - WHOLESALE ACQUISITION COST"]
    suggest_persist_for: "24 hours"
    drill_fields: [drug_cost_type_reference]
  }


  dimension: source_system_id {
    hidden: yes
    type: number
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: drug_cost_unit_amount {
    label: "Medi-Span Drug Cost Unit Amount"
    description: "Stores the Unit Cost Amount for a Medi-Span Drug Cost Type"
    type: number
    sql: ${TABLE}.DRUG_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  dimension: drug_cost_source_reference {
    label: "Medi-Span Drug Cost Source"
    type: string
    hidden: yes
    sql: ${TABLE}.DRUG_COST_SOURCE ;;
  }

  dimension: drug_cost_source {
    label: "Medi-Span Drug Cost Source"
    description: "Medi-Span Drug Cost Source Valid Values: M = MEDISPAN"
    type: string
    hidden: yes
    sql: CASE WHEN ${TABLE}.NDC IS NULL              THEN 'N/A'
              WHEN ${TABLE}.NDC IS NOT NULL
               AND ${TABLE}.DRUG_COST_SOURCE IS NULL THEN 'NULL - UNKNOWN'
              WHEN ${TABLE}.DRUG_COST_SOURCE = 'M'   THEN 'M - MEDISPAN'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: ["NULL - UNKNOWN", "M - MEDISPAN"]
    suggest_persist_for: "24 hours"
    drill_fields: [drug_cost_source_reference]
  }

  dimension: drug_cost_deleted {
    hidden: yes
    type: string
    sql: ${TABLE}.DRUG_COST_DELETED ;;
  }

  dimension_group: drug_cost_hist_source {
    label: "Medi-Span Drug Cost Source"
    description: "Date/Time the Medi-Span Drug Cost record was last updated in source"
    type: time
    sql: ${TABLE}.SOURCE_TIMESTAMP ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: drug_cost_lcr_id {
    label: "Medi-Span Drug Cost LCR ID"
    hidden : yes
    type: number
    sql: ${TABLE}.DRUG_COST_LCR_ID ;;
  }

  dimension: drug_cost_form_reference {
    label: "Medi-Span Drug Cost Form"
    type: string
    hidden: yes
    sql: ${TABLE}.DRUG_COST_FORM ;;
  }

  dimension: drug_cost_form {
    label: "Medi-Span Drug Cost Form"
    description: "Medi-Span Drug Cost Form in which this drug associated with this record is dispensed"
    type: string
    sql: CASE WHEN ${TABLE}.NDC IS NULL            THEN 'N/A'
              WHEN ${TABLE}.NDC IS NOT NULL
               AND ${TABLE}.DRUG_COST_FORM IS NULL THEN 'NULL - UNKNOWN'
              WHEN ${TABLE}.DRUG_COST_FORM = 'AER' THEN 'AER - AEROSOL'
              WHEN ${TABLE}.DRUG_COST_FORM = 'BAG' THEN 'BAG - BAG'
              WHEN ${TABLE}.DRUG_COST_FORM = 'BAR' THEN 'BAR - SOAP'
              WHEN ${TABLE}.DRUG_COST_FORM = 'BOT' THEN 'BOT - BOTTLE'
              WHEN ${TABLE}.DRUG_COST_FORM = 'BOX' THEN 'BOX - BOX'
              WHEN ${TABLE}.DRUG_COST_FORM = 'CAP' THEN 'CAP - CAPSULE'
              WHEN ${TABLE}.DRUG_COST_FORM = 'CHW' THEN 'CHW - CHEWABLE'
              WHEN ${TABLE}.DRUG_COST_FORM = 'CMB' THEN 'CMB - UNKNOWN'
              WHEN ${TABLE}.DRUG_COST_FORM = 'CON' THEN 'CON - CONC'
              WHEN ${TABLE}.DRUG_COST_FORM = 'CPB' THEN 'CPB - UNKNOWN'
              WHEN ${TABLE}.DRUG_COST_FORM = 'CRE' THEN 'CRE - CREAM'
              WHEN ${TABLE}.DRUG_COST_FORM = 'CRT' THEN 'CRT - CARTRIDGE'
              WHEN ${TABLE}.DRUG_COST_FORM = 'CRY' THEN 'CRY - CRYSTAL'
              WHEN ${TABLE}.DRUG_COST_FORM = 'DIS' THEN 'DIS - PATCH'
              WHEN ${TABLE}.DRUG_COST_FORM = 'DPR' THEN 'DPR - DIAPHRAGM'
              WHEN ${TABLE}.DRUG_COST_FORM = 'DRO' THEN 'DRO - DROP'
              WHEN ${TABLE}.DRUG_COST_FORM = 'DRP' THEN 'DRP - UNKNOWN'
              WHEN ${TABLE}.DRUG_COST_FORM = 'EA'  THEN 'EA - EACH'
              WHEN ${TABLE}.DRUG_COST_FORM = 'EFF' THEN 'EFF - EFF POWDER PACKET'
              WHEN ${TABLE}.DRUG_COST_FORM = 'EMU' THEN 'EMU - EMULSION'
              WHEN ${TABLE}.DRUG_COST_FORM = 'ENE' THEN 'ENE - ENEMA'
              WHEN ${TABLE}.DRUG_COST_FORM = 'FLM' THEN 'FLM - FILM'
              WHEN ${TABLE}.DRUG_COST_FORM = 'GAS' THEN 'GAS - UNKNOWN'
              WHEN ${TABLE}.DRUG_COST_FORM = 'GEL' THEN 'GEL - GEL'
              WHEN ${TABLE}.DRUG_COST_FORM = 'GM'  THEN 'GM - GRAM'
              WHEN ${TABLE}.DRUG_COST_FORM = 'GRA' THEN 'GRA - GRANULE'
              WHEN ${TABLE}.DRUG_COST_FORM = 'GUM' THEN 'GUM - GUM'
              WHEN ${TABLE}.DRUG_COST_FORM = 'IMP' THEN 'IMP - IMPLANT'
              WHEN ${TABLE}.DRUG_COST_FORM = 'INH' THEN 'INH - INHALATION'
              WHEN ${TABLE}.DRUG_COST_FORM = 'INJ' THEN 'INJ - INJECTION'
              WHEN ${TABLE}.DRUG_COST_FORM = 'IUD' THEN 'IUD - INTRAUTERINE'
              WHEN ${TABLE}.DRUG_COST_FORM = 'KIT' THEN 'KIT - KIT'
              WHEN ${TABLE}.DRUG_COST_FORM = 'LIQ' THEN 'LIQ - LIQUID'
              WHEN ${TABLE}.DRUG_COST_FORM = 'LOZ' THEN 'LOZ - LOZENGE'
              WHEN ${TABLE}.DRUG_COST_FORM = 'MIS' THEN 'MIS - MISCELLANEOUS'
              WHEN ${TABLE}.DRUG_COST_FORM = 'ML'  THEN 'ML - MILLILITER'
              WHEN ${TABLE}.DRUG_COST_FORM = 'NDL' THEN 'NDL - NEEDLE'
              WHEN ${TABLE}.DRUG_COST_FORM = 'NEB' THEN 'NEB - NEBULIZER'
              WHEN ${TABLE}.DRUG_COST_FORM = 'OIL' THEN 'OIL - OIL'
              WHEN ${TABLE}.DRUG_COST_FORM = 'OIN' THEN 'OIN - OINTMENT'
              WHEN ${TABLE}.DRUG_COST_FORM = 'PAC' THEN 'PAC - PACKET'
              WHEN ${TABLE}.DRUG_COST_FORM = 'PAD' THEN 'PAD - PAD'
              WHEN ${TABLE}.DRUG_COST_FORM = 'PAK' THEN 'PAK - PACKET'
              WHEN ${TABLE}.DRUG_COST_FORM = 'PAT' THEN 'PAT - PATCH'
              WHEN ${TABLE}.DRUG_COST_FORM = 'PEN' THEN 'PEN - INSULIN PEN'
              WHEN ${TABLE}.DRUG_COST_FORM = 'POW' THEN 'POW - POWDER'
              WHEN ${TABLE}.DRUG_COST_FORM = 'SET' THEN 'SET - INFUS SET, IV ACCESSR, BLOOD SET'
              WHEN ${TABLE}.DRUG_COST_FORM = 'SHA' THEN 'SHA - SHAMPOO'
              WHEN ${TABLE}.DRUG_COST_FORM = 'SHT' THEN 'SHT - SHEET'
              WHEN ${TABLE}.DRUG_COST_FORM = 'SOL' THEN 'SOL - SOLUTION'
              WHEN ${TABLE}.DRUG_COST_FORM = 'SPA' THEN 'SPA - SPACER'
              WHEN ${TABLE}.DRUG_COST_FORM = 'SPO' THEN 'SPO - CON SPONGE'
              WHEN ${TABLE}.DRUG_COST_FORM = 'SPR' THEN 'SPR - SPRAY'
              WHEN ${TABLE}.DRUG_COST_FORM = 'STK' THEN 'STK - STICK'
              WHEN ${TABLE}.DRUG_COST_FORM = 'STP' THEN 'STP - STRIP'
              WHEN ${TABLE}.DRUG_COST_FORM = 'SUB' THEN 'SUB - SUBLINGUAL'
              WHEN ${TABLE}.DRUG_COST_FORM = 'SUP' THEN 'SUP - SUPPOSITORY'
              WHEN ${TABLE}.DRUG_COST_FORM = 'SUS' THEN 'SUS - SUSPENSION'
              WHEN ${TABLE}.DRUG_COST_FORM = 'SWB' THEN 'SWB - SWAB'
              WHEN ${TABLE}.DRUG_COST_FORM = 'SYN' THEN 'SYN - SYRINGE'
              WHEN ${TABLE}.DRUG_COST_FORM = 'TAB' THEN 'TAB - TABLET'
              WHEN ${TABLE}.DRUG_COST_FORM = 'TAM' THEN 'TAM - TAMPON'
              WHEN ${TABLE}.DRUG_COST_FORM = 'TAP' THEN 'TAP - TAPE'
              WHEN ${TABLE}.DRUG_COST_FORM = 'TES' THEN 'TES - TEST STRIP'
              WHEN ${TABLE}.DRUG_COST_FORM = 'TIN' THEN 'TIN - TINCTURE'
              WHEN ${TABLE}.DRUG_COST_FORM = 'TRO' THEN 'TRO - TROCHE'
              WHEN ${TABLE}.DRUG_COST_FORM = 'TRY' THEN 'TRY - TRAY'
              WHEN ${TABLE}.DRUG_COST_FORM = 'TWL' THEN 'TWL - TOWELETTE'
              WHEN ${TABLE}.DRUG_COST_FORM = 'VIA' THEN 'VIA - VIAL'
              WHEN ${TABLE}.DRUG_COST_FORM = 'WAF' THEN 'WAF - WAFER'
              WHEN ${TABLE}.DRUG_COST_FORM = 'BAN' THEN 'BAN - BANDAGE'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: ["NULL - UNKNOWN", "AER - AEROSOL", "BAG - BAG", "BAR - SOAP", "BOT - BOTTLE", "BOX - BOX", "CAP - CAPSULE", "CHW - CHEWABLE", "CMB - UNKNOWN", "CON - CONC", "CPB - UNKNOWN", "CRE - CREAM", "CRT - CARTRIDGE", "CRY - CRYSTAL", "DIS - PATCH", "DPR - DIAPHRAGM", "DRO - DROP", "DRP - UNKNOWN", "EA - EACH", "EFF - EFF POWDER PACKET", "EMU - EMULSION", "ENE - ENEMA", "FLM - FILM", "GAS - UNKNOWN", "GEL - GEL", "GM - GRAM", "GRA - GRANULE", "GUM - GUM", "IMP - IMPLANT", "INH - INHALATION", "INJ - INJECTION", "IUD - INTRAUTERINE", "KIT - KIT", "LIQ - LIQUID", "LOZ - LOZENGE", "MIS - MISCELLANEOUS", "ML - MILLILITER", "NDL - NEEDLE", "NEB - NEBULIZER", "OIL - OIL", "OIN - OINTMENT", "PAC - PACKET", "PAD - PAD", "PAK - PACKET", "PAT - PATCH", "PEN - INSULIN PEN", "POW - POWDER", "SET - INFUS SET, IV ACCESSR, BLOOD SET", "SHA - SHAMPOO", "SHT - SHEET", "SOL - SOLUTION", "SPA - SPACER", "SPO - CON SPONGE", "SPR - SPRAY", "STK - STICK", "STP - STRIP", "SUB - SUBLINGUAL", "SUP - SUPPOSITORY", "SUS - SUSPENSION", "SWB - SWAB", "SYN - SYRINGE", "TAB - TABLET", "TAM - TAMPON", "TAP - TAPE", "TES - TEST STRIP", "TIN - TINCTURE", "TRO - TROCHE", "TRY - TRAY", "TWL - TOWELETTE", "VIA - VIAL", "WAF - WAFER", "BAN - BANDAGE"]
    suggest_persist_for: "24 hours"
    drill_fields: [drug_cost_form_reference]
  }

  dimension: drug_cost_gpi {
    label: "Medi-Span Drug Cost GPI"
    description: "Medi-Span Generic Product Indicator"
    type: string
    sql: ${TABLE}.DRUG_COST_GPI ;;
  }

  dimension_group: drug_cost_effective_start {
    label: "Medi-Span Drug Cost Effective Start"
    description: "Date/Time this Medi-Span Drug Cost record became effective"
    type: time
    sql: ${TABLE}.DRUG_COST_EFFECTIVE_START_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension_group: drug_cost_effective_end {
    label: "Medi-Span Drug Cost Effective End"
    description: "Date/Time this Medi-Span Drug Cost record ceased to be in effect"
    type: time
    sql: ${TABLE}.DRUG_COST_EFFECTIVE_END_DATE ;;
    timeframes: [time,date,week,month,month_num,year,quarter,quarter_of_year,yesno,hour_of_day,time_of_day,hour2,minute15,day_of_week,day_of_month]
  }

  dimension: drug_cost_current_price_flag_reference {
    label: "Medi-Span Drug Cost Current Price Flag"
    description: "Flag indicating if this record holds the current cost value based on the PK."
    type: string
    hidden: yes
    sql: ${TABLE}.DRUG_COST_CURRENT_PRICE_FLAG ;;
  }

  dimension: drug_cost_current_price_flag {
    label: "Medi-Span Drug Cost Current Price Flag"
    description: "Flag indicating if this Medi-Span Drug Cost record holds the current cost value based on the PK."
    type: string
    sql: CASE WHEN ${TABLE}.NDC IS NULL                          THEN 'N/A'
              WHEN ${TABLE}.NDC IS NOT NULL
               AND ${TABLE}.DRUG_COST_CURRENT_PRICE_FLAG IS NULL THEN 'NULL - UNKNOWN'
              WHEN ${TABLE}.DRUG_COST_CURRENT_PRICE_FLAG = 'Y'   THEN 'Y - YES'
              WHEN ${TABLE}.DRUG_COST_CURRENT_PRICE_FLAG = 'N'   THEN 'N - NO'
              ELSE 'UNKNOWN'
         END ;;
    suggestions: ["NULL - UNKNOWN", "Y - YES", "N - NO"]
    suggest_persist_for: "24 hours"
    drill_fields: [drug_cost_current_price_flag_reference]
  }

  measure: sum_drug_cost_unit_amount {
    label: "Total Medi-Span Drug Cost Unit Amount"
    description: "Total Medi-Span Drug Cost Unit Amount for a Drug Cost Type. Excluding the 'Medi-Span Drug Cost Type' and 'Medi-Span Drug Cost Source Time' dimensions will cause this measure to sum across all Drug Cost Types and Source Time records"
    type: sum
    sql: ${TABLE}.DRUG_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

  measure: avg_drug_cost_unit_amount {
    label: "Avg Medi-Span Drug Cost Unit Amount"
    description: "Average Medi-Span Drug Cost Unit Amount for a Drug Cost Type. Excluding the 'Medi-Span Drug Cost Type' and 'Medi-Span Drug Cost Source Time' dimensions will cause this measure to sum across all Drug Cost Types and Source Time records"
    type: average
    sql: ${TABLE}.DRUG_COST_UNIT_AMOUNT ;;
    value_format: "$#,##0.0000000;($#,##0.0000000)"
  }

}
