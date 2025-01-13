*&---------------------------------------------------------------------*
*& Report ZSYRO1110_T2_PRNT_OUT_GNV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsyro1110_t2_prnt_out_gnv.

* Include for ALV update functionality
INCLUDE zsyro1110_t2_prnt_out_gnv_top.
INCLUDE zsyro1110_t2_prnt_out_gnv_f01.

* Start of Selection
START-OF-SELECTION.
  PERFORM fetch_data.
  PERFORM build_field_catalog.
  PERFORM display_alv.
