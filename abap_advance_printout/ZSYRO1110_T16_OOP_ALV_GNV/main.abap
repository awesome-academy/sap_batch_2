*&---------------------------------------------------------------------*
*& Report ZSYRO1110_T16_OOP_GNV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSYRO1110_T16_OOP_ALV_GNV.

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
             display_sflight_full_data,
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
           ( seatsmax - seatsocc ) AS vacseats,          " Calculate vacseats
           ( seatsmax_b - seatsocc_b ) AS vacseats_b,    " Calculate vacseats_b
           ( seatsmax_f - seatsocc_f ) AS vacseats_f,    " Calculate vacseats_f
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
  DATA: lo_alv       TYPE REF TO cl_salv_table,
        lx_msg       TYPE REF TO cx_salv_msg,
        lt_sflight   TYPE tt_sflight,
*        lo_columns   TYPE REF TO cl_salv_columns_table,
        lo_column    TYPE REF TO cl_salv_column_table.

  " Copy data to local table
  lt_sflight = mt_sflight.

  " Try to create ALV
  TRY.
      cl_salv_table=>factory(
        IMPORTING
          r_salv_table = lo_alv
        CHANGING
          t_table      = lt_sflight
      ).

      " Get the columns object
       DATA(lt_columns) = lo_alv->get_columns( )->get( ).

       LOOP AT lt_columns INTO DATA(ls_column).
         lo_column ?= ls_column-r_column.
        CASE lo_column->get_columnname( ).
          WHEN 'CARRID' OR 'CARRNAME' OR 'CONNID' OR 'FLDATE' OR 'VACSEATS' OR 'VACSEATS_B' OR 'VACSEATS_F'.
            " Keep these columns visible (already set above)
          WHEN OTHERS.
            " Hide other columns
            lo_column->set_visible( value = abap_false ).
        ENDCASE.
      ENDLOOP.

      " Optimize column width
      lo_alv->get_columns( )->set_optimize( abap_true ).

      " Set ALV display settings
      lo_alv->get_display_settings( )->set_list_header( 'Flight Data' ). " Set header

      " Display ALV
      lo_alv->display( ).

    CATCH cx_salv_msg INTO lx_msg.
      MESSAGE lx_msg->get_text( ) TYPE 'E'.
  ENDTRY.
ENDMETHOD.


METHOD display_sflight_full_data.
  DATA: lo_alv       TYPE REF TO cl_salv_table,
        lx_msg       TYPE REF TO cx_salv_msg,
        lt_sflight   TYPE tt_sflight.

  " Copy data to local table
  lt_sflight = mt_sflight.

  " Try to create ALV
  TRY.
      cl_salv_table=>factory(
        IMPORTING
          r_salv_table = lo_alv
        CHANGING
          t_table      = lt_sflight
      ).

      " Set ALV display settings
      lo_alv->get_columns( )->set_optimize( abap_true ). " Optimize column width
      lo_alv->get_display_settings( )->set_list_header( 'Flight Data' ). " Set header

      " Display ALV
      lo_alv->display( ).

    CATCH cx_salv_msg INTO lx_msg.
      MESSAGE lx_msg->get_text( ) TYPE 'E'.
  ENDTRY.
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
*  go_flight_data->display_grouped_prices( ).
