*&---------------------------------------------------------------------*
*& Include          ZSYRO1110_T16_GNV_TOP
*&---------------------------------------------------------------------*

TABLES: zysflight1t.

TYPES: gtt_sflight TYPE TABLE OF zst_sflight1t_gnv.

DATA: gt_sflight_data TYPE TABLE OF zst_sflight1t_gnv, " Internal table to store extracted data
      gv_carrname     TYPE zyscarr1t-carrname. " Airline name

PARAMETERS: p_carrid TYPE zysflight1t-carrid OBLIGATORY.
SELECT-OPTIONS: s_connid FOR zysflight1t-connid.