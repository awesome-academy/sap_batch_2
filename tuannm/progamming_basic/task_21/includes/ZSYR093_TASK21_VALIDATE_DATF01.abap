*----------------------------------------------------------------------*
***INCLUDE ZSYR093_TASK21_VALIDATE_DATF01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form VALIDATE_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM GET_DATA .
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
  INTO TABLE @gt_flight.

  " Check if data exists
  IF gt_flight IS INITIAL.
    MESSAGE TEXT-002 TYPE 'E'.
  ENDIF.
ENDFORM.