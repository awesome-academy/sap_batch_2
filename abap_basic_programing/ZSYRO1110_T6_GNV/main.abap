*&---------------------------------------------------------------------*
*& Report ZSYRO1110_T6_GNV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsyro1110_t6_gnv.


"1. Select-options for numeric values with multiplication results
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS s_num1 FOR sy-index DEFAULT 1 TO 10. "Numeric values
SELECTION-SCREEN END OF BLOCK b1.

"2. Select-options for numeric values with comma-separated output
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
SELECT-OPTIONS s_num2 FOR sy-index. "Numeric values
SELECTION-SCREEN END OF BLOCK b2.

"3. Select-options without ranges and zero validation
SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE TEXT-003.
SELECT-OPTIONS s_num3 FOR sy-index NO-EXTENSION NO INTERVALS DEFAULT 1. "No ranges allowed
SELECTION-SCREEN END OF BLOCK b3.

"4. Select-options without multiple ranges and value validation
SELECTION-SCREEN BEGIN OF BLOCK b4 WITH FRAME TITLE TEXT-004.
SELECT-OPTIONS s_num4 FOR sy-index NO-EXTENSION. "No multiple ranges
SELECTION-SCREEN END OF BLOCK b4.

"5. Parameter as listbox for Airline codes
SELECTION-SCREEN BEGIN OF BLOCK b5 WITH FRAME TITLE TEXT-005.
PARAMETERS p_carr TYPE scarr-carrid AS LISTBOX VISIBLE LENGTH 20.
SELECTION-SCREEN END OF BLOCK b5.

"6. Parameters as checkboxes for flight classes
SELECTION-SCREEN BEGIN OF BLOCK b6 WITH FRAME TITLE TEXT-006.
PARAMETERS: p_first1 AS CHECKBOX,
            p_busin1 AS CHECKBOX,
            p_econ1  LIKE p_first1 AS CHECKBOX.
SELECTION-SCREEN END OF BLOCK b6.

"7. Parameters as radio buttons for flight classes
SELECTION-SCREEN BEGIN OF BLOCK b7 WITH FRAME TITLE TEXT-007.
PARAMETERS: p_first2 RADIOBUTTON GROUP g1,
            p_busin2 RADIOBUTTON GROUP g1,
            p_econ2  LIKE p_first2 RADIOBUTTON GROUP g1.
SELECTION-SCREEN END OF BLOCK b7.


* 8. Three checkboxes with initialization logic
SELECTION-SCREEN BEGIN OF BLOCK b8 WITH FRAME TITLE TEXT-008.
PARAMETERS: p_chk81 AS CHECKBOX DEFAULT 'X',
            p_chk82 AS CHECKBOX,
            p_chk83 AS CHECKBOX.
SELECTION-SCREEN END OF BLOCK b8.

* 9. Radio buttons affecting input field
SELECTION-SCREEN BEGIN OF BLOCK b9 WITH FRAME TITLE TEXT-009.
PARAMETERS: p_rad91 RADIOBUTTON GROUP g2 USER-COMMAND action9,
            p_rad92 RADIOBUTTON GROUP g2,
            p_rad93 RADIOBUTTON GROUP g2.
PARAMETERS p_input9 TYPE char10.
SELECTION-SCREEN END OF BLOCK b9.

* 10. Radio buttons controlling input fields visibility
DATA lv_action10 LIKE sy-ucomm.
SELECTION-SCREEN BEGIN OF BLOCK b10 WITH FRAME TITLE TEXT-010.
PARAMETERS: p_r101 RADIOBUTTON GROUP g3 DEFAULT 'X' USER-COMMAND action10,
            p_r102 RADIOBUTTON GROUP g3,
            p_r103 LIKE p_r101 RADIOBUTTON GROUP g3.
PARAMETERS: p_inp101 TYPE char10,
            p_inp102 TYPE char10.
SELECTION-SCREEN END OF BLOCK b10.

