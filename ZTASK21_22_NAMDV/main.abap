*&---------------------------------------------------------------------*
*& Report ZSYR1580_NAMDV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSYR1580_NAMDV.

INCLUDE ZSYR1580_NAMDV_TOP.
INCLUDE ZSYR1580_NAMDV_F01.

START-OF-SELECTION.
 PERFORM GET_SFLIGHT_DATA.
 PERFORM DISPLAY_SFLIGHT_DATA.
 PERFORM DISPLAY_PRICES_WHEN_GROUP_BY.