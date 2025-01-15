*&---------------------------------------------------------------------*
*& Report ZSYR093_TASK21
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSYR093_TASK21.

TABLES: sflight.

TYPES:
  BEGIN OF lty_flight,
    carrid     TYPE sflight-carrid,
    connid     TYPE sflight-connid,
    fldate     TYPE sflight-fldate,
    price      TYPE sflight-price,
    currencY   TYPE sflight-currency,
    seatsmax   TYPE sflight-seatsmax,
    seatsocc   TYPE sflight-seatsocc,
    seatsmax_b TYPE sflight-seatsmax_b,
    seatsocc_b TYPE sflight-seatsocc_b,
    seatsmax_f TYPE sflight-seatsmax_f,
    seatsocc_f TYPE sflight-seatsocc_f,
    carrname   TYPE zy093tsc-carrname,
  END OF lty_flight.

DATA:
  lv_total_price TYPE zy093tf-price,
  gt_flight      TYPE TABLE OF lty_flight.

PARAMETERS: p_carrid TYPE sflight-carrid OBLIGATORY.
SELECT-OPTIONS: s_connid FOR sflight-connid.

START-OF-SELECTION.
  PERFORM get_data.

END-OF-SELECTION.
  PERFORM display_data.

INCLUDE zsyr093_task21_validate_datf01.

INCLUDE zsyr093_task21_display_dataf01.