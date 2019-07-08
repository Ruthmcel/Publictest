#[ERXDWPS-5232] Found duplicate records in EPR for PK combination. created EPSD-8089 & CSD-9214 defects for source system. Work around implemented in looker by applying ranking on PK columns to pick the latest record.


view: rx_tx {
  derived_table: {
    sql: select *
           from (select epr.chain_id,
                        epr.nhin_store_id,
                        epr.rx_tx_rx_number,
                        epr.rx_tx_tx_number,
                        epr.rx_com_id,
                        epr.rx_tx_new_rx_number,
                        epr.rx_tx_old_rx_number,
                        epr.rx_tx_refill_number,
                        epr.rx_tx_rx_status,
                        epr.rx_tx_tx_status,
                        epr.rx_tx_fill_status,
                        epr.rx_tx_partial_fill_status,
                        epr.rx_tx_tax_amount,
                        epr.rx_tx_discount_amount,
                        epr.rx_tx_price,
                        epr.rx_tx_acquisition_cost,
                        epr.rx_tx_price-epr.rx_tx_acquisition_cost,
                        epr.rx_tx_uc_price,
                        epr.rx_tx_fill_quantity,
                        epr.rx_tx_tp_bill,
                        decode(winpdx_rx_tx_patient_image.will_call_picked_up_date,null,epr.rx_tx_sold_date,winpdx_rx_tx_patient_image.will_call_picked_up_date) as rx_tx_sold_date,
                        decode(epr.rx_tx_reportable_sales_date,null,epr.rx_tx_filled_date,epr.rx_tx_reportable_sales_date) as rx_tx_reportable_sales_date, -- With Regard to Reportable Sales Date from EPR,
                        epr.rx_tx_filled_date,
                        'Active' AS active_or_non_active,
                        epr.prescriber_id,
                        epr.rx_tx_modpcm_id,
                        epr.rx_tx_acs_priority,
                        epr.rx_tx_allergy_override,
                        epr.rx_tx_alternate_doctor,
                        epr.rx_tx_charge,
                        epr.rx_tx_compound_fee,
                        epr.rx_tx_cost,
                        epr.rx_tx_counseling_choice,
                        epr.rx_tx_ncpdp_daw,
                        epr.rx_tx_quantity,
                        epr.rx_tx_decimal_quantity,
                        epr.rx_tx_dose_cover,
                        epr.rx_tx_drug_code,
                        epr.rx_tx_drug_expiration_date,
                        epr.rx_tx_duplicate_therapy,
                        epr.rx_tx_dur_override,
                        epr.rx_tx_not_picked_up_yet,
                        epr.rx_tx_host_retrieval_date,
                        epr.rx_tx_initials,
                        epr.rx_tx_interaction_override,
                        epr.rx_tx_tx_message,
                        epr.rx_tx_manufacturer,
                        epr.rx_tx_ndc,
                        epr.rx_tx_nsc_choice,
                        epr.rx_tx_order_initials,
                        epr.rx_tx_other_price,
                        epr.rx_tx_pac_med,
                        epr.rx_tx_patient_disease_override,
                        epr.rx_tx_physician_code,
                        epr.rx_tx_pos_type,
                        epr.rx_tx_price_code,
                        epr.rx_tx_rph_counselling_initials,
                        epr.rx_tx_sched_drug_report_date,
                        epr.rx_tx_sig_code,
                        epr.rx_tx_tax_code,
                        epr.rx_tx_tech_initials,
                        epr.rx_tx_up_charge,
                        epr.rx_tx_usual,
                        epr.rx_tx_via_prefill,
                        epr.rx_tx_prescribed_drug_gpi,
                        epr.rx_tx_prescribed_drug_ndc,
                        epr.rx_tx_prescribed_drug_name,
                        epr.rx_tx_dispensed_drug_gpi,
                        epr.rx_tx_dispensed_drug_ndc,
                        epr.rx_tx_dispensed_drug_name,
                        epr.rx_tx_compound,
                        epr.rx_tx_doctor_daw,
                        epr.rx_tx_days_supply,
                        epr.rx_tx_drug_schedule,
                        epr.rx_tx_days_supply_basis,
                        epr.rx_tx_days_supply_code,
                        epr.rx_tx_expiration_date,
                        epr.rx_tx_first_filled_date,
                        epr.rx_tx_follow_up_date,
                        epr.rx_tx_force_cog,
                        epr.rx_tx_group_code,
                        epr.rx_tx_icd9_code,
                        epr.rx_tx_icd9_type,
                        epr.rx_tx_number_of_labels,
                        epr.rx_tx_remaining_quantity,
                        epr.rx_tx_remaining_decimal_qty,
                        epr.rx_tx_original_written_date,
                        epr.rx_tx_other_nhin_store_id,
                        epr.rx_tx_owed_quantity,
                        epr.rx_tx_patient_code,
                        epr.rx_tx_authorized_via_phone,
                        epr.rx_tx_created_via_phone,
                        epr.rx_tx_autofill_mail,
                        epr.rx_tx_autofill,
                        epr.rx_tx_autofill_quantity,
                        epr.rx_tx_autofill_decimal_qty,
                        epr.rx_tx_transfer,
                        epr.rx_tx_refills_authorized,
                        epr.rx_tx_refills_remaining,
                        epr.rx_tx_refills_transferred,
                        epr.rx_tx_stop_date,
                        epr.rx_tx_substitute,
                        epr.rx_tx_why_deactivated,
                        epr.rx_tx_written_date,
                        epr.rx_tx_archive_date,
                        epr.rx_tx_sig_language,
                        epr.rx_tx_sig_per_day,
                        epr.rx_tx_sig_per_dose,
                        epr.rx_tx_sig_text,
                        epr.rx_tx_sig_text_foreign_lang,
                        epr.rx_tx_lost,
                        epr.rx_tx_pv_initials,
                        epr.rx_tx_call_for_refills,
                        epr.rx_tx_drug_image_key,
                        epr.rx_tx_has_tx_creds,
                        epr.rx_tx_has_tx_tps,
                        epr.rx_tx_mrn_location_code,
                        epr.rx_tx_mrn_id,
                        epr.rx_tx_sending_application,
                        epr.rx_tx_prescriber_order_number,
                        epr.rx_tx_refill_quantity,
                        epr.rx_tx_rx_start_date,
                        epr.rx_tx_confidentiality_ind,
                        epr.rx_tx_workers_comp,
                        epr.rx_tx_rx_serial_number,
                        epr.rx_tx_shipper_name,
                        epr.rx_tx_shipper_tracking_number,
                        epr.rx_tx_ship_date,
                        epr.rx_tx_cancel_reason,
                        epr.rx_tx_interaction_rx_source,
                        epr.rx_tx_active_member,
                        epr.rx_tx_will_call_ready,
                        epr.rx_tx_enterprise_rx_fill_count,
                        epr.rx_tx_rx_state,
                        epr.rx_tx_teen_confidential,
                        epr.rx_tx_prescribed_decimal_qty,
                        epr.rx_tx_fill_decimal_quantity,
                        epr.rx_tx_renewed_rx,
                        epr.rx_tx_counsel_reason,
                        epr.rx_tx_therapeutic_conversion,
                        epr.rx_tx_benefits_rights_letter,
                        epr.rx_tx_has_compound_ingredients,
                        epr.rx_tx_rx_note,
                        epr.rx_tx_tx_note,
                        epr.rx_tx_deact_rx_user_last_name,
                        epr.rx_tx_deact_rx_user_first_name,
                        epr.rx_tx_deact_rx_user_emp_num,
                        epr.rx_tx_deactivate_rx_date,
                        epr.rx_tx_lang_manually_selected,
                        epr.rx_tx_local_mail,
                        epr.rx_tx_unverified_rx,
                        epr.rx_tx_pos_overridden_net_paid,
                        epr.rx_tx_sync_script_enrollment,
                        epr.rx_tx_sync_script_enrolled_dt,
                        epr.rx_tx_sync_script_enrolled_by,
                        epr.rx_tx_sig_change_user_initials,
                        epr.rx_tx_sig_text_changed,
                        epr.rx_tx_interaction_code,
                        epr.rx_tx_check_rx_overwritten,
                        epr.rx_tx_patient_start_date,
                        epr.rx_tx_last_message_source,
                        epr.rx_tx_spi_identifier,
                        epr.rx_tx_immunization_indicator,
                        epr.rx_tx_disp_drug_unit,
                        epr.rx_tx_cvx_code,
                        epr.rx_tx_cpt_code,
                        epr.rx_tx_mvx_code,
                        epr.rx_tx_clinic_reference_number,
                        epr.rx_tx_rxfill_indicator,
                        epr.rx_tx_rx_deleted,
                        epr.rx_tx_tx_deleted,
                        epr.rx_tx_lcr_id as epr_rx_tx_lcr_id,
                        epr.rx_tx_id as epr_rx_tx_id,
                        epr.source_timestamp as epr_source_timestamp,
                        decode(winpdx_rx_tx_patient_image.will_call_picked_up_date,null,epr.rx_tx_will_call_picked_up_date,winpdx_rx_tx_patient_image.will_call_picked_up_date) as rx_tx_will_call_picked_up_date,   -- WIll Call Picked Up Date in EPR is always populated only from WinPDX. Currently EPS is not populating once EPS fixes their application, this date will start populating
                        epr.rx_tx_order_class,
                        epr.rx_tx_order_type,
                        epr.rx_tx_print_drug_name,
                        epr.rx_tx_program_add,
                        epr.rx_tx_specialty,
                        epr.rx_tx_route_of_administration,
                        epr.rx_tx_site_of_administration,
                        epr.audit_access_log_id,
                        datediff(day,max(rx_tx_filled_date) over (partition by epr.chain_id,epr.rx_com_id),current_timestamp) as days_since_last_activity,
                        -- ERXLPS-79 Changes
                        'N' as file_buy_flag,
                        row_number() over(partition by epr.chain_id, epr.nhin_store_id, epr.rx_tx_rx_number, epr.rx_tx_tx_number order by epr.source_timestamp desc) rnk
                   FROM edw.f_rx_tx epr    -- Encompasses PDX Classic and EPS Non-Symmetric Stores
                        left outer join
                             (select cast(168 as number(10,0)) as chain_id,
                                     nhin_store_id,
                                     rx_number,
                                     tx_number,
                                     image_add_date_time as will_call_picked_up_date
                                from report_temp.pdx_rx_tx_patient_image
                               where image_type = 'SignatureCapture'   -- Considering only prescriptions picked by patients to determine the actual time the prescriptions were sold as WINPDX if POS not used does not capture the actual sold date in sold_date field, it is pretty much equivalent to the fill date
                             ) winpdx_rx_tx_patient_image
                        ON (     epr.chain_id = 168 -- hardcoded for performance reasons and there is only stores for 168 that exist in this table
                             and epr.nhin_store_id = winpdx_rx_tx_patient_image.nhin_store_id
                             and epr.rx_tx_rx_number = winpdx_rx_tx_patient_image.rx_number
                             and epr.rx_tx_tx_number = winpdx_rx_tx_patient_image.tx_number
                           )
                   /********************************** START OF SEPARATE CALENDAR DATES ARE REQUIRED FOR SOLD, REPORTABLE_SALES & FILLED DATES *****************************************************/
                   /** This would help to ensure, if we are looking for Transactions filled for last 60 Days but only sold in last 30 days, then we don't select transactions sold in last 60 days *****/
                        inner join
                        ( select dateadd(year,-1,min(calendar_date)) as min_date,
                                 dateadd(year,-1,max(dateadd(day,1,calendar_date))) as max_date -- Adding one day as the max when consumed for records less than the end date without adding a day, would end up not considering the records until the specified date (for e.g., if 2015-12-31 is selected, then if 1 day is not added, then the begin and end date would basically be 2015-12-31 and 2015-12-31)
                            from (select to_date(dateadd(day,seq4(),trunc(to_date(to_timestamp('2010-01-01 12:00:00')),'day'))) as calendar_date
                                    from table(generator(rowcount => 5113))
                                 )
                            where (
                                    {% condition this_year_last_year_filter %} 'Yes-Sold' {% endcondition %}
                                    and {% condition sold_date_filter %} CALENDAR_DATE {% endcondition %}
                                  )
                        ) ly_sold_date     -- IMPORTANT VIEW TO DERIVE DATES FOR LAST YEAR WITH REGARD TO SOLD_DATE
                        on 1 = 1
                        inner join
                        ( select dateadd(year,-1,min(calendar_date)) as min_date,
                                 dateadd(year,-1,max(dateadd(day,1,calendar_date))) as max_date -- adding one day as the max when consumed for records less than the end date without adding a day, would end up not considering the records until the specified date (for e.g., if 2015-12-31 is selected, then if 1 day is not added, then the begin and end date would basically be 2015-12-31 and 2015-12-31)
                            from (select to_date(dateadd(day,seq4(),trunc(to_date(to_timestamp('2010-01-01 12:00:00')),'day'))) as calendar_date
                                    from table(generator(rowcount => 5113))
                                  )
                           where (
                                    {% condition this_year_last_year_filter %} 'Yes-ReportableSales' {% endcondition %}
                                    and {% condition reportable_sales_date_filter %} CALENDAR_DATE {% endcondition %}
                                 )
                        ) ly_reportable_sales_date     -- IMPORTANT VIEW TO DERIVE DATES FOR LAST YEAR WITH REGARD TO REPORTABLE_SALES_DATE
                        on 1 = 1
                        inner join
                        ( select dateadd(year,-1,min(calendar_date)) as min_date,
                                 dateadd(year,-1,max(dateadd(day,1,calendar_date))) as max_date -- adding one day as the max when consumed for records less than the end date without adding a day, would end up not considering the records until the specified date (for e.g., if 2015-12-31 is selected, then if 1 day is not added, then the begin and end date would basically be 2015-12-31 and 2015-12-31)
                            from ( select to_date(dateadd(day,seq4(),trunc(to_date(to_timestamp('2010-01-01 12:00:00')),'day'))) as calendar_date
                                    from table(generator(rowcount => 5113)) )
                           where (
                                   {% condition this_year_last_year_filter %} 'Yes-Filled' {% endcondition %}
                                   and {% condition filled_date_filter %} CALENDAR_DATE {% endcondition %}
                                 )
                        ) ly_filled_date     -- IMPORTANT VIEW TO DERIVE DATES FOR LAST YEAR WITH REGARD TO FILL_DATES
                        on 1 = 1
                        /********************************** END OF SEPARATE CALENDAR DATES ARE REQUIRED FOR SOLD, REPORTABLE_SALES & FILLED DATES *****************************************************/
                        where epr.rx_tx_rx_deleted = 'N'
                          and epr.rx_tx_tx_deleted = 'N'
                          and epr.rx_tx_tx_number is not null
                          and nvl(epr.rx_tx_tx_status,'Y') = 'Y'
                          and epr.rx_tx_price is not null
                          and epr.rx_tx_acquisition_cost is not null
                          and epr.rx_tx_fill_status is not null
                          and decode(epr.rx_tx_reportable_sales_date,null,epr.rx_tx_filled_date,epr.rx_tx_reportable_sales_date) is not null
                          and epr.rx_tx_fill_quantity is not null
                          and {% condition chain.chain_id %} EPR.CHAIN_ID {% endcondition %}   -- Required for performance reasons and to avoid scanning all chain/store records
                          and {% condition store.nhin_store_id %} EPR.NHIN_STORE_ID {% endcondition %}  -- Required for performance reasons and to avoid scanning all chain/store records
                          -- [ERXDWPS-1690] Added store_number filter to avoid scanning all chain/store records and minimize data buffer for derived view.
                          and epr.nhin_store_id in (select distinct nhin_store_id from edw.d_store
                                                       where source_system_id = 5
                                                         and {% condition chain.chain_id %} chain_id {% endcondition %}
                                                         and {% condition store.store_number %} store_number {% endcondition %})
                          and {% condition cost_filter %} RX_TX_COST {% endcondition %}
                          and {% condition acquisition_cost_filter %} EPR.RX_TX_ACQUISITION_COST {% endcondition %}
                          and {% condition autofill_quantity_filter %} RX_TX_AUTOFILL_QUANTITY {% endcondition %}
                          and {% condition fill_quantity_filter %} EPR.RX_TX_FILL_QUANTITY {% endcondition %}
                          and {% condition quantity_filter %} RX_TX_QUANTITY {% endcondition %}
                          and {% condition price_filter %} EPR.RX_TX_PRICE {% endcondition %}
                          and {% condition gross_margin_filter %} RX_TX_GROSS_MARGIN {% endcondition %}
                          and (
                                {% condition sold_date_filter %} decode(winpdx_rx_tx_patient_image.will_call_picked_up_date,null,epr.rx_tx_sold_date,winpdx_rx_tx_patient_image.will_call_picked_up_date) {% endcondition %}
                              or
                                ( {% condition this_year_last_year_filter %} 'Yes-Sold' {% endcondition %}
                                  and decode(winpdx_rx_tx_patient_image.will_call_picked_up_date,null,epr.rx_tx_sold_date,winpdx_rx_tx_patient_image.will_call_picked_up_date) >= ly_sold_date.min_date
                                  and decode(winpdx_rx_tx_patient_image.will_call_picked_up_date,null,epr.rx_tx_sold_date,winpdx_rx_tx_patient_image.will_call_picked_up_date) < ly_sold_date.max_date
                                )
                              )
                          and (
                                {% condition reportable_sales_date_filter %} decode(epr.rx_tx_reportable_sales_date,null,epr.rx_tx_filled_date,epr.rx_tx_reportable_sales_date) {% endcondition %}
                              or
                                ( {% condition this_year_last_year_filter %} 'Yes-ReportableSales' {% endcondition %}
                                  and decode(epr.rx_tx_reportable_sales_date,null,epr.rx_tx_filled_date,epr.rx_tx_reportable_sales_date) >= ly_reportable_sales_date.min_date
                                  and decode(epr.rx_tx_reportable_sales_date,null,epr.rx_tx_filled_date,epr.rx_tx_reportable_sales_date) < ly_reportable_sales_date.max_date
                                )
                              )
                          and (
                                {% condition filled_date_filter %} EPR.RX_TX_FILLED_DATE {% endcondition %}
                              or
                                ( {% condition this_year_last_year_filter %} 'Yes-Filled' {% endcondition %}
                                  and epr.rx_tx_filled_date >= ly_filled_date.min_date
                                  and epr.rx_tx_filled_date < ly_filled_date.max_date
                                )
                              )
                          and exists (select null
                                        from edw.d_patient patient
                                       where {% condition chain.chain_id %} patient.CHAIN_ID {% endcondition %}
                                         and epr.chain_id = patient.chain_id
                                         and epr.rx_com_id = patient.rx_com_id
                                         and patient.patient_survivor_id is null
                                         and patient.patient_unmerged_date is null
                                     )
                ) rxtx
          where rnk = 1 ;;
  }

  #[ERXLPS-1055] - Removed Rx word from label name.
  dimension: rx_number {
    label: "Prescription Number"
    description: "Prescription number"
    type: number
    sql: ${TABLE}.RX_TX_RX_NUMBER ;;
    value_format: "####"
  }

  dimension: refill_number {
    label: "Prescription Refill Number"
    type: number
    sql: ${TABLE}.RX_TX_REFILL_NUMBER ;;
  }

  dimension: tx_number {
    label: "Prescription TX Number"
    description: "Transaction number"
    type: number
    sql: ${TABLE}.RX_TX_TX_NUMBER ;;
    value_format: "####"
  }

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${rx_number} ||'@'|| ${tx_number} ;; #ERXLPS-1649
  }

  #################################################################################################### Foreign Key References ####################################################################################
  dimension: chain_id {
    hidden: yes
    type: number
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    hidden: yes
    type: number
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: rx_com_id {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_COM_ID ;;
  }

  dimension: rx_tx_id {
    hidden: yes
    type: number
    # Primary key in source
    sql: ${TABLE}.EPR_RX_TX_ID ;;
  }

  dimension: eps_rx_summary_id {
    hidden: yes
    type: number
    sql: ${TABLE}.EPS_RX_SUMMARY_ID ;;
  }

  dimension: prescriber_id {
    hidden: yes
    type: number
    sql: ${TABLE}.PRESCRIBER_ID ;;
  }

  dimension: alternate_prescriber_id {
    hidden: yes
    type: number
    sql: ${TABLE}.ALTERNATE_PRESCRIBER_ID ;;
  }

  dimension: modpcm_id {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_MODPCM_ID ;;
  }

  dimension: mrn_id {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_MRN_ID ;;
  }

  dimension: rx_prescribed_drug_ddid {
    label: "Prescriber Prescribed Drug DDID"
    description: "Unique reference to a drug concept that defines the prescribed drug without selecting a specific pack size"
    hidden: yes
    type: number
    sql: ${TABLE}.RX_PRESCRIBED_DRUG_DDID ;;
    value_format: "######"
  }

  dimension: rx_prescribed_drug_id {
    label: "Prescription Prescried Drug ID"
    description: "Unique ID that links this record to a specific DRUG record"
    hidden: yes
    type: string
    sql: ${TABLE}.RX_PRESCRIBED_DRUG_ID ;;
  }

  dimension: rx_prescriber_edi_id {
    hidden: yes
    type: number
    sql: ${TABLE}.RX_PRESCRIBER_EDI_ID ;;
  }

  ######################################  deleted fields are not exposed to the explore but are used in the join conditions to ensure soft deleted records in application/EDW are not picked up #########################

  dimension: rx_deleted {
    label: "Prescription Deleted"
    hidden: yes
    sql: ${TABLE}.RX_TX_RX_DELETED ;;
  }

  dimension: tx_deleted {
    label: "Prescription TX Deleted"
    hidden: yes
    sql: ${TABLE}.RX_TX_TX_DELETED ;;
  }

  #######################################################################################################################################################################################################################

  ########################################################################################################### Dimensions ################################################################################################

  dimension: ndc {
    hidden: yes
    sql: ${TABLE}.RX_TX_NDC ;;
  }

  dimension: new_rx_number {
    sql: ${TABLE}.RX_TX_NEW_RX_NUMBER ;;
  }

  dimension: old_rx_number {
    sql: ${TABLE}.RX_TX_OLD_RX_NUMBER ;;
  }

  dimension: acs_priority {
    label: "Prescription ACS Priority"
    description: "Numeric rank that indicates the priority of the prescription in the automated counting system.  1 - highest priority, 9 = lowest priority"
    type: string
    sql: ${TABLE}.RX_TX_ACS_PRIORITY ;;
  }

  dimension: alternate_doctor {
    label: "Prescription Alternate Doctor"
    type: string
    description: "Mnemonic code representing the alternate prescriber record associated with this transaction"
    sql: ${TABLE}.RX_TX_ALTERNATE_DOCTOR ;;
  }

  dimension: authorized_via_phone {
    label: "Rx Phone - Refill Authorization"
    description: "Indicates if the prescription was approved/authorized via phone by the prescriber"
    sql: ${TABLE}.RX_TX_AUTHORIZED_VIA_PHONE ;;
  }

  #     suggestions: ['Y','N']
  #     full_suggestions: true

  dimension: autofill {
    label: "Prescription Autofill"
    description: "Store autofill setting for this prescription"
    sql: ${TABLE}.RX_TX_AUTOFILL ;;
  }

  dimension: cancel_reason {
    label: "Prescription Cancel Reason"
    description: "Used to store the reason why a this prescription was cancelled"
    sql: ${TABLE}.RX_TX_CANCEL_REASON ;;
  }

  dimension: charge {
    label: "Prescription Accounts Receivable Charge Flag"
    description: "Yes/No Flag that indicates if the transaction was charged to accounts receivable"
    type: string
    sql: (SELECT MAX(MASTER_CODE_SHORT_DESCRIPTION) FROM EDW.D_MASTER_CODE MC WHERE MC.MASTER_CODE_VALUE = NVL(${TABLE}.RX_TX_CHARGE,'NULL') AND MC.EDW_COLUMN_NAME = 'RX_TX_CHARGE') ;;
  }

  dimension: check_rx_overwritten {
    label: "Prescription DUR Override Flag"
    description: "Indicates if the pharmacist overrode DUR interaction for the transaction"
    sql: ${TABLE}.RX_TX_CHECK_RX_OVERWRITTEN ;;
  }

  dimension: clinic_reference_number {
    label: "Prescription Clinic Reference Number"
    hidden: yes
    description: "Source the eScript identifier from the souce system"
    sql: ${TABLE}.RX_TX_CLINIC_REFERENCE_NUMBER ;;
  }

  dimension: counseling_choice {
    label: "Prescription Counselling Choice"
    description: "Code that indicates if the patient accepted or rejected counseling information for the transaction. Accepted, Rejected/Refused, Required and Ask"
    sql: ${TABLE}.RX_TX_COUNSELING_CHOICE ;;
  }

  dimension: cpt_code {
    label: "Prescription CPT Code"
    description: "Used to report medical procedures and services under public and private health insurance programs"
    sql: ${TABLE}.RX_TX_CPT_CODE ;;
  }

  dimension: created_via_phone {
    label: "Prescription Phone - New"
    description: "Indicates if a new prescription was initiated via phone by the prescriber"
    sql: ${TABLE}.RX_TX_CREATED_VIA_PHONE ;;
  }

  dimension: cvx_code {
    label: "Prescription CVX Code"
    description: "CDC defined code for the vaccination dispensed"
    sql: ${TABLE}.RX_TX_CVX_CODE ;;
  }

  dimension: days_supply {
    type: number
    label: "Prescription Days Supply"
    description: "Days supply for this transaction"
    sql: ${TABLE}.RX_TX_DAYS_SUPPLY ;;
  }

  dimension: days_supply_basis {
    label: "Prescription Days Supply Basis"
    description: "Days supply for this transaction"
    sql: ${TABLE}.RX_TX_DAYS_SUPPLY_BASIS ;;
  }

  dimension: days_supply_code {
    label: "Prescription Days Supply Code"
    description: "Basis for which the days supply was calculated.   Not Specified, Explicit Directions, PRN Directions and As Directed By Prescriber"
    sql: ${TABLE}.RX_TX_DAYS_SUPPLY_CODE ;;
  }

  dimension: doctor_daw {
    label: "Prescription Doctor DAW"
    description: "DAW associated to the prescriber of this prescription"
    sql: ${TABLE}.RX_TX_DOCTOR_DAW ;;
  }

  dimension: dose_cover {
    label: "Prescription Dose Cover"
    description: "Indicates if a dose check override was performed during the filling process"
    sql: ${TABLE}.RX_TX_DOSE_COVER ;;
  }

  dimension: drug_code {
    label: "Prescription Drug Code"
    description: "Represents the drug code for the drug used on this prescription transaction"
    sql: ${TABLE}.RX_TX_DRUG_CODE ;;
  }

  dimension: drug_schedule {
    hidden: yes
    sql: ${TABLE}.RX_TX_DRUG_SCHEDULE ;;
  }

  dimension: duplicate_therapy {
    label: "Prescription Duplicate Therapy"
    description: "Indicates if a duplicate therapy override was performed during the filling process"
    sql: ${TABLE}.RX_TX_DUPLICATE_THERAPY ;;
  }

  dimension: dur_override {
    label: "Prescription DUR Override"
    description: "Indicates if a DUR override was performed during the filling process"
    sql: ${TABLE}.RX_TX_DUR_OVERRIDE ;;
  }

  dimension: fill_status {
    label: "Prescription Fill Status"
    description: "Indicates the type of transaction. New prescription transaction, Refill transaction and Non-filled, Cognitive service transaction"
    sql: ${TABLE}.RX_TX_FILL_STATUS ;;
  }

  dimension: force_cog {
    label: "Prescription Force Cog"
    sql: ${TABLE}.RX_TX_FORCE_COG ;;
  }

  dimension: group_code {
    label: "Prescription Group Code"
    description: "Group code for this prescription"
    sql: ${TABLE}.RX_TX_GROUP_CODE ;;
  }

  dimension: icd9_code {
    label: "Prescription ICD9 Code"
    sql: ${TABLE}.RX_TX_ICD9_CODE ;;
  }

  dimension: icd9_type {
    label: "Prescription ICD9 Type"
    sql: ${TABLE}.RX_TX_ICD9_TYPE ;;
  }

  dimension: immunization_indicator {
    label: "Prescription Immunization Indicator"
    description: "Stores the indicator which denotes a prescription was a vaccine"
    sql: ${TABLE}.RX_TX_IMMUNIZATION_INDICATOR ;;
  }

  dimension: initials {
    label: "Prescription Initials"
    sql: ${TABLE}.RX_TX_INITIALS ;;
  }

  dimension: interaction_code {
    label: "Prescription Interaction Code"
    sql: ${TABLE}.RX_TX_INTERACTION_CODE ;;
  }

  dimension: interaction_override {
    label: "Prescription Interaction Override Flag"
    description: "Flag indicating if an interaction override was performed during the filling process"
    sql: ${TABLE}.RX_TX_INTERACTION_OVERRIDE ;;
  }

  dimension: interaction_rx_source {
    label: "Prescription Interaction Rx Source"
    description: "Used to indicate the source of an Interaction prescription. Outside Pharmacy, Sample, Back Office, Historical Med, Internal Reference, External Reference, Module and Nurse Treatment Room"
    sql: ${TABLE}.RX_TX_INTERACTION_RX_SOURCE ;;
  }

  dimension: manufacturer {
    label: "Prescription Manufacturer"
    description: "Manufacturer name"
    sql: ${TABLE}.RX_TX_MANUFACTURER ;;
  }

  dimension: mvx_code {
    label: "Prescription MVX Code"
    description: "Stores the manufacturer code for the vaccine administered"
    sql: ${TABLE}.RX_TX_MVX_CODE ;;
  }

  dimension: ncpdp_daw {
    label: "Prescription NCPDP DAW"
    description: "Third party dispensed as written flag that indicates which DAW code was assigned during data entry"
    case: {
      when: {
        sql: ${TABLE}.RX_TX_NCPDP_DAW = '0' ;;
        label: "0 - NO SELECTION"
      }

      when: {
        sql: ${TABLE}.RX_TX_NCPDP_DAW = '1' ;;
        label: "1 - DISPENSE AS WRITTEN"
      }

      when: {
        sql: ${TABLE}.RX_TX_NCPDP_DAW = '2' ;;
        label: "2 - BRAND - PATIENT CHOICE"
      }

      when: {
        sql: ${TABLE}.RX_TX_NCPDP_DAW = '3' ;;
        label: "3 - BRAND - PHARMACIST CHOICE"
      }

      when: {
        sql: ${TABLE}.RX_TX_NCPDP_DAW = '4' ;;
        label: "4 - BRAND - GENERIC OUT OF STOCK"
      }

      when: {
        sql: ${TABLE}.RX_TX_NCPDP_DAW = '5' ;;
        label: "5 - BRAND - DISPENSED AS GENERIC"
      }

      when: {
        sql: ${TABLE}.RX_TX_NCPDP_DAW = '6' ;;
        label: "6 - OVERRIDE"
      }

      when: {
        sql: ${TABLE}.RX_TX_NCPDP_DAW = '7' ;;
        label: "7 - BRAND - MANDATED BY LAW"
      }

      when: {
        sql: ${TABLE}.RX_TX_NCPDP_DAW = '8' ;;
        label: "8 - BRAND - GENERIC UNAVAILABLE"
      }

      when: {
        sql: ${TABLE}.RX_TX_NCPDP_DAW = '9' ;;
        label: "9 - OTHER"
      }

      when: {
        sql: ${TABLE}.RX_TX_NCPDP_DAW IS NULL ;;
        label: "NOT SPECIFIED"
      }
    }
    suggestions: [
      "0 - NO SELECTION",
      "1 - DISPENSE AS WRITTEN",
      "2 - BRAND - PATIENT CHOICE",
      "3 - BRAND - PHARMACIST CHOICE",
      "4 - BRAND - GENERIC OUT OF STOCK",
      "5 - BRAND - DISPENSED AS GENERIC",
      "6 - OVERRIDE",
      "7 - BRAND - MANDATED BY LAW",
      "8 - BRAND - GENERIC UNAVAILABLE",
      "9 - OTHER",
      "NOT SPECIFIED"
    ]
  }

  dimension: not_picked_up_yet {
    label: "Prescription Not Picked Up Yet"
    description: "Indicates if prescription has been picked up"
    sql: ${TABLE}.RX_TX_NOT_PICKED_UP_YET ;;
  }

  dimension: nsc_choice {
    label: "Rx No Safety Caps Flag"
    description: "Y/N Flag indicating NSC Choice will store whether the patient opted out of safety caps for this fill"
    sql: ${TABLE}.RX_TX_NSC_CHOICE ;;
  }

  dimension: number_of_labels {
    label: "Prescription Number Of Labels"
    description: "Stores the number of labels printed for this prescription fill"
    sql: ${TABLE}.RX_TX_NUMBER_OF_LABELS ;;
  }

  dimension: order_initials {
    sql: ${TABLE}.RX_TX_ORDER_INITIALS ;;
  }

  dimension: other_nhin_store_id {
    label: "Prescription Other NHIN Store ID"
    description: "Stores the NHIN ID of the pharmacy that has custody of a prescription. This is the pharmacy from which the prescription would have to be transferred to be filled at any other pharmacy"
    sql: ${TABLE}.RX_TX_OTHER_NHIN_STORE_ID ;;
  }

  dimension: pac_med {
    label: "Prescription PAC Med"
    description: "Flag that indicates whether the prescription was filled with a PacMed system"
    sql: ${TABLE}.RX_TX_PAC_MED ;;
  }

  dimension: physician_code {
    label: "Prescription Physician Code"
    description: "Stores the PDX Retail formatted prescriber code. This column has all values null as of 15th April 2016"
    sql: ${TABLE}.RX_TX_PHYSICIAN_CODE ;;
  }

  dimension: pos_type {
    label: "Prescription POS Type"
    description: "Type of POS being used by Classic (manual or POS)"
    sql: ${TABLE}.RX_TX_POS_TYPE ;;
  }

  dimension: price_code {
    label: "Prescription Price Code"
    description: "Price code used to price this prescription"
    sql: ${TABLE}.RX_TX_PRICE_CODE ;;
  }

  dimension: pv_initials {
    label: "Prescription PV Initials"
    description: "Initials of the user who performed Product Verification on this transaction"
    sql: ${TABLE}.RX_TX_PV_INITIALS ;;
  }

  dimension: rph_counselling_initials {
    label: "Prescription Rph Counselling Initials"
    description: "Stores the initials of user that counseled the patient"
    sql: ${TABLE}.RX_TX_RPH_COUNSELLING_INITIALS ;;
  }

  dimension: tech_initials {
    label: "Prescription Tech Initials"
    sql: ${TABLE}.RX_TX_TECH_INITIALS ;;
  }

  dimension: tax_code {
    label: "Prescription Tax Code"
    description: "Tax Code used to price this prescription, if applicable"
    sql: ${TABLE}.RX_TX_TAX_CODE ;;
  }

  dimension: via_prefill {
    label: "Prescription Via Prefill"
    description: "Indicates if the fill of this prescription was due to a pre-fill"
    sql: ${TABLE}.RX_TX_VIA_PREFILL ;;
  }

  dimension: why_deactivated_reason {
    label: "Prescription Why Deactivated Reason"
    description: "Stores the deactivation reason for a prescription"
    sql: ${TABLE}.RX_TX_WHY_DEACTIVATED ;;
  }

  dimension: will_call_ready_flag {
    label: "Prescription Will Call Ready Flag"
    description: "Flag indicating if this prescription is ready to be placed into Will Call"
    sql: ${TABLE}.RX_TX_WILL_CALL_READY ;;
  }

  dimension: store_dispensed_drug_gpi {
    type: string
    label: "Dispensed Drug GPI"
    description: "Dispensed Drug GPI"
    sql: ${TABLE}.RX_TX_DISPENSED_DRUG_GPI ;;
  }

  dimension: store_dispensed_drug_ndc {
    type: string
    label: "Dispensed Drug NDC"
    description: "Dispensed Drug NDC"
    sql: ${TABLE}.RX_TX_DISPENSED_DRUG_NDC ;;
  }

  dimension: store_dispensed_drug_ndc_11_digit_format {
    type: string
    label: "Dispensed Drug NDC 11 Digit Format"
    description: "11-Digit Format of Prescribed NDC represented in the format of 99999-9999-99"
    sql: CONCAT(CONCAT(CONCAT(CONCAT(SUBSTRING(${store_dispensed_drug_ndc},1,5),'-'),SUBSTRING(${store_dispensed_drug_ndc},6,4)),'-'),SUBSTRING(${store_dispensed_drug_ndc},10,2)) ;;
  }

  dimension: store_dispensed_drug_name {
    type: string
    label: "Dispensed Drug Name"
    description: "Dispensed Drug Name"
    sql: ${TABLE}.RX_TX_DISPENSED_DRUG_NAME ;;
  }

  dimension: store_prescribed_drug_gpi {
    type: string
    label: "Prescribed Drug GPI"
    description: "Prescribed Drug GPI"
    sql: ${TABLE}.RX_TX_PRESCRIBED_DRUG_GPI ;;
  }

  dimension: store_prescribed_drug_ndc {
    type: string
    label: "Prescribed Drug NDC"
    description: "Prescribed Drug NDC"
    sql: ${TABLE}.RX_TX_PRESCRIBED_DRUG_NDC ;;
  }

  dimension: store_prescribed_drug_ndc_11_digit_format {
    type: string
    label: "Prescribed Drug NDC 11 Digit Format"
    description: "11-Digit Format of Prescribed NDC represented in the format of 99999-9999-99"
    sql: CONCAT(CONCAT(CONCAT(CONCAT(SUBSTRING(${store_prescribed_drug_ndc},1,5),'-'),SUBSTRING(${store_prescribed_drug_ndc},6,4)),'-'),SUBSTRING(${store_prescribed_drug_ndc},10,2)) ;;
  }

  dimension: store_prescribed_drug_name {
    type: string
    label: "Prescribed Drug Name"
    description: "Prescribed Drug Name"
    sql: ${TABLE}.RX_TX_PRESCRIBED_DRUG_NAME ;;
  }

  dimension: rx_tx_refills_authorized {
    type: string
    label: "Prescription Transaction Refills Authorized"
    description: "Number of refills authorized by physician"
    sql: ${TABLE}.RX_TX_REFILLS_AUTHORIZED ;;
  }

  dimension: rx_tx_refills_remaining {
    type: string
    label: "Prescription Transaction Refills Remaining"
    description: "Refills remaining for this prescription"
    sql: ${TABLE}.RX_TX_REFILLS_REMAINING ;;
  }

  ############################################################################################ US47412  #########################################################################################

  dimension: rx_tx_order_class {
    label: "Prescription Order Class"
    description: "Field that indicates the class of the order. The order class is used to indicate the priority of the Prescription"
    type: string
    sql: ${TABLE}.RX_TX_ORDER_CLASS ;;
  }

  dimension: rx_tx_order_type {
    label: "Prescription Order Type"
    description: "Field that identifies the type of order the Prescription is for"
    type: string
    sql: ${TABLE}.RX_TX_ORDER_TYPE ;;
  }

  dimension: rx_tx_program_add {
    label: "Prescription Program Add"
    description: "Program Add"
    type: string
    sql: ${TABLE}.RX_TX_PROGRAM_ADD ;;
  }

  dimension: rx_tx_route_of_administration {
    label: "Prescription Route of Administration"
    description: "Stores the code for reporting the route of administration to immunization registries"
    type: string
    sql: ${TABLE}.RX_TX_ROUTE_OF_ADMINISTRATION ;;
  }

  dimension: rx_tx_site_of_administration {
    label: "Prescription Site of Adminstration"
    description: "Stores the code for reporting the site of administration to immunization registries"
    type: string
    sql: ${TABLE}.RX_TX_SITE_OF_ADMINISTRATION ;;
  }

  dimension: rx_tx_print_drug_name {
    label: "Prescription Print Drug Name"
    description: "Prescription Print Drug Name"
    type: number
    sql: ${TABLE}.RX_TX_PRINT_DRUG_NAME ;;
  }

  dimension: audit_access_log_id {
    hidden: yes
    label: "Prescription Access Log Id"
    description: "Audit Access Log Identifier"
    type: number
    sql: ${TABLE}.AUDIT_ACCESS_LOG_ID ;;
  }

  ################################################################## Dimensions ( These column has all values null (as of 15th April 2016) ###########################################################

  dimension: benefits_rights_letter {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescription Benefits Rights Letter"
    description: "Indicates if patient has received Benefits Rights Letter"
    sql: ${TABLE}.RX_TX_BENEFITS_RIGHTS_LETTER ;;
  }

  dimension: confidentiality_ind {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescription Confidentiality Ind"
    description: "Flag used to indicate if the prescription is to be kept confidential from the patient's parent or guardian"
    sql: ${TABLE}.RX_TX_CONFIDENTIALITY_IND ;;
  }

  dimension: counsel_reason {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescription Counsel Reason"
    sql: ${TABLE}.RX_TX_COUNSEL_REASON ;;
  }

  dimension: deact_rx_user_emp_num {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescription Deact Rx User Emp Num"
    description: "Employee number of user who deactivated this prescription"
    sql: ${TABLE}.RX_TX_DEACT_RX_USER_EMP_NUM ;;
  }

  dimension: deact_rx_user_first_name {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescription Deact Rx User First Name"
    description: "First name of user who deactivated this prescription"
    sql: ${TABLE}.RX_TX_DEACT_RX_USER_FIRST_NAME ;;
  }

  dimension: deact_rx_user_last_name {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescription Deact Rx User Last Name"
    description: "Last name of user who deactivated this prescription"
    sql: ${TABLE}.RX_TX_DEACT_RX_USER_LAST_NAME ;;
  }

  dimension: drug_image_key {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescription Drug Image Key"
    description: "DIB filename of the drug image associated with this transaction"
    sql: ${TABLE}.RX_TX_DRUG_IMAGE_KEY ;;
  }

  dimension: enterprise_rx_fill_count {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    sql: ${TABLE}.RX_TX_ENTERPRISE_RX_FILL_COUNT ;;
  }

  dimension: lang_manually_selected {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescription Lang Manually Selected"
    description: "Indicates if a language (that is not the default for this patient) was manually selected by a user during the fill of this prescription"
    sql: ${TABLE}.RX_TX_LANG_MANUALLY_SELECTED ;;
  }

  dimension: last_message_source {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescription Last Message Source"
    sql: ${TABLE}.RX_TX_LAST_MESSAGE_SOURCE ;;
  }

  dimension: local_mail {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescription Local Mail"
    description: "Indicates if this prescription was processed via Local Mail EPS"
    sql: ${TABLE}.RX_TX_LOCAL_MAIL ;;
  }

  dimension: lost {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescription Lost"
    description: "Used to indicate if this prescription transaction record was flagged as lost"
    sql: ${TABLE}.RX_TX_LOST ;;
  }

  dimension: mrn_location_code {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    sql: ${TABLE}.RX_TX_MRN_LOCATION_CODE ;;
  }

  dimension: prescriber_order_number {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    sql: ${TABLE}.RX_TX_PRESCRIBER_ORDER_NUMBER ;;
  }

  dimension: renewed_rx {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescription Renewed"
    description: "Indicates if this prescription was renewed"
    sql: ${TABLE}.RX_TX_RENEWED_RX ;;
  }

  dimension: rx_note {
    #       This column has all values null (as of 15th April 2016)/safe-harbor
    hidden: yes
    sql: ${TABLE}.RX_TX_RX_NOTE ;;
  }

  dimension: rx_serial_number {
    #       This column has all values null (as of 15th April 2016)/safe-harbor
    hidden: yes
    sql: ${TABLE}.RX_TX_RX_SERIAL_NUMBER ;;
  }

  dimension: rxfill_indicator {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescription Fill Indicator"
    description: "Stores the indication given by the prescriber to receive prescription filling alerts"
    sql: ${TABLE}.RX_TX_RXFILL_INDICATOR ;;
  }

  dimension: sending_application {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescription Sending Application"
    description: "Used to identify the application from which the escript prescription originated"
    sql: ${TABLE}.RX_TX_SENDING_APPLICATION ;;
  }

  dimension: shipper_tracking_number {
    #       This column has all values null (as of 15th April 2016)/safe-harbor
    hidden: yes
    sql: ${TABLE}.RX_TX_SHIPPER_TRACKING_NUMBER ;;
  }

  dimension: therapeutic_conversion {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescription Therapeutic Conversion"
    description: "Indicates if the prescription was generated due to a therapeutic conversaion"
    sql: ${TABLE}.RX_TX_THERAPEUTIC_CONVERSION ;;
  }

  dimension: unverified_rx {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescription Unverified Rx"
    description: "Flag that indicates whether a prescription is an unverified prescription and was posted to the patient?s profile without being verified by a pharmacist"
    sql: ${TABLE}.RX_TX_UNVERIFIED_RX ;;
  }

  dimension: workers_comp_flag {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescription Workers Comp Flag"
    description: "Indicates if the prescription is filed under Workers Compensation"
    sql: ${TABLE}.RX_TX_WORKERS_COMP ;;
  }

  dimension: tx_message {
    sql: ${TABLE}.RX_TX_TX_MESSAGE ;;
  }

  dimension: tx_note {
    #       This column has all values null (as of 15th April 2016)/safe-harbor
    hidden: yes
    sql: ${TABLE}.RX_TX_TX_NOTE ;;
  }

  ########################################################################################################### DATE/TIME specific Fields ################################################################################
  dimension_group: archive {
    label: "Prescription Archive"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_ARCHIVE_DATE ;;
  }

  dimension_group: deactivate_rx {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescription Deactivate Rx"
    description: ""
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_DEACTIVATE_RX_DATE ;;
  }

  dimension_group: drug_expiration {
    label: "Prescription Drug Expiration"
    description: "Represents the drug expiration date of the drug filled for this prescription transaction"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_DRUG_EXPIRATION_DATE ;;
  }

  dimension_group: expiration {
    label: "Prescription Expiration"
    description: "Stores the expiration date of prescription"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_EXPIRATION_DATE ;;
  }

  dimension_group: host_retrieval {
    label: "Prescription Host Retrieval"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_HOST_RETRIEVAL_DATE ;;
  }

  dimension_group: filled {
    label: "Prescription Filled"
    description: "Date prescription was filled"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    can_filter: yes
    sql: CASE WHEN {% condition this_year_last_year_filter %} 'Yes-Filled' {% endcondition %} THEN ${rpt_cal_this_year_last_year_filled.report_date} ELSE ${TABLE}.RX_TX_FILLED_DATE END ;;
  }

  dimension_group: next_refill {
    label: "Next Refill"
    description: "Date prescription can be refilled, based on the days supply. Calculation Used: Filled Date + Days Supply"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: DATEADD(DAY,${days_supply},${filled_date}) ;;
  }

  #     sql: CASE WHEN {% condition this_year_last_year_filter %} 'Yes-Filled' {% endcondition %} THEN DATEADD(DAY,${rpt_cal_this_year_last_year_filled.report_date},${days_supply}) ELSE DATEADD(DAY,${TABLE}.RX_TX_FILLED_DATE,${days_supply}) END

  dimension: rpt_cal_filled_date {
    # Not for display purpose but just used a field to join to rpt_cal_this_year_last_year_report_sales view file
    hidden: yes
    label: "Prescription Filled"
    description: "Date prescription was filled"
    sql: TO_DATE(${TABLE}.RX_TX_FILLED_DATE) ;;
  }

  dimension_group: first_filled {
    label: "Prescription First Filled"
    description: "Stores the date of the original prescription fill"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_FIRST_FILLED_DATE ;;
  }

  dimension_group: follow_up {
    label: "Prescription Follow Up Date"
    description: "Stores the Follow-up date"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_FOLLOW_UP_DATE ;;
  }

  dimension_group: original_written {
    label: "Prescription Original Written"
    description: "Original written date of the first prescription in a series of reassigned prescriptions"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_ORIGINAL_WRITTEN_DATE ;;
  }

  dimension_group: reportable_sales {
    label: "Prescription Reportable Sales"
    description: "Used to record the date when a TP script was adjudicated. For cash scripts, it is set when DE is completed"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: CASE WHEN {% condition this_year_last_year_filter %} 'Yes-ReportableSales' {% endcondition %} THEN ${rpt_cal_this_year_last_year_report_sales.report_date} ELSE ${TABLE}.RX_TX_REPORTABLE_SALES_DATE END ;;
    can_filter: yes
  }

  dimension: rpt_cal_reportable_sales_date {
    # Not for display purpose but just used a field to join to rpt_cal_this_year_last_year_report_sales view file
    hidden: yes
    label: "Prescription Reportable Sales"
    description: "Used to record the date when a TP script was adjudicated. For cash scripts, it is set when DE is completed"
    sql: TO_DATE(${TABLE}.RX_TX_REPORTABLE_SALES_DATE) ;;
  }



  dimension_group: rx_start {
    label: "Prescription Start"
    description: "Effective or the Earliest Fill Date/Time in which the pharmacy may fill a prescription"
    sql: ${TABLE}.RX_TX_RX_START_DATE ;;
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
  }

  dimension_group: sched_drug_report {
    label: "Prescription Sched Drug Report"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_SCHED_DRUG_REPORT_DATE ;;
  }

  dimension_group: sold {
    label: "Prescription Sold"
    description: "Date/Time prescription was sold"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: CASE WHEN {% condition this_year_last_year_filter %} 'Yes-Sold' {% endcondition %} THEN ${rpt_cal_this_year_last_year_sold.report_date} ELSE ${TABLE}.RX_TX_SOLD_DATE END ;;
    can_filter: yes
  }

  dimension: rpt_cal_sold_date {
    # Not for display purpose but just used a field to join to rpt_cal_this_year_last_year_sold view file
    hidden: yes
    label: "Prescription Sold"
    description: "Date/Time prescription was sold"
    sql: TO_DATE(${TABLE}.RX_TX_SOLD_DATE) ;;
  }

  dimension_group: written {
    label: "Prescription Written"
    description: "Date/Time prescription was written"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_WRITTEN_DATE ;;
  }

  dimension_group: will_call_picked_up {
    label: "Will Call Picked Up"
    description: "Date/Time that a prescription was sold out of Will Call by a User or a POS system"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_WILL_CALL_PICKED_UP_DATE ;;
  }

  dimension: fill_time {
    description: "Time taken to fill a prescription transaction. Calculation Used: SOLD_DATE - FILLED_DATE"
    type: number
    sql: DATEDIFF(MIN,${filled_date},${sold_date}) ;;
  }

  dimension: patient_age {
    label: "Patient Age at the Time of Fill"
    description: "Patient's Age based on when the transaction was filled"
    type: number
    sql: (DATEDIFF('DAY',${patient.patient_birth_date},${filled_date})/365.25) ;;
  }

  dimension: days_since_last_activity_patient {
    label: "Days Since Patient's Last Activity"
    description: "Indicates the number of days since the patient had his prescription last filled"
    type: number
    sql: ${TABLE}.DAYS_SINCE_LAST_ACTIVITY ;;
  }

  ##################################################################################### YES/NO & CASE WHEN fields ###############################################################################################

  dimension: paid_at_uc {
    label: "Prescription Paid At U&C Price"
    description: "Yes/No flag indicating if the transaction was paid in a U&C pricing of the drug filled"
    type: yesno
    sql: ${TABLE}.RX_TX_UC_PRICE = ${TABLE}.RX_TX_PRICE ;;
  }

  dimension: 100_percent_copay {
    label: "Prescription Paid At 100% Copay"
    description: "Yes/No flag indicating if the transaction was entirely paid at the patient copay amount"
    type: yesno
    sql: ${TABLE}.RX_TX_PRICE = ${tx_tp_summary.patient_final_copay} ;;
  }

  dimension: allergy_override {
    label: "Prescription Allergy Overide Flag"
    description: "Yes/No Flag indicating if an allergy override was performed during the filling process"
    type: yesno
    sql: ${TABLE}.RX_TX_ALLERGY_OVERRIDE = 'Y' ;;
  }

  dimension: rx_tx_specialty {
    label: "Prescription Specialty"
    description: "Yes/No flag indicating if the drug marked as a specialty drug, is to be used for the specialty prior authorization services. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.RX_TX_SPECIALTY = 'Y' ;;
  }

  dimension: compound {
    label: "Prescription Compound Flag"
    description: "Y/N Flag that determines whether prescription is for a compound drug"
    sql: ${TABLE}.RX_TX_COMPOUND ;;
  }

  dimension: has_compound_ingredients {
    label: "Prescription Has Compound Ingredients"
    description: "Indicates if this prescription is for a compound, and therefore has an associated Compound Ingredients transaction record"
    sql: ${TABLE}.RX_TX_HAS_COMPOUND_INGREDIENTS ;;
  }

  dimension: has_tx_creds {
    label: "Prescription Has Tx Creds Flag"
    description: "Yes/No flag indicating if a given prescription transaction has been credited"
    type: yesno
    sql: ${TABLE}.RX_TX_HAS_TX_CREDS = 'Y' ;;
  }

  dimension: has_tx_tps {
    label: "Prescription Has Tx Tps Flag"
    description: "Yes/No flag indicating if a given prescription transaction has claims"
    type: yesno
    sql: ${TABLE}.RX_TX_HAS_TX_TPS = 'Y' ;;
  }

  dimension: usual_and_customary_pricing_flag {
    label: "Prescription Usual And Customary Pricing Flag"
    description: "Yes/No Flag that indicates if this transaction used usual and customary pricing"
    type: yesno
    sql: ${TABLE}.RX_TX_USUAL = 'Y' ;;
  }

  dimension: autofill_mail {
    label: "Prescription Autofill Mail"
    description: "SBMO autofill setting for this prescription"

    case: {
      when: {
        sql: ${TABLE}.RX_TX_AUTOFILL_MAIL = 'Y' ;;
        label: "Automail"
      }

      when: {
        sql: ${TABLE}.RX_TX_AUTOFILL_MAIL = 'N' ;;
        label: "AutoFill/Ask"
      }

      when: {
        sql: ${TABLE}.RX_TX_AUTOFILL_MAIL = 'R' ;;
        label: "Refused"
      }

      when: {
        sql: true ;;
        label: "None of the Above"
      }
    }
  }

  dimension: call_for_refills {
    label: "Prescription Call For Refills"
    description: "Flag that determines what AutoFill should do when no refills remain or the prescription has expired"

    case: {
      when: {
        sql: ${TABLE}.RX_TX_CALL_FOR_REFILLS = 'D' ;;
        label: "Call Prescriber"
      }

      when: {
        sql: ${TABLE}.RX_TX_CALL_FOR_REFILLS = 'P' ;;
        label: "Notify Patient"
      }

      when: {
        sql: ${TABLE}.RX_TX_CALL_FOR_REFILLS = 'N' ;;
        label: "Do Not Autofill"
      }

      # ERXLPS-200  Changes made based on code review and discussion with QA and referring to Data Dictionary(Lexicon)
      when: {
        sql: true ;;
        label: "No Preference Selected"
      }
    }
  }

  dimension: immunization_indicator_description {
    label: "Prescription Immunization Indicator Description"
    description: "Immunization Vs. Non-Immunization Prescriptions"

    case: {
      when: {
        sql: ${TABLE}.RX_TX_IMMUNIZATION_INDICATOR = 'Y' ;;
        label: "Immunization"
      }

      when: {
        sql: true ;;
        label: "Non-Immunization"
      }
    }
  }

  dimension: partial_fill_status {
    label: "Prescription Partial Fill Status"
    description: "Stores the indicator of 'P' or 'C' for partial(P) /completion(C) fills"
    sql: ${TABLE}.RX_TX_PARTIAL_FILL_STATUS ;;
  }

  dimension: rx_status {
    label: "Prescription Status"
    description: "Represents the current status of the prescription in the pharmacy"

    case: {
      when: {
        sql: ${TABLE}.RX_TX_RX_STATUS = 'U' ;;
        label: "Unit Dose"
      }

      #[ERXLPS-6155]
      when: {
        sql: ${TABLE}.RX_TX_RX_STATUS = 'Y' ;;
        label: "Fillable(EPS)/Active(PDX)"
      }

      when: {
        sql: ${TABLE}.RX_TX_RX_STATUS = 'H' ;;
        label: "On File / Hold"
      }

      when: {
        sql: ${TABLE}.RX_TX_RX_STATUS = 'I' ;;
        label: "Interaction DUR"
      }

      when: {
        sql: ${TABLE}.RX_TX_RX_STATUS = 'R' ;;
        label: "Reassigned"
      }

      when: {
        sql: ${TABLE}.RX_TX_RX_STATUS = 'C' ;;
        label: "Credited Rx"
      }

      when: {
        sql: ${TABLE}.RX_TX_RX_STATUS = 'S' ;;
        label: "Service Rx"
      }

      when: {
        sql: ${TABLE}.RX_TX_RX_STATUS = 'E' ;;
        label: "Temp Workflow Rx (DUR)"
      }

      when: {
        sql: ${TABLE}.RX_TX_RX_STATUS = 'N' ;;
        label: "Non Fillable (EPS Only)"
      }

      when: {
        sql: ${TABLE}.RX_TX_RX_STATUS = 'D' ;;
        label: "Deactivated (PDX Only)"
      }

      when: {
        sql: true ;;
        label: "Unknown"
      }
    }
  }

  dimension: tp_bill_flag {
    label: "Prescription Tp Bill Flag"
    description: "Indicates if this transaction was a Cash or 'T/P'"

    case: {
      when: {
        sql: NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'N' ;;
        label: "Cash"
      }

      else: "T/P"
    }
  }

  dimension: tp_bill_status {
    label: "Prescription Tp Bill Status"
    description: "Indicates if this transaction was charged to a third party"

    case: {
      when: {
        sql: ${TABLE}.RX_TX_TP_BILL = 'Y' ;;
        label: "Charged"
      }

      when: {
        sql: ${TABLE}.RX_TX_TP_BILL = 'T' ;;
        label: "Transmitted"
      }

      when: {
        sql: NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'N' ;;
        label: "Not Charged"
      }
    }
  }

  dimension: transfer {
    label: "Prescription Transfer"
    description: "Flag indicating whether the prescription has been transfer, either incoming or outgoing"

    case: {
      when: {
        sql: ${TABLE}.RX_TX_TRANSFER = 'I' ;;
        label: "Incoming"
      }

      when: {
        sql: ${TABLE}.RX_TX_TRANSFER IN ('O','A') ;;
        label: "Outgoing"
      }

      else: "Non-Transfers"
    }
  }

  dimension: tx_status {
    label: "Prescription TX Status"
    description: "Flag indicating the status (Active, Cancelled, Credit Returned, Hold & Replacement) of the transaction"

    case: {
      when: {
        sql: NVL(${TABLE}.RX_TX_TX_STATUS,'Y') = 'Y' AND ${TABLE}.RX_TX_RX_STATUS NOT IN ('N','H','C','D') AND ${TABLE}.RX_TX_RX_STATUS IS NOT NULL AND ${TABLE}.RX_TX_COST IS NOT NULL AND ${TABLE}.RX_TX_PRICE IS NOT NULL ;;
        label: "Active"
      }

      when: {
        sql: ${TABLE}.RX_TX_TX_STATUS = 'N' ;;
        label: "Cancelled"
      }

      when: {
        sql: ${TABLE}.RX_TX_TX_STATUS = 'C' ;;
        label: "Credit Returned"
      }

      when: {
        sql: ${TABLE}.RX_TX_TX_STATUS = 'H' ;;
        label: "Hold"
      }

      else: "Replacement"
    }
  }

  dimension: active_or_nonactive_fills {
    description: "Flag indicating if you want active/non-active fills or every other prescription thats not deleted."
    # as this is used only as  filter
    hidden: yes
    sql: ${TABLE}.ACTIVE_OR_NON_ACTIVE ;;
    suggestions: ["Active"]
  }

  #   ERXLPS-79 Changes
  dimension: file_buy_flag {
    label: "Prescription File Buy"
    description: "Y/N Flag Indicating if a prescription/transaction came via File Buy"
    type: string
    sql: ${TABLE}.FILE_BUY_FLAG ;;
    suggestions: ["Y", "N"]
  }

  ################################################################################################ EPS Specific Only Fields #############################################################################

  dimension: rx_escript_message_id {
    label: "Prescription Escript Message Identifier"
    description: "eScript ID# generated at pharmacy at the time of sell which is sent in EPSv15 patientUpdate/select to EPR in order for a triggered message to be sent to Emdeon to make them aware of a successfull eScript fill. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.RX_ESCRIPT_MESSAGE_ID ;;
  }

  dimension: rx_reportable_drug_number {
    label: "Prescription Reportable Drug Number"
    description: "Schedule 2 (CAN N) Form Number. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.RX_REPORTABLE_DRUG_NUMBER ;;
  }

  dimension: rx_image_total {
    label: "Prescription Image Total"
    description: "Defines the number of prescriptions on a single hard copy image. This field is EPS only!!!"
    type: number
    sql: ${TABLE}.RX_IMAGE_TOTAL ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: rx_tx_counseling_rph_employee_number {
    label: "Prescription Counseling Rph Employee Number"
    description: "Employee Number of the Pharmacist that completed the RPh Counseling task for a prescription. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.RX_TX_COUNSELING_RPH_EMPLOYEE_NUMBER ;;
  }

  dimension: rx_tx_ddid_used_by_drug_selection {
    label: "Prescription DDID Used By Drug Selection"
    description: "DDID used by automatic drug selection for a particular fill. This field is EPS only!!!"
    type: number
    sql: ${TABLE}.RX_TX_DDID_USED_BY_DRUG_SELECTION ;;
    value_format: "######"
  }

  dimension: rx_tx_de_initials {
    label: "Prescription DE Initials"
    description: "Initials of the user who performed Data Entry on this transaction. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.RX_TX_DE_INITIALS ;;
  }

  dimension: rx_tx_dob_override_employee_number {
    label: "Prescription DOB Override Employee Number"
    description: "Employee Number of the individual that completed the Override of the DOB during DOB verification prompted at will call screen. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.RX_TX_DOB_OVERRIDE_EMPLOYEE_NUMBER ;;
  }

  dimension: rx_tx_dob_override_reason_id {
    label: "Prescription DOB Override Reason ID"
    description: "ID for the reason of the Override of the DOB during DOB verification prompted at will call screen. This field is EPS only!!!"
    hidden: yes
    type: number
    sql: ${TABLE}.RX_TX_DOB_OVERRIDE_REASON_ID ;;
  }

  dimension: rx_tx_dv_initials {
    label: "Prescription DV Initials"
    description: "Initials of the user who performed Data Verification on this transaction. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.RX_TX_DV_INITIALS ;;
  }

  dimension: rx_tx_epr_synch_version {
    label: "Prescription EPR Synch Version"
    description: "EPS version when the EPS SYNC occurs and EPR sends a successful response. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.RX_TX_EPR_SYNCH_VERSION ;;
  }

  dimension: rx_tx_gpi_used_by_drug_selection {
    label: "Prescription GPI Used By Drug Selection"
    description: "Prescribed Drug GPI used by automatic drug selection for a particular fill. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.RX_TX_GPI_USED_BY_DRUG_SELECTION ;;
  }

  dimension: rx_tx_mobile_services_channel {
    label: "Prescription Mobile Services Channel"
    description: "Channel that refills are coming into the system via true IVR or mobile device, Mobile App, text, Epharm, email, etc. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.RX_TX_MOBILE_SERVICES_CHANNEL ;;
  }

  dimension: rx_tx_new_ddid_authorized_by_emp_number {
    label: "Prescription New DDID Authorized By Emp Number"
    description: "Employee Number of the user who authorized the use of the new DDID for this fill. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.RX_TX_NEW_DDID_AUTHORIZED_BY_EMP_NUMBER ;;
  }

  dimension: rx_tx_pos_invoice_number {
    label: "Prescription POS Invoice Number"
    description: "The invoice number from the POS system. This field is EPS only!!!"
    type: number
    sql: ${TABLE}.RX_TX_POS_INVOICE_NUMBER ;;
    value_format: "######"
  }

  dimension: rx_tx_pos_reason_for_void {
    label: "Prescription POS Reason For Void"
    description: "Reason that a POS sold transaction was unsold or voided. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.RX_TX_POS_REASON_FOR_VOID ;;
  }

  dimension: rx_tx_pv_employee_number {
    label: "Prescription PV Employee Number"
    description: "Employee Number of the person who completed Product Verification. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.RX_TX_PV_EMPLOYEE_NUMBER ;;
  }

  dimension: rx_tx_register_number {
    label: "Prescription Register Number"
    description: "Register number where the prescription was sold. This field is EPS only!!!"
    type: string
    sql: ${TABLE}.RX_TX_REGISTER_NUMBER ;;
  }

  dimension_group: rx_last_refill_reminder_date {
    label: "Prescription Last Refill Reminder"
    description: "Indicates the last time this prescription was triggered for a refill reminder notification. This field is EPS only!!!"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_LAST_REFILL_REMINDER_DATE ;;
  }

  dimension_group: rx_short_fill_sent {
    label: "Prescription Short Fill Sent"
    description: "Used to identify when a SyncScript Short-Fill Request form was printed for the Prescription. This field is EPS only!!!"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_SHORT_FILL_SENT ;;
  }

  dimension_group: rx_tx_custom_reported_date {
    label: "Prescription Custom Reported"
    description: "Date/time the record was reported on the Meijer Sales Report. This field is EPS only!!!"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_CUSTOM_REPORTED_DATE ;;
  }

  dimension_group: rx_tx_dob_override_time {
    label: "Prescription DOB Override"
    description: "Date/time that the Override of the DOB was completed during DOB verification prompted at will call screen. This field is EPS only!!!"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_DOB_OVERRIDE_TIME ;;
  }

  dimension_group: rx_tx_last_epr_synch {
    label: "Prescription Last EPR Synch"
    description: "Date/time when the EPS SYNC occurs and EPR sends a successful response. This field is EPS only!!!"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_LAST_EPR_SYNCH ;;
  }

  dimension_group: rx_tx_missing_date {
    label: "Prescription Missing"
    description: "Date/time when the user reported that prescription missing. This field is EPS only!!!"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_MISSING_DATE ;;
  }

  dimension_group: rx_tx_pc_ready_date {
    label: "Prescription PC Ready"
    description: "Date/time of when the prescription was marked as Patient Accepted Counseling. This field is EPS only!!!"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_PC_READY_DATE ;;
  }

  dimension_group: rx_tx_replace_date {
    label: "Prescription Replace"
    description: "Date application replaced missing/stolen prescription filling. This field is EPS only!!!"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_REPLACE_DATE ;;
  }

  dimension_group: rx_tx_return_to_stock_date {
    label: "Prescription Return To Stock"
    description: "Date prescription filling was returned to stock. This field is EPS only!!!"
    type: time
    timeframes: [
      time,
      date,
      week,
      month,
      month_num,
      year,
      quarter,
      quarter_of_year,
      yesno,
      hour_of_day,
      time_of_day,
      hour2,
      minute15,
      day_of_week,
      week_of_year,
      day_of_week_index,
      day_of_month
    ]
    sql: ${TABLE}.RX_TX_RETURN_TO_STOCK_DATE ;;
  }

  dimension: rpt_cal_type {
    hidden: yes
    label: "Report Calendar Type"
    description: "This field is used to determine which report calendar type should be used for determining TY/LY calculation. Used only for internal calculation and not for display purposes"
    type: string
    sql: CASE WHEN {% condition this_year_last_year_filter %} 'No' {% endcondition %} THEN 'TY' WHEN {% condition this_year_last_year_filter %} 'Yes-Sold' {% endcondition %} THEN ${rpt_cal_this_year_last_year_sold.type} WHEN {% condition this_year_last_year_filter %} 'Yes-Filled' {% endcondition %} THEN ${rpt_cal_this_year_last_year_filled.type} WHEN {% condition this_year_last_year_filter %} 'Yes-ReportableSales' {% endcondition %} THEN ${rpt_cal_this_year_last_year_report_sales.type} END ;;
  }

  dimension: rx_enable_autofill {
    label: "Prescription Enable Autofill"
    description: "Flag that indicates whether this prescription is an Auto-Fill prescription. This field is EPS only!!!"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_ENABLE_AUTOFILL = 'N' ;;
        label: "No"
      }

      when: {
        sql: ${TABLE}.RX_ENABLE_AUTOFILL = 'Y' ;;
        label: "Yes"
      }

      when: {
        sql: ${TABLE}.RX_ENABLE_AUTOFILL = 'R' ;;
        label: "Refused"
      }
    }
  }

  dimension: rx_hard_copy_printed {
    label: "Prescription Hard Copy Printed"
    description: "Yes/No flag indicating whether the E-script hard copy and the System-Generated Hard Copy have been successfully printed. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.RX_HARD_COPY_PRINTED = 'Y' ;;
  }

  dimension: rx_tx_admin_rebilled {
    label: "Prescription Admin Rebilled"
    description: "Yes/No flag indicating if the prescription has been admin rebilled. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.RX_TX_ADMIN_REBILLED = 'Y' ;;
  }

  dimension: rx_tx_allow_price_override {
    label: "Prescription Allow Price Override"
    description: "Yes/No flag indicating if a price override can be performed on this transaction. This field is EPS only!!!"
    type: yesno
    sql: NVL(${TABLE}.RX_TX_ALLOW_PRICE_OVERRIDE,'Y') = 'Y' ;;
  }

  dimension: rx_tx_brand_manually_selected {
    label: "Precription Brand Manually Selected"
    description: "Yes/No flag indicating if the Brand drug was manually selected rather than being selected through auto drug selection. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.RX_TX_BRAND_MANUALLY_SELECTED = 'Y' ;;
  }

  dimension: rx_tx_competitive_priced {
    label: "Prescription Competitive Priced"
    description: "Yes/No flag indicating if the competitive pricing was used when transaction was priced. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.RX_TX_COMPETITIVE_PRICED = 'Y' ;;
  }

  dimension: rx_tx_controlled_substance_escript {
    label: "Prescription Controlled Substance Escript"
    description: "Yes/No flag indicating if prescription was generated from a controlled substance escript. Used to identify prescriptions for auditing and prescription edits requirements. This field is EPS only!!!"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_CONTROLLED_SUBSTANCE_ESCRIPT = 'N' ;;
        label: "Not Controlled Substance"
      }

      when: {
        sql: true ;;
        label: "Yes"
      }
    }
  }

  dimension: rx_tx_custom_sig {
    label: "Prescription Custom SIG"
    description: "Yes/No flag indicating if indicated SIG is a custom SIG. This means that the user typed the SIG manualy or they used a SIG code and manually added additional SIG text. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.RX_TX_CUSTOM_SIG = 'Y' ;;
  }

  dimension: rx_tx_different_generic {
    label: "Prescription Different Generic"
    description: "Yes/No flag indicating if a different generic drug was used for this fill from the previous fill. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.RX_TX_DIFFERENT_GENERIC = 'Y' ;;
  }

  dimension: rx_tx_fill_location {
    label: "Prescription Fill Location"
    description: "Flag that identifies where this transaction was filled. This field is EPS only!!!"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_FILL_LOCATION = 'A' ;;
        label: "ACS System"
      }

      when: {
        sql: ${TABLE}.RX_TX_FILL_LOCATION = 'L' ;;
        label: "Local Pharmacy"
      }

      when: {
        sql: ${TABLE}.RX_TX_FILL_LOCATION = 'M' ;;
        label: "Mail Order"
      }

      when: {
        sql: ${TABLE}.RX_TX_FILL_LOCATION = 'C' ;;
        label: "Central Fill"
      }

      when: {
        sql: true ;;
        label: "Unknown"
      }
    }
  }

  dimension: rx_tx_generic_manually_selected {
    label: "Prescription Generic Manually Selected"
    description: "Yes/No flag indicating if the Generic drug was manually selected rather than being selected through auto drug selection. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.RX_TX_GENERIC_MANUALLY_SELECTED = 'Y' ;;
  }

  dimension: rx_tx_keep_same_drug {
    label: "Prescription Keep Same Drug"
    description: "Yes/No flag indicating if the same drug should be used for each refill of a prescription. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.RX_TX_KEEP_SAME_DRUG = 'Y' ;;
  }

  dimension: rx_tx_manual_acquisition_drug_dispensed {
    label: "Prescription Manual Acquisition Drug Dispensed"
    description: "Yes/No flag indicating if, at the time the transaction was processed, the Dispensed Drug was identified as a Manual ACQ Drug. This would imply that the ACQ used to price the prescription was manually entered before pricing was done. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.RX_TX_MANUAL_ACQUISITION_DRUG_DISPENSED = 'Y' ;;
  }

  dimension: rx_tx_medicare_notice {
    label: "Prescription Medicare Notice"
    description: "Yes/No flag indicating if approval code or reject code were received in the response from the PBM and that the patient should be given a Medicare Rights Notice. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.RX_TX_MEDICARE_NOTICE = 'Y' ;;
  }

  dimension: rx_tx_no_sales_tax {
    label: "Prescription No Sales Tax"
    description: "Yes/No flag indicating if the patient associated with this transaction is flagged as tax exempt. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.RX_TX_NO_SALES_TAX = 'Y' ;;
  }

  dimension: rx_tx_otc_taxable_indicator {
    label: "Prescription OTC Taxable Indicator"
    description: "Yes/No flag indicating if the OTC drug is taxable. This field is EPS only!!!"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_OTC_TAXABLE_INDICATOR = 'Y' ;;
        label: "Yes Taxable"
      }

      when: {
        sql: true ;;
        label: "Not Taxable"
      }
    }
  }

  dimension: rx_tx_patient_request_brand_generic {
    label: "Prescription Patient Request Brand Generic"
    description: "Flag to identify that a patient has specifically requested the brand or generic when requesting their prescription be filled. This field is EPS only!!!"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_PATIENT_REQUEST_BRAND_GENERIC = 'B' ;;
        label: "Brand"
      }

      when: {
        sql: ${TABLE}.RX_TX_PATIENT_REQUEST_BRAND_GENERIC = 'G' ;;
        label: "Generic"
      }

      when: {
        sql: true ;;
        label: "Not Specified"
      }
    }
  }

  dimension: rx_tx_patient_requested_price {
    label: "Prescription Patient Requested Price"
    description: "Yes/No flag indicating if the patient requested a specific price for this transaction in Order Entry. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.RX_TX_PATIENT_REQUESTED_PRICE = 'Y' ;;
  }

  dimension: rx_tx_pickup_signature_not_required {
    label: "Prescriber Pickup Signature Not Required"
    description: "flag that marks the transaction as 'Y' Yes, it needs, or 'N', No it does not need a pickup signature due to the plan setting at the time it was sold. This field is EPS only!!!"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_PICKUP_SIGNATURE_NOT_REQUIRED = 'Y' ;;
        label: "Yes Required"
      }

      when: {
        sql: true ;;
        label: "Not Required"
      }
    }
  }

  dimension: rx_tx_price_override_reason {
    label: "Prescription Price Override Reason"
    description: "Reason that the user chose to override the price of this transaction. This field is EPS only!!!"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_PRICE_OVERRIDE_REASON = '0' ;;
        label: "Other"
      }

      when: {
        sql: ${TABLE}.RX_TX_PRICE_OVERRIDE_REASON = '1' ;;
        label: "Match Compete Price"
      }

      when: {
        sql: ${TABLE}.RX_TX_PRICE_OVERRIDE_REASON = '2' ;;
        label: "Match Quote"
      }

      when: {
        sql: ${TABLE}.RX_TX_PRICE_OVERRIDE_REASON = '3' ;;
        label: "Match Previous Fill"
      }

      when: {
        sql: ${TABLE}.RX_TX_PRICE_OVERRIDE_REASON = '4' ;;
        label: "Pricing Error"
      }

      when: {
        sql: true ;;
        label: "Not Performed"
      }
    }
  }

  dimension: rx_tx_refill_source {
    label: "Prescription Refill Source"
    description: "Flag represents the process that initiated the creation of this Prescription Transaction record. This field is EPS only!!!"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '0' ;;
        label: "IVR"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '1' ;;
        label: "Fax"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '2' ;;
        label: "Auto-fill"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '3' ;;
        label: "N/H Batch"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '4' ;;
        label: "N/H unit Dose Billing"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '5' ;;
        label: "Call-In(Non_IVR)"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '6' ;;
        label: "Walk-up"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '7' ;;
        label: "Drive-up"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '8' ;;
        label: "Order Entry"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '9' ;;
        label: "eScript"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '10' ;;
        label: "WS EPHARM"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '11' ;;
        label: "WS IVR"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '12' ;;
        label: "ePharm"
      }

      when: {
        sql: ${TABLE}.RX_TX_REFILL_SOURCE = '13' ;;
        label: "Mobile Service Provider"
      }

      when: {
        sql: true ;;
        label: "Not A Refill"
      }
    }
  }

  dimension: rx_tx_relationship_to_patient {
    label: "Prescription Relationship To Patient"
    description: "Relationship of the person dropping off or picking up the Rx, on behalf of the patient/customer. This field is EPS only!!!"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_RELATIONSHIP_TO_PATIENT = '01' ;;
        label: "Patient"
      }

      when: {
        sql: ${TABLE}.RX_TX_RELATIONSHIP_TO_PATIENT = '02' ;;
        label: "Parent/Legal Guardian"
      }

      when: {
        sql: ${TABLE}.RX_TX_RELATIONSHIP_TO_PATIENT = '03' ;;
        label: "Spouse"
      }

      when: {
        sql: ${TABLE}.RX_TX_RELATIONSHIP_TO_PATIENT = '04' ;;
        label: "Caregiver"
      }

      when: {
        sql: ${TABLE}.RX_TX_RELATIONSHIP_TO_PATIENT = '99' ;;
        label: "Other"
      }

      when: {
        sql: true ;;
        label: "Not Specified"
      }
    }
  }

  dimension: rx_tx_require_relation_to_patient {
    label: "Prescription Require Relation To Patient"
    description: "Flag to identify if the relationship of the person picking up of dropping off a rx on behalf or the customer still needs to be collected. This field is EPS only!!!"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_REQUIRE_RELATION_TO_PATIENT = 'Y' ;;
        label: "Yes Need Data"
      }

      when: {
        sql: ${TABLE}.RX_TX_REQUIRE_RELATION_TO_PATIENT = 'N' ;;
        label: "No Data Not Needed"
      }

      when: {
        sql: ${TABLE}.RX_TX_REQUIRE_RELATION_TO_PATIENT = 'D' ;;
        label: "Data Acquired"
      }

      when: {
        sql: true ;;
        label: "Not Specified"
      }
    }
  }

  dimension: rx_tx_rx_com_down {
    label: "Prescription RXCOM Down"
    description: "Flag that indicates that the RX_TX record was added while communication to the Central Patient database was down, and a patient select has not occured. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.RX_TX_RX_COM_DOWN = 'Y' ;;
  }

  dimension: rx_tx_rx_stolen {
    label: "Prescription Stolen"
    description: "Yes/No flag indicating if the prescription has been marked as stolen. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.RX_TX_RX_STOLEN = 'Y' ;;
  }

  dimension: rx_tx_sent_to_ehr {
    label: "Prescription Sent To EHR"
    description: "Yes/No flag indicating if the transaction has been sent EHR (Set by the application when the record is sent to EHR). This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.RX_TX_SENT_TO_EHR = 'Y' ;;
  }

  dimension: rx_tx_specialty_pa_status {
    label: "Prescription Specialty PA Status"
    description: "Status used to determine where the order is in the specialty prior authorization communication process, from the time it leaves EPS for billing analysis to the time it comes back to the store for filling. This field is EPS only!!!"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_SPECIALTY_PA_STATUS = '1' ;;
        label: "Specialty Sent"
      }

      when: {
        sql: ${TABLE}.RX_TX_SPECIALTY_PA_STATUS = '2' ;;
        label: "Specialty Received"
      }

      when: {
        sql: ${TABLE}.RX_TX_SPECIALTY_PA_STATUS = '3' ;;
        label: "Specialty Failed"
      }

      when: {
        sql: ${TABLE}.RX_TX_SPECIALTY_PA_STATUS = '4' ;;
        label: "Specialty Complete"
      }

      when: {
        sql: true ;;
        label: "Not Specified"
      }
    }
  }

  dimension: rx_tx_state_report_status {
    label: "Prescription State Report Status"
    description: "Flag indicating if the EC5 report has been submitted to the pharmacies specific state prescription monitoring program. This field is EPS only!!!"
    type: string

    case: {
      when: {
        sql: ${TABLE}.RX_TX_STATE_REPORT_STATUS = '0' ;;
        label: "ECS Not Sent"
      }

      when: {
        sql: ${TABLE}.RX_TX_STATE_REPORT_STATUS = '1' ;;
        label: "ECS Sent"
      }

      when: {
        sql: ${TABLE}.RX_TX_STATE_REPORT_STATUS = '2' ;;
        label: "ECS Sent And Credited"
      }

      when: {
        sql: ${TABLE}.RX_TX_STATE_REPORT_STATUS = '3' ;;
        label: "ECS Sent And Changed"
      }

      when: {
        sql: true ;;
        label: "Not Available"
      }
    }
  }

  dimension: rx_tx_tx_user_modified {
    label: "Prescription Transaction User Modified"
    description: "Yes/No flag indicating if the prescription or transaction Modification/Correction was performed at the source system (EPS). This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.RX_TX_TX_USER_MODIFIED = 'Y' ;;
  }

  dimension: rx_tx_using_compound_plan_pricing {
    label: "Prescription Using Compound Plan Pricing"
    description: "Yes/No flag indicating if the Compound Plan Pricing was used when this transaction was priced. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.RX_TX_USING_COMPOUND_PLAN_PRICING = 'Y' ;;
  }

  dimension: rx_tx_using_percent_of_brand {
    label: "Prescription Using Percent od Brand"
    description: "Yes/No flag indicating if the generic price was based on a percentage of the brand price. This field is EPS only!!!"
    type: yesno
    sql: ${TABLE}.RX_TX_USING_PERCENT_OF_BRAND = 'Y' ;;
  }

  ############################################################ Start ERXLPS-386 New Dimensions added for BI ALB ##################################

  dimension: rx_tx_fill_quantity {
    label: "Prescription Fill Quantity"
    description: "Quantity (number of units) of the drug dispensed. (This field should only be used for grouping or filtering. Example: if you want to see Transaction Disp by Qty 30, 60, etc... )"
    type: number
    can_filter: no
    sql: CASE WHEN ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_FILL_QUANTITY END ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  dimension: rx_tx_price {
    label: "Sales"
    description: "Price of prescription for Active transactions. (This field should only be used for grouping or filtering. Example: if you want to see the price of Prescriptions Sales $25, $35, etc ... )"
    type: number
    sql: CASE WHEN ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_PRICE END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  dimension: rx_tx_uc_price {
    label: "Prescription U&C Price"
    description: "Usual and Customary Price of the prescription of the drug filled. (This field should only be used for grouping or filtering. Example: if you want to see U&C pricing of $50, $100,etc... )"
    type: number
    sql: CASE WHEN ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_UC_PRICE END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ############################################################ End of ERXLPS-386 New Dimensions added for BI ALB ##################################
  #[ERXLPS-2045] - Added reference dimension to use it in other dimensions and measures. Added NVL to consider drug_multi_source with NULL records as generic scripts.
  dimension: drug_multi_source_reference {
    type: string
    hidden: yes
    sql: NVL(${drug.drug_multi_source},'Y') ;;
  }

  ################################################################################################## End of Dimensions #################################################################################################

  ####################################################################################################### Measures ####################################################################################################

  # This measure is used only in store explore to determine the no. of prescription transactions that were filled
  measure: store_rx_tx_fill_count {
    label: "Store Prescription Fill Count"
    type: count_distinct
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number} ||'@'|| ${rx_number} ;; #ERXLPS-1649
    value_format: "#,##0"
  }

  measure: avg_fill_time {
    label: "Average Fill Time"
    type: average
    sql: (${fill_time}) ;;
  }

  measure: count {
    label: "Total Scripts"
    description: "Total Scripts for Active fills"
    type: count_distinct
    # If This view in the future is broken to include rejects, on-holds then the logic will need to change & probably a new field for Active Scripts may be required at that point
    sql: (CASE WHEN ${rpt_cal_type} = 'TY' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
    value_format: "#,##0"
    drill_fields: [detail*]
  }

  measure: count_last_year {
    label: "LY Total Scripts"
    description: "Total Scripts for Active fills for last year based on the period selected"
    type: count_distinct
    # If This view in the future is broken to include rejects, on-holds then the logic will need to change & probably a new field for Active Scripts may be required at that point
    sql: (CASE WHEN ${rpt_cal_type} = 'LY' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
    value_format: "#,##0"
    drill_fields: [detail*]
  }

  #   ERXLPS-80 Changes
  measure: count_adjusted {
    label: "Total Adjusted Scripts"
    description: "Total Scripts for Active fills based on adjustment done on Days Supply (i.e. when Days Supply = 90, the script count is increased by 3 for each script)"
    type: number
    # If This view in the future is broken to include rejects, on-holds then the logic will need to change & probably a new field for Active Scripts may be required at that point
    sql: COUNT(DISTINCT(CASE WHEN ${rpt_cal_type} = 'TY' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END)) + (COUNT(DISTINCT((CASE WHEN ${rpt_cal_type} = 'TY' AND ${days_supply} = 90 THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END)))*2) ;;
    value_format: "#,##0"
    drill_fields: [detail*]
  }

  measure: count_last_year_adjusted {
    label: "LY Total Adjusted Scripts"
    description: "Total Scripts for Active fills for last year based on the period selected and by adjustment done on Days Supply (i.e. when Days Supply = 90, the script count is increased by 3 for each script)"
    type: number
    # If This view in the future is broken to include rejects, on-holds then the logic will need to change & probably a new field for Active Scripts may be required at that point
    sql: COUNT(DISTINCT(CASE WHEN ${rpt_cal_type} = 'LY' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END)) + (COUNT(DISTINCT((CASE WHEN ${rpt_cal_type} = 'LY' AND ${days_supply} = 90 THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END)))*2) ;;
    value_format: "#,##0"
    drill_fields: [detail*]
  }

  measure: count_variance {
    label: "TY/LY Total Scripts Variance %"
    description: "Percentage Increase/Decrease of the Active Prescription Fills compared to the Last Year"
    type: number
    sql: CAST((${count} - ${count_last_year}) AS DECIMAL(38,7))/(NULLIF(${count_last_year},0)) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  #     html: |
  #         {% if value < 0 %}
  #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% else %}
  #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% endif %}

  #   ERXLPS-80 Changes
  measure: count_variance_adjusted {
    label: "TY/LY Total Adjusted Scripts Variance %"
    description: "Percentage Increase/Decrease of the Active Prescription Fills compared to the Last Year based on the adjustment done on Days Supply (i.e. when Days Supply = 90, the script count is increased by 3 for each script)"
    type: number
    sql: CAST((${count_adjusted} - ${count_last_year_adjusted}) AS DECIMAL(38,7))/(NULLIF(${count_last_year_adjusted},0)) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  #     html: |
  #         {% if value < 0 %}
  #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% else %}
  #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% endif %}

  measure: count_new {
    label: "New Scripts"
    description: "Total New Scripts for Active fills"
    type: count_distinct
    sql: (CASE WHEN ${TABLE}.RX_TX_FILL_STATUS = 'N' AND ${rpt_cal_type} = 'TY' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
    value_format: "#,##0"
    drill_fields: [detail*]
  }

  measure: count_new_last_year {
    label: "LY New Scripts"
    description: "Total New Scripts for Active fills for last year based on the period selected"
    type: count_distinct
    sql: (CASE WHEN ${TABLE}.RX_TX_FILL_STATUS = 'N' AND ${rpt_cal_type} = 'LY' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
    value_format: "#,##0"
    drill_fields: [detail*]
  }

  measure: count_new_variance {
    label: "TY/LY New Scripts Variance %"
    description: "Percentage Increase/Decrease of the New Scripts for Active Fills compared to the Last Year"
    type: number
    sql: CAST((${count_new} - ${count_new_last_year}) AS DECIMAL(38,7))/NULLIF(${count_new_last_year},0) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  #     html: |
  #         {% if value < 0 %}
  #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% else %}
  #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% endif %}

  measure: count_new_pct {
    label: "New Scripts %"
    description: "Percentage of the New Scripts in comparisson to the Total Scripts for Active Fills"
    type: number
    sql: ${count_new}/NULLIF(${count},0) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  measure: count_refill {
    label: "Refill Scripts"
    description: "Total Refill Scripts for Active fills"
    type: count_distinct
    sql: (CASE WHEN ${TABLE}.RX_TX_FILL_STATUS = 'R' AND ${rpt_cal_type} = 'TY' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
    value_format: "#,##0"
    drill_fields: [detail*]
  }

  measure: count_refill_last_year {
    label: "LY Refill Scripts"
    description: "Total Refill Scripts for Active fills for last year based on the period selected"
    type: count_distinct
    sql: (CASE WHEN ${TABLE}.RX_TX_FILL_STATUS = 'R' AND ${rpt_cal_type} = 'LY' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
    value_format: "#,##0"
    drill_fields: [detail*]
  }

  measure: count_refill_variance {
    label: "TY/LY Refill Scripts Variance %"
    description: "Percentage Increase/Decrease of the Refill Scripts for Active Fills compared to the Last Year"
    type: number
    sql: CAST((${count_refill} - ${count_refill_last_year}) AS DECIMAL(38,7))/NULLIF(${count_refill_last_year},0) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  #     html: |
  #         {% if value < 0 %}
  #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% else %}
  #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% endif %}

  measure: count_refill_pct {
    label: "Refill Scripts %"
    description: "Percentage of the Refill Scripts in comparisson to the Total Scripts for Active Fills"
    type: number
    sql: ${count_refill}/NULLIF(${count},0) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  #[ERXLPS-2045] replaced drug.drug_multi_source with drug_multi_source_reference dimension.
  measure: count_generic {
    label: "Generic Scripts"
    description: "Total Generic Scripts for Active fills"
    type: count_distinct
    sql: (CASE WHEN ${drug_multi_source_reference} = 'Y' AND ${rpt_cal_type} = 'TY' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
    value_format: "#,##0"
    drill_fields: [detail*]
  }

  #[ERXLPS-2045] replaced drug.drug_multi_source with drug_multi_source_reference dimension.
  measure: count_generic_last_year {
    label: "LY Generic Scripts"
    description: "Total Generic Scripts for Active fills for last year based on the period selected"
    type: count_distinct
    sql: (CASE WHEN ${drug_multi_source_reference} = 'Y' AND ${rpt_cal_type} = 'LY' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
    value_format: "#,##0"
    drill_fields: [detail*]
  }

  measure: count_generic_variance {
    label: "TY/LY Generic Scripts Variance %"
    description: "Percentage Increase/Decrease of the Generic Scripts for Active Fills compared to the Last Year"
    type: number
    sql: CAST((${count_generic} - ${count_generic_last_year}) AS DECIMAL(38,7))/NULLIF(${count_generic_last_year},0) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  #     html: |
  #         {% if value < 0 %}
  #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% else %}
  #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% endif %}

  measure: count_generic_pct {
    label: "Generic Scripts %"
    description: "Percentage of the Generic Scripts in comparisson to the Total Scripts for Active Fills"
    type: number
    sql: ${count_generic}/NULLIF(${count},0) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  #[ERXLPS-2045] replaced drug.drug_multi_source with drug_multi_source_reference dimension.
  measure: count_brand {
    label: "Brand Scripts"
    description: "Total Brand Scripts for Active fills"
    type: count_distinct
    sql: (CASE WHEN ${drug_multi_source_reference} <> 'Y' AND ${rpt_cal_type} = 'TY' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
    value_format: "#,##0"
    drill_fields: [detail*]
  }

  #[ERXLPS-2045] replaced drug.drug_multi_source with drug_multi_source_reference dimension.
  measure: count_brand_last_year {
    label: "LY Brand Scripts"
    description: "Total Brand Scripts for Active fills for last year based on the period selected"
    type: count_distinct
    sql: (CASE WHEN ${drug_multi_source_reference} <> 'Y' AND ${rpt_cal_type} = 'LY' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
    value_format: "#,##0"
    drill_fields: [detail*]
  }

  measure: count_brand_variance {
    label: "TY/LY Brand Scripts Variance %"
    description: "Percentage Increase/Decrease of the Brand Scripts for Active Fills compared to the Last Year"
    type: number
    sql: CAST((${count_brand} - ${count_brand_last_year}) AS DECIMAL(38,7))/NULLIF(${count_brand_last_year},0) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  #     html: |
  #         {% if value < 0 %}
  #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% else %}
  #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% endif %}

  measure: count_brand_pct {
    label: "Brand Scripts %"
    description: "Percentage of the Branded Scripts in comparisson to the Total Scripts for Active Fills"
    type: number
    sql: ${count_brand}/NULLIF(${count},0) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  measure: count_cash {
    label: "Cash Scripts"
    description: "Total Cash Scripts for Active fills"
    type: count_distinct
    sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'N' AND ${rpt_cal_type} = 'TY' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
    value_format: "#,##0"
    drill_fields: [detail*]
  }

  measure: count_cash_last_year {
    label: "LY Cash Scripts"
    description: "Total Cash Scripts for Active fills for last year based on the period selected"
    type: count_distinct
    sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'N' AND ${rpt_cal_type} = 'LY' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
    value_format: "#,##0"
    drill_fields: [detail*]
  }

  measure: count_cash_variance {
    label: "TY/LY Cash Scripts Variance %"
    description: "Percentage Increase/Decrease of the Cash Scripts for Active Fills compared to the Last Year"
    type: number
    sql: CAST((${count_cash} - ${count_cash_last_year}) AS DECIMAL(38,7))/NULLIF(${count_cash_last_year},0) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  #     html: |
  #         {% if value < 0 %}
  #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% else %}
  #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% endif %}

  measure: count_cash_pct {
    label: "Cash Scripts %"
    description: "Percentage of the Cash Scripts in comparisson to the Total Scripts for Active Fills"
    type: number
    sql: ${count_cash}/NULLIF(${count},0) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  measure: count_tp {
    label: "TP Scripts"
    description: "Total Third Party Scripts for Active fills"
    type: count_distinct
    sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'Y' AND ${rpt_cal_type} = 'TY' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
    value_format: "#,##0"
    drill_fields: [detail*]
  }

  measure: count_tp_last_year {
    label: "LY TP Scripts"
    description: "Total Third Party Scripts for Active fills for last year based on the period selected"
    type: count_distinct
    sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'Y' AND ${rpt_cal_type} = 'LY' THEN (${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${tx_number}) END) ;;
    value_format: "#,##0"
    drill_fields: [detail*]
  }

  measure: count_tp_variance {
    label: "TY/LY TP Scripts Variance %"
    description: "Percentage Increase/Decrease of the Third Party Scripts for Active Fills compared to the Last Year"
    type: number
    sql: CAST((${count_tp} - ${count_tp_last_year}) AS DECIMAL(38,7))/NULLIF(${count_tp_last_year},0) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  #     html: |
  #         {% if value < 0 %}
  #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% else %}
  #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% endif %}

  measure: count_tp_pct {
    label: "TP Scripts %"
    description: "Percentage of the Third Party Scripts in comparisson to the Total Scripts for Active Fills"
    type: number
    sql: ${count_tp}/NULLIF(${count},0) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  #   - measure: sum_price
  #     label: "Total Sales"
  #     description: "Total Price of prescription"
  #     type: sum
  #     sql: (CASE WHEN ${TABLE}.LAST_YEAR = 'No' THEN ${TABLE}.RX_TX_PRICE END)
  #     value_format: '$#,##0.00;($#,##0.00)'
  #     drill_fields: detail
  #
  #   - measure: sum_price_last_year
  #     label: "LY Total Sales"
  #     description: "Total Price of prescription for last year based on the period selected"
  #     type: sum
  #     sql: (CASE WHEN ${TABLE}.LAST_YEAR = 'Yes' THEN ${TABLE}.RX_TX_PRICE END)
  #     value_format: '$#,##0.00;($#,##0.00)'
  #     drill_fields: detail

  measure: sum_price {
    label: "Total Sales"
    description: "Total Price of prescription"
    type: sum
    sql: (CASE WHEN ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_PRICE END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [detail*]
  }

  measure: tx_tp_claim_amount {
    label: "Total Claim Amount"
    description: "Toal Claim Amount from Third Party. Calculation Used: Prescription Transaction Price - Patient Final Copay"
    # sum is not used as the unlderlying fields used in this measures already does a SUM
    type: number
    sql: ${sum_price} - ${tx_tp_summary.sum_patient_final_copay} ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [detail*]
  }

  measure: sum_price_last_year {
    label: "LY Total Sales"
    description: "Total Price of prescription for last year based on the period selected"
    type: sum
    sql: (CASE WHEN ${rpt_cal_type} = 'LY' THEN ${TABLE}.RX_TX_PRICE END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [detail*]
  }

  measure: sum_price_variance {
    label: "TY/LY Sales Variance %"
    description: "Percentage Increase/Decrease of the Total Prescription Price compared to the Last Year"
    type: number
    sql: CAST((${sum_price} - ${sum_price_last_year}) AS DECIMAL(38,7))/NULLIF(${sum_price_last_year},0) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  #     html: |
  #         {% if value < 0 %}
  #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% else %}
  #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% endif %}

  #[ERXLPS-2045] replaced drug.drug_multi_source with drug_multi_source_reference dimension.
  measure: sum_price_generic {
    label: "Generic Sales"
    description: "Total Price of prescription for Generic Drugs"
    type: sum
    sql: (CASE WHEN ${drug_multi_source_reference} = 'Y' AND ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_PRICE END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [detail*]
  }

  #[ERXLPS-2045] replaced drug.drug_multi_source with drug_multi_source_reference dimension.
  measure: sum_price_generic_last_year {
    label: "LY Generic Sales"
    description: "Total Price of prescription for Generic Drugs for last year based on the period selected"
    type: sum
    sql: (CASE WHEN ${drug_multi_source_reference} = 'Y' AND ${rpt_cal_type} = 'LY' THEN ${TABLE}.RX_TX_PRICE END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [detail*]
  }

  measure: sum_price_generic_variance {
    label: "TY/LY Generic Sales Variance %"
    description: "Percentage Increase/Decrease of the Prescription Price for Generic Drugs compared to the Last Year"
    type: number
    sql: CAST((${sum_price_generic} - ${sum_price_generic_last_year}) AS DECIMAL(38,7))/NULLIF(${sum_price_generic_last_year},0) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  #     html: |
  #         {% if value < 0 %}
  #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% else %}
  #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% endif %}

  measure: sum_price_generic_pct {
    label: "Generic Sales %"
    description: "% Sales for Generic Drugs.  Formula Used: ( Prescription Price - Generic/Prescription Price - Total)"
    type: number
    sql: ${sum_price_generic}/NULLIF(${sum_price},0) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  #[ERXLPS-2045] replaced drug.drug_multi_source with drug_multi_source_reference dimension.
  measure: sum_price_brand {
    label: "Brand Sales"
    description: "Total Price of prescription for Branded Drugs"
    type: sum
    sql: (CASE WHEN ${drug_multi_source_reference} <> 'Y' AND ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_PRICE END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [detail*]
  }

  #[ERXLPS-2045] replaced drug.drug_multi_source with drug_multi_source_reference dimension.
  measure: sum_price_brand_last_year {
    label: "LY Brand Sales"
    description: "Total Price of prescription for Branded Drugs for last year based on the period selected"
    type: sum
    sql: (CASE WHEN ${drug_multi_source_reference} <> 'Y' AND ${rpt_cal_type} = 'LY' THEN ${TABLE}.RX_TX_PRICE END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [detail*]
  }

  measure: sum_price_brand_variance {
    label: "TY/LY Brand Sales Variance %"
    description: "Percentage Increase/Decrease of the Prescription Price for Branded Drugs compared to the Last Year"
    type: number
    sql: CAST((${sum_price_brand} - ${sum_price_brand_last_year}) AS DECIMAL(38,7))/NULLIF(${sum_price_brand_last_year},0) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  #     html: |
  #         {% if value < 0 %}
  #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% else %}
  #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% endif %}

  measure: sum_price_brand_pct {
    label: "Brand Sales %"
    description: "% Sales for Branded Drugs.  Formula Used: ( Prescription Price - Brand/Prescription Price - Total)"
    type: number
    sql: ${sum_price_brand}/NULLIF(${sum_price},0) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  measure: sum_price_cash {
    label: "Cash Sales"
    description: "Total Price of prescription for Cash Transactions"
    type: sum
    sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'N' AND ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_PRICE END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [detail*]
  }

  measure: sum_price_cash_last_year {
    label: "LY Cash Sales"
    description: "Total Price of prescription for Cash Transactions for last year based on the period selected"
    type: sum
    sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'N' AND ${rpt_cal_type} = 'LY' THEN ${TABLE}.RX_TX_PRICE END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [detail*]
  }

  measure: sum_price_cash_variance {
    label: "TY/LY Cash Sales Variance %"
    description: "Percentage Increase/Decrease of the Prescription Price for Cash Transactions compared to the Last Year"
    type: number
    sql: CAST((${sum_price_cash} - ${sum_price_cash_last_year}) AS DECIMAL(38,7))/NULLIF(${sum_price_cash_last_year},0) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  measure: sum_price_cash_pct {
    label: "Cash Sales %"
    description: "% Sales for Cash Transactions.  Formula Used: ( Prescription Price - Cash / Prescription Price - Total)"
    type: number
    sql: ${sum_price_cash}/NULLIF(${sum_price},0) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  measure: sum_price_tp {
    label: "TP Sales"
    description: "Total Price of prescription for Third Party Transactions"
    type: sum
    sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'Y' AND ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_PRICE END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [detail*]
  }

  measure: sum_price_tp_last_year {
    label: "LY TP Sales"
    description: "Total Price of prescription for Third Party Transactions for last year based on the period selected"
    type: sum
    sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'Y' AND ${rpt_cal_type} = 'LY' THEN ${TABLE}.RX_TX_PRICE END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [detail*]
  }

  measure: sum_price_tp_variance {
    label: "TY/LY TP Sales Variance %"
    description: "Percentage Increase/Decrease of the Prescription Price for Third Party Transactions compared to the Last Year"
    type: number
    sql: CAST((${sum_price_tp} - ${sum_price_tp_last_year}) AS DECIMAL(38,7))/NULLIF(${sum_price_tp_last_year},0) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  measure: sum_price_tp_pct {
    label: "TP Sales %"
    description: "% Sales for Third Party Transactions.  Formula Used: ( Prescription Price - Third Party / Prescription Price - Total)"
    type: number
    sql: ${sum_price_tp}/NULLIF(${sum_price},0) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  measure: sum_other_price {
    label: "Prescription Other Price"
    description: "The total price of the other drug (brand/generic) that was not used in the dispensing of this prescription"
    type: sum
    sql: (CASE WHEN ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_OTHER_PRICE END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_acquisition_cost {
    label: "Prescription ACQ Cost"
    description: "Represents the total acquisition cost of filled drug used on the prescription transaction record"
    type: sum
    sql: (CASE WHEN ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_ACQUISITION_COST END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_acquisition_cost_last_year {
    label: "LY Prescription ACQ Cost"
    description: "Represents the total acquisition cost of filled drug used on the prescription transaction record for last year based on the period selected"
    type: sum
    sql: (CASE WHEN ${rpt_cal_type} = 'LY' THEN ${TABLE}.RX_TX_ACQUISITION_COST END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [detail*]
  }

  measure: sum_acquisition_cost_variance {
    label: "TY/LY Prescription ACQ $ Variance"
    description: "$ Increase/Decrease of the total acquisition cost of filled drug on the prescription transaction compared to the Last Year"
    type: number
    sql: (${sum_acquisition_cost} - ${sum_acquisition_cost_last_year}) ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [detail*]
  }

  #     html: |
  #         {% if value < 0 %}
  #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% else %}
  #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% endif %}

  measure: sum_margin {
    label: "Prescription Gross Margin %"
    description: "Margin % of the prescription. Formula Used: ( (Total Price of prescription - Total Acquisition Cost of prescription)/Total Price of prescription)"
    type: number
    sql: (${sum_price} - ${sum_acquisition_cost})/NULLIF(${sum_price},0) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  #     html: |
  #         {% if value < 0 %}
  #           <b><style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</b>
  #         {% elsif value < 20 %}
  #           <b><style="color: black; background-color: #e9b404; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</b>
  #         {% else %}
  #           <b><style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</b>
  #         {% endif %}

  measure: sum_margin_last_year {
    label: "LY Prescription Gross Margin %"
    description: "Margin % of the prescription for the last year based on the Period Selected. Formula Used: ( (LY Total Price of prescription - LY Total Acquisition Cost of prescription)/LY Total Price of prescription)"
    type: number
    sql: (${sum_price_last_year} - ${sum_acquisition_cost_last_year})/NULLIF(${sum_price_last_year},0) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  #     html: |
  #         {% if value < 0 %}
  #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% elsif value < 20 %}
  #           <b><p style="color: black; background-color: #e9b404; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% else %}
  #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% endif %}

  measure: sum_margin_variance {
    label: "TY/LY Prescription Gross Margin Variance %"
    description: "Margin % Increase/Decrease of the Prescription compared to the Last Year"
    type: number
    sql: CAST((${sum_margin} - ${sum_margin_last_year}) AS DECIMAL(38,7))/NULLIF(${sum_margin_last_year},0) ;;
    value_format: "00.00%"
    drill_fields: [detail*]
  }

  #     html: |
  #         {% if value < 0 %}
  #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% elsif value < 20 %}
  #           <b><p style="color: black; background-color: #e9b404; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% else %}
  #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% endif %}

  measure: sum_margin_dollars {
    label: "Prescription Gross Margin $"
    description: "Margin $ of the Prescription. Formula Used: ( (Total Price of prescription - Total Acquisition Cost of prescription))"
    type: number
    sql: (${sum_price} - ${sum_acquisition_cost}) ;;
    drill_fields: [detail*]
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #     html: |
  #         {% if value < 0 %}
  #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% elsif value < 20 %}
  #           <b><p style="color: black; background-color: #e9b404; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% else %}
  #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% endif %}

  measure: sum_margin_dollars_last_year {
    label: "LY Prescription Gross Margin $"
    description: "Margin $ of the Prescription for the last year based on the Period Selected. Formula Used: ( (LY Total Price of prescription - LY Total Acquisition Cost of prescription))"
    type: number
    sql: (${sum_price_last_year} - ${sum_acquisition_cost_last_year}) ;;
    drill_fields: [detail*]
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #     html: |
  #         {% if value < 0 %}
  #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% elsif value < 20 %}
  #           <b><p style="color: black; background-color: #e9b404; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% else %}
  #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% endif %}

  measure: sum_margin_dollars_variance {
    label: "TY/LY Prescription Gross Margin $ Variance"
    description: "Margin $ Increase/Decrease of the Prescription compared to the Last Year"
    type: number
    sql: (${sum_margin_dollars} - ${sum_margin_dollars_last_year}) ;;
    drill_fields: [detail*]
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #     html: |
  #         {% if value < 0 %}
  #           <b><p style="color: white; background-color: #dc7350; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% elsif value < 20 %}
  #           <b><p style="color: black; background-color: #e9b404; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% else %}
  #           <b><p style="color: white; background-color: #20D76C; font-size:100%; text-align:center; margin: 0; border-radius: 5px;">{{ rendered_value }}</p></b>
  #         {% endif %}

  measure: sum_uc_price {
    label: "Prescription U&C Price"
    description: "Total Usual and Customary Price of the prescription of the drug filled"
    type: sum
    sql: ${TABLE}.RX_TX_UC_PRICE ;;
    value_format: "$#,##0.00;($#,##0.00)"
    drill_fields: [detail*]
  }

  measure: avg_price {
    label: "Avg Prescription Price - Total"
    description: "Average Prescription Price"
    type: average
    sql: CASE WHEN ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_PRICE END ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXLPS-2045] replaced drug.drug_multi_source with drug_multi_source_reference dimension.
  measure: avg_price_generic {
    label: "Avg Prescription Price - Generic"
    description: "Average Prescription Price for Generic Drugs"
    type: average
    sql: (CASE WHEN ${drug_multi_source_reference} = 'Y' AND ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_PRICE END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXLPS-2045] replaced drug.drug_multi_source with drug_multi_source_reference dimension.
  measure: avg_price_brand {
    label: "Avg Prescription Price - Brand"
    description: "Average Prescription Price for Branded Drugs"
    type: average
    sql: (CASE WHEN ${drug_multi_source_reference} <> 'Y' AND ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_PRICE END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_price_cash {
    label: "Avg Prescription Price - Cash"
    description: "Average Prescription Price for Cash Transactions"
    type: average
    sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'N' AND ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_PRICE END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_price_tp {
    label: "Avg Prescription Price - T/P"
    description: "Average Prescription Price for Third Party Transactions"
    type: average
    sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'Y' AND ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_PRICE END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_acquisition_cost {
    label: "Avg Prescription ACQ Cost - Total"
    description: "Average Acquisition Cost for Generic Drugs"
    type: average
    sql: (CASE WHEN ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_ACQUISITION_COST END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXLPS-2045] replaced drug.drug_multi_source with drug_multi_source_reference dimension.
  measure: avg_acquisition_cost_generic {
    label: "Avg Prescription ACQ Cost - Generic"
    description: "Average Acquisition Cost for Generic Drugs"
    type: average
    sql: (CASE WHEN ${drug_multi_source_reference} = 'Y' AND ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_ACQUISITION_COST END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  #[ERXLPS-2045] replaced drug.drug_multi_source with drug_multi_source_reference dimension.
  measure: avg_acquisition_cost_brand {
    label: "Avg Prescription ACQ Cost - Brand"
    description: "Average Acquisition Cost for Branded Drugs"
    type: average
    sql: (CASE WHEN ${drug_multi_source_reference} <> 'Y' AND ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_ACQUISITION_COST END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_acquisition_cost_cash {
    label: "Avg Prescription ACQ Cost - Cash"
    description: "Average Acquisition Cost for Cash Transactions"
    type: average
    sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'N' AND ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_ACQUISITION_COST END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_acquisition_cost_tp {
    label: "Avg Prescription ACQ Cost - TP"
    description: "Average Acquisition Cost for Third Party Transactions"
    type: average
    sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'Y' AND ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_ACQUISITION_COST END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_margin_dollars {
    label: "Avg Prescription Gross Margin $ - Total"
    description: "Average Margin $ of the Prescription. Formula Used: ( (Average Price of prescription - Average ACQ Cost of prescription))"
    type: number
    sql: (${avg_price} - ${avg_acquisition_cost}) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_margin_generic {
    label: "Avg Prescription Gross Margin $ - Generic"
    description: "Average Margin $ of the Prescription for Generic Drugs. Formula Used: ( (Average Price of prescription for Generic Drugs - Average ACQ Cost of prescription for Generic Drugs))"
    type: number
    sql: (${avg_price_generic} - ${avg_acquisition_cost_generic}) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_margin_brand {
    label: "Avg Prescription Gross Margin $ - Brand"
    description: "Average Margin $ of the Prescription for Branded Drugs. Formula Used: ( (Average Price of prescription for Branded Drugs - Average ACQ Cost of prescription for Branded Drugs))"
    type: number
    sql: (${avg_price_brand} - ${avg_acquisition_cost_brand}) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_margin_cash {
    label: "Avg Prescription Gross Margin $ - Cash"
    description: "Average Margin $ of the Prescription for Cash Transactions. Formula Used: ( (Average Price of prescription for Cash Transactions - Average ACQ Cost of prescription for Cash Transactions))"
    type: number
    sql: (${avg_price_cash} - ${avg_acquisition_cost_cash}) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_margin_tp {
    label: "Avg Prescription Gross Margin $ - TP"
    description: "Average Margin $ of the Prescription for Third Party Transactions. Formula Used: ( (Average Price of prescription for Third Party Transactions - Average ACQ Cost of prescription for Cash Transactions))"
    type: number
    sql: (${avg_price_tp} - ${avg_acquisition_cost_tp}) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_uc_price {
    label: "Avg Prescription U&C Price"
    description: "Average Usual and Customary Price of the prescription of the drug filled"
    type: average
    sql: ${TABLE}.RX_TX_UC_PRICE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_other_price {
    label: "Avg Prescription Other Price"
    description: "Average price of the other drug (brand/generic) that was not used in the dispensing of this prescription"
    type: average
    sql: (CASE WHEN ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_OTHER_PRICE END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: autofill_decimal_qty {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Prescription Autofill Decimal Qty"
    description: "The autofill prescription refill quantity in decimals"
    type: number
    sql: (CASE WHEN ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_AUTOFILL_DECIMAL_QTY END) ;;
    value_format: "#,##0.00"
  }

  measure: sum_autofill_quantity {
    label: "Total Prescription Autofill Quantity"
    description: "Total autofill prescription refill quantity"
    type: sum
    sql: (CASE WHEN ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_AUTOFILL_QUANTITY END) ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: avg_autofill_quantity {
    label: "Avg Prescription Autofill Quantity"
    description: "Average autofill prescription refill quantity"
    type: average
    sql: (CASE WHEN ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_AUTOFILL_QUANTITY END) ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: sum_compound_fee {
    label: "Total Prescription Compound Fee"
    description: "Total compound preparation charges"
    type: sum
    sql: (CASE WHEN ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_COMPOUND_FEE END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_compound_fee {
    label: "Avg Prescription Compound Fee"
    description: "Average compound preparation charges"
    type: average
    sql: (CASE WHEN ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_COMPOUND_FEE END) ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_owed_quantity {
    label: "Total Prescription Owed Quantity"
    description: "OWED stores the number of units (quantity) of the drug that are owed to the patient"
    type: sum
    sql: (CASE WHEN ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_OWED_QUANTITY END) ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: sum_prescribed_decimal_qty {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Total Prescription Prescribed Decimal Quantity"
    description: "Total Decimal quantity for prescribed prescription quantity"
    type: sum
    sql: (CASE WHEN ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_PRESCRIBED_DECIMAL_QTY END) ;;
    value_format: "#,##0.00"
  }

  measure: avg_prescribed_decimal_qty {
    #       This column has all values null (as of 15th April 2016)
    hidden: yes
    label: "Avg Prescription Prescribed Decimal Quantity"
    description: "Average Decimal quantity for prescribed prescription quantity"
    type: average
    sql: (CASE WHEN ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_PRESCRIBED_DECIMAL_QTY END) ;;
    value_format: "#,##0.00"
  }

  measure: sum_tax {
    label: "Total Prescription Tax"
    description: "Total Sales tax amount of the drug filled"
    type: sum
    sql: ${TABLE}.RX_TX_TAX_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_tax {
    label: "Avg Prescription Tax"
    description: "Average Sales tax amount of the drug filled"
    type: average
    sql: ${TABLE}.RX_TX_TAX_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_discount {
    label: "Total Prescription Discount"
    description: "Total Patient's discount based on drug dispensed(Brand/Generic)"
    type: sum
    sql: ${TABLE}.RX_TX_DISCOUNT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_discount {
    label: "Avg Prescription Discount"
    description: "Average Patient's discount based on drug dispensed(Brand/Generic)"
    type: average
    sql: ${TABLE}.RX_TX_DISCOUNT_AMOUNT ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_fill_quantity {
    label: "Total Prescription Fill Quantity"
    description: "Total Quantity (number of units) of the drug dispensed"
    type: sum
    sql: ${TABLE}.RX_TX_FILL_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: sum_cash_fill_quantity {
    label: "Cash Prescription Fill Quantity"
    description: "Total Quantity for Cash Sales (number of units) of the drug you dispensed"
    type: sum
    sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'N' THEN ${TABLE}.RX_TX_FILL_QUANTITY END) ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: sum_tp_fill_quantity {
    label: "TP Prescription Fill Quantity"
    description: "Total Quantity for Third Party Sales (number of units) of the drug you dispensed"
    type: sum
    sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'Y' THEN ${TABLE}.RX_TX_FILL_QUANTITY END) ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: avg_fill_quantity {
    label: "Avg Prescription Fill Quantity"
    description: "Average Quantity (number of units) of the drug you dispensed"
    type: average
    sql: ${TABLE}.RX_TX_FILL_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  ## As part of ERXLPS-92, Changed from "Total Prescription" to "Total Prescribed" Quantity to better describe the measure
  measure: sum_quantity {
    label: "Total Prescribed Quantity"
    description: "Total prescription transaction prescribed refill quantity"
    type: sum
    sql: ${TABLE}.RX_TX_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: sum_cash_prescribed_quantity {
    label: "Cash Prescribed Quantity"
    description: "Total Cash Prescribed prescription transaction refill quantity"
    type: sum
    sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'N' THEN ${TABLE}.RX_TX_QUANTITY END) ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: sum_tp_prescribed_quantity {
    label: "TP Prescribed Quantity"
    description: "Total Third Party Prescribed prescription transaction refill quantity"
    type: sum
    sql: (CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'Y' THEN ${TABLE}.RX_TX_QUANTITY END) ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: avg_quantity {
    label: "Avg Prescription Quantity"
    description: "Average prescription transaction prescribed refill quantity"
    type: average
    sql: ${TABLE}.RX_TX_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: sum_remaining_quantity {
    label: "Total Prescription Remaining Quantity"
    description: "Total number of remaining units (quantity) of the drug for this prescription"
    type: sum
    sql: ${TABLE}.RX_TX_REMAINING_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: avg_remaining_quantity {
    label: "Avg Prescription Remaining Quantity"
    description: "Average number of remaining units (quantity) of the drug for this prescription"
    type: average
    sql: ${TABLE}.RX_TX_REMAINING_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: sum_cost {
    #       This column is hidden to avoid confusion around prescription cost and prescription acquistion cost and prescription acquisition cost is what is required for now based on drug dispensed (Brand/Generic)
    hidden: yes
    label: "Total Prescription Cost"
    description: "Total dollar amount the cost was for this transaction of the drug filled"
    type: sum
    sql: ${TABLE}.RX_TX_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_cost {
    #       This column is hidden to avoid confusion around prescription cost and prescription acquistion cost and prescription acquisition cost is what is required for now based on drug dispensed (Brand/Generic)
    hidden: yes
    label: "Avg Prescription Cost"
    description: "Average dollar amount the cost was for this transaction of the drug filled"
    type: average
    sql: ${TABLE}.RX_TX_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: sum_rx_tx_pos_overridden_net_paid {
    label: "Total Prescription POS Overridden Net Paid"
    type: sum
    sql: ${TABLE}.RX_TX_POS_OVERRIDDEN_NET_PAID ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_rx_tx_pos_overridden_net_paid {
    label: "Avg Prescription POS Overridden Net Paid"
    type: average
    sql: ${TABLE}.RX_TX_POS_OVERRIDDEN_NET_PAID ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: rx_tx_intended_days_supply {
    label: "Prescription Intended Days Supply"
    description: "The original Days Supply that the customer requested for this transaction. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.RX_TX_INTENDED_DAYS_SUPPLY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: rx_tx_intended_quantity {
    label: "Prescription Intended Quantity"
    description: "The original quantity that the customer requested for this transaction. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.RX_TX_INTENDED_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: sum_rx_tx_manual_acquisition_cost {
    label: "Total Prescription Manual Acquisition Cost"
    description: "Total prescription manual acquisition cost. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.RX_TX_MANUAL_ACQUISITION_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_rx_tx_manual_acquisition_cost {
    label: "Avg Prescription Manual Acquisition Cost"
    description: "Average prescription manual acquisition cost. This field is EPS only!!!"
    type: average
    sql: ${TABLE}.RX_TX_MANUAL_ACQUISITION_COST ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: rx_tx_original_quantity {
    label: "Prescription Original Quantity"
    description: "Original quantity on the transaction before credit return. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.RX_TX_ORIGINAL_QUANTITY ;;
    value_format: "#,##0.00;(#,##0.00)"
  }

  measure: sum_rx_tx_professional_fee {
    label: "Total Prescription Professional Fee"
    description: "Total of any additional fees included in the price of this transaction, outside of the normal pricing calculation. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.RX_TX_PROFESSIONAL_FEE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: avg_rx_tx_professional_fee {
    label: "Average Prescription Professional Fee"
    description: "Average of any additional fees included in the price of this transaction, outside of the normal pricing calculation. This field is EPS only!!!"
    type: average
    sql: ${TABLE}.RX_TX_PROFESSIONAL_FEE ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  measure: rx_tx_requested_price_to_quantity {
    label: "Prescription Requested Price To Quality"
    description: "The requested dollar amount of the prescription that the patient would like to purchase. This field is EPS only!!!"
    type: sum
    sql: ${TABLE}.RX_TX_REQUESTED_PRICE_TO_QUANTITY ;;
    value_format: "$#,##0.00;($#,##0.00)"
  }

  ################################################################Start ERXLPS-385 New Measures for BI ALB #####################################################################################
  measure: sum_cash_margin {
    label: "Cash Margin $"
    description: "Cash Margin of prescription. Calculation Used: Cash Price of the Prescription - Acquisition Cost"
    type: sum
    hidden: yes
    sql: COALESCE(CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'N' AND ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_PRICE - ${TABLE}.RX_TX_ACQUISITION_COST END,0) ;;
    value_format: "$#,##0.00;($#,##0.00)"
    html: {% if value < 0 %}
        <font color="red">{{ rendered_value }}
      {% else %}
        <font color="grey">{{ rendered_value }}
      {% endif %}
      ;;
  }

  measure: sum_cash_margin_pct {
    label: "Cash Margin %"
    description: "Cash Margin % of prescription. Calculation Used: (Cash Price of the Prescription - Acquisition Cost)/Cash Price of the Prescription"
    type: number
    sql: ${sum_cash_margin}/NULLIF(${sum_price_cash},0) ;;
    value_format: "00.00%"
    html: {% if value < 0 %}
        <font color="red">{{ rendered_value }}
      {% else %}
        <font color="grey">{{ rendered_value }}
      {% endif %}
      ;;
  }

  measure: sum_tp_margin {
    label: "T/P Margin $"
    description: "Third Party Margin of prescription. Calculation Used: Third Party Price of the Prescription - Acquisition Cost"
    type: sum
    hidden: yes
    sql: COALESCE(CASE WHEN NVL(${TABLE}.RX_TX_TP_BILL,'N') = 'Y' AND ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_PRICE - ${TABLE}.RX_TX_ACQUISITION_COST END,0) ;;
    value_format: "$#,##0.00;($#,##0.00)"
    html: {% if value < 0 %}
        <font color="red">{{ rendered_value }}
      {% else %}
        <font color="grey">{{ rendered_value }}
      {% endif %}
      ;;
  }

  measure: sum_tp_margin_pct {
    label: "T/P Margin %"
    description: "Third Party Margin % of prescription. Calculation Used: (Third Party Price of the Prescription - Acquisition Cost)/Third Party Price of the Prescription"
    type: number
    sql: ${sum_tp_margin}/NULLIF(${sum_price_tp},0) ;;
    value_format: "00.00%"
    html: {% if value < 0 %}
        <font color="red">{{ rendered_value }}
      {% else %}
        <font color="grey">{{ rendered_value }}
      {% endif %}
      ;;
  }

  #[ERXLPS-2045] replaced drug.drug_multi_source with drug_multi_source_reference dimension.
  measure: sum_generic_margin {
    label: "Generic Margin $"
    description: "Generic Margin of prescription. Calculation Used: Generic Price of the Prescription - Acquisition Cost"
    type: sum
    hidden: yes
    sql: COALESCE(CASE WHEN ${drug_multi_source_reference} = 'Y' AND ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_PRICE - ${TABLE}.RX_TX_ACQUISITION_COST END,0) ;;
    value_format: "$#,##0.00;($#,##0.00)"
    html: {% if value < 0 %}
        <font color="red">{{ rendered_value }}
      {% else %}
        <font color="grey">{{ rendered_value }}
      {% endif %}
      ;;
  }

  measure: sum_generic_margin_pct {
    label: "Generic Margin %"
    description: "Generic Margin % of prescription. Calculation Used: (Generic Price of the Prescription - Acquisition Cost)/Generic Price of the Prescription"
    type: number
    sql: ${sum_generic_margin}/NULLIF(${sum_price_generic},0) ;;
    value_format: "00.00%"
    html: {% if value < 0 %}
        <font color="red">{{ rendered_value }}
      {% else %}
        <font color="grey">{{ rendered_value }}
      {% endif %}
      ;;
  }

  #[ERXLPS-2045] replaced drug.drug_multi_source with drug_multi_source_reference dimension.
  measure: sum_brand_margin {
    label: "Brand Margin $"
    description: "Brand Margin of prescription. Calculation Used: Brand Price of the Prescription - Acquisition Cost"
    type: sum
    hidden: yes
    sql: COALESCE(CASE WHEN ${drug_multi_source_reference} <> 'Y' AND ${rpt_cal_type} = 'TY' THEN ${TABLE}.RX_TX_PRICE - ${TABLE}.RX_TX_ACQUISITION_COST END,0) ;;
    value_format: "$#,##0.00;($#,##0.00)"
    html: {% if value < 0 %}
        <font color="red">{{ rendered_value }}
      {% else %}
        <font color="grey">{{ rendered_value }}
      {% endif %}
      ;;
  }

  measure: sum_brnad_margin_pct {
    label: "Brand Margin %"
    description: "Brand Margin % of prescription. Calculation Used: (Brand Price of the Prescription - Acquisition Cost)/Brand Price of the Prescription"
    type: number
    sql: ${sum_brand_margin}/NULLIF(${sum_price_brand},0) ;;
    value_format: "00.00%"
    html: {% if value < 0 %}
        <font color="red">{{ rendered_value }}
      {% else %}
        <font color="grey">{{ rendered_value }}
      {% endif %}
      ;;
  }

  ################################################################End ERXLPS-385 New Measures for BI ALB #####################################################################################

  ############################################################ Templated Filters (Applied only for measures (so it could be applied in WHERE instead of HAVING clause #################################
  filter: cost_filter {
    #       This column is hidden to avoid confusion around prescription cost and prescription acquistion cost and prescription acquisition cost is what is required for now based on drug dispensed (Brand/Generic)
    hidden: yes
    label: "Prescription Cost"
    description: "Dollar amount the cost was for this transaction of the drug filled"
    type: number
  }

  filter: acquisition_cost_filter {
    label: "Prescription Acquisition Cost"
    description: "Acquisition cost of filled drug used on the prescription transaction record"
    type: number
  }

  filter: autofill_quantity_filter {
    label: "Prescription Autofill Quantity"
    description: "Autofill prescription refill quantity"
    type: number
  }

  filter: other_price_filter {
    label: "Prescription Other Price"
    description: "Price of the other drug (brand/generic) that was not used in the dispensing of this prescription"
    type: number
  }

  filter: price_filter {
    label: "Prescription Price"
    description: "Price of prescription"
    type: number
  }

  filter: fill_quantity_filter {
    label: "Prescription Fill Quantity"
    description: "Quantity (number of units) of the drug dispensed"
    type: number
  }

  filter: quantity_filter {
    label: "Prescription Quantity"
    description: "Prescription transaction prescribed refill quantity"
    type: number
  }

  filter: gross_margin_filter {
    label: "Prescription Gross Margin Dollars"
    description: "Margin Dollars of the Filled Prescription. Formula Used: ( (Total Price of prescription - Total Acquisition Cost of prescription))"
    type: number
  }

  filter: sold_date_filter {
    label: "Prescription Sold Date \"Filter Only\""
    description: "Date/Time prescription was sold"
    type: date
    required_access_grants: [can_view_rx_tx_ty_ly_filter] #[ERXDWPS-8395]
  }

  filter: reportable_sales_date_filter {
    label: "Prescription Reportable Sales Date \"Filter Only\""
    description: "Used to record the date when a TP script was adjudicated. For cash scripts, it is set when DE is completed"
    type: date
    required_access_grants: [can_view_rx_tx_ty_ly_filter] #[ERXDWPS-8395]
  }

  filter: filled_date_filter {
    label: "Prescription Filled Date \"Filter Only\""
    description: "Date prescription was filled"
    type: date
    required_access_grants: [can_view_rx_tx_ty_ly_filter] #[ERXDWPS-8395]
  }

  filter: this_year_last_year_filter {
    label: "Prescription TY/LY Analysis (Yes/No)"
    description: "Flag that indicates if LY vs. TY Analysis is required on selected measures. Use 'Yes-Filled' if LY Analysis is required based on filled date, 'Yes-Sold' if LY Analysis is required on sold date and 'Yes-ReportableSales', if LY Analysis is required on Reportable Sales Date. By Default a value of 'No' would be selected"
    type: string
    required_access_grants: [can_view_rx_tx_ty_ly_filter] #[ERXDWPS-8395]
    suggestions: ["No", "Yes-Sold", "Yes-Filled", "Yes-ReportableSales"]
  }

  ####################################################################################################### End of Measures ####################################################################################################

  ########################################################################################################## End of 4.8.000 New columns #############################################################################################

  ###############################################################################################################################################################################################

  set: detail {
    fields: [

      #added by KR on 7-25-16
      chain.chain_name,

      #added by KR on 7-25-16
      store_alignment.division,

      #added by KR on 7-25-16
      store_alignment.region,

      #added by KR on 7-25-16
      store_alignment.district,

      #Changes made w.r.t ERXLPS-126
      store.store_number,
      store.store_name,
      drug.drug_name,

      #added by KR on 7-25-16
      filled,
      filled_date,
      rx_number,
      tx_number,

      #added by JCF on 7-21-16
      ndc,

      #added by JCF on 7-21-16
      ncpdp_daw,

      #added by KR on 08-02-16
      paid_at_uc,

      #added by KR on 08-02-16
      sum_uc_price,

      #added by JCF on 7-21-16
      sum_price,

      #added by JCF on 7-21-16
      sum_acquisition_cost,

      #added by JCF on 7-21-16
      sum_margin_dollars
    ]
  }

  #Grouping Will Call Picked Up Date Into sets, hence whenever all the fiels/parameters in this dimension group needs to be used, the set can be used.
  set: will_call_picked_up_date_info {
    fields: [
      will_call_picked_up_time,
      will_call_picked_up_date,
      will_call_picked_up_week,
      will_call_picked_up_month,
      will_call_picked_up_month_num,
      will_call_picked_up_year,
      will_call_picked_up_quarter,
      will_call_picked_up_quarter_of_year,
      will_call_picked_up_hour_of_day,
      will_call_picked_up_time_of_day,
      will_call_picked_up_hour2,
      will_call_picked_up_minute15,
      will_call_picked_up_day_of_week,
      will_call_picked_up_week_of_year,
      will_call_picked_up_day_of_week_index,
      will_call_picked_up_day_of_month
    ]
  }

  set: rx_tx_claim_info {
    fields: [
      refill_number,
      tx_number,
      call_for_refills,
      compound,
      filled_date,
      filled_week,
      filled_month,
      filled_month_num,
      filled_year,
      filled_quarter,
      filled_quarter_of_year,
      filled,
      filled_day_of_week,
      filled_day_of_month,
      first_filled_date,
      first_filled_week,
      first_filled_month,
      first_filled_month_num,
      first_filled_year,
      first_filled_quarter,
      first_filled_quarter_of_year,
      first_filled,
      first_filled_day_of_week,
      first_filled_day_of_month,
      has_compound_ingredients,
      immunization_indicator_description,
      original_written_date,
      original_written_week,
      original_written_month,
      original_written_month_num,
      original_written_year,
      original_written_quarter,
      original_written_quarter_of_year,
      original_written,
      original_written_day_of_week,
      original_written_day_of_month,
      partial_fill_status,
      rx_start_date,
      rx_start_week,
      rx_start_month,
      rx_start_month_num,
      rx_start_year,
      rx_start_quarter,
      rx_start_quarter_of_year,
      rx_start,
      rx_start_day_of_week,
      rx_start_day_of_month,
      rx_status,
      sold_date,
      sold_week,
      sold_month,
      sold_month_num,
      sold_year,
      sold_quarter,
      sold_quarter_of_year,
      sold,
      sold_day_of_week,
      sold_day_of_month,
      transfer,
      tx_status,
      usual_and_customary_pricing_flag,
      written_date,
      written_week,
      written_month,
      written_month_num,
      written_year,
      written_quarter,
      written_quarter_of_year,
      written,
      written_day_of_week,
      written_day_of_month,
      count,
      sum_cost,
      sum_acquisition_cost,
      sum_autofill_quantity,
      sum_compound_fee,
      avg_compound_fee,
      sum_other_price,
      sum_prescribed_decimal_qty,
      sum_margin,
      sum_margin_dollars,
      sum_price,
      sum_fill_quantity,
      sum_quantity,
      sum_remaining_quantity,
      cost_filter,
      acquisition_cost_filter,
      autofill_quantity_filter,
      fill_quantity_filter,
      quantity_filter,
      price_filter,
      gross_margin_filter,
      sold_date_filter,
      reportable_sales_date_filter,
      filled_date_filter,
      this_year_last_year_filter
    ]
  }

  set: explore_rx_4_6_000_sf_deployment_candidate_list {
    fields: [
      eps_rx_summary_id,
      rx_enable_autofill,
      rx_escript_message_id,
      rx_hard_copy_printed,
      rx_last_refill_reminder_date_date,
      rx_last_refill_reminder_date_day_of_month,
      rx_last_refill_reminder_date_day_of_week,
      rx_last_refill_reminder_date_day_of_week_index,
      rx_last_refill_reminder_date_hour_of_day,
      rx_last_refill_reminder_date_hour2,
      rx_last_refill_reminder_date_minute15,
      rx_last_refill_reminder_date_month,
      rx_last_refill_reminder_date_month_num,
      rx_last_refill_reminder_date_quarter,
      rx_last_refill_reminder_date_quarter_of_year,
      rx_last_refill_reminder_date_time,
      rx_last_refill_reminder_date_time_of_day,
      rx_last_refill_reminder_date_week,
      rx_last_refill_reminder_date_week_of_year,
      rx_last_refill_reminder_date_year,
      rx_last_refill_reminder_date,
      rx_prescribed_drug_ddid,
      rx_prescribed_drug_id,
      rx_prescriber_edi_id,
      rx_reportable_drug_number,
      rx_image_total,
      rx_short_fill_sent_date,
      rx_short_fill_sent_day_of_month,
      rx_short_fill_sent_day_of_week,
      rx_short_fill_sent_day_of_week_index,
      rx_short_fill_sent_hour_of_day,
      rx_short_fill_sent_hour2,
      rx_short_fill_sent_minute15,
      rx_short_fill_sent_month,
      rx_short_fill_sent_month_num,
      rx_short_fill_sent_quarter,
      rx_short_fill_sent_quarter_of_year,
      rx_short_fill_sent_time,
      rx_short_fill_sent_time_of_day,
      rx_short_fill_sent_week,
      rx_short_fill_sent_week_of_year,
      rx_short_fill_sent_year,
      rx_short_fill_sent,
      rx_tx_admin_rebilled,
      rx_tx_allow_price_override,
      rx_tx_brand_manually_selected,
      rx_tx_competitive_priced,
      rx_tx_controlled_substance_escript,
      rx_tx_counseling_rph_employee_number,
      rx_tx_custom_reported_date_date,
      rx_tx_custom_reported_date_day_of_month,
      rx_tx_custom_reported_date_day_of_week,
      rx_tx_custom_reported_date_day_of_week_index,
      rx_tx_custom_reported_date_hour_of_day,
      rx_tx_custom_reported_date_hour2,
      rx_tx_custom_reported_date_minute15,
      rx_tx_custom_reported_date_month,
      rx_tx_custom_reported_date_month_num,
      rx_tx_custom_reported_date_quarter,
      rx_tx_custom_reported_date_quarter_of_year,
      rx_tx_custom_reported_date_time,
      rx_tx_custom_reported_date_time_of_day,
      rx_tx_custom_reported_date_week,
      rx_tx_custom_reported_date_week_of_year,
      rx_tx_custom_reported_date_year,
      rx_tx_custom_reported_date,
      rx_tx_custom_sig,
      rx_tx_ddid_used_by_drug_selection,
      rx_tx_de_initials,
      rx_tx_different_generic,
      rx_tx_dob_override_employee_number,
      rx_tx_dob_override_reason_id,
      rx_tx_dob_override_time_date,
      rx_tx_dob_override_time_day_of_month,
      rx_tx_dob_override_time_day_of_week,
      rx_tx_dob_override_time_day_of_week_index,
      rx_tx_dob_override_time_hour_of_day,
      rx_tx_dob_override_time_hour2,
      rx_tx_dob_override_time_minute15,
      rx_tx_dob_override_time_month,
      rx_tx_dob_override_time_month_num,
      rx_tx_dob_override_time_quarter,
      rx_tx_dob_override_time_quarter_of_year,
      rx_tx_dob_override_time_time,
      rx_tx_dob_override_time_time_of_day,
      rx_tx_dob_override_time_week,
      rx_tx_dob_override_time_week_of_year,
      rx_tx_dob_override_time_year,
      rx_tx_dob_override_time,
      rx_tx_dv_initials,
      rx_tx_epr_synch_version,
      rx_tx_fill_location,
      rx_tx_generic_manually_selected,
      rx_tx_gpi_used_by_drug_selection,
      rx_tx_intended_days_supply,
      rx_tx_intended_quantity,
      rx_tx_keep_same_drug,
      rx_tx_last_epr_synch_date,
      rx_tx_last_epr_synch_day_of_month,
      rx_tx_last_epr_synch_day_of_week,
      rx_tx_last_epr_synch_day_of_week_index,
      rx_tx_last_epr_synch_hour_of_day,
      rx_tx_last_epr_synch_hour2,
      rx_tx_last_epr_synch_minute15,
      rx_tx_last_epr_synch_month,
      rx_tx_last_epr_synch_month_num,
      rx_tx_last_epr_synch_quarter,
      rx_tx_last_epr_synch_quarter_of_year,
      rx_tx_last_epr_synch_time,
      rx_tx_last_epr_synch_time_of_day,
      rx_tx_last_epr_synch_week,
      rx_tx_last_epr_synch_week_of_year,
      rx_tx_last_epr_synch_year,
      rx_tx_last_epr_synch,
      rx_tx_manual_acquisition_drug_dispensed,
      rx_tx_medicare_notice,
      rx_tx_missing_date_date,
      rx_tx_missing_date_day_of_month,
      rx_tx_missing_date_day_of_week,
      rx_tx_missing_date_day_of_week_index,
      rx_tx_missing_date_hour_of_day,
      rx_tx_missing_date_hour2,
      rx_tx_missing_date_minute15,
      rx_tx_missing_date_month,
      rx_tx_missing_date_month_num,
      rx_tx_missing_date_quarter,
      rx_tx_missing_date_quarter_of_year,
      rx_tx_missing_date_time,
      rx_tx_missing_date_time_of_day,
      rx_tx_missing_date_week,
      rx_tx_missing_date_week_of_year,
      rx_tx_missing_date_year,
      rx_tx_missing_date,
      rx_tx_mobile_services_channel,
      rx_tx_new_ddid_authorized_by_emp_number,
      rx_tx_no_sales_tax,
      rx_tx_original_quantity,
      rx_tx_otc_taxable_indicator,
      rx_tx_patient_request_brand_generic,
      rx_tx_patient_requested_price,
      rx_tx_pc_ready_date_date,
      rx_tx_pc_ready_date_day_of_month,
      rx_tx_pc_ready_date_day_of_week,
      rx_tx_pc_ready_date_day_of_week_index,
      rx_tx_pc_ready_date_hour_of_day,
      rx_tx_pc_ready_date_hour2,
      rx_tx_pc_ready_date_minute15,
      rx_tx_pc_ready_date_month,
      rx_tx_pc_ready_date_month_num,
      rx_tx_pc_ready_date_quarter,
      rx_tx_pc_ready_date_quarter_of_year,
      rx_tx_pc_ready_date_time,
      rx_tx_pc_ready_date_time_of_day,
      rx_tx_pc_ready_date_week,
      rx_tx_pc_ready_date_week_of_year,
      rx_tx_pc_ready_date_year,
      rx_tx_pc_ready_date,
      rx_tx_pickup_signature_not_required,
      rx_tx_pos_invoice_number,
      rx_tx_pos_reason_for_void,

      #ERXLPS-124 As per discussion with PO, this field would be continued to be excluded until re-initial load is done, which is expected to happen at the release of 4.8.000. This is done to avoid confusion to business users as not all transactions would have a override reason.
      rx_tx_price_override_reason,
      rx_tx_pv_employee_number,
      rx_tx_refill_source,
      rx_tx_register_number,
      rx_tx_relationship_to_patient,
      rx_tx_replace_date_date,
      rx_tx_replace_date_day_of_month,
      rx_tx_replace_date_day_of_week,
      rx_tx_replace_date_day_of_week_index,
      rx_tx_replace_date_hour_of_day,
      rx_tx_replace_date_hour2,
      rx_tx_replace_date_minute15,
      rx_tx_replace_date_month,
      rx_tx_replace_date_month_num,
      rx_tx_replace_date_quarter,
      rx_tx_replace_date_quarter_of_year,
      rx_tx_replace_date_time,
      rx_tx_replace_date_time_of_day,
      rx_tx_replace_date_week,
      rx_tx_replace_date_week_of_year,
      rx_tx_replace_date_year,
      rx_tx_replace_date,
      rx_tx_requested_price_to_quantity,
      rx_tx_require_relation_to_patient,
      rx_tx_return_to_stock_date_date,
      rx_tx_return_to_stock_date_day_of_month,
      rx_tx_return_to_stock_date_day_of_week,
      rx_tx_return_to_stock_date_day_of_week_index,
      rx_tx_return_to_stock_date_hour_of_day,
      rx_tx_return_to_stock_date_hour2,
      rx_tx_return_to_stock_date_minute15,
      rx_tx_return_to_stock_date_month,
      rx_tx_return_to_stock_date_month_num,
      rx_tx_return_to_stock_date_quarter,
      rx_tx_return_to_stock_date_quarter_of_year,
      rx_tx_return_to_stock_date_time,
      rx_tx_return_to_stock_date_time_of_day,
      rx_tx_return_to_stock_date_week,
      rx_tx_return_to_stock_date_week_of_year,
      rx_tx_return_to_stock_date_year,
      rx_tx_return_to_stock_date,
      rx_tx_rx_com_down,
      rx_tx_rx_stolen,
      rx_tx_sent_to_ehr,
      rx_tx_specialty_pa_status,
      rx_tx_state_report_status,
      rx_tx_tx_user_modified,
      rx_tx_using_compound_plan_pricing,
      rx_tx_using_percent_of_brand,
      sum_rx_tx_manual_acquisition_cost,
      avg_rx_tx_manual_acquisition_cost,
      sum_rx_tx_professional_fee,
      avg_rx_tx_professional_fee
    ]
  }

  #[ERXDWPS-8395] - Set added to exlucde ty ly related filters/dimension/measurres from MDS and Third party Claim explores.
  #Adding this_year_last_year_filter filter to set causing validtion errors as filter referenced in many dimensions of rx_tx view.
  #Ended up creating access grants to exclude this_year_last_year filter from MDS and Third Party Claim explores.
  set: exploredx_ty_ly_specific_entities_list{
    fields: [
      count_last_year,
      count_last_year_adjusted,
      count_new_last_year,
      count_refill_last_year,
      count_generic_last_year,
      count_brand_last_year,
      count_cash_last_year,
      count_tp_last_year,
      sum_price_last_year,
      sum_price_generic_last_year,
      sum_price_brand_last_year,
      sum_price_cash_last_year,
      sum_price_tp_last_year,
      sum_acquisition_cost_last_year,
      sum_margin_last_year,
      sum_margin_dollars_last_year,
      count_variance,
      count_variance_adjusted,
      count_new_variance,
      count_refill_variance,
      count_generic_variance,
      count_brand_variance,
      count_cash_variance,
      count_tp_variance,
      sum_price_variance,
      sum_price_generic_variance,
      sum_price_brand_variance,
      sum_price_cash_variance,
      sum_price_tp_variance,
      sum_acquisition_cost_variance,
      sum_margin_variance,
      sum_margin_dollars_variance
    ]
  }
}