* 11 & 12. Parameters in separate blocks with frames
SELECTION-SCREEN BEGIN OF BLOCK b11 WITH FRAME TITLE TEXT-011.
PARAMETERS: p_ch111 TYPE char10,
            p_ch112 TYPE char10.
SELECTION-SCREEN END OF BLOCK b11.

SELECTION-SCREEN BEGIN OF BLOCK b12 WITH FRAME TITLE TEXT-012.
PARAMETERS: p_n121 TYPE i,
            p_n122 TYPE i.
SELECTION-SCREEN END OF BLOCK b12.

* 13. Parameter with translated text element
SELECTION-SCREEN BEGIN OF BLOCK b13 WITH FRAME TITLE TEXT-013.
PARAMETERS p_trns13 TYPE char10.
SELECTION-SCREEN END OF BLOCK b13.

* 14. Checkbox and input field side-by-side
SELECTION-SCREEN BEGIN OF BLOCK b14 WITH FRAME TITLE TEXT-014.
SELECTION-SCREEN BEGIN OF LINE.
POSITION 1.
PARAMETERS p_chk14 AS CHECKBOX.
SELECTION-SCREEN COMMENT 3(10) TEXT-p14 FOR FIELD p_inp14.
POSITION 15.
PARAMETERS p_inp14 TYPE char10.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK b14.

* 15. Button in selection screen
SELECTION-SCREEN BEGIN OF BLOCK b15 WITH FRAME TITLE TEXT-015.
SELECTION-SCREEN PUSHBUTTON 10(8) btn_15 USER-COMMAND press15.
SELECTION-SCREEN END OF BLOCK b15.

* 16. table blocks
SELECTION-SCREEN BEGIN OF TABBED BLOCK tab_block FOR 20 LINES.
SELECTION-SCREEN TAB (20) tab161 USER-COMMAND tab161_pressed DEFAULT SCREEN 110.
SELECTION-SCREEN TAB (20) tab162 USER-COMMAND tab162_pressed DEFAULT SCREEN 120.
SELECTION-SCREEN TAB (20) tab163 USER-COMMAND tab163_pressed DEFAULT SCREEN 130.
SELECTION-SCREEN END OF BLOCK tab_block.

SELECTION-SCREEN BEGIN OF SCREEN 110 AS SUBSCREEN.
PARAMETERS p_tab161 TYPE char10.
SELECTION-SCREEN END OF SCREEN 110.

SELECTION-SCREEN BEGIN OF SCREEN 120 AS SUBSCREEN.
PARAMETERS p_tab162 TYPE d.
SELECTION-SCREEN END OF SCREEN 120.

SELECTION-SCREEN BEGIN OF SCREEN 130 AS SUBSCREEN.
PARAMETERS p_tab163 TYPE t.
SELECTION-SCREEN END OF SCREEN 130.


" 17. Define 3 params
SELECTION-SCREEN BEGIN OF BLOCK b17 WITH FRAME TITLE TEXT-017.
PARAMETERS p_s171 TYPE char10.
SELECTION-SCREEN ULINE.
PARAMETERS p_s172 TYPE char10.
SELECTION-SCREEN SKIP 1.
PARAMETERS p_s173 TYPE char10.
SELECTION-SCREEN END OF BLOCK b17.


" 18.Multiple parameters and select-options for variants
SELECTION-SCREEN BEGIN OF BLOCK b18 WITH FRAME TITLE TEXT-018.
PARAMETERS: p_v181 TYPE char10,
            p_v182 TYPE char10,
            p_v183 TYPE i,
            p_v184 TYPE i,
            p_v185 TYPE dats,
            p_v186 TYPE tims,
            p_v187 TYPE string,
            p_v188 TYPE char20.

SELECT-OPTIONS: s_num18 FOR sy-index,
               s_dat18 FOR sy-datum,
               s_vt18 FOR sy-uzeit.
SELECTION-SCREEN END OF BLOCK b18.



