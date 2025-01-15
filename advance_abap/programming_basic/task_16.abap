*&---------------------------------------------------------------------*
*& Report ZSYR8414
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsyr8414.

TABLES sflight.

*--------------------------------Declare--------------------------------
CONSTANTS: lc_error TYPE c VALUE 'E'.
DATA: lt_sflight         TYPE TABLE OF sflight,
      ls_sflight         TYPE sflight,
      lt_scarr           TYPE TABLE OF scarr,
      ls_scarr           TYPE scarr,
      lv_total_price     TYPE sflight-price,
      lv_vacant_economy  TYPE i,
      lv_vacant_business TYPE i,
      lv_vacant_first    TYPE i.

*--------------------------------Selection Screen--------------------------------
PARAMETERS: p_carrid TYPE sflight-carrid OBLIGATORY. " Airline Code (bắt buộc)
SELECT-OPTIONS: s_connid FOR sflight-connid NO INTERVALS. " Connection ID (không bắt buộc)

* Kiểm tra mã hãng hàng không
AT SELECTION-SCREEN ON p_carrid.
  PERFORM check_airline_code.

* Chương trình chính
START-OF-SELECTION.
  PERFORM display_selected_data.
  PERFORM extract_flight_data.

*&---------------------------------------------------------------------*
*&      Form  CHECK_AIRLINE_CODE
*&---------------------------------------------------------------------*
FORM check_airline_code.
  DATA: lv_carrid TYPE scarr-carrid.

  SELECT SINGLE carrid INTO lv_carrid
  FROM scarr
  WHERE carrid = p_carrid.

  IF sy-subrc <> 0.
    MESSAGE TEXT-001 TYPE lc_error.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  DISPLAY_SELECTED_DATA
*&---------------------------------------------------------------------*
FORM display_selected_data.
  DATA: lt_sflight TYPE TABLE OF sflight,
        ls_sflight TYPE sflight.

  SELECT * INTO TABLE lt_sflight
  FROM sflight
  WHERE carrid = p_carrid
    AND connid IN s_connid.

  IF lt_sflight IS NOT INITIAL.
    LOOP AT lt_sflight INTO ls_sflight.
      WRITE: / 'Airline Code:', ls_sflight-carrid,
             'Connection ID:', ls_sflight-connid,
             'Flight Date:', ls_sflight-fldate,
             'Price:', ls_sflight-price,
             'Currency:', ls_sflight-currency.
    ENDLOOP.
  ELSE.
    WRITE: / 'No data found for the selected criteria.'.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  EXTRACT_FLIGHT_DATA
*&---------------------------------------------------------------------*
FORM extract_flight_data.
  DATA: lt_sflight         TYPE TABLE OF sflight,
        ls_sflight         TYPE sflight,
        lt_scarr           TYPE TABLE OF scarr,
        ls_scarr           TYPE scarr,
        lv_total_price     TYPE sflight-price,
        lv_vacant_economy  TYPE i,
        lv_vacant_business TYPE i,
        lv_vacant_first    TYPE i.

  SELECT *
  INTO TABLE @lt_sflight
  FROM sflight
  WHERE carrid = @p_carrid
    AND connid IN @s_connid
    ORDER BY carrid, connid.

  IF lt_sflight IS INITIAL.
    MESSAGE TEXT-002 TYPE lc_error.
  ELSE.
    SELECT carrid, carrname
    INTO TABLE @lt_scarr
    FROM scarr
    WHERE carrid = @p_carrid.

    FORMAT COLOR COL_HEADING.
    WRITE: /3 'Airline Code',
           20 'Airline Name',
           40 'Flight No',
           55 'Flight Date',
           70 'Price',
           85 'Vacant Eco',
           100 'Vacant Bus',
           115 'Vacant First'.
    FORMAT COLOR OFF.


* Hiển thị dữ liệu chi tiết
    LOOP AT lt_sflight INTO ls_sflight.
      WRITE: /3  ls_sflight-carrid,
             20 ls_scarr-carrname,
             40 ls_sflight-connid,
             55 ls_sflight-fldate,
             70 ls_sflight-price CURRENCY ls_sflight-currency,
             85 ls_sflight-seatsocc,
             100 ls_sflight-seatsocc_b,
             115 ls_sflight-seatsocc_f.
    ENDLOOP.

* Tính tổng theo nhóm
    SKIP 2.
    WRITE: / 'Summary by Airline Code and Flight Number:'.

    LOOP AT lt_sflight INTO ls_sflight.
      AT NEW connid.
        lv_total_price = 0.
      ENDAT.

      lv_total_price = lv_total_price + ls_sflight-price.

      AT END OF connid.
        WRITE: / 'Airline:', ls_sflight-carrid,
               'Flight:', ls_sflight-connid,
               'Total Price:', lv_total_price CURRENCY ls_sflight-currency.
      ENDAT.
    ENDLOOP.
  ENDIF.
ENDFORM.
