*&---------------------------------------------------------------------*
*& Report ZSYRO1110_T16_GNV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsyro1110_t16_gnv.

INCLUDE zsyro1110_t16_gnv_top.

INCLUDE zsyro1110_t16_gnv_f01.

START-OF-SELECTION.

PERFORM validate_carrid(zsyro1110_t16_gnv)
    USING p_carrid.

*PERFORM get_sflight_data(zsyro1110_t16_gnv)
*  USING p_carrid
*  CHANGING gt_sflight_data.

PERFORM get_sflight_data_fm(zsyro1110_t16_gnv)
  CHANGING gt_sflight_data.

*PERFORM prepair_sflight_display_data(zsyro1110_t16_gnv)
*  CHANGING gt_sflight_data.


PERFORM display_sflight_data(zsyro1110_t16_gnv)
  USING gt_sflight_data.

PERFORM display_grouped_prices(zsyro1110_t16_gnv)
  USING gt_sflight_data.
