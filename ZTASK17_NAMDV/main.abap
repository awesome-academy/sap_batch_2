*&---------------------------------------------------------------------*
*& Report ZSYR1590_NAMDV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSYR1590_NAMDV.

SELECTION-SCREEN BEGIN OF BLOCK B1 WITH FRAME TITLE TEXT-001.
PARAMETERS: RB_CRE RADIOBUTTON GROUP GR1,
            RB_DEL RADIOBUTTON GROUP GR1,
            RB_TR  RADIOBUTTON GROUP GR1 DEFAULT 'X'.
SELECTION-SCREEN END OF BLOCK B1.

SELECTION-SCREEN BEGIN OF BLOCK B2 WITH FRAME TITLE TEXT-002.
PARAMETERS: P_CARRID TYPE ZY052T-CARRID OBLIGATORY,
            P_CONNID TYPE ZY052T-CONNID OBLIGATORY,
            P_FLDATE TYPE ZY052T-FLDATE OBLIGATORY,
            P_PRICE  TYPE ZY052T-PRICE,
            P_CURR   TYPE ZY052T-CURRENCY,
            P_PT     TYPE ZY052T-PLANETYPE,
            P_SM     TYPE ZY052T-SEATSMAX,
            P_SS     TYPE ZY052T-SEATSOCC,
            P_PS     TYPE ZY052T-PAYMENTSUM,
            P_SMB    TYPE ZY052T-SEATSMAX_B,
            P_SSB    TYPE ZY052T-SEATSOCC_B,
            P_SMF    TYPE ZY052T-SEATSMAX_F,
            P_SSF    TYPE ZY052T-SEATSOCC_F.
SELECTION-SCREEN END OF BLOCK B2.

AT SELECTION-SCREEN.
  SELECT SINGLE CARRID FROM ZY050T WHERE CARRID = @P_CARRID INTO @DATA(GV_CARRID).
  IF GV_CARRID IS INITIAL.
    MESSAGE TEXT-E01 TYPE 'E'.
  ENDIF.

  SELECT SINGLE CONNID
  FROM ZY052T
  WHERE CARRID = @P_CARRID
    AND CONNID = @P_CONNID
  INTO @DATA(GV_FLIGHT_NO).

  IF GV_FLIGHT_NO IS INITIAL AND RB_DEL = ABAP_TRUE.
    MESSAGE |No object data exists in table Flight { P_CARRID } - { P_CONNID }| TYPE 'E'.
  ENDIF.

  IF P_CURR IS NOT INITIAL.
    SELECT SINGLE CURRKEY FROM SCURX WHERE CURRKEY = @P_CURR INTO @DATA(GV_CURR).
    IF GV_CURR IS INITIAL.
      MESSAGE TEXT-E02 TYPE 'E'.
    ENDIF.
  ENDIF.

  IF P_PT IS NOT INITIAL.
    SELECT SINGLE PLANETYPE FROM SAPLANE WHERE PLANETYPE = @P_PT INTO @DATA(GV_PLANT_TYPE).
    IF GV_PLANT_TYPE IS INITIAL.
      MESSAGE TEXT-E03 TYPE 'E'.
    ENDIF.
  ENDIF.

