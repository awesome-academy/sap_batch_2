*&---------------------------------------------------------------------*
*& Report ZSYR093_TASK17 by Tuannm
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSYR093_TASK17.

DATA:
  lv_popup_text  TYPE string,       " text for popup question
  lv_submit_type TYPE string,       " type of submit (create/update)
  lv_answer      TYPE c LENGTH 1.   " answer for popup question

" Create selection screen
SELECTION-SCREEN BEGIN OF BLOCK func_block WITH FRAME TITLE TEXT-001.
PARAMETERS: create TYPE c RADIOBUTTON GROUP func,
            delete TYPE c RADIOBUTTON GROUP func,
            test   TYPE c RADIOBUTTON GROUP func DEFAULT 'X'.
SELECTION-SCREEN END OF BLOCK func_block.

SELECTION-SCREEN BEGIN OF BLOCK input_block WITH FRAME TITLE TEXT-002.
PARAMETERS: p_carrid TYPE zy093tsc-carrid OBLIGATORY,     " Airline Code
            p_connid TYPE zy093tf-connid  OBLIGATORY,     " Flight No
            p_fldate TYPE zy093tf-fldate  OBLIGATORY,     " Flight Date
            p_price  TYPE zy093tf-price,                  " Airfare
            p_curr   TYPE zy093tf-currency,               " Currency
            p_pltype TYPE zy093tf-planetype,              " Plane type
            p_smax   TYPE zy093tf-seatsmax,               " Available seats
            p_socc   TYPE zy093tf-seatsocc,               " Reserved seats
            p_sum    TYPE zy093tf-paymentsum,             " total amount of reserved seats
            p_smax_b TYPE zy093tf-seatsmax_b,             " Available seats (Business)
            p_socc_b TYPE zy093tf-seatsocc_b,             " Reserved seats (Business)
            p_smax_f TYPe zy093tf-seatsmax_f,             " Available seats (First Class)
            p_socc_f TYPE zy093tf-seatsocc_f.             " Reserved seats (First Class)
SELECTION-SCREEN END OF BLOCK input_block.

" validate Airline Code, Flight No, Currency and Plane Type
AT SELECTION-SCREEN.
  " validate Airline Code
  SELECT SINGLE carrid
  FROM ZY093TSC
  WHERE carrid = @p_carrid
  INTO @DATA(lv_carrid).

  IF sy-subrc <> 0.
    MESSAGE 'No object data exists in table Airline' TYPE 'E'.
  ENDIF.

  " validate FlightNo only if user selected delete btn
  IF delete = 'X'.
    SELECT SINGLE connid
    FROM zy093tf
    WHERE carrid = @p_carrid
      AND connid = @p_connid
    INTO @DATA(lv_connid).

    IF lv_connid IS INITIAL.
      MESSAGE |No object data exists in table Flight ({ p_carrid }     { p_connid })| TYPE 'E'.
    ENDIF.
  ENDIF.

  " validate Currency
  IF p_curr IS NOT INITIAL.
    SELECT SINGLE currkey
    FROM scurx
    WHERE currkey = @p_curr
    INTO @DATA(lv_curr).

    IF lv_curr IS INITIAL.
      MESSAGE |No object data exists in table SCURX ({ p_curr })| TYPE 'E'.
    ENDIF.
  ENDIF.

  " validate Plane Type
  IF p_pltype IS NOT INITIAL.
    SELECT SINGLE planetype
    FROM saplane
    WHERE planetype = @p_pltype
    INTO @DATA(lv_pltype).

    IF lv_pltype IS INITIAL.
      MESSAGE |No object data exists in table SAPLANE ({ p_pltype })| TYPE 'E'.
    ENDIF.
  ENDIF.

