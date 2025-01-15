*&---------------------------------------------------------------------*
*& Report ZSYR093_TASK16
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSYR093_TASK16.

TABLES: sflight.
DATA:
  lv_total_price TYPE zy093tf-price.

PARAMETERS: p_carrid TYPE sflight-carrid OBLIGATORY.
SELECT-OPTIONS: s_connid FOR sflight-connid.

START-OF-SELECTION.
  " Validate carrid
  SELECT SINGLE carrid FROM zy093tsc WHERE carrid = @p_carrid INTO @DATA(lv_carrid).
  IF sy-subrc <> 0.
    MESSAGE TEXT-001 TYPE 'E'.
    RETURN.
  ENDIF.

  " Get data from table FLIGHT
  SELECT
    zy093tf~carrid,
    zy093tf~connid,
    zy093tf~fldate,
    zy093tf~price,
    zy093tf~currency,
    zy093tf~seatsmax,
    zy093tf~seatsocc,
    zy093tf~seatsmax_b,
    zy093tf~seatsocc_b,
    zy093tf~seatsmax_f,
    zy093tf~seatsocc_f,
    zy093tsc~carrname
  FROM zy093tf
  JOIN zy093tsc
    ON zy093tsc~carrid = zy093tf~carrid
  WHERE zy093tf~carrid = @p_carrid
    AND zy093tf~connid in @s_connid
  INTO TABLE @DATA(lt_flight).

  " Check if data exists
  IF lt_flight IS INITIAL.
    MESSAGE TEXT-002 TYPE 'E'.
  ENDIF.

END-OF-SELECTION.
  " display respective header for extracted data
  WRITE: / 'Airline Code', 20 'Airline Name', 40 'Flight Number',
         60 'Flight Date', 80 'Price', 100 'Currency',
         120 'Vacant Seats (Economy)',
         160 'Vacant Seats (Business)',
         200 'Vacant Seats (First)'.
  ULINE.

  " Display extracted data
  LOOP AT lt_flight INTO DATA(ls_flight)
                    GROUP BY ( carrid = ls_flight-carrid
                               connid = ls_flight-connid ).

    LOOP AT GROUP ls_flight INTO DATA(ls_item).
      CLEAR lv_total_price.

      " Calculate vacant seats
      DATA(lv_vacant_economy) = ls_item-seatsmax - ls_item-seatsocc.
      DATA(lv_vacant_business) = ls_item-seatsmax_b - ls_item-seatsocc_b.
      DATA(lv_vacant_first) = ls_item-seatsmax_f - ls_item-seatsocc_f.

      lv_total_price = lv_total_price + ls_item-price.
    ENDLOOP.

    " Display each row with respective header
    WRITE: / ls_flight-carrid UNDER 'Airline Code',
             ls_flight-carrname UNDER 'Airline Name',
             ls_flight-connid UNDER 'Flight Number',
             ls_flight-fldate UNDER 'Flight Date',
             ls_flight-price UNDER 'Price' CURRENCY ls_flight-currency,
             ls_flight-currency UNDER 'Currency',
             lv_vacant_economy UNDER 'Vacant Seats (Economy)',
             lv_vacant_business UNDER 'Vacant Seats (Business)',
             lv_vacant_first UNDER 'Vacant Seats (First)'.

    SKIP 1.
    WRITE: / 'Total price: ', lv_total_price CURRENCY ls_item-currency.
    SKIP 1.
    ULINE 1.
  ENDLOOP.