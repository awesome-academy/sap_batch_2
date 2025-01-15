*&---------------------------------------------------------------------*
*& Report ZSYRO1110_T17_GNV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsyro1110_t17_gnv.


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
PARAMETERS: rb_upsrt RADIOBUTTON GROUP grp1,
            rb_del   RADIOBUTTON GROUP grp1,
            rb_test  RADIOBUTTON GROUP grp1 DEFAULT 'X'.
SELECTION-SCREEN END OF BLOCK b1.

* Selection Screen Definition
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
PARAMETERS: p_carrid TYPE zysflight1t-carrid OBLIGATORY,
            p_connid TYPE zysflight1t-connid OBLIGATORY,
            p_fldate TYPE zysflight1t-fldate OBLIGATORY,
            p_price  TYPE zysflight1t-price,
            p_curr   TYPE zysflight1t-currency,
            p_ptype  TYPE zysflight1t-planetype,
            p_sm     TYPE zysflight1t-seatsmax, " Available seat economy
            p_occ    TYPE zysflight1t-seatsocc, " Reserved seat economy
            p_pysum  TYPE zysflight1t-paymentsum, " Total amount reserved
            p_smb    TYPE zysflight1t-seatsmax_b, " Available seat business
            p_occb   TYPE zysflight1t-seatsocc_b,  " Reserved seat business
            p_smf    TYPE zysflight1t-seatsmax_f, " Available seat first
            p_occf   TYPE zysflight1t-seatsocc_f. " Reserved seat first
SELECTION-SCREEN END OF BLOCK b2.

* Initialization
INITIALIZATION.

AT SELECTION-SCREEN.
  SELECT SINGLE carrid FROM zyscarr1t WHERE carrid = @p_carrid INTO @DATA(gv_carrid).
  IF gv_carrid IS INITIAL.
    MESSAGE 'No object data exists in table Airline.'(003) TYPE 'E'.
  ENDIF.

  SELECT SINGLE connid FROM zysflight1t WHERE carrid = @p_carrid AND connid = @p_connid INTO @DATA(gv_flno).
  IF gv_flno IS INITIAL AND rb_del = abap_true.
    MESSAGE |No object data exists in table Flight { p_carrid } - { p_connid }| TYPE 'E'.
  ENDIF.

  IF p_curr IS NOT INITIAL.
    SELECT SINGLE currkey FROM scurx WHERE currkey = @p_curr INTO @DATA(gv_curr).
    IF gv_curr IS INITIAL.
      MESSAGE 'No object data exists in table SCURX'(004) TYPE 'E'.
    ENDIF.
  ENDIF.

  IF p_ptype IS NOT INITIAL.
    SELECT SINGLE planetype FROM saplane WHERE planetype = @p_ptype INTO @DATA(gv_plty).
    IF gv_plty IS INITIAL.
      MESSAGE 'No object data exists in table SAPLANE'(005) TYPE 'E'.
    ENDIF.
  ENDIF.

* Start of Selection
START-OF-SELECTION.

  DATA(lv_ans) = 'f'.
  DATA(lv_o_txt) = ''.

  " Handle logic money
  DATA(lv_curr) = CONV tcurc-waers( p_curr ).
  DATA(lv_price) = CONV bapicurr-bapicurr( p_price ).
  IF p_price IS NOT INITIAL.
    CALL FUNCTION 'BAPI_CURRENCY_CONV_TO_INTERNAL'
      EXPORTING
        currency             = lv_curr
        amount_external      = lv_price
        max_number_of_digits = 15
      IMPORTING
        amount_internal      = p_price
