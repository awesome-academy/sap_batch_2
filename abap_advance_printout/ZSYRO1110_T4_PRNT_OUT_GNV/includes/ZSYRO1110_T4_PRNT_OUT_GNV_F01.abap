*&---------------------------------------------------------------------*
*& Include          ZSYRO1110_T16_GNV_F01
*&---------------------------------------------------------------------*

FORM validate_carrid USING VALUE(p_carrid) TYPE zysflight1t-carrid.

  " Check if the Airline Code exists in the Airline table
  SELECT SINGLE carrid
    INTO @DATA(lv_carrid)
    FROM zysflight1t
    WHERE carrid = @p_carrid.

  IF sy-subrc <> 0. " Airline code not found
    MESSAGE TEXT-e01 TYPE 'E'. " Airline Code is not exists. Please input again.
    LEAVE TO SCREEN 0.
  ENDIF.
ENDFORM.


FORM get_sflight_data CHANGING ct_sflight TYPE gtt_sflight.

  SELECT sfli~carrid,
       connid,
       fldate,
       price,
       currency,
       seatsmax,
       seatsocc,
       seatsmax_b,
       seatsocc_b,
       seatsmax_f,
       seatsocc_f,
       scar~carrname
  FROM zysflight1t AS sfli
  JOIN zyscarr1t AS scar
  ON scar~carrid = sfli~carrid
  WHERE sfli~carrid = @p_carrid AND sfli~connid IN @s_connid
  INTO CORRESPONDING FIELDS OF TABLE @ct_sflight.

  IF sy-subrc <> 0. " Airline code not found
    MESSAGE TEXT-e02 TYPE 'E'. " Airline code not found.
    LEAVE TO SCREEN 0.
  ENDIF.
ENDFORM.


FORM get_sflight_data_fm CHANGING ct_sflight TYPE gtt_sflight.

  CALL FUNCTION 'ZFM_T16_GET_SFLIGHT_GNV'
    EXPORTING
      pv_carrid     = p_carrid
      it_connid     = s_connid[]
    IMPORTING
      et_sflight    = ct_sflight
    EXCEPTIONS
      no_data_found = 1
      OTHERS        = 2.
  IF sy-subrc <> 0.
    MESSAGE TEXT-e02 TYPE 'E'. " Airline code not found.
    LEAVE TO SCREEN 0.
  ENDIF.

ENDFORM.


FORM prepare_field_catalog CHANGING ct_fieldcat TYPE slis_t_fieldcat_alv.
  DATA: lt_fieldcat TYPE slis_t_fieldcat_alv,
        lv_tabname  TYPE slis_tabname VALUE 'ZST_SFLIGHT1T_GNV'.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = lv_tabname
    CHANGING
      ct_fieldcat      = lt_fieldcat.

  LOOP AT lt_fieldcat ASSIGNING FIELD-SYMBOL(<fs_fieldcat>).
    CASE <fs_fieldcat>-fieldname.
      WHEN 'CARRID' OR 'CARRNAME' OR 'CONNID' OR 'FLDATE' OR 'VACSEATS' OR 'VACSEATS_B' OR 'VACSEATS_F' OR 'PRICE'.

      WHEN OTHERS.
        " Remove other fields
        DELETE lt_fieldcat.
    ENDCASE.
  ENDLOOP.
  ct_fieldcat = lt_fieldcat.
ENDFORM.


FORM display_sflight_data_alv USING it_sflight TYPE gtt_sflight.
  DATA: lt_fieldcat TYPE slis_t_fieldcat_alv,
        ls_layout   TYPE slis_layout_alv.

  " Prepare field catalog
  PERFORM prepare_field_catalog CHANGING lt_fieldcat.

  " Set layout
  ls_layout-zebra = 'X'.
  ls_layout-colwidth_optimize = 'X'.

  " Display ALV
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'SET_PF_STATUS'
      i_callback_user_command  = 'USER_COMMAND'
      is_layout                = ls_layout
      it_fieldcat              = lt_fieldcat
    TABLES
      t_outtab                 = it_sflight
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
ENDFORM.


FORM display_grouped_prices USING it_sflight TYPE gtt_sflight.

  " Temporary variables for grouping and calculations
  DATA: lv_sum_price TYPE zysflight1t-price,
        lv_currency  TYPE zysflight1t-currency.

  " Display header
  WRITE: / 'Airline Code', 12 'Flight Number', 30 'Total Price'.
  WRITE: / sy-uline.

  " Group by Airline Code (CARRID) and Flight Number (CONNID)
  LOOP AT it_sflight INTO DATA(ls_sflight)
    GROUP BY ( carrid = ls_sflight-carrid connid = ls_sflight-connid )
    ASCENDING
    ASSIGNING FIELD-SYMBOL(<group>).

    " Initialize sum for each group
    lv_sum_price = 0.
    lv_currency = ls_sflight-currency.

    " Calculate the sum of PRICE for the group
    LOOP AT GROUP <group> INTO DATA(ls_group).
      lv_sum_price = lv_sum_price + ls_group-price.
    ENDLOOP.

    " Display the grouped result
    WRITE: / <group>-carrid,
             12 <group>-connid,
             30 lv_sum_price CURRENCY lv_currency.
  ENDLOOP.

  " Display footer
  WRITE: / sy-uline.

ENDFORM.


FORM set_pf_status USING rt_extab TYPE slis_t_extab.
  SET PF-STATUS 'ZS_SALV_STANDARD_T14' EXCLUDING rt_extab.
ENDFORM.

FORM user_command USING r_ucomm LIKE sy-ucomm
                        rs_selfield TYPE slis_selfield.
  CASE r_ucomm.
    WHEN '&AVE_XLSX'.
      PERFORM display_xlsx_workbench(zsyro1110_t4_prnt_out_gnv)
        USING gt_sflight_data.
    WHEN OTHERS.
      " Handle other commands
  ENDCASE.
ENDFORM.


FORM display_xlsx_workbench USING VALUE(it_sflight) TYPE gtt_sflight.
  CALL FUNCTION 'ZFM_XLWB_CALLFORM'
    EXPORTING
      iv_formname    = 'ZT_FLIGHT_DATA_GNV'
      iv_context_ref = it_sflight
*     IV_VIEWER_TITLE               = SY-TITLE
*     IV_VIEWER_INPLACE             = 'X'
*     IV_VIEWER_CALLBACK_PROG       = SY-CPROG
*     IV_VIEWER_CALLBACK_FORM       =
*     IV_VIEWER_SUPPRESS            =
*     IV_PROTECT     =
*     IV_SAVE_AS     =
*     IV_SAVE_AS_APPSERVER          =
*     IV_STARTUP_MACRO              =
*     IT_DOCPROPERTIES              =
*     IV_OPENFILE    = 'X'
*   IMPORTING
*     EV_DOCUMENT_RAWDATA           =
*     EV_DOCUMENT_EXTENSION         =
*   EXCEPTIONS
*     PROCESS_TERMINATED            = 1
*     OTHERS         = 2
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.
