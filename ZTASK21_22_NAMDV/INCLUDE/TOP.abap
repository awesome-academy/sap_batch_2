*&---------------------------------------------------------------------*
*& Include          ZSYR1580_NAMDV_TOP
*&---------------------------------------------------------------------*
TABLES ZY052T.

TYPES: GTT_FLIGHT TYPE TABLE OF ZST_SFLIGHT_NAMDV.

DATA: GT_SFLIGHT_DATA TYPE TABLE OF ZST_SFLIGHT_NAMDV,
      GV_CARRNAME     TYPE ZY050T-CARRNAME.

PARAMETERS: P_CARRID TYPE ZY052T-CARRID OBLIGATORY.
SELECT-OPTIONS: S_CONNID FOR ZY052T-CONNID.