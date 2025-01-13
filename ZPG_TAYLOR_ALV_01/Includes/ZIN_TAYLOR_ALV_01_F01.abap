*&---------------------------------------------------------------------*
*& Include          ZIN_TAYLOR_ALV_01_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form HANDLE_VALIDATE_CARRID
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
FORM handle_validate_carrid .
  SELECT SINGLE *
    FROM zy225t
    WHERE carrid = @p_carrid
    INTO @DATA(lv_carrid).

  IF sy-subrc <> 0.  " Nếu không tìm thấy
    MESSAGE TEXT-002 TYPE 'E'.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form HANDLE_SELECT_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
FORM handle_select_data .
  SELECT sflight~carrid,
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
  FROM zy225t AS sflight
  INNER JOIN zy226t AS scarr ON sflight~carrid = scarr~carrid
  WHERE sflight~carrid = @p_carrid
  AND   sflight~connid IN @s_connid
  INTO CORRESPONDING FIELDS OF TABLE @gt_flights.

  IF sy-subrc <> 0.
    MESSAGE ID 'ZYINC2' TYPE 'E' NUMBER 002.

    RETURN.
  ENDIF.

  LOOP AT gt_flights ASSIGNING FIELD-SYMBOL(<ls_flight>).
    <ls_flight>-vacant_economy = <ls_flight>-seatsmax - <ls_flight>-seatsocc.
    <ls_flight>-vacant_business = <ls_flight>-seatsmax_b - <ls_flight>-seatsocc_b.
    <ls_flight>-vacant_first = <ls_flight>-seatsmax_f - <ls_flight>-seatsocc_f.
  ENDLOOP.

  PERFORM display_alv.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
FORM display_alv .
  TRY .
      cl_salv_table=>factory(
          IMPORTING
            r_salv_table = go_alv
          CHANGING
            t_table      = gt_flights ).

      " Lấy đối tượng display settings
      go_layout = go_alv->get_display_settings( ).
      go_layout->set_striped_pattern( abap_true ).

      PERFORM prepare_alv.

      go_alv->display( ).
    CATCH cx_salv_msg INTO DATA(lx_msg).
      MESSAGE lx_msg->get_text( ) TYPE 'E'.
  ENDTRY.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form PREPARE_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
FORM prepare_alv .
  DATA: lo_column          TYPE REF TO cl_salv_column_table,
        lt_columns_to_hide TYPE TABLE OF string. " Khai báo biến lv_text bên ngoài

  " Lấy danh sách các cột
  go_columns = go_alv->get_columns( ).
  go_columns->set_optimize( abap_true ).

  DATA(lt_columns) = go_columns->get( ).

  LOOP AT lt_columns INTO DATA(ls_column).
    lo_column ?= ls_column-r_column. " Chuyển đổi sang kiểu CL_SALV_COLUMN_TABLE

    " Ẩn các cột cụ thể
    CASE lo_column->get_columnname( ).
      WHEN 'MANDT' OR 'CURRENCY' OR 'SEATSMAX' OR 'SEATSOCC' OR 'SEATSMAX_B' OR 'SEATSOCC_B' OR 'SEATSMAX_F' OR 'SEATSOCC_F'.
        lo_column->set_visible( abap_false ).
    ENDCASE.

    " Đổi tên các cột cụ thể
    CASE lo_column->get_columnname( ).
      WHEN 'CARRID'.
        lo_column->set_short_text( CONV scrtext_s( 'Airline Code' ) ).
        lo_column->set_medium_text( CONV scrtext_m( 'Airline Code' ) ).
        lo_column->set_long_text( CONV scrtext_l( 'Airline Code' ) ).
      WHEN 'CARRNAME'.
        lo_column->set_short_text( CONV scrtext_s( 'Airline Name' ) ).
        lo_column->set_medium_text( CONV scrtext_m( 'Airline Name' ) ).
        lo_column->set_long_text( CONV scrtext_l( 'Airline Name' ) ).
      WHEN 'CONNID'.
        lo_column->set_short_text( CONV scrtext_s( 'Flight Number' ) ).
        lo_column->set_medium_text( CONV scrtext_m( 'Flight Number' ) ).
        lo_column->set_long_text( CONV scrtext_l( 'Flight Number' ) ).
      WHEN 'FLDATE'.
        lo_column->set_short_text( CONV scrtext_s( 'Flight Date' ) ).
        lo_column->set_medium_text( CONV scrtext_m( 'Flight Date' ) ).
        lo_column->set_long_text( CONV scrtext_l( 'Flight Date' ) ).
      WHEN 'PRICE'.
        lo_column->set_short_text( CONV scrtext_s( 'Price' ) ).
        lo_column->set_medium_text( CONV scrtext_m( 'Price' ) ).
        lo_column->set_long_text( CONV scrtext_l( 'Price' ) ).
        lo_column->set_currency_column( 'CURRENCY' ).
      WHEN 'VACANT_ECONOMY'.
        lo_column->set_short_text( CONV scrtext_s( 'Vacant Seat (Economy)' ) ).
        lo_column->set_medium_text( CONV scrtext_m( 'Vacant Seat (Economy)' ) ).
        lo_column->set_long_text( CONV scrtext_l( 'Vacant Seat (Economy)' ) ).
      WHEN 'VACANT_BUSINESS'.
        lo_column->set_short_text( CONV scrtext_s( 'Vacant Seat (Business)' ) ).
        lo_column->set_medium_text( CONV scrtext_m( 'Vacant Seat (Business)' ) ).
        lo_column->set_long_text( CONV scrtext_l( 'Vacant Seat (Business)' ) ).
      WHEN 'VACANT_FIRST'.
        lo_column->set_short_text( CONV scrtext_s( 'Vacant Seat (First)' ) ).
        lo_column->set_medium_text( CONV scrtext_m( 'Vacant Seat (First)' ) ).
        lo_column->set_long_text( CONV scrtext_l( 'Vacant Seat (First)' ) ).
    ENDCASE.
  ENDLOOP.
ENDFORM.
