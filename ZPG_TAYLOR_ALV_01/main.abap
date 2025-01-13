*&---------------------------------------------------------------------*
*& Report ZPG_TAYLOR_ALV_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZPG_TAYLOR_ALV_01 NO STANDARD PAGE HEADING.

INCLUDE zin_taylor_alv_01_top.
INCLUDE zin_taylor_alv_01_f01.

AT SELECTION-SCREEN ON p_carrid.
 PERFORM handle_validate_carrid.

START-OF-SELECTION.
  IF sy-subrc = 0.
    PERFORM handle_select_data.
  ENDIF.
