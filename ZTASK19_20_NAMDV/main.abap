*&---------------------------------------------------------------------*
*& Report ZSYR1570_NAMDV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSYR1570_NAMDV.

InCLUDE ZSYR1570_NAMDV_TOP.
INCLUDE ZSYR1570_NAMDV_F01.

START-OF-SELECTION.
  PERFORM BUILD_CARR_DATA.
  PERFORM BUILD_FLIGHT_DATA.
  PERFORM BUILD_BOOK_FLIGHT_DATA.