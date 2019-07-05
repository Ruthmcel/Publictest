view: ar_nhin_type {
  derived_table: {
    sql: select c.nhin_category_id,
       c.nhin_category_description,
       c.nhin_category_last_update_user_identifier,
       c.nhin_category_deleted,
       t.nhin_type_id,
       t.nhin_type_description,
       t.nhin_type_abbreviation,
       t.nhin_type_notes,
       t.nhin_type_last_update_user_identifier,
       t.nhin_type_deleted
  from edw.d_nhin_category c,
       edw.d_nhin_type t
 where c.nhin_category_id(+) = t.nhin_category_id
   and c.NHIN_CATEGORY_DELETED(+) = 'N'
   and t.NHIN_TYPE_DELETED = 'N'
   and c.source_system_id(+) = t.source_system_id
   and t.source_system_id = 8
 ;;
  }

  ################################################################################################## Dimensions ################################################################################################

  dimension: unique_key {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${nhin_type_id} ;;
  }

  dimension: nhin_category_id {
    hidden: yes
    label: "NHIN Category ID"
    description: "Unique ID of the NHIN Category Record that resides in the AR system"
    type: number
    sql: ${TABLE}.NHIN_CATEGORY_ID ;;
  }

  dimension: nhin_category_description {
    label: "Category Description"
    description: "NHIN Category Description"
    type: string
    sql: ${TABLE}.NHIN_CATEGORY_DESCRIPTION ;;
  }

  dimension: nhin_category_last_update_user_identifier {
    label: "Category Last Update User Identifier"
    description: "ID of the user who last updated this NHIN Category Record"
    type: number
    sql: ${TABLE}.NHIN_CATEGORY_LAST_UPDATE_USER_IDENTIFIER ;;
    value_format: "####"
  }

  dimension: nhin_category_deleted {
    hidden: yes
    label: "NHIN Category deleted"
    type: string
    sql: ${TABLE}.NHIN_CATEGORY_DELETED ;;
  }

  dimension: nhin_type_id {
    hidden: yes
    label: "NHIN TYPE ID"
    description: "Unique ID of the NHIN Category Record that resides in the AR system"
    type: number
    sql: ${TABLE}.NHIN_TYPE_ID ;;
  }

  dimension: nhin_type_description {
    label: "Type Description"
    description: "NHIN Type Description"
    type: string
    sql: ${TABLE}.NHIN_TYPE_DESCRIPTION ;;
  }

  dimension: nhin_type_abbreviation {
    label: "Type Abbreviation"
    description: "NHIN Type Abbreviation"
    type: string
    sql: ${TABLE}.NHIN_TYPE_ABBREVIATION ;;
  }

  dimension: nhin_type_notes {
    label: "Type Notes"
    description: "NHIN Type Notes"
    type: string
    sql: ${TABLE}.NHIN_TYPE_NOTES ;;
  }

  dimension: nhin_type_last_update_user_identifier {
    label: "Type Last Update User Identifier"
    description: "ID of the user who last updated this NHIN Type Record"
    type: number
    sql: ${TABLE}.NHIN_TYPE_LAST_UPDATE_USER_IDENTIFIER ;;
    value_format: "####"
  }

  dimension: nhin_type_deleted {
    label: "NHIN type deleted"
    hidden: yes
    type: string
    sql: ${TABLE}.NHIN_TYPE_DELETED ;;
  }
}

################################################################################################## End of Dimensions #########################################################################################
