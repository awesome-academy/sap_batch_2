*&---------------------------------------------------------------------*
*& Report ZSYRO1110_T1_GNV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsyro1110_t1_gnv.

START-OF-SELECTION.
  ULINE AT 50(50).
  SKIP 1.
  WRITE: 50 |{ TEXT-001 }| COLOR COL_NORMAL,
  /50 TEXT-002, ':', sy-datum COLOR COL_HEADING,
  /50 TEXT-003, ':', sy-uzeit COLOR COL_HEADING,
  /50 TEXT-004, ':', sy-uname COLOR COL_HEADING.
  SKIP 1.
  ULINE AT 50(50).