view: store_vendor {
  #[ERXLPS-1878]
  sql_table_name: EDW.D_STORE_VENDOR ;;

  dimension: primary_key {
    hidden: yes
    type: number
    description: "Unique Identification number"
    primary_key: yes
    sql: ${chain_id} ||'@'|| ${nhin_store_id} ||'@'|| ${vendor_id} ;;
  }

  ################################################ FK References ##############################################
  dimension: chain_id {
    hidden: yes
    type: number
    description: "NHIN assigned customer chain ID number to uniquely identify the chain owning this record"
    sql: ${TABLE}.CHAIN_ID ;;
  }

  dimension: nhin_store_id {
    hidden: yes
    type: number
    description: "Unique ID number assigned by NHIN for the store associated to this record"
    sql: ${TABLE}.NHIN_STORE_ID ;;
  }

  dimension: vendor_id {
    hidden: yes
    type: number
    description: "Unique ID number identifying a pharmacy record"
    sql: ${TABLE}.VENDOR_ID ;;
  }

  dimension: source_system_id {
    hidden: yes
    type: number
    description: "Unique ID number identifying an BI source sytem (0 - HOST, 1 - ECC, 2 - SEC_ADMIN,   3 - EPR, 4 - EPS, 5 - ARS, 6 - NHIN)"
    sql: ${TABLE}.SOURCE_SYSTEM_ID ;;
  }

  dimension: store_vendor_price_code_id {
    hidden: yes
    type: number
    description: "Price code associated with this record"
    sql: ${TABLE}.STORE_VENDOR_PRICE_CODE_ID ;;
  }

  dimension: store_vendor_phone_id {
    hidden: yes
    type: number
    sql: ${TABLE}.STORE_VENDOR_PHONE_ID ;;
  }

  dimension: store_vendor_address_id {
    hidden: yes
    type: number
    sql: ${TABLE}.STORE_VENDOR_ADDRESS_ID ;;
  }

  ############################################ Dimensions #####################################################

  dimension: store_vendor_speed_code {
    type: string
    label: "Vendor Speed Code"
    description: "Code to represent vendor"
    sql: ${TABLE}.STORE_VENDOR_SPEED_CODE ;;
  }

  dimension: Store_vendor_name {
    type: string
    label: "Vendor Name"
    description: "Vendor name"
    sql: ${TABLE}.STORE_VENDOR_NAME ;;
  }

  #Dimension for demo model
  dimension: Store_vendor_name_deidentified {
    type: string
    label: "Vendor Name"
    description: "Vendor name"
    sql: SHA2(${TABLE}.STORE_VENDOR_NAME) ;;
  }

  dimension: store_vendor_contact {
    label: "Vendor Contact"
    type: string
    description: "Name of the person to contact for ordering information, such as the sales representative for this vendor"
    sql: ${TABLE}.STORE_VENDOR_CONTACT ;;
  }

  dimension: Store_vendor_manufacturer {
    type: string
    label: "Vendor Manufacturer"
    description: "Vendor identification"
    sql: ${TABLE}.STORE_VENDOR_MANUFACTURER ;;
  }

  dimension: Store_vendor_site_code {
    type: string
    label: "Vendor Site Code"
    description: "Site code the system uses for transmitting a drug order to this vendor"
    sql: ${TABLE}.STORE_VENDOR_SITE_CODE ;;
  }

  dimension: Store_vendor_asap_edi_version {
    type: number
    label: "Vendor ASAP EDI Version"
    description: "Version of ASAP EDI the system uses for electronic drug order to create an order for this vendor"
    sql: ${TABLE}.STORE_VENDOR_ASAP_EDI_VERSION ;;
  }

  dimension: Store_vendor_product_number {
    type: string
    label: "Vendor Product Number"
    description: "Product ID qualifier the system uses when placing an electronic drug order that tells the vendor what the item number from the reorder parameters record represents"
    sql: ${TABLE}.STORE_VENDOR_PRODUCT_NUMBER ;;
  }

  dimension: Store_vendor_group_code {
    type: string
    label: "Vendor Group Code"
    description: "Code indicating group into which a vendor record can be categorized"
    sql: ${TABLE}.STORE_VENDOR_GROUP_CODE ;;
  }

  dimension: Store_vendor_include_in_drug_list {
    type: yesno
    label: "Vendor Include in Drug List"
    description: "Yes/No Flag used by all drug lists to include any products from that vendor from displaying on the drug searches and drug lists"
    sql: ${TABLE}.STORE_VENDOR_INCLUDE_IN_DRUG_LIST = 'Y' ;;
  }

  dimension: Store_vendor_use_in_inventory_management {
    type: yesno
    label: "Vendor Use in Inventory Management"
    description: "Yes/No Flag used by Inventory Management to determine if this Vendor should be used by Inventory Management"
    sql: ${TABLE}.STORE_VENDOR_USE_IN_INVENTORY_MANAGEMENT = 'Y' ;;
  }

  dimension: Store_vendor_nhin_vendor_code {
    type: string
    hidden: yes #ODX to EPS conversion column. Vendor ID is used in EPS. vendor_code is used in PDX.
    label: "Vendor NHIN Vendor Code"
    description: "Standard NHIN vendor code for the VMI (Vendor Managed Inventory) vendor"
    sql: ${TABLE}.STORE_VENDOR_NHIN_VENDOR_CODE ;;
  }

  dimension: Store_vendor_nhin_vendor_level {
    type: string
    label: "Vendor Level"
    description: "Vendor level"
    sql: CASE WHEN ${TABLE}.STORE_VENDOR_NHIN_VENDOR_LEVEL IS NULL THEN 'NOT SPECIFIED'
              WHEN ${TABLE}.STORE_VENDOR_NHIN_VENDOR_LEVEL = 0 THEN 'BLANK'
              WHEN ${TABLE}.STORE_VENDOR_NHIN_VENDOR_LEVEL = 1 THEN 'PRIMARY'
              WHEN ${TABLE}.STORE_VENDOR_NHIN_VENDOR_LEVEL = 2 THEN 'SECONDARY'
              WHEN ${TABLE}.STORE_VENDOR_NHIN_VENDOR_LEVEL = 3 THEN 'TERTIARY'
              WHEN ${TABLE}.STORE_VENDOR_NHIN_VENDOR_LEVEL = 4 THEN 'QUATERNARY'
              WHEN ${TABLE}.STORE_VENDOR_NHIN_VENDOR_LEVEL = 5 THEN 'QUINARY'
              WHEN ${TABLE}.STORE_VENDOR_NHIN_VENDOR_LEVEL = 6 THEN 'SENARY'
              WHEN ${TABLE}.STORE_VENDOR_NHIN_VENDOR_LEVEL = 7 THEN 'SEPTENARY'
              WHEN ${TABLE}.STORE_VENDOR_NHIN_VENDOR_LEVEL = 8 THEN 'OCTONARY'
              WHEN ${TABLE}.STORE_VENDOR_NHIN_VENDOR_LEVEL = 9 THEN 'NONARY'
         END ;;
  }
}
