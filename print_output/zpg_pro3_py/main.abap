*&---------------------------------------------------------------------*
*& Report ZPG_PRO1_PY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpg_pro3_py.

TABLES: zyfl3t.

PARAMETERS: p_air TYPE zyfl3t-carrid OBLIGATORY.
SELECT-OPTIONS: s_conn FOR zyfl3t-connid NO-EXTENSION.

DATA: gv_total     TYPE zyfl3t-price,
      gt_flight    TYPE ztt_flight_py,
            lv_price     TYPE bapicurr-bapicurr,
      go_alv_table TYPE REF TO cl_salv_table.

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

  CALL FUNCTION 'ZFM_XLWB_CALLFORM'
    EXPORTING
      iv_formname        = 'ZWB_PRO3_PY'
      iv_context_ref     = gt_flight
    EXCEPTIONS
      process_terminated = 1
      OTHERS             = 2.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

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
