*----------------------------------------------------------------------*
***INCLUDE ZSYR093_TASK22_VALIDATE_DATF01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& FORM GET_DATA .
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
  CALL FUNCTION 'ZFM_GET_DATA_FLIGHT_NMT'
   EXPORTING
      i_carrid = p_carrid
      i_connid = s_connid[]
    IMPORTING
      e_flight = gt_flight.

  " Check if data exists
  IF gt_flight IS INITIAL.
    MESSAGE TEXT-002 TYPE 'E'.
  ENDIF.
ENDFORM.


FUNCTION ZFM_GET_DATA_FLIGHT_NMT.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(I_CARRID) TYPE  ZDE_CARRID_NMT
*"     REFERENCE(I_CONNID) TYPE  ZTT_FLCONN_RANGE_NMT
*"  EXPORTING
*"     REFERENCE(E_FLIGHT) TYPE  ZTT_FLIGHT_NMT
*"----------------------------------------------------------------------

  RANGES: r_connid FOR zy093tf-connid.

  LOOP AT i_connid INTO DATA(ls_connid).
    r_connid-sign = ls_connid-sign.
    r_connid-option = ls_connid-option.
    r_connid-low = ls_connid-low.
    r_connid-high = ls_connid-high.
    APPEND r_connid.
  ENDLOOP.

  SELECT
    Sflight~carrid,
    sflight~connid,
    sflight~fldate,
    sflight~price,
    sflight~currency,
    sflight~seatsmax,
    sflight~seatsocc,
    sflight~seatsmax_b,
    sflight~seatsocc_b,
    sflight~seatsmax_f,
    sflight~seatsocc_f,
    scarr~carrname
  FROM zy093tf AS sflight
  JOIN zy093tsc AS scarr
    ON scarr~carrid = sflight~carrid
  WHERE sflight~carrid = @i_carrid
    AND sflight~connid IN @r_connid
  INTO CORRESPONDING FIELDS OF TABLE @e_flight.
ENDFUNCTION.