START-OF-SELECTION.
  DATA: LV_ANS TYPE C LENGTH 1 VALUE 'F',
        LV_O_TXT TYPE STRING VALUE '',
        LV_PRICE TYPE BAPICURR-BAPICURR,
        LV_CURR TYPE TCURC-WAERS.

  LV_PRICE = P_PRICE.
  LV_CURR = P_CURR.

  IF P_PRICE IS NOT INITIAL.
    CALL FUNCTION 'BAPI_CURRENCY_CONV_TO_INTERNAL'
      EXPORTING
        CURRENCY             = LV_CURR
        AMOUNT_EXTERNAL      = LV_PRICE
        MAX_NUMBER_OF_DIGITS = 15
      IMPORTING
        AMOUNT_INTERNAL      = P_PRICE
      EXCEPTIONS
        OTHERS                = 2.

    IF SY-SUBRC <> 0.
      MESSAGE TEXT-E10 TYPE 'E'.
      RETURN.
    ENDIF.
  ENDIF.

  IF RB_TR = ABAP_TRUE.
    WRITE :  TEXT-003,
           / TEXT-004, P_CARRID,
           / TEXT-005, P_CONNID,
           / TEXT-006, P_FLDATE,
           / TEXT-007, P_PRICE CURRENCY P_CURR, P_CURR,
           / TEXT-008, P_CURR,
           / TEXT-009, P_PT,
           / TEXT-010, P_PS CURRENCY P_CURR,
           / TEXT-011, P_SM,
           / TEXT-012, P_SS,
           / TEXT-013, P_SMB,
           / TEXT-014, P_SSB,
           / TEXT-015, P_SMF,
           / TEXT-016, P_SSF.
  ELSE.
    IF RB_CRE = ABAP_TRUE.
      DATA LV_TXT_QUES TYPE STRING VALUE ''.
      DATA LV_CREATE   TYPE BOOLEAN VALUE 'X'.

      SELECT SINGLE CARRID
      FROM ZY052T
      WHERE CARRID = @P_CARRID
        AND CONNID = @P_CONNID
        AND FLDATE = @P_FLDATE
      INTO @DATA(GV_FLINO).

      IF GV_FLINO IS INITIAL.
        LV_TXT_QUES = TEXT-017.
      ELSE.
        LV_TXT_QUES = TEXT-018.
        LV_CREATE = ABAP_FALSE.
      ENDIF.

      PERFORM POPUP_CONFIRM USING LV_TXT_QUES CHANGING LV_ANS.

      IF LV_ANS = '2' OR LV_ANS = 'A'.
        LEAVE LIST-PROCESSING.
      ENDIF.

      IF LV_ANS = '1'.
        IF LV_CREATE = ABAP_TRUE.
          INSERT ZY052T FROM @( VALUE #( CARRID      = P_CARRID
                                          CONNID     = P_CONNID
                                          FLDATE     = P_FLDATE
                                          PRICE      = P_PRICE
                                          CURRENCY   = P_CURR
                                          PLANETYPE  = P_PT
                                          SEATSMAX   = P_SM
                                          SEATSOCC   = P_SS
                                          PAYMENTSUM = P_PS
                                          SEATSMAX_B = P_SMB
                                          SEATSOCC_B = P_SSB
                                          SEATSMAX_F = P_SMF
                                          SEATSOCC_F = P_SSF
                                        )
                             ).
        ELSE.
          UPDATE ZY052T FROM @( VALUE #( CARRID      = P_CARRID
                                          CONNID     = P_CONNID
                                          FLDATE     = P_FLDATE
                                          PRICE      = P_PRICE
                                          CURRENCY   = P_CURR
                                          PLANETYPE  = P_PT
                                          SEATSMAX   = P_SM
                                          SEATSOCC   = P_SS
                                          PAYMENTSUM = P_PS
                                          SEATSMAX_B = P_SMB
                                          SEATSOCC_B = P_SSB
                                          SEATSMAX_F = P_SMF
                                          SEATSOCC_F = P_SSF
                                        )
                             ).
        ENDIF.

        IF SY-SUBRC <> 0.
          MESSAGE TEXT-E04 TYPE 'E'.
          RETURN.
        ENDIF.
      ENDIF.

      LV_O_TXT = COND STRING( WHEN LV_CREATE = ABAP_TRUE THEN TEXT-020 ELSE TEXT-021 ).
    ENDIF.

    IF RB_DEL = ABAP_TRUE.
      PERFORM POPUP_CONFIRM USING TEXT-019 CHANGING LV_ANS.

      IF LV_ANS = '2' OR LV_ANS = 'A'.
        LEAVE LIST-PROCESSING.
      ENDIF.

      IF LV_ANS = '1'.
        DELETE ZY052T FROM @( VALUE #( CARRID = P_CARRID CONNID = P_CONNID FLDATE = P_FLDATE ) ).

        IF SY-SUBRC <> 0.
          MESSAGE TEXT-023 TYPE 'E'.
          RETURN.
        ENDIF.

        LV_O_TXT = TEXT-022.
      ENDIF.
    ENDIF.

    MESSAGE |{ LV_O_TXT } process is successful| TYPE 'S'.
    WRITE: / |{ LV_O_TXT } process is successful|,
         / TEXT-004, P_CARRID,
         / TEXT-005, P_CONNID,
         / TEXT-006, P_FLDATE.
  ENDIF.


*&---------------------------------------------------------------------*
*& FORM POPUP_CONFIRM
*&---------------------------------------------------------------------*
FORM POPUP_CONFIRM  USING    UV_POPUP_TEXT TYPE STRING
                    CHANGING CV_ANS TYPE C1.
  CALL FUNCTION 'POPUP_TO_CONFIRM'
    EXPORTING
      TITLEBAR              = 'CONFIRM'
      TEXT_QUESTION         = UV_POPUP_TEXT
      TEXT_BUTTON_1         = 'YES'
      TEXT_BUTTON_2         = 'NO'
      DEFAULT_BUTTON        = '1'
      DISPLAY_CANCEL_BUTTON = 'X'
      START_COLUMN          = 25
      START_ROW             = 6
    IMPORTING
      ANSWER                = CV_ANS
    EXCEPTIONS
      TEXT_NOT_FOUND        = 1
      OTHERS                = 2.

  IF SY-SUBRC <> 0.
    MESSAGE TEXT-E05 TYPE 'E'.
    RETURN.
  ENDIF.
ENDFORM.