START-OF-SELECTION.
  " when user selected button test
  IF test = 'X'.
    WRITE: / 'List of data can be created/updated/deleted:'.
    ULINE.

    " Display airline information
    WRITE: / 'Airline code:', p_carrid.
    WRITE: / 'Flight No:', p_connid.
    WRITE: / 'Flight Date:', p_fldate.
    WRITE: / 'Price:', p_price.
    WRITE: / 'Currency:', p_curr.
    WRITE: / 'Plane type:', p_pltype.

    " Display seat and reservation information
    WRITE: / 'Total reserved airfare:', p_sum CURRENCY p_curr.
    WRITE: / 'Total Economy cl seat:', p_smax.
    WRITE: / 'Economy cl reserved seat:', p_socc.
    WRITE: / 'Total Business cl seat:', p_smax_b.
    WRITE: / 'Business reserved seat:', p_socc_b.
    WRITE: / 'Total First class seat:', p_smax_b.
    WRITE: / 'First cl reserved seat:', p_socc_b.

    RETURN.
  ENDIF.

  " when user selected create/update
  IF create = 'X'.
    lv_submit_type = 'create'.

    SELECT SINGLE carrid
    FROM zy093tf
    WHERE carrid = @p_carrid
      AND connid = @p_connid
      AND fldate = @p_fldate
    INTO @DATA(lv_flight).

    IF lv_flight IS INITIAL.
      lv_popup_text = 'Would you like to create data'.
    ELSE.
      lv_popup_text = 'Would you like to update data'.
      lv_submit_type = 'update'.
    ENDIF.

    " call function display popup
    PERFORM popup_confirm USING lv_popup_text CHANGING lv_answer.

    " when user choose yes
    IF lv_answer = '1'.
      IF lv_submit_type = 'create'.
        INSERT zy093tf FROM @(
          VALUE #(
            carrid = p_carrid connid = p_connid fldate = p_fldate currency = p_curr price = p_price
            planetype = p_pltype seatsmax = p_smax seatsocc = p_socc paymentsum = p_sum
            seatsmax_b = p_smax_b seatsocc_b = p_socc_b seatsmax_f = p_smax_f seatsocc_f = p_socc_f
          )
        ).
      ELSEIF lv_submit_type = 'update'.
        UPDATE zy093tf FROM @(
          VALUE #(
            carrid = p_carrid connid = p_connid fldate = p_fldate currency = p_curr price = p_price
            planetype = p_pltype seatsmax = p_smax seatsocc = p_socc paymentsum = p_sum
            seatsmax_b = p_smax_b seatsocc_b = p_socc_b seatsmax_f = p_smax_f seatsocc_f = p_socc_f
          )
        ).
      ELSE.
        MESSAGE 'Wrong type submit!' TYPE 'E'.
        RETURN.
      ENDIF.

      IF sy-subrc <> 0.
        MESSAGE 'There are some errors when create/update flight data!' TYPE 'E'.
        RETURN.
      ENDIF.
    ELSE.
      LEAVE LIST-PROCESSING.
    ENDIF.
  ENDIF.

  " when user selected delete button
  IF delete = 'X'.
    lv_submit_type = 'delete'.
    lv_popup_text = 'Would you like to delete data'.

    " call function display popup
    PERFORM popup_confirm USING lv_popup_text CHANGING lv_answer.

    IF lv_answer = '1'.
      " Delete FLIGHT data
      DELETE zy093tf FROM @(
        VALUE #( carrid = p_carrid connid = p_connid fldate = p_fldate )
      ).

      IF sy-subrc <> 0.
        MESSAGE 'There are some errors when delete flight data!' TYPE 'E'.
        RETURN.
      ENDIF.
    ELSE.
      LEAVE LIST-PROCESSING.
    ENDIF.
  ENDIF.

END-OF-SELECTION.
  WRITE: / |{ lv_submit_type } process is successful|,
         / 'Airline code:', p_carrid,
         / 'Flight No:', p_connid,
         / 'Flight Date:', p_fldate.


*&---------------------------------------------------------------------*
*& Form call popup confirm
*&---------------------------------------------------------------------*
FORM popup_confirm USING    u_text   TYPE string
                    CHANGING c_answer TYPE c1.

  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      titlebar              = 'Confirm'
      text_question         = u_text
      text_button_1         = 'Yes'
      text_button_2         = 'No'
      default_button        = '1'
      display_cancel_button = 'X'
      start_column          = 25
      start_row             = 6
    IMPORTING
      answer                = c_answer
    EXCEPTIONS
      text_not_found        = 1
      others                = 2.

  IF sy-subrc <> 0.
    MESSAGE 'Error when openning popup' TYPE 'E'.
  ENDIF.
ENDFORM.