* 19. Declare a selection screen with two date parameters. The first once should be typed with the*
* primitive type. The second, with type SYST-DATUM. Is there any different between them when*
* filling the selection screen? What about the documentation displayed when you hit F1 key?*

"Technical Type:
"Both are actually the same internal type (DATS/D)
"Both store dates in YYYYMMDD format
"Both have a length of 8 characters

"User Interface Behavior:
"Both show a calendar picker
"Both accept dates in your local date format
"Both show dates according to user's display settings

"F1 Help Documentation:
"p_da191 (TYPE D): Shows generic documentation about date fields
"p_da192 (TYPE SYST-DATUM): Shows specific documentation about system date field
"SYST-DATUM has richer built-in documentation explaining its use as system date

"Semantic Meaning:
"TYPE D is a generic date type
"SYST-DATUM specifically indicates a system date, making the code more self-documenting
SELECTION-SCREEN BEGIN OF BLOCK b19 WITH FRAME TITLE TEXT-019.
* date parameter using primitive type d (8 characters yyyymmdd)
PARAMETERS: p_da191 TYPE d,
* Date parameter using SYST-DATUM (system field type)
            p_da192 TYPE syst-datum.

* Documentation text elements for F1 help
* These would normally be maintained in SE91 transaction
DATA: BEGIN OF text_elements,
        p_da191 TYPE string VALUE 'Date with primitive type D',
        p_da192 TYPE string VALUE 'Date with SYST-DATUM type',
      END OF text_elements.
SELECTION-SCREEN END OF BLOCK b19.


" 20. Declare a selection screen with two date parameters. The first once should be typed with the primitive type
SELECTION-SCREEN BEGIN OF BLOCK b20 WITH FRAME TITLE TEXT-020.
* Time parameter using primitive type T (6 characters HHMMSS)
PARAMETERS: p_time1 TYPE t,
* Time parameter using SYST-UZEIT (system field type)
            p_time2 TYPE syst-uzeit.
SELECTION-SCREEN END OF BLOCK b20.


* 21. Date parameter for last day of previous month
SELECTION-SCREEN BEGIN OF BLOCK b21 WITH FRAME TITLE TEXT-021.
PARAMETERS p_date21 TYPE d.
SELECTION-SCREEN END OF BLOCK b21.


* 22. Time parameter for current time minus 3 hours
SELECTION-SCREEN BEGIN OF BLOCK b22 WITH FRAME TITLE TEXT-022.
PARAMETERS p_time22 TYPE t.
SELECTION-SCREEN END OF BLOCK b22.


* 23. Date range for current month until today
SELECTION-SCREEN BEGIN OF BLOCK b23 WITH FRAME TITLE TEXT-023.
SELECT-OPTIONS s_date23 FOR sy-datum.
SELECTION-SCREEN END OF BLOCK b23.


* 24. Time range from start of day until now
SELECTION-SCREEN BEGIN OF BLOCK b24 WITH FRAME TITLE TEXT-024.
SELECT-OPTIONS s_time24 FOR sy-uzeit.
SELECTION-SCREEN END OF BLOCK b24.


* 25. Parameter and select-options with variant settings
SELECTION-SCREEN BEGIN OF BLOCK b25 WITH FRAME TITLE TEXT-025.
PARAMETERS p_blk25 TYPE char10.
SELECT-OPTIONS s_hide25 FOR sy-index.
SELECTION-SCREEN END OF BLOCK b25.


* 27. Parameter for program execution
SELECTION-SCREEN BEGIN OF BLOCK b27 WITH FRAME TITLE TEXT-027.
PARAMETERS p_prog27 TYPE sy-repid.
SELECTION-SCREEN END OF BLOCK b27.


* 28. Select-options for multiple program execution
SELECTION-SCREEN BEGIN OF BLOCK b28 WITH FRAME TITLE TEXT-028.
  SELECT-OPTIONS s_prog28 FOR sy-repid.
