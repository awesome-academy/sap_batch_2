*&---------------------------------------------------------------------*
*& Report ZSYRO1110_T7_GNV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSYRO1110_T7_GNV.

DATA: lv_str1         TYPE string VALUE 'System Applications and Products',
      lv_str2         TYPE string VALUE 'in',
      lv_str3         TYPE string VALUE 'Data Processing',
      lv_result       TYPE string,
      lv_length       TYPE i,
      lv_index        TYPE i,
      lt_split_result TYPE TABLE OF string WITH EMPTY KEY.

" Task 1: CONCATENATE without spaces
CONCATENATE lv_str1 lv_str2 lv_str3 INTO lv_result.
WRITE: / 'Task 7.1:', lv_result.

" Task 2: CONCATENATE with space
CONCATENATE lv_str1 lv_str2 lv_str3 INTO lv_result SEPARATED BY space.
WRITE: / 'Task 7.2:', lv_result.

" Task 3: STRLEN for Task 2 result
lv_length = strlen( lv_result ).
WRITE: / 'Task 7.3: Length of concatenated string with spaces:', lv_length.

" Task 4: CONDENSE with gaps for Task 2 result
CONDENSE lv_result.
WRITE: / 'Task 7.4: Condensed with gaps:', lv_result.

" Task 5: CONDENSE without gaps for Task 2 result
CONDENSE lv_result NO-GAPS.
WRITE: / 'Task 7.5: Condensed without gaps:', lv_result.

" Task 6: SEARCH for keyword 'SAP' in Task 2 result
SEARCH lv_result FOR 'SAP'.
IF sy-subrc = 0.
  WRITE: / 'Task 7.6: Keyword "SAP" found at position:', sy-fdpos.
ELSE.
  WRITE: / 'Task 7.6: Keyword "SAP" not found.'.
ENDIF.

" Task 7: SPLIT to get 'Products'
CLEAR: lv_result.
SPLIT lv_str1 AT space INTO TABLE lt_split_result.
READ TABLE lt_split_result INTO lv_result INDEX 4. " 4th word is 'Products'
WRITE: / 'Task 7.7: Extracted string:', lv_result.

" Task 8: Substring to get 'Application'
CLEAR: lv_result.
FIND 'Applications' IN lv_str1 MATCH OFFSET lv_index.
IF sy-subrc = 0.
  lv_result = lv_str1+lv_index(11). " Extracting substring from the offset
  WRITE: / 'Task 7.8: Substring result:', lv_result.
ELSE.
  WRITE: / 'Task 7.8: Substring not found.'.
ENDIF.