*&---------------------------------------------------------------------*
*& Report zsyro1110_t4_prnt_out_gnv
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsyro1110_t4_prnt_out_gnv.

INCLUDE ZSYRO1110_T4_PRNT_OUT_GNV_TOP.
INCLUDE ZSYRO1110_T4_PRNT_OUT_GNV_F01.

START-OF-SELECTION.

  PERFORM validate_carrid(zsyro1110_t4_prnt_out_gnv)
      USING p_carrid.

  PERFORM get_sflight_data_fm(zsyro1110_t4_prnt_out_gnv)
    CHANGING gt_sflight_data.

*  PERFORM prepair_sflight_display_data(zsyro1110_t4_prnt_out_gnv)
*    CHANGING gt_sflight_data.

  PERFORM display_sflight_data_alv USING gt_sflight_data.
