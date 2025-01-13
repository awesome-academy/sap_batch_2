*&---------------------------------------------------------------------*
*& Report ZSYRO1110_T10_GNV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSYRO1110_T10_GNV.


DATA: lv_index TYPE i VALUE 0.  "Changed to start from 0

START-OF-SELECTION.
  WRITE: / 'Alphabet from A to Z:'.
  SKIP.

  WHILE lv_index < 26.  "Changed to < instead of <=
    WRITE: / sy-abcde+lv_index(1).
    lv_index = lv_index + 1.
  ENDWHILE.
