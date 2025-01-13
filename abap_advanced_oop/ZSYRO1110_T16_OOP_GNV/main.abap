*&---------------------------------------------------------------------*
*& Report ZSYRO1110_T16_OOP_GNV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSYRO1110_T16_OOP_GNV.

TABLES: zysflight1t.

* Local Class Definition
CLASS zcl_flight_data DEFINITION.
  PUBLIC SECTION.
    TYPES: tt_sflight TYPE ztt_sflight1t_gnv.

    METHODS: constructor IMPORTING iv_carrid TYPE zysflight1t-carrid
                                   it_connid TYPE ztt_connid_range_gnv,
             validate_carrid,
             get_sfli_data,
             get_sfli_data_fm,
             display_sflight_data,
             display_grouped_prices.

  PRIVATE SECTION.
    DATA: mv_carrid     TYPE zysflight1t-carrid,
          mt_connid     TYPE ztt_connid_range_gnv,
          mt_sflight    TYPE tt_sflight.
ENDCLASS.

* Local Class Implementation
CLASS zcl_flight_data IMPLEMENTATION.
  METHOD constructor.
    mv_carrid = iv_carrid.
    mt_connid = it_connid.
  ENDMETHOD.

  METHOD validate_carrid.
    SELECT SINGLE carrid INTO @DATA(lv_carrid)
      FROM zysflight1t
      WHERE carrid = @mv_carrid.
    IF sy-subrc <> 0.
      MESSAGE 'Airline Code does not exist.' TYPE 'E'.
    ENDIF.
  ENDMETHOD.

  METHOD get_sfli_data.
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
      INTO CORRESPONDING FIELDS OF TABLE @mt_sflight
      WHERE sfli~carrid = @mv_carrid AND sfli~connid IN @mt_connid.
    IF sy-subrc <> 0.
      MESSAGE 'No data found for the given criteria.' TYPE 'E'.
    ENDIF.
  ENDMETHOD.

  METHOD get_sfli_data_fm.
    CALL FUNCTION 'ZFM_T16_GET_SFLIGHT_GNV'
      EXPORTING
        pv_carrid = mv_carrid
        it_connid = mt_connid
      IMPORTING
        et_sflight = mt_sflight
      EXCEPTIONS
        no_data_found = 1
        OTHERS        = 2.
    IF sy-subrc <> 0.
      MESSAGE 'No data found for the given criteria.' TYPE 'E'.
    ENDIF.
  ENDMETHOD.

  METHOD display_sflight_data.
    DATA: lv_vacant_seats_economy TYPE i,
          lv_vacant_seats_business TYPE i,
          lv_vacant_seats_first TYPE i.

    WRITE: / 'Airline Code', 12 'Airline Name', 30 'Flight No.', 45 'Flight Date', 80 'Price',
             100 'Vacant Seat (Economy)', 115 'Vacant Seat (Business)', 130 'Vacant Seat (First)'.
    WRITE: / sy-uline.

    LOOP AT mt_sflight INTO DATA(ls_sflight).
      lv_vacant_seats_economy = ls_sflight-seatsmax - ls_sflight-seatsocc.
      lv_vacant_seats_business = ls_sflight-seatsmax_b - ls_sflight-seatsocc_b.
      lv_vacant_seats_first = ls_sflight-seatsmax_f - ls_sflight-seatsocc_f.

      WRITE: / ls_sflight-carrid,
               12 ls_sflight-carrname,
               30 ls_sflight-connid,
               45 ls_sflight-fldate,
               80 ls_sflight-price CURRENCY ls_sflight-currency,
               100 lv_vacant_seats_economy,
               115 lv_vacant_seats_business,
               130 lv_vacant_seats_first.
    ENDLOOP.
  ENDMETHOD.

  METHOD display_grouped_prices.
    DATA: lv_sum_price TYPE zysflight1t-price,
          lv_currency  TYPE zysflight1t-currency.

    WRITE: / 'Airline Code', 12 'Flight Number', 30 'Total Price'.
    WRITE: / sy-uline.

    LOOP AT mt_sflight INTO DATA(ls_sflight)
      GROUP BY ( carrid = ls_sflight-carrid connid = ls_sflight-connid )
      ASCENDING
      ASSIGNING FIELD-SYMBOL(<group>).

      lv_sum_price = 0.
      lv_currency = ls_sflight-currency.

      LOOP AT GROUP <group> INTO DATA(ls_group).
        lv_sum_price = lv_sum_price + ls_group-price.
      ENDLOOP.

      WRITE: / <group>-carrid,
               12 <group>-connid,
               30 lv_sum_price CURRENCY lv_currency.
    ENDLOOP.

    WRITE: / sy-uline.
  ENDMETHOD.
ENDCLASS.

* Main Program Logic
DATA: go_flight_data TYPE REF TO zcl_flight_data.

PARAMETERS: p_carrid TYPE zysflight1t-carrid OBLIGATORY.
SELECT-OPTIONS: s_connid FOR zysflight1t-connid.

START-OF-SELECTION.
  CREATE OBJECT go_flight_data
    EXPORTING
      iv_carrid = p_carrid
      it_connid = s_connid[]. " Truyền SELECT-OPTIONS vào class

  go_flight_data->validate_carrid( ).
  go_flight_data->get_sfli_data_fm( ).
  go_flight_data->display_sflight_data( ).
  go_flight_data->display_grouped_prices( ).