SELECTION-SCREEN END OF BLOCK b28.


" INITIALIZATION

INITIALIZATION.
  "Populate airline listbox
  SELECT carrid, carrname
    FROM scarr
  INTO TABLE @DATA(lt_carriers).

  " 8. Initialize checkbox values based on day
  IF sy-datum+6(2) BETWEEN 1 AND 10.
    p_chk82 = p_chk83 = 'X'.
  ENDIF.

  " 16. table blocks
  tab161 = 'String params'.
  tab162 = 'Number params'.
  tab163 = 'Date params'.

  " 23. Date range with variant for current month to current date
  DATA: lv_fd23 TYPE d,
      lv_td23    TYPE d.

  lv_td23 = sy-datum.
  lv_fd23 = sy-datum.
  lv_fd23+6(2) = '01'.

  s_date23-low = lv_fd23.
  s_date23-high = lv_td23.
  s_date23-option = 'BT'.
  s_date23-sign = 'I'.
  APPEND s_date23.

  " 24. Time range with variant for start of day until current time
  DATA: lv_st24 TYPE t,
      lv_ct24  TYPE t.

  lv_st24 = '000000'.
  lv_ct24 = sy-uzeit.

  s_time24-low = lv_st24.
  s_time24-high = lv_ct24.
  s_time24-option = 'BT'.
  s_time24-sign = 'I'.
  APPEND s_time24.


AT SELECTION-SCREEN OUTPUT.
  " 10. Radio buttons controlling input fields visibility
*  Declare four parameters. The first two should have a character type and the last two a
*numeric type. Separate each pair in the selection screen using selection screen blocks. Both blocks
*should contain a frame so it's possible to see the separation between them.
  IF lv_action10 = 'ACTION10'.
    CASE 'X'.
      WHEN p_r101.
        LOOP AT SCREEN.
          IF screen-name = 'P_INP101' OR screen-name = 'P_INP102'.
            screen-input = 1.
            MODIFY SCREEN.
          ENDIF.
        ENDLOOP.
      WHEN p_r102.
        LOOP AT SCREEN.
          IF screen-name = 'P_INP101'.
            screen-required = 1.
            MODIFY SCREEN.
          ENDIF.
          IF screen-name = 'P_INP102'.
            screen-input = 0.
            MODIFY SCREEN.
          ENDIF.
        ENDLOOP.
      WHEN p_r103.
        LOOP AT SCREEN.
          IF screen-name = 'P_INP101' OR screen-name = 'P_INP102'.
            screen-input = 0.
            screen-invisible = 1.
            MODIFY SCREEN.
          ENDIF.
        ENDLOOP.
    ENDCASE.
  ENDIF.
  " End 10

" 3. Validate zero entries
AT SELECTION-SCREEN ON s_num3.
  IF s_num3-low = 0.
    MESSAGE 'Task3: Zero value is not allowed' TYPE 'E'.
  ENDIF.

" 10. Radio buttons controlling input fields visibility
AT SELECTION-SCREEN ON BLOCK b10.
  lv_action10 = sy-ucomm.


" 21. Date parameter with variant for last day of previous month
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_date21.
  DATA: lv_dat21 TYPE d.
  lv_dat21 = sy-datum.
  "Move to first day of current month
  lv_dat21+6(2) = '01'.
  "Subtract 1 day to get last day of previous month
  lv_dat21 = lv_dat21 - 1.
  p_date21 = lv_dat21.


  "22. Time parameter with variant for current time minus 3 hours
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_time22.
  DATA: lv_tim22 TYPE t.
  lv_tim22 = sy-uzeit.
  "Subtract 3 hours (10800 seconds)
  lv_tim22 = lv_tim22 - 10800.
  p_time22 = lv_tim22.

AT SELECTION-SCREEN.
  " 3. validate if the number zero is entered and if it is, show an error message.
