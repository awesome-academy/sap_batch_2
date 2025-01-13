*&---------------------------------------------------------------------*
*& Include          ZSYRO1110_T2_PRNT_OUT_GNV_TOP
*&---------------------------------------------------------------------*

TABLES: zyscarr1t.

DATA: gt_scarr TYPE TABLE OF zyscarr1t,
      gs_scarr TYPE zyscarr1t.

DATA: gt_fieldcat TYPE slis_t_fieldcat_alv,
      gs_fieldcat TYPE slis_fieldcat_alv,
      gs_layout   TYPE slis_layout_alv.