*       RETURN               =
      .
  ENDIF.

  IF rb_test = abap_true.
    WRITE : 'List of data can be created/updated/deleted'(006),
           / 'Airline code:'(007), p_carrid,
           / 'Flight No:'(008), p_connid,
           / 'Flight Date:'(009), p_fldate,
           / 'Price:'(010), p_price CURRENCY p_curr, p_curr,
           / 'Currency:'(011), p_curr,
           / 'Plane Type:'(012), p_ptype,
           / 'Total reserved airfare:'(013), p_pysum CURRENCY p_curr,
           / 'Total Economy cl seat:'(014), p_sm,
           / 'Economy cl reserved seat:'(015), p_occ,
           / 'Total Business cl seat:'(016), p_smb,
           / 'Business reserved seat:'(017), p_occb,
           / 'Total First class seat:'(018), p_smf,
           / 'First cl reserved seat:'(019), p_occf.
  ELSE.
    IF rb_upsrt = abap_true.
      DATA(lv_txt_ques) = VALUE string( ).
      DATA(lv_create) = abap_true.

      SELECT SINGLE carrid FROM zysflight1t WHERE carrid = @p_carrid AND connid = @p_connid AND fldate = @p_fldate INTO @DATA(gv_flno).
      IF gv_flno IS INITIAL.
        lv_txt_ques = 'Would you like to create data'(020).
      ELSE.
        lv_txt_ques = 'Would you like to update data'(021).
        lv_create = abap_false.
      ENDIF.
      PERFORM popup_confirm USING lv_txt_ques CHANGING lv_ans.

      IF lv_ans = '2' OR lv_ans = 'A'.
        LEAVE LIST-PROCESSING.
      ENDIF.

      IF lv_ans = '1'.

        IF lv_create = abap_true.
          INSERT zysflight1t FROM @( VALUE #( carrid = p_carrid connid = p_connid fldate = p_fldate price = p_price currency = p_curr planetype = p_ptype
                                              seatsmax = p_sm seatsocc = p_occ paymentsum = p_pysum seatsmax_b = p_smb seatsocc_b = p_occb seatsmax_f = p_smf seatsocc_f = p_occf
                                            )
                                   ).
        ELSE.
          UPDATE zysflight1t FROM @( VALUE #( carrid = p_carrid connid = p_connid fldate = p_fldate price = p_price currency = p_curr planetype = p_ptype
                                              seatsmax = p_sm seatsocc = p_occ paymentsum = p_pysum seatsmax_b = p_smb seatsocc_b = p_occb
                                              seatsmax_f = p_smf seatsocc_f = p_occf
                                            )
                                   ).
        ENDIF.
        IF sy-subrc <> 0.
          MESSAGE 'Error insert/update'(022) TYPE 'E'.
          RETURN.
        ENDIF.

      ENDIF.
      lv_o_txt = COND string( WHEN lv_create = abap_true THEN 'Insert'(024) ELSE 'Update'(025) ).
    ENDIF.

    IF rb_del = abap_true.
      PERFORM popup_confirm USING 'Would you like to delete data?'(023) CHANGING lv_ans.

      IF lv_ans = '2' OR lv_ans = 'A'.
        LEAVE LIST-PROCESSING.
      ENDIF.

      IF lv_ans = '1'.
        DELETE zysflight1t FROM @( VALUE #( carrid = p_carrid connid = p_connid fldate = p_fldate ) ).

        IF sy-subrc <> 0.
          MESSAGE 'Error delete'(027) TYPE 'E'.
          RETURN.
        ENDIF.

        lv_o_txt = 'Delete'(026).
      ENDIF.
    ENDIF.

    MESSAGE |{ lv_o_txt } process is successful| TYPE 'S'.
    WRITE: / |{ lv_o_txt } process is successful|,
         / 'Airline code:'(007), p_carrid,
         / 'Flight No:'(008), p_connid,
         / 'Flight Date:'(009), p_fldate.
  ENDIF.


*&---------------------------------------------------------------------*
*& Form POPUP_CONFIRM
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> UV_TEXT
*&      <-- CV_ANS
*&---------------------------------------------------------------------*
FORM popup_confirm  USING    uv_text TYPE string
                    CHANGING cv_ans TYPE c1.
  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      titlebar              = 'Confirm'
      text_question         = uv_text
      text_button_1         = 'Yes'
*     ICON_BUTTON_1         = ' '
      text_button_2         = 'No'
*     ICON_BUTTON_2         = ' '
      default_button        = '1'
      display_cancel_button = 'X'
      start_column          = 25
      start_row             = 6
    IMPORTING
      answer                = cv_ans
    EXCEPTIONS
      text_not_found        = 1
      OTHERS                = 2.

  IF sy-subrc <> 0.
    " Handle exception if needed
  ENDIF.
ENDFORM.
