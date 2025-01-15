*&---------------------------------------------------------------------*
*& Report ZSYR093_TASK22
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSYR093_TASK22.

TABLES: sflight.

DATA:
  lv_total_price TYPE zy093tf-price,
  gt_flight      TYPE ztt_flight_nmt.

PARAMETERS: p_carrid TYPE sflight-carrid OBLIGATORY.
SELECT-OPTIONS: s_connid FOR sflight-connid.

START-OF-SELECTION.
  PERFORM get_data.

END-OF-SELECTION.
  PERFORM display_data.

INCLUDE zsyr093_task22_validate_datf01.
INCLUDE zsyr093_task21_display_dataf01.