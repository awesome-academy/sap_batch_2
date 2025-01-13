*&---------------------------------------------------------------------*
*& Report ZPG_PRO1_PY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpg_pro1_py.

TABLES: zyfl3t.

PARAMETERS: p_air TYPE zyfl3t-carrid OBLIGATORY.
SELECT-OPTIONS: s_conn FOR zyfl3t-connid NO-EXTENSION.

DATA: gv_total     TYPE zyfl3t-price,
      gt_flight    TYPE ztt_flight_py,
      go_alv_table TYPE REF TO cl_salv_table.

AT SELECTION-SCREEN.
  PERFORM validate_airl.

START-OF-SELECTION.
  PERFORM query_data.

  LOOP AT gt_flight ASSIGNING FIELD-SYMBOL(<fs_flight>).
    <fs_flight>-vacase = <fs_flight>-seatsmax - <fs_flight>-seatsocc.
    <fs_flight>-vacas_b = <fs_flight>-seatsmax_b - <fs_flight>-seatsocc_b.
    <fs_flight>-vacas_f = <fs_flight>-seatsmax_f - <fs_flight>-seatsocc_f.
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
        lo_selections  TYPE REF TO cl_salv_selections.

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
*
  go_alv_table->get_functions( )->set_all( ).

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
