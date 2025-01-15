*----------------------------------------------------------------------*
***INCLUDE ZSYR093_TASK20_MODIFY_DBF01.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form MODIFY_DB
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> LT_AIRLINE
*&      --> LT_FLIGHT
*&      --> LT_BOOKING
*&---------------------------------------------------------------------*
FORM MODIFY_DB USING u_lt_ariline  TYPE lty_airline
                     u_lt_flight   TYPE lty_flight
                     u_lt_booking  TYPE lty_booking.

  MODIFY zy093tsc FROM TABLE u_lt_ariline.
  IF sy-subrc = 0.
    WRITE: / 'Modify data to table AIRLINE zy093tsc successful.'.
  ELSE.
    WRITE: / 'Error while Modifying data to table AIRLINE zy093tsc.'.
  ENDIF.

  MODIFY zy093tf  FROM TABLE u_lt_flight.
  IF sy-subrc = 0.
    WRITE: / 'Modify data to table FLIGHT zy093tf successful.'.
  ELSE.
    WRITE: / 'Error while Modifying data to table FLIGHT zy093tf.'.
  ENDIF.

  MODIFY zy093tb  FROM TABLE u_lt_booking.
  IF sy-subrc = 0.
    WRITE: / 'Modify data to table BOOKING zy093tb successful.'.
  ELSE.
    WRITE: / 'Error while Modifying data to table BOOKING zy093tb.'.
  ENDIF.
ENDFORM.