*  IF s_num3-low = 0 OR  s_num3-low IS INITIAL.
*    MESSAGE 'Task3: Zero value is not allowed' TYPE 'E'.
*  ENDIF.
  "4. Validate range > 100
  IF s_num4-high - s_num4-low > 100.
    MESSAGE 'Task 4: Values greater than 100 are not allowed' TYPE 'E'.
  ENDIF.

  " 9. Clear input field when radio button selected
  IF sy-ucomm = 'ACTION9' AND ( p_rad91 = 'X' OR p_rad92 = 'X' OR p_rad93 = 'X' ).
    CLEAR p_input9.
  ENDIF.

  " 15. Declare a button inside a selection screen and show an information message when it is pressed.
  PERFORM task15.

  " FORM
  " Task1
FORM task1.
  "1. Print multiplication results
  DATA: lv_number TYPE i,
        lv_result TYPE i.

  LOOP AT s_num1.
    IF s_num1-option = 'BT'. "Handle BETWEEN range
      DO s_num1-high - s_num1-low + 1 TIMES.
        lv_number = s_num1-low + sy-index - 1.
        lv_result = lv_number * 3.
        WRITE: / 'Number:', lv_number, 'Multiplied by 3:', lv_result.
      ENDDO.
    ELSE. "Handle single value or other options
      lv_number = s_num1-low.
      lv_result = lv_number * 3.
      WRITE: / 'Number:', lv_number, 'Multiplied by 3:', lv_result.
    ENDIF.
  ENDLOOP.
ENDFORM.


FORM task2.
  DATA: lv_criteria TYPE string,
        lv_first    TYPE abap_bool VALUE abap_true.

  LOOP AT s_num2.
    IF lv_first = abap_true.
      lv_criteria = |{ s_num2-sign }{ s_num2-option } { s_num2-low }|.
      IF s_num2-option = 'BT'.
        lv_criteria = |{ lv_criteria } { s_num2-high }|.
      ENDIF.
      lv_first = abap_false.
    ELSE.
      lv_criteria = |{ lv_criteria }, { s_num2-sign }{ s_num2-option } { s_num2-low }|.
      IF s_num2-option = 'BT'.
        lv_criteria = |{ lv_criteria } { s_num2-high }|.
      ENDIF.
    ENDIF.
  ENDLOOP.

  IF lv_criteria IS NOT INITIAL.
    WRITE: / 'Search Criteria:', lv_criteria.
  ELSE.
    WRITE: / 'No search criteria entered.'.
  ENDIF.
ENDFORM.

" Task15
FORM task15.
  IF sy-ucomm = 'PRESS15'.
    MESSAGE 'Button 15 was clicked' TYPE 'I'.
  ENDIF.
ENDFORM.


FORM task27.
  IF p_prog27 IS NOT INITIAL.
    "Check if the report exists
      SUBMIT (p_prog27)  VIA SELECTION-SCREEN AND RETURN.
  ENDIF.
ENDFORM.


" Task 28
FORM task28.

*  LOOP AT s_prog28 INTO DATA(ls_prog).
*    TRY.
*        " Submit the report for background execution
*        SUBMIT (ls_prog-low)
*          VIA SELECTION-SCREEN
*          AND RETURN.
*    ENDTRY.
*  ENDLOOP.

DATA: lv_prog TYPE sy-repid.

LOOP AT s_prog28.
    lv_prog = s_prog28-low.
    " Execute the program
    WRITE: / 'Executing program:', lv_prog.
    SUBMIT (lv_prog) AND RETURN. " AND RETURN ensures control returns to this program
  ENDLOOP.

ENDFORM.
" Exec
START-OF-SELECTION.

  WRITE: / 'Task 1'.
  uline.
  PERFORM task1.
  uline.
  WRITE: / 'Task 2'.
  uline.
  PERFORM task2.
  uline.

  WRITE: / 'Task 27'.
  uline.
  PERFORM task27.
  uline.

  WRITE: / 'Task 28'.
  uline.
  PERFORM task28.
  uline.