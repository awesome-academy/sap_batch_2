*&---------------------------------------------------------------------*
*& Include          ZSYRO1110_T16_GNV_F01
*&---------------------------------------------------------------------*

FORM validate_carrid USING VALUE(p_carrid) TYPE zysflight1t-carrid.

  " Check if the Airline Code exists in the Airline table
  SELECT SINGLE carrid
    INTO @DATA(lv_carrid)
    FROM zysflight1t
    WHERE carrid = @p_carrid.

  IF sy-subrc <> 0. " Airline code not found
    MESSAGE TEXT-e01 TYPE 'E'. " Airline Code is not exists. Please input again.
    LEAVE TO SCREEN 0.
  ENDIF.
ENDFORM.


FORM get_sflight_data CHANGING ct_sflight TYPE gtt_sflight.

  SELECT sfli~carrid,
       connid,
       fldate,
       price,
       currency,
       seatsmax,
       seatsocc,
       seatsmax_b,
       seatsocc_b,
       seatsmax_f,
       seatsocc_f,
       scar~carrname
  FROM zysflight1t AS sfli
  JOIN zyscarr1t AS scar
  ON scar~carrid = sfli~carrid
  WHERE sfli~carrid = @p_carrid AND sfli~connid IN @s_connid
  INTO CORRESPONDING FIELDS OF TABLE @ct_sflight.

  IF sy-subrc <> 0. " Airline code not found
    MESSAGE TEXT-e02 TYPE 'E'. " Airline code not found.
    LEAVE TO SCREEN 0.
  ENDIF.
ENDFORM.


FORM get_sflight_data_fm CHANGING ct_sflight TYPE gtt_sflight.

  CALL FUNCTION 'ZFM_T16_GET_SFLIGHT_GNV'
    EXPORTING
      pv_carrid     = p_carrid
      it_connid     = s_connid[]
    IMPORTING
      et_sflight    = ct_sflight
    EXCEPTIONS
      no_data_found = 1
      OTHERS        = 2.
  IF sy-subrc <> 0.
    MESSAGE TEXT-e02 TYPE 'E'. " Airline code not found.
    LEAVE TO SCREEN 0.
  ENDIF.

ENDFORM.


FORM prepair_sflight_display_data CHANGING it_sflight TYPE gtt_sflight.
  DATA: lv_price TYPE BAPICURR-BAPICURR.
  LOOP AT it_sflight ASSIGNING FIELD-SYMBOL(<fs_sflight>).
    <fs_sflight>-vacseats = <fs_sflight>-seatsmax - <fs_sflight>-seatsocc.
    <fs_sflight>-vacseats_b = <fs_sflight>-seatsmax_b - <fs_sflight>-seatsocc_b.
    <fs_sflight>-vacseats_f = <fs_sflight>-seatsmax_f - <fs_sflight>-seatsocc_f.

    CALL FUNCTION 'BAPI_CURRENCY_CONV_TO_EXTERNAL'
      EXPORTING
        currency              = <fs_sflight>-currency
        amount_internal       = <fs_sflight>-price
     IMPORTING
       AMOUNT_EXTERNAL       = lv_price
              .
    <fs_sflight>-price = lv_price.
  ENDLOOP.
ENDFORM.



FORM display_sflight_data USING it_sflight TYPE gtt_sflight.
  " Display header
  WRITE: / 'Airline Code', 12 'Airline Name', 30 'Flight No.', 45 'Flight Date', 60 'Price',
           70 'Vacant Seat (Economy)', 90 'Vacant Seat (Business)', 110 'Vacant Seat (First)'.
  WRITE: / sy-uline.

*  LOOP AT it_sflight INTO DATA(ls_sflight).
  LOOP AT it_sflight INTO DATA(ls_sflight).
    " Display data row
    WRITE: / ls_sflight-carrid,
             12 ls_sflight-carrname,
             30 ls_sflight-connid,
             45 ls_sflight-fldate,
             60 ls_sflight-price CURRENCY ls_sflight-currency,
             70 ls_sflight-vacseats,
             90 ls_sflight-vacseats_b,
             110 ls_sflight-vacseats_f.
  ENDLOOP.
ENDFORM.


FORM display_grouped_prices USING it_sflight TYPE gtt_sflight.

  " Temporary variables for grouping and calculations
  DATA: lv_sum_price TYPE zysflight1t-price,
        lv_currency  TYPE zysflight1t-currency.

  " Display header
  WRITE: / 'Airline Code', 12 'Flight Number', 30 'Total Price'.
  WRITE: / sy-uline.

  " Group by Airline Code (CARRID) and Flight Number (CONNID)
  LOOP AT it_sflight INTO DATA(ls_sflight)
    GROUP BY ( carrid = ls_sflight-carrid connid = ls_sflight-connid )
    ASCENDING
    ASSIGNING FIELD-SYMBOL(<group>).

    " Initialize sum for each group
    lv_sum_price = 0.
    lv_currency = ls_sflight-currency.

    " Calculate the sum of PRICE for the group
    LOOP AT GROUP <group> INTO DATA(ls_group).
      lv_sum_price = lv_sum_price + ls_group-price.
    ENDLOOP.

    " Display the grouped result
    WRITE: / <group>-carrid,
             12 <group>-connid,
             30 lv_sum_price CURRENCY lv_currency.
  ENDLOOP.

  " Display footer
  WRITE: / sy-uline.

ENDFORM.

FORM display_xlsx_workbench USING VALUE(it_sflight) TYPE gtt_sflight.
  CALL FUNCTION 'ZFM_XLWB_CALLFORM'
    EXPORTING
      iv_formname    = 'ZT_FLIGHT_DATA_GNV'
      iv_context_ref = it_sflight
*     IV_VIEWER_TITLE               = SY-TITLE
*     IV_VIEWER_INPLACE             = 'X'
*     IV_VIEWER_CALLBACK_PROG       = SY-CPROG
*     IV_VIEWER_CALLBACK_FORM       =
*     IV_VIEWER_SUPPRESS            =
*     IV_PROTECT     =
*     IV_SAVE_AS     =
*     IV_SAVE_AS_APPSERVER          =
*     IV_STARTUP_MACRO              =
*     IT_DOCPROPERTIES              =
*     IV_OPENFILE    = 'X'
*   IMPORTING
*     EV_DOCUMENT_RAWDATA           =
*     EV_DOCUMENT_EXTENSION         =
*   EXCEPTIONS
*     PROCESS_TERMINATED            = 1
*     OTHERS         = 2
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.