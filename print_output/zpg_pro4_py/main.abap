*&---------------------------------------------------------------------*
*& Report ZPG_PRO1_PY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpg_pro4_py.

TABLES: zyfl3t.

PARAMETERS: p_air TYPE zyfl3t-carrid OBLIGATORY.
SELECT-OPTIONS: s_conn FOR zyfl3t-connid NO-EXTENSION.

DATA: gv_total     TYPE zyfl3t-price,
      gt_flight    TYPE ztt_flight_py,
      lv_price     TYPE bapicurr-bapicurr,
      go_alv_table TYPE REF TO cl_salv_table.

CLASS gcl_alv_handler DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS: added_function FOR EVENT added_function OF cl_salv_events_table
      IMPORTING
        e_salv_function.
ENDCLASS.

CLASS gcl_alv_handler IMPLEMENTATION.
  METHOD added_function.
    PERFORM handle_user_function USING e_salv_function.
  ENDMETHOD.
ENDCLASS.

AT SELECTION-SCREEN.
  PERFORM validate_airl.

START-OF-SELECTION.
  PERFORM query_data.

  LOOP AT gt_flight ASSIGNING FIELD-SYMBOL(<fs_flight>).
    <fs_flight>-vacase = <fs_flight>-seatsmax - <fs_flight>-seatsocc.
    <fs_flight>-vacas_b = <fs_flight>-seatsmax_b - <fs_flight>-seatsocc_b.
    <fs_flight>-vacas_f = <fs_flight>-seatsmax_f - <fs_flight>-seatsocc_f.

    CALL FUNCTION 'BAPI_CURRENCY_CONV_TO_EXTERNAL'
      EXPORTING
        currency        = <fs_flight>-currency
        amount_internal = <fs_flight>-price
      IMPORTING
        amount_external = lv_price.

    <fs_flight>-price = lv_price.
  ENDLOOP.

  PERFORM handle_alv.

FORM handle_alv .
  PERFORM create_alv_object.
  PERFORM prepare_alv.
  PERFORM display_alv.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form CREATE_ALV_OBJECT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- go_alv_table
*&---------------------------------------------------------------------*
FORM create_alv_object.
  TRY.
      cl_salv_table=>factory(
              IMPORTING
                r_salv_table   =  go_alv_table                         " Basis Class Simple ALV Tables
              CHANGING
                t_table        = gt_flight
            ).

    CATCH cx_salv_msg. " ALV: General Error Class with Message
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
             WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDTRY.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form PREPARE_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- go_alv_table
*&---------------------------------------------------------------------*
FORM prepare_alv.

  DATA: lo_columns     TYPE REF TO cl_salv_columns_table,
        lo_column      TYPE REF TO cl_salv_column,
        lo_dis_setting TYPE REF TO cl_salv_display_settings,
        lo_selections  TYPE REF TO cl_salv_selections,
        lo_events      TYPE REF TO cl_salv_events_table.

  lo_columns = go_alv_table->get_columns( ).
  lo_columns->set_optimize( ).

  lo_column = lo_columns->get_column( columnname = 'MANDT' ).
  lo_column->set_visible( value = if_salv_c_bool_sap=>false ).
  lo_column = lo_columns->get_column( columnname = 'PAYMENTSUM' ).
  lo_column->set_visible( value = if_salv_c_bool_sap=>false ).
  lo_column = lo_columns->get_column( columnname = 'PLANETYPE' ).
  lo_column->set_visible( value = if_salv_c_bool_sap=>false ).
  lo_column = lo_columns->get_column( columnname = 'SEATSMAX' ).
  lo_column->set_visible( value = if_salv_c_bool_sap=>false ).
  lo_column = lo_columns->get_column( columnname = 'SEATSOCC' ).
  lo_column->set_visible( value = if_salv_c_bool_sap=>false ).
  lo_column = lo_columns->get_column( columnname = 'SEATSMAX_B' ).
  lo_column->set_visible( value = if_salv_c_bool_sap=>false ).
  lo_column = lo_columns->get_column( columnname = 'SEATSMAX_B' ).
  lo_column->set_visible( value = if_salv_c_bool_sap=>false ).
  lo_column = lo_columns->get_column( columnname = 'SEATSOCC_B' ).
  lo_column->set_visible( value = if_salv_c_bool_sap=>false ).
  lo_column = lo_columns->get_column( columnname = 'SEATSMAX_F' ).
  lo_column->set_visible( value = if_salv_c_bool_sap=>false ).
  lo_column = lo_columns->get_column( columnname = 'SEATSOCC_F' ).
  lo_column->set_visible( value = if_salv_c_bool_sap=>false ).
*CATCH cx_salv_not_found. " ALV: General Error Class (Checked During Syntax Check)

  lo_dis_setting = go_alv_table->get_display_settings( ).
  lo_dis_setting->set_striped_pattern( value = abap_true ).

  lo_selections = go_alv_table->get_selections( ).
  lo_selections->set_selection_mode(
      value = if_salv_c_selection_mode=>row_column
  ).

  go_alv_table->set_screen_status(
    EXPORTING
      report        = sy-repid                 " ABAP Program: Current Master Program
      pfstatus      = 'ZGS_ALV_PY'     " Screens, Current GUI Status
      set_functions = cl_salv_table=>c_functions_all " ALV: Data Element for Constants
  ).

  lo_events = go_alv_table->get_event( ).
  SET HANDLER gcl_alv_handler=>added_function FOR lo_events.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- go_alv_table
*&---------------------------------------------------------------------*
FORM display_alv.
  go_alv_table->display( ).

  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form VALIDATE_AIRL
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM validate_airl .
  SELECT SINGLE carrid FROM zyairl3t WHERE carrid = @p_air INTO @DATA(gv_air).
  IF gv_air IS INITIAL.
    MESSAGE 'Airline Code is not exists. Please input again.'(001) TYPE 'E'.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form QUERY_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM query_data .
  CALL FUNCTION 'ZFM_GET_FLIGHT_PY'
    EXPORTING
      i_carrid = p_air
      i_connid = s_conn[]
    IMPORTING
      e_flight = gt_flight.

  IF gt_flight IS INITIAL.
    MESSAGE e001(zmsg_error_py) "No data exists in &1 table
    WITH 'Flight'
  .

    LEAVE LIST-PROCESSING.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form HANDLE_USER_FUNCTION
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> E_SALV_FUNCTION
*&---------------------------------------------------------------------*
FORM handle_user_function USING ue_salv_function TYPE any.
  CASE ue_salv_function.
    WHEN 'EXPORT'.
      PERFORM export.
    WHEN OTHERS.
  ENDCASE.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form EXPORT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM export.
  CALL FUNCTION 'ZFM_XLWB_CALLFORM'
    EXPORTING
      iv_formname    = 'ZWB_PRO3_PY'
      iv_context_ref = gt_flight
    EXCEPTIONS
      OTHERS         = 2.

  IF sy-subrc NE 0 .
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4 .
  ENDIF .
ENDFORM.
