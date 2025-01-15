*----------------------------------------------------------------------*
***INCLUDE ZSYR093_TASK21_DISPLAY_DATAF01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form DISPLAY_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM DISPLAY_DATA .
  " Display extracted data with headers
  WRITE: / 'Airline Code', 20 'Airline Name', 40 'Flight Number',
         60 'Flight Date', 80 'Price', 100 'Currency',
         120 'Vacant Seats (Economy)',
         160 'Vacant Seats (Business)',
         200 'Vacant Seats (First)'.
  ULINE.

  LOOP AT gt_flight INTO DATA(ls_flight).
    " Calculate vacant seats
    DATA(lv_vacant_economy) = ls_flight-seatsmax - ls_flight-seatsocc.
    DATA(lv_vacant_business) = ls_flight-seatsmax_b - ls_flight-seatsocc_b.
    DATA(lv_vacant_first) = ls_flight-seatsmax_f - ls_flight-seatsocc_f.

    " Display each row with respective header
    WRITE: / ls_flight-carrid   UNDER 'Airline Code',
             ls_flight-carrname UNDER 'Airline Name',
             ls_flight-connid   UNDER 'Flight Number',
             ls_flight-fldate   UNDER 'Flight Date',
             ls_flight-price    UNDER 'Price' CURRENCY ls_flight-currency,
             ls_flight-currency UNDER 'Currency',
             lv_vacant_economy  UNDER 'Vacant Seats (Economy)',
             lv_vacant_business UNDER 'Vacant Seats (Business)',
             lv_vacant_first    UNDER 'Vacant Seats (First)'.
  ENDLOOP.
ENDFORM.