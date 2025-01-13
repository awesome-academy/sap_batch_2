*&---------------------------------------------------------------------*
*& Report ZSYRO1110_T3_GNV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsyro1110_t3_gnv.

TABLES: sflight.
*&---------------------------------------------------------------------*
*& Selection Screen
*&---------------------------------------------------------------------*
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_carrid TYPE scarr-carrid OBLIGATORY DEFAULT 'JL'.
PARAMETERS: p_flight TYPE sflight-connid.
SELECT-OPTIONS: s_date FOR sflight-fldate OBLIGATORY NO-EXTENSION.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-005.
PARAMETERS: p_chkdst AS CHECKBOX.
PARAMETERS: p_cty_fr TYPE spfli-cityfrom.
PARAMETERS: p_cty_t TYPE spfli-cityto.
SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-009.
PARAMETERS: p_econ RADIOBUTTON GROUP grp1 DEFAULT 'X'.
PARAMETERS: p_busi RADIOBUTTON GROUP grp1.
PARAMETERS: p_first RADIOBUTTON GROUP grp1.
SELECTION-SCREEN END OF BLOCK b3.

*&---------------------------------------------------------------------*
*& AT SELECTION-SCREEN
*&---------------------------------------------------------------------*
AT SELECTION-SCREEN.
  IF p_chkdst = abap_true AND p_cty_fr IS INITIAL AND p_cty_t IS INITIAL.
    MESSAGE TEXT-E01 TYPE 'E'.
    MESSAGE e002(zyinc1_gnv) WITH 'City From' 'City To'.
  ENDIF.

*&---------------------------------------------------------------------*
*& START-OF-SELECTION
*&---------------------------------------------------------------------*
START-OF-SELECTION.
  PERFORM display_result.

*&---------------------------------------------------------------------*
*& FORM display_result
*&---------------------------------------------------------------------*

FORM display_result.
  DATA: lv_date TYPE string,
        lv_time TYPE string.

  " Convert date to external format (dd.MM.YYYY)
  CALL FUNCTION 'CONVERT_DATE_TO_EXTERNAL'
    EXPORTING
      date_internal            = sy-datum
    IMPORTING
      date_external            = lv_date
    EXCEPTIONS
      date_internal_is_invalid = 1
      OTHERS                   = 2.
  IF sy-subrc <> 0.
    lv_date = 'Invalid Date'.
  ENDIF.
  DATA(lv_ctime) = sy-uzeit.

  lv_time = |{ lv_ctime+0(2) }:{ lv_ctime+2(2) }:{ lv_ctime+4(2) }|.

  " Display the results
  WRITE: / |{ TEXT-002 }: { p_carrid }|.
  WRITE: / |{ TEXT-003 }: { p_flight }|.
  WRITE: / | { TEXT-004 }: { s_date-low+0(4) }.{ s_date-low+4(2) }.{ s_date-low+6(2) } - { s_date-high+0(4) }.{ s_date-high+4(2) }.{ s_date-high+6(2) }|.
  WRITE: / TEXT-009, ':', COND string( WHEN p_econ = 'X' THEN ''(012)
                                      WHEN p_busi = 'X' THEN ''(013)
                                      WHEN p_first = 'X' THEN ''(014) ).

  IF p_cty_fr IS NOT INITIAL OR p_cty_t IS NOT INITIAL.
    WRITE: / |{ TEXT-007 }: { p_cty_fr }|.
    WRITE: / |{ TEXT-008 }: { p_cty_t }|.
  ENDIF.

  " Display formatted date and time
  WRITE: / |{ TEXT-010 }: { lv_date }|.
  WRITE: / |{ TEXT-011 }: { lv_time }|.
ENDFORM.