*&---------------------------------------------------------------------*
*& Include          ZIN_TAYLOR_ALV_01_TOP
*&---------------------------------------------------------------------*

TABLES: zy225t, zy226t.

TYPES: BEGIN OF ty_flight.
         INCLUDE STRUCTURE: zst_tay_sflight_22.
TYPES:  vacant_economy TYPE i,
        vacant_business TYPE i,
        vacant_first    TYPE i,
      END OF ty_flight.

TYPES: ty_sflight TYPE TABLE OF ty_flight.

DATA: gt_flights TYPE ty_sflight,
      go_alv     TYPE REF TO cl_salv_table,
      go_columns TYPE REF TO cl_salv_columns_table,
      go_layout  TYPE REF TO cl_salv_display_settings.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_carrid TYPE zy225t-carrid OBLIGATORY.
SELECT-OPTIONS s_connid FOR zy225t-connid.
SELECTION-SCREEN END OF BLOCK b1.
