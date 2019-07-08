view: store_to_store_alignment_secured_view {
# ERXDWPS-6276 - Changes to move store to store alignment secured view for performance improvement and fix master code issue
# Store view join logic for customer model - sales and workflow explore.
# This is required for View user only access at Division/Region/District/Pharmacy level.
# Chain access filter is added for evey table join used below. Please check with architect in case if you are planning to remove.
    derived_table: {
      sql: SELECT CHAIN_ID,NHIN_STORE_ID,CAST('STORE-ALIGNMENT' AS VARCHAR) AS ENTITY_TYPE
            FROM edw.d_store_alignment
            WHERE {% condition chain.chain_id %} CHAIN_ID {% endcondition %}
            AND {% condition store_alignment.division_access_filter %} NVL(pharmacy_division,'') {% endcondition %}
            AND {% condition store_alignment.region_access_filter %} NVL(pharmacy_region,'') {% endcondition %}
            AND {% condition store_alignment.district_access_filter %} NVL(pharmacy_district,'') {% endcondition %}
            AND {% condition store_alignment.pharmacy_number_access_filter %} NVL(store_pharmacy_number,'') {% endcondition %}
            UNION
            SELECT CHAIN_ID,NHIN_STORE_ID,CAST('STORE-ALIGNMENT' AS VARCHAR) AS ENTITY_TYPE
            FROM EDW.D_STORE
            WHERE {% condition chain.chain_id %} CHAIN_ID {% endcondition %}
            AND source_system_id = 5
            AND (--logic to include all stores of a chain for PDX User
              --[ERXLPS-1050] - Email address logic changed to user attribute.
              '{{_user_attributes['internal_or_external_user_group']}}' = 'internal'
              --logic tp exclude chains which are present in store_alignment table
              OR CHAIN_ID NOT IN (SELECT CHAIN_ID FROM edw.d_store_alignment WHERE {% condition chain.chain_id %} CHAIN_ID {% endcondition %})
              ) ;;
    }


    #################################################################################################### Primary Key References #####################################################################################################

    dimension: unique_key {
      hidden: yes
      primary_key: yes
      sql: ${chain_id} ||'@'|| ${nhin_store_id}  ;;
    }

    #################################################################################################### Foreign Key References #####################################################################################################

    dimension: chain_id {
      hidden: yes
      type: number
      label: "Chain ID"
      sql: ${TABLE}.CHAIN_ID ;;
    }

    dimension: nhin_store_id {
      hidden: yes
      type: number
      label: "NHIN Store ID"
      sql: ${TABLE}.NHIN_STORE_ID ;;
    }

    dimension: entity_type {
      hidden: yes
      type: string
      label: "Entity Type"
      sql: ${TABLE}.ENTITY_TYPE ;;
  }
}
