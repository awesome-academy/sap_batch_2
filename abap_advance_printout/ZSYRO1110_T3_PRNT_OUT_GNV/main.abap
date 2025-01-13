*&---------------------------------------------------------------------*
*& Report zsyro1110_t3_prnt_out_gnv
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsyro1110_t3_prnt_out_gnv.

INCLUDE zsyro1110_t3_prnt_out_gnv_top.

INCLUDE zsyro1110_t3_prnt_out_gnv_f01.


START-OF-SELECTION.

  PERFORM validate_carrid(zsyro1110_t3_prnt_out_gnv)
      USING p_carrid.

  PERFORM get_sflight_data_fm(zsyro1110_t3_prnt_out_gnv)
    CHANGING gt_sflight_data.

*PERFORM get_sflight_data_fm(zsyro1110_t3_prnt_out_gnv)
*  CHANGING gt_sflight_data.

  PERFORM prepair_sflight_display_data(zsyro1110_t3_prnt_out_gnv)
    CHANGING gt_sflight_data.

  PERFORM display_xlsx_workbench(zsyro1110_t3_prnt_out_gnv)
    USING gt_sflight_data.
