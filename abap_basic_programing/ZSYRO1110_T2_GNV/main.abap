*&---------------------------------------------------------------------*
*& Report ZSYRO1110_T2_GNV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSYRO1110_T2_GNV.

* Selection screen fields
PARAMETERS:
  p_num01 TYPE n LENGTH 2 OBLIGATORY, " Num. 1, 2 digits, required
  p_num02 TYPE n LENGTH 2 OBLIGATORY. " Num. 2, 2 digits, required

DATA:
  lv_comparison TYPE string, " For comparison result
  lv_result     TYPE p LENGTH 10. " For calculation result

START-OF-SELECTION.

  " Step 1: Compare values and determine comparison result
  IF p_num01 > p_num02.
    lv_comparison = |P_NUM01 > P_NUM02|.
  ELSEIF p_num01 < p_num02.
    lv_comparison = |P_NUM01 < P_NUM02|.
  ELSE.
    lv_comparison = |P_NUM01 = P_NUM02|.
  ENDIF.

  " Step 2: Perform calculation
  lv_result = p_num02 * ( p_num01 + ( p_num01 * p_num02 ) ).

  " Display results
  WRITE: / lv_comparison,
         / lv_result.
