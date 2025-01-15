REPORT ZSYRO1110_T5_GNV.

TABLES: usr04.

" Task 1
FORM task1.
  DATA: lv_result1 TYPE i.
  lv_result1 = 2 + 3 * 5.
  WRITE: / 'Output:', lv_result1.
ENDFORM.

" Task 2
FORM task2.
  DATA: lv_num1 TYPE i VALUE 10,
        lv_num2 TYPE i VALUE 5,
        lv_add  TYPE i,
        lv_sub  TYPE i,
        lv_mul  TYPE i,
        lv_div  TYPE i,
        lv_pow  TYPE i.

  lv_add = lv_num1 + lv_num2.
  lv_sub = lv_num1 - lv_num2.
  lv_mul = lv_num1 * lv_num2.
  lv_div = lv_num1 / lv_num2.
  lv_pow = lv_num1 ** lv_num2.

  WRITE: / 'Addition:', lv_add,
         / 'Subtraction:', lv_sub,
         / 'Multiplication:', lv_mul,
         / 'Division:', lv_div,
         / 'Power:', lv_pow.
ENDFORM.

" Task 3
SELECTION-SCREEN BEGIN OF BLOCK bt03 WITH FRAME TITLE TEXT-b03.
PARAMETERS: p_num1 TYPE i, p_num2 TYPE i.
SELECTION-SCREEN END OF BLOCK bt03.

FORM task3 USING p_num1 TYPE i
                 p_num2 TYPE i.
  IF ( p_num1 IS INITIAL AND p_num1 <> 0 ) OR p_num2 IS INITIAL.
    RETURN.
  ENDIF.
  DATA: lv_add  TYPE i,
        lv_sub  TYPE i,
        lv_mul  TYPE i,
        lv_div  TYPE i,
        lv_pow  TYPE i.

  lv_add = p_num1 + p_num2.
  lv_sub = p_num1 - p_num2.
  lv_mul = p_num1 * p_num2.
  IF p_num2 NE 0.
    lv_div = p_num1 / p_num2.
  ELSE.
    lv_div = 0.
  ENDIF.
  lv_pow = p_num1 ** p_num2.

  WRITE: / 'Addition:', lv_add,
         / 'Subtraction:', lv_sub,
         / 'Multiplication:', lv_mul,
         / 'Division:', lv_div,
         / 'Power:', lv_pow.
ENDFORM.

" Task 4
FORM task4.
  DATA: lv_word1 TYPE string VALUE 'Hello',
        lv_word2 TYPE string VALUE 'World',
        lv_concat TYPE string.

  CONCATENATE lv_word1 lv_word2 INTO lv_concat SEPARATED BY space.
  WRITE: / 'Output:', lv_concat.
ENDFORM.

" Task 5
FORM task5.
  DATA: lv_word1 TYPE string VALUE 'Hello',
        lv_word2 TYPE string VALUE 'World',
        lv_month TYPE string.

  lv_month = sy-datum+4(2).
  DATA(lv_result) = |{ lv_word1 }-{ lv_word2 }-{ lv_month }|.
  WRITE: / lv_result.
ENDFORM.

" Task 6
FORM task6.
  DATA: lv_day   TYPE string,
        lv_month TYPE string,
        lv_year  TYPE string,
        ls_month TYPE t247,
        lv_date  TYPE string.

  CALL FUNCTION 'IDWT_READ_MONTH_TEXT'
    EXPORTING
      langu = sy-langu
      month = sy-datum+4(2)
    IMPORTING
      t247  = ls_month.
  lv_month = ls_month-ltx.

  CASE sy-datum+6(2).
    WHEN '01'. lv_day = 'first'.
    WHEN '02'. lv_day = 'second'.
    WHEN '03'. lv_day = 'third'.
    WHEN OTHERS.
      IF sy-datum+6(2) BETWEEN 04 AND 19.
        CASE sy-datum+6(2).
          WHEN '04'. lv_day = 'fourth'.
          WHEN '05'. lv_day = 'fifth'.
          WHEN '06'. lv_day = 'sixth'.
          WHEN '07'. lv_day = 'seventh'.
          WHEN '08'. lv_day = 'eighth'.
          WHEN '09'. lv_day = 'ninth'.
          WHEN '10'. lv_day = 'tenth'.
          WHEN '11'. lv_day = 'eleventh'.
          WHEN '12'. lv_day = 'twelfth'.
          WHEN '13'. lv_day = 'thirteenth'.
          WHEN '14'. lv_day = 'fourteenth'.
          WHEN '15'. lv_day = 'fifteenth'.
          WHEN '16'. lv_day = 'sixteenth'.
          WHEN '17'. lv_day = 'seventeenth'.
          WHEN '18'. lv_day = 'eighteenth'.
          WHEN '19'. lv_day = 'nineteenth'.
        ENDCASE.
        CONCATENATE lv_day 'th' INTO lv_day.
      ELSE.
        CASE sy-datum+6(2).
          WHEN '20'. lv_day = 'twentieth'.
          WHEN '21'. lv_day = 'twenty-first'.
          WHEN '22'. lv_day = 'twenty-second'.
          WHEN '23'. lv_day = 'twenty-third'.
          WHEN '24'. lv_day = 'twenty-fourth'.
          WHEN '25'. lv_day = 'twenty-fifth'.
          WHEN '26'. lv_day = 'twenty-sixth'.
          WHEN '27'. lv_day = 'twenty-seventh'.
          WHEN '28'. lv_day = 'twenty-eighth'.
          WHEN '29'. lv_day = 'twenty-ninth'.
          WHEN '30'. lv_day = 'thirtieth'.
          WHEN '31'. lv_day = 'thirty-first'.
        ENDCASE.
      ENDIF.
  ENDCASE.

  lv_year = sy-datum(4).
  WRITE:/ 'OUTPUT:', lv_month, ' the ', lv_day, ', ', lv_year. NEW-LINE.
ENDFORM.

" Task 7
FORM task7.
  DATA: lv_tz1 TYPE tznzone VALUE 'GMTUK',
        lv_tz2 TYPE tznzone VALUE 'INDIA',
        lv_tz3 TYPE tznzone VALUE 'BRAZIL',
        lv_tz4 TYPE tznzone VALUE 'CST',
        lv_tz5 TYPE tznzone VALUE 'ISRAEL',
        lv_tz6 TYPE tznzone VALUE 'RUS06',
        lv_ts  TYPE tzonref-tstamps,
        lv_ts_str TYPE string.

  CONCATENATE sy-datum sy-uzeit INTO lv_ts_str.
  lv_ts = lv_ts_str.
  WRITE: / lv_tz1, ':', lv_ts TIME ZONE lv_tz1. NEW-LINE.
  WRITE: / lv_tz2, ':', lv_ts TIME ZONE lv_tz2. NEW-LINE.
  WRITE: / lv_tz3, ':', lv_ts TIME ZONE lv_tz3. NEW-LINE.
  WRITE: / lv_tz4, ':', lv_ts TIME ZONE lv_tz4. NEW-LINE.
  WRITE: / lv_tz5, ':', lv_ts TIME ZONE lv_tz5. NEW-LINE.
  WRITE: / lv_tz6, ':', lv_ts TIME ZONE lv_tz6. NEW-LINE.
ENDFORM.

" Task 8
FORM task8.
  DATA: lv_vowels TYPE i,
        lv_user   LIKE sy-uname.

  lv_user = sy-uname.
  TRANSLATE lv_user TO UPPER CASE.
  FIND ALL OCCURRENCES OF REGEX 'A|E|I|O|U' IN lv_user MATCH COUNT lv_vowels.
  WRITE: / 'User:', lv_user.
  WRITE: / 'Total vowels:', lv_vowels.
ENDFORM.

" Task 9
FORM task9.
  DATA: lv_str TYPE string VALUE '1234567890ABCDEFGHIJ21',
        lv_len TYPE i.
  lv_len = strlen( lv_str ).
  IF lv_len > 20.
    WRITE 'Too big'.
  ELSE.
    WRITE lv_len.
  ENDIF.
ENDFORM.

" Task 10
FORM task10.
  DATA: lv_num TYPE i VALUE 1.
  WHILE lv_num <= 100.
    IF ( lv_num MOD 8 ) = 0.
      WRITE: 'The number', lv_num, ' is a multiple of 8'.
      NEW-LINE.
    ENDIF.
    ADD 1 TO lv_num.
  ENDWHILE.
ENDFORM.

" Task 11
TYPES: gtt_users TYPE TABLE OF usr04-bname.
FORM task11.
  DATA: lt_users TYPE gtt_users.
  SELECT bname
  FROM usr04
  INTO TABLE lt_users.
  PERFORM print_users USING lt_users.
ENDFORM.

FORM print_users USING lt_users TYPE gtt_users.
  DATA: ls_user TYPE usr04-bname.
  LOOP AT lt_users INTO ls_user.
    WRITE ls_user. NEW-LINE.
  ENDLOOP.
ENDFORM.

" Task 12

DATA: gv_var121 TYPE i VALUE 10,
      gv_var122 TYPE i VALUE 20,
      gv_var123 TYPE i VALUE 30,
      gv_var124 TYPE i VALUE 40.

FORM modify_variables USING    VALUE(uv_var121) TYPE i
                               uv_var122 TYPE i
                      CHANGING VALUE(cv_var123) TYPE i
                               cv_var124 TYPE i.

  WRITE: / 'Inside FORM - Before modification:'.
  WRITE: / 'uv_var121:', uv_var121,
         / 'uv_var122:', uv_var122,
         / 'cv_var123:', cv_var123,
         / 'cv_var124:', cv_var124.

  " Modify the variables
  uv_var121 = uv_var121 + 100.
  uv_var122 = uv_var122 + 100.
  cv_var123 = cv_var123 + 100.
  cv_var124 = cv_var124 + 100.

  WRITE: / 'Inside FORM - After modification:'.
  WRITE: / 'uv_var121:', uv_var121,
         / 'uv_var122:', uv_var122,
         / 'cv_var123:', cv_var123,
         / 'cv_var124:', cv_var124.

ENDFORM.

FORM task12.
  WRITE: / 'Before PERFORM:'.
  WRITE: / 'gv_var121:', gv_var121,
         / 'gv_var122:', gv_var122,
         / 'gv_var123:', gv_var123,
         / 'gv_var124:', gv_var124.

  PERFORM modify_variables USING    gv_var121
                                    gv_var122
                           CHANGING gv_var123
                                    gv_var124.

  WRITE: / 'After PERFORM:'.
  WRITE: / 'gv_var121:', gv_var121,
         / 'gv_var122:', gv_var122,
         / 'gv_var123:', gv_var123,
         / 'gv_var124:', gv_var124.
ENDFORM.


" Task 13
DATA: gv_largest TYPE f.

FORM get_larger USING num_a TYPE f
                      num_b TYPE f
             CHANGING largest TYPE f.
  IF num_a >= num_b.
    largest = num_a.
  ELSE.
    largest = num_b.
  ENDIF.
ENDFORM.

FORM task13.
  PERFORM get_larger USING 1 2 CHANGING gv_largest.
  WRITE gv_largest EXPONENT 0. NEW-LINE.
  PERFORM get_larger USING 4 3 CHANGING gv_largest.
  WRITE gv_largest EXPONENT 0. NEW-LINE.
  PERFORM get_larger USING 5 5 CHANGING gv_largest.
  WRITE gv_largest EXPONENT 0. NEW-LINE.
  PERFORM get_larger USING '6.2' '7.1' CHANGING gv_largest.
  WRITE gv_largest EXPONENT 0. NEW-LINE.
ENDFORM.

" Task 14
DATA: gv_flag TYPE c.

FORM set_flag USING num_a TYPE f
                    num_b TYPE f
           CHANGING flag TYPE c.
  IF num_a = num_b.
    flag = abap_true.
  ELSE.
    flag = abap_false.
  ENDIF.
ENDFORM.

FORM task14.
  DATA: num_a TYPE f,
        num_b TYPE f.
  num_a = 1.
  num_b = 1.
  PERFORM set_flag USING num_a num_b CHANGING gv_flag.
  WRITE: / |a: { num_a }, b: { num_b }, flag: { gv_flag } |.

  num_a = 4.
  num_b = 3.
  PERFORM set_flag USING num_a num_b CHANGING gv_flag.
  WRITE: / |a: { num_a }, b: { num_b }, flag: { gv_flag } |.

  num_a = 5.
  num_b = 5.
  PERFORM set_flag USING num_a num_b CHANGING gv_flag.
  WRITE: / |a: { num_a }, b: { num_b }, flag: { gv_flag } |.

  num_a = '6.2'.
  num_b = '7.1'.
  PERFORM set_flag USING num_a num_b CHANGING gv_flag.
  WRITE: / |a: { num_a }, b: { num_b }, flag: { gv_flag } |.
ENDFORM.

" Task 15
DATA: gv_result TYPE f.

FORM div_or_pow2 USING num_a TYPE f
                       num_b TYPE f
              CHANGING result TYPE f.
  DATA: lv_equal TYPE c.
  PERFORM set_flag USING num_a num_b CHANGING lv_equal.
  IF lv_equal = abap_true.
    result = num_a ** 2.
  ELSE.
    DATA lv_larger TYPE f.
    PERFORM get_larger USING num_a num_b CHANGING lv_larger.
    IF num_a = lv_larger.
      result = num_a / num_b.
    ELSE.
      result = num_b / num_a.
    ENDIF.
  ENDIF.
ENDFORM.

FORM task15.
  DATA: num_a TYPE f,
        num_b TYPE f.

  num_a = 1.
  num_b = 1.
  PERFORM div_or_pow2 USING num_a num_b CHANGING gv_result.
  WRITE: / |a: { num_a }, b: { num_b }, result: { gv_result } |.

  num_a = 3.
  num_b = 3.
  PERFORM div_or_pow2 USING num_a num_b CHANGING gv_result.
  WRITE: / |a: { num_a }, b: { num_b }, result: { gv_result } |.

  num_a = 6.
  num_b = 2.
  PERFORM div_or_pow2 USING num_a num_b CHANGING gv_result.
  WRITE: / |a: { num_a }, b: { num_b }, result: { gv_result } |.

  num_a = 2.
  num_b = 6.
  PERFORM div_or_pow2 USING num_a num_b CHANGING gv_result.
  WRITE: / |a: { num_a }, b: { num_b }, result: { gv_result } |.

  num_a = 10.
  num_b = 2.
  PERFORM div_or_pow2 USING num_a num_b CHANGING gv_result.
  WRITE: / |a: { num_a }, b: { num_b }, result: { gv_result } |.

  num_a = 2.
  num_b = 10.
  PERFORM div_or_pow2 USING num_a num_b CHANGING gv_result.
  WRITE: / |a: { num_a }, b: { num_b }, result: { gv_result } |.
ENDFORM.

" Task 16
TYPES: BEGIN OF gty_emp,
         emp_id   TYPE i,
         emp_name TYPE string,
         salary   TYPE p DECIMALS 2,
         hire_dt  TYPE datum,
         dept     TYPE char20,
       END OF gty_emp.

DATA: gs_emp TYPE gty_emp.

FORM task16.
  gs_emp-emp_id = 1001.
  gs_emp-emp_name = 'John Doe'.
  gs_emp-salary = '75000.50'.
  gs_emp-hire_dt = '20230615'.
  gs_emp-dept = 'IT DEPARTMENT'.

  PERFORM disp_emp_info.
ENDFORM.

FORM disp_emp_info.
  WRITE: / 'Employee ID:', gs_emp-emp_id.
  WRITE: sy-uline.
  WRITE: / 'Employee Name:', gs_emp-emp_name.
  WRITE: sy-uline.
  WRITE: / 'Salary:', gs_emp-salary.
  WRITE: sy-uline.
  WRITE: / 'Hire Date:', gs_emp-hire_dt.
  WRITE: sy-uline.
  WRITE: / 'Department:', gs_emp-dept.
  WRITE: sy-uline.
ENDFORM.

" Task 17
TYPES: BEGIN OF gty_data_17,
         num  TYPE i,
         txt  TYPE string,
         amt  TYPE p DECIMALS 2,
         dt   TYPE datum,
         flag TYPE xfeld,
       END OF gty_data_17.

DATA: gs_data_17 TYPE gty_data_17,
      gv_empty   TYPE i.

FORM task17.
  gs_data_17-num = 0.
  gs_data_17-amt = '100.50'.
  gs_data_17-flag = abap_false.

  PERFORM count_empty CHANGING gs_data_17 gv_empty.
  PERFORM disp_result_17.
ENDFORM.

FORM count_empty CHANGING ps_data TYPE gty_data_17
                          pv_count TYPE i.
  pv_count = 0.
  IF ps_data-num IS INITIAL. ADD 1 TO pv_count. ENDIF.
  IF ps_data-txt IS INITIAL. ADD 1 TO pv_count. ENDIF.
  IF ps_data-amt IS INITIAL. ADD 1 TO pv_count. ENDIF.
  IF ps_data-dt IS INITIAL. ADD 1 TO pv_count. ENDIF.
  IF ps_data-flag IS INITIAL. ADD 1 TO pv_count. ENDIF.
ENDFORM.

FORM disp_result_17.
  WRITE: / 'Unfilled components:', gv_empty.
ENDFORM.

" Task 18
TYPES: BEGIN OF gty_num_18,
         int     TYPE i,
         pck_num TYPE p DECIMALS 2,
         flt_num TYPE f,
         dec_num TYPE decfloat16,
       END OF gty_num_18.

DATA: gs_num_18 TYPE gty_num_18,
      gv_sum_18 TYPE decfloat34.

FORM task18.
  gs_num_18-int = 100.
  gs_num_18-pck_num = '250.75'.
  gs_num_18-flt_num = '75.5'.
  gs_num_18-dec_num = '1234.56'.

  PERFORM sum_nums CHANGING gs_num_18 gv_sum_18.
  PERFORM disp_sum.
ENDFORM.

FORM sum_nums CHANGING ps_num TYPE gty_num_18
                       pv_sum TYPE decfloat34.
  pv_sum = ps_num-int + ps_num-pck_num + ps_num-flt_num + ps_num-dec_num.
ENDFORM.

FORM disp_sum.
  WRITE: / 'Total Sum:', gv_sum_18.
ENDFORM.

" Task 19
TYPES: BEGIN OF gty_mix_19,
         char1 TYPE char20,
         char2 TYPE char20,
         char3 TYPE char20,
         num1  TYPE i,
         num2  TYPE p DECIMALS 2,
         num3  TYPE f,
       END OF gty_mix_19.

DATA: gs_mix_19 TYPE gty_mix_19.

FORM task19.
  gs_mix_19-char1 = 'Hell'.
  gs_mix_19-char2 = 'World'.
  gs_mix_19-char3 = 'ABAP'.
  gs_mix_19-num1 = 10.
  gs_mix_19-num2 = '15.50'.
  gs_mix_19-num3 = '20.5'.

  PERFORM proc_comp CHANGING gs_mix_19.
  PERFORM disp_res.
ENDFORM.

FORM proc_comp CHANGING cs_data TYPE gty_mix_19.
  DATA: lv_num_sum TYPE decfloat34,
        lv_vow_cnt TYPE i,
        lv_tot_vow TYPE i.

  lv_num_sum = abs( cs_data-num1 ) +
               abs( trunc( cs_data-num2 ) ) +
               abs( trunc( cs_data-num3 ) ).

  PERFORM count_vowels USING cs_data-char1 CHANGING lv_vow_cnt.
  ADD lv_vow_cnt TO lv_tot_vow.
  PERFORM count_vowels USING cs_data-char2 CHANGING lv_vow_cnt.
  ADD lv_vow_cnt TO lv_tot_vow.
  PERFORM count_vowels USING cs_data-char3 CHANGING lv_vow_cnt.
  ADD lv_vow_cnt TO lv_tot_vow.

  IF lv_num_sum MOD 2 = 1.
    CLEAR: cs_data-char1, cs_data-char2, cs_data-char3.
  ENDIF.

  IF lv_tot_vow MOD 2 = 0.
    CLEAR: cs_data-num1, cs_data-num2, cs_data-num3.
  ENDIF.
ENDFORM.

FORM count_vowels USING p_str TYPE char20
               CHANGING p_cnt TYPE i.
  DATA: lt_matches TYPE match_result_tab.
  FIND ALL OCCURRENCES OF REGEX '[AEIOU]'
    IN to_upper( p_str )
    RESULTS lt_matches.
  p_cnt = lines( lt_matches ).
ENDFORM.

FORM disp_res.
  WRITE: / 'Char1:', gs_mix_19-char1,
         / 'Char2:', gs_mix_19-char2,
         / 'Char3:', gs_mix_19-char3,
         / 'Num1:', gs_mix_19-num1,
         / 'Num2:', gs_mix_19-num2,
         / 'Num3:', gs_mix_19-num3.
ENDFORM.

" Task 20
TYPES: BEGIN OF gty_line_20,
         id    TYPE c LENGTH 10,
         name  TYPE string,
         value TYPE i,
       END OF gty_line_20.

DATA: gt_std TYPE STANDARD TABLE OF gty_line_20,
      gt_srt TYPE SORTED TABLE OF gty_line_20 WITH UNIQUE KEY id,
      gt_hsh TYPE HASHED TABLE OF gty_line_20 WITH UNIQUE KEY id.

FORM task20.
  DATA: ls_line TYPE gty_line_20.

  ls_line-id = '3'.
  ls_line-name = 'John'.
  ls_line-value = 50.
  APPEND ls_line TO gt_std.
  INSERT ls_line INTO TABLE gt_srt.
  INSERT ls_line INTO TABLE gt_hsh.

  ls_line-id = '2'.
  ls_line-name = 'Mary'.
  ls_line-value = 60.
  APPEND ls_line TO gt_std.
  INSERT ls_line INTO TABLE gt_srt.
  INSERT ls_line INTO TABLE gt_hsh.

  ls_line-id = '1'.
  ls_line-name = 'Max'.
  ls_line-value = 30.
  APPEND ls_line TO gt_std.
  INSERT ls_line INTO TABLE gt_srt.
  INSERT ls_line INTO TABLE gt_hsh.

  WRITE: / 'Standard Table:'.
  LOOP AT gt_std INTO ls_line.
    WRITE: / ls_line-id, ls_line-name, ls_line-value.
  ENDLOOP.

  WRITE: / 'Sorted Table:'.
  LOOP AT gt_srt INTO ls_line.
    WRITE: / ls_line-id, ls_line-name, ls_line-value.
  ENDLOOP.

  WRITE: / 'Hashed Table:'.
  LOOP AT gt_hsh INTO ls_line.
    WRITE: / ls_line-id, ls_line-name, ls_line-value.
  ENDLOOP.
ENDFORM.

" Task 21
TYPES: BEGIN OF gty_line_21,
         id    TYPE c LENGTH 10,
         name  TYPE string,
         value TYPE i,
         cr_dt TYPE d,
       END OF gty_line_21.

TYPES: gtt_tab_21 TYPE STANDARD TABLE OF gty_line_21 WITH DEFAULT KEY.

FORM task21.
  DATA: lt_data TYPE gtt_tab_21,
        ls_line TYPE gty_line_21.

  APPEND VALUE #( id = '1' name = 'John' value = 50 cr_dt = '20140727' ) TO lt_data.
  APPEND VALUE #( id = '2' name = 'Mary' value = 20 ) TO lt_data.
  APPEND VALUE #( id = '3' name = 'Max' ) TO lt_data.
  APPEND VALUE #( ) TO lt_data.

  PERFORM proc_tab_init USING lt_data.
ENDFORM.

FORM proc_tab_init USING lt_tab TYPE gtt_tab_21.
  DATA: lv_init_cnt TYPE i,
        lv_tot_init TYPE i.

  LOOP AT lt_tab INTO DATA(ls_line).
    PERFORM cnt_init_flds USING ls_line CHANGING lv_init_cnt.
    ADD lv_init_cnt TO lv_tot_init.
    WRITE: / 'Line', sy-tabix, 'Initial Fields:', lv_init_cnt.
  ENDLOOP.

  WRITE: / 'Total Initial Fields:', lv_tot_init.
ENDFORM.

FORM cnt_init_flds USING ls_line TYPE gty_line_21
                CHANGING pv_cnt TYPE i.
  pv_cnt = 0.
  IF ls_line-id IS INITIAL. ADD 1 TO pv_cnt. ENDIF.
  IF ls_line-name IS INITIAL. ADD 1 TO pv_cnt. ENDIF.
  IF ls_line-value IS INITIAL. ADD 1 TO pv_cnt. ENDIF.
  IF ls_line-cr_dt IS INITIAL. ADD 1 TO pv_cnt. ENDIF.
ENDFORM.

" Task 22
TYPES: BEGIN OF gty_line_22,
         id    TYPE c LENGTH 10,
         name  TYPE string,
         value TYPE i,
         cr_dt TYPE d,
       END OF gty_line_22.

TYPES: gtt_tab_22 TYPE STANDARD TABLE OF gty_line_22 WITH DEFAULT KEY.

FORM task22.
  DATA: lt_data TYPE gtt_tab_22,
        ls_line TYPE gty_line_22.

  APPEND VALUE #( id = '1' name = 'John' value = 50 cr_dt = '20140727' ) TO lt_data.
  APPEND VALUE #( id = '2' name = 'Mary' value = 20 ) TO lt_data.
  APPEND VALUE #( id = '3' name = 'Max' ) TO lt_data.
  APPEND VALUE #( ) TO lt_data.

  PERFORM proc_tab_blnk USING lt_data.
ENDFORM.

FORM proc_tab_blnk USING lt_tab TYPE gtt_tab_22.
  DATA: lv_blnk_cnt TYPE i,
        lv_tot_blnk TYPE i.

  WRITE: / 'Blank Fields Analysis:'.
  ULINE.

  LOOP AT lt_tab INTO DATA(ls_line).
    PERFORM cnt_blnk_flds USING ls_line CHANGING lv_blnk_cnt.
    ADD lv_blnk_cnt TO lv_tot_blnk.
    WRITE: / 'Line', sy-tabix, '=>', lv_blnk_cnt, 'blank fields'.
  ENDLOOP.

  ULINE.
  WRITE: / 'Total:', lv_tot_blnk, 'blank fields'.
ENDFORM.

FORM cnt_blnk_flds USING ls_line TYPE gty_line_22
                CHANGING pv_cnt TYPE i.
  pv_cnt = 0.
  IF ls_line-id IS INITIAL. ADD 1 TO pv_cnt. ENDIF.
  IF ls_line-name IS INITIAL. ADD 1 TO pv_cnt. ENDIF.
  IF ls_line-value IS INITIAL. ADD 1 TO pv_cnt. ENDIF.
  IF ls_line-cr_dt IS INITIAL. ADD 1 TO pv_cnt. ENDIF.
ENDFORM.

" Task 23
TYPES: BEGIN OF gty_line_23,
         comp1 TYPE c LENGTH 10,
         comp2 TYPE string,
         comp3 TYPE c LENGTH 5,
       END OF gty_line_23.

TYPES: gtt_tab_23 TYPE TABLE OF gty_line_23.

FORM task23.
  DATA: lt_tab TYPE gtt_tab_23,
        ls_line TYPE gty_line_23.

  ls_line-comp1 = 'ABAP 101'.
  ls_line-comp2 = 'One Two Three Four Five Six Seven Eight Nine'.
  ls_line-comp3 = '12345'.
  APPEND ls_line TO lt_tab.
  CLEAR ls_line.

  ls_line-comp1 = 'ABAP101'.
  ls_line-comp2 = 'One/Two/Three/Four Five/Six/Seven/Eight/Nine'.
  ls_line-comp3 = '12 45'.
  APPEND ls_line TO lt_tab.
  CLEAR ls_line.

  ls_line-comp1 = ' '.
  ls_line-comp2 ='One/Two/Three/Four+ =_-Five/Six/Seven/Eight/Nine'.
  ls_line-comp3 = ''.
  APPEND ls_line TO lt_tab.
  CLEAR ls_line.

  WRITE: 'Before replace'. NEW-LINE.
  PERFORM print_tab USING lt_tab.

  PERFORM rep_spaces CHANGING lt_tab.

  WRITE: /, 'After replace'. NEW-LINE.
  PERFORM print_tab USING lt_tab.
ENDFORM.

FORM rep_spaces CHANGING lt_tab TYPE gtt_tab_23.
  DATA: ls_line TYPE gty_line_23.

  LOOP AT lt_tab INTO ls_line.
    REPLACE ALL OCCURRENCES OF REGEX '\s' IN ls_line-comp1 WITH '_'.
    REPLACE ALL OCCURRENCES OF REGEX '[[:space:]]' IN ls_line-comp2 WITH '_'.
    REPLACE ALL OCCURRENCES OF REGEX '\s' IN ls_line-comp3 WITH '_'.
    MODIFY lt_tab FROM ls_line INDEX sy-tabix.
  ENDLOOP.
ENDFORM.

FORM print_tab USING lt_tab TYPE gtt_tab_23.
  DATA: ls_line TYPE gty_line_23.

  LOOP AT lt_tab INTO ls_line.
    WRITE: ls_line-comp1 COLOR 1. NEW-LINE.
    WRITE: ls_line-comp2 COLOR 2. NEW-LINE.
    WRITE: ls_line-comp3 COLOR 3. NEW-LINE.
    WRITE /.
  ENDLOOP.
ENDFORM.

" Task 24
TYPES: BEGIN OF gty_line_24,
         fname TYPE string,
         lname TYPE string,
         dept  TYPE string,
       END OF gty_line_24.

TYPES: gtt_tab_24 TYPE STANDARD TABLE OF gty_line_24 WITH DEFAULT KEY.

FORM task24.
  DATA: lt_tab TYPE gtt_tab_24,
        ls_line TYPE gty_line_24.

  ls_line-fname = 'John q'.
  ls_line-lname = 'Doe q'.
  ls_line-dept = 'q   IT'.
  APPEND ls_line TO lt_tab.
  CLEAR ls_line.

  ls_line-fname = ' Jane Marie'.
  ls_line-lname = ' '.
  ls_line-dept = 'Human Rces '.
  APPEND ls_line TO lt_tab.
  CLEAR ls_line.

  ls_line-fname = 'Michael David'.
  ls_line-lname = 'Williams'.
  ls_line-dept = 'Finance'.
  APPEND ls_line TO lt_tab.
  CLEAR ls_line.

  ls_line-fname = 'Emily'.
  ls_line-lname = 'Brown'.
  ls_line-dept = 'Product Development'.
  APPEND ls_line TO lt_tab.
  CLEAR ls_line.

  ls_line-fname = 'Robert James'.
  ls_line-lname = 'Miller Thompson'.
  ls_line-dept = 'Customer Support'.
  APPEND ls_line TO lt_tab.
  CLEAR ls_line.

  ls_line-fname = 'Sarah'.
  ls_line-lname = 'Davis'.
  ls_line-dept = 'Marketing'.
  APPEND ls_line TO lt_tab.
  CLEAR ls_line.

  ls_line-fname = 'Daniel Patrick'.
  ls_line-lname = 'Wilson'.
  ls_line-dept = 'Sales Operations'.
  APPEND ls_line TO lt_tab.
  CLEAR ls_line.

  ls_line-fname = 'Lisa'.
  ls_line-lname = 'Garcia Rodriguez'.
  ls_line-dept = 'Legal'.
  APPEND ls_line TO lt_tab.
  CLEAR ls_line.

  ls_line-fname = 'Christopher Michael'.
  ls_line-lname = 'Anderson Peterson'.
  ls_line-dept = 'Executive Management'.
  APPEND ls_line TO lt_tab.
  CLEAR ls_line.

  ls_line-fname = 'Elizabeth Anne Marie'.
  ls_line-lname = 'Martinez Rodriguez Gonzalez'.
  ls_line-dept = 'International Relations'.
  APPEND ls_line TO lt_tab.
  CLEAR ls_line.

  WRITE: / 'Original Table:'.
  PERFORM disp_tab USING lt_tab.

  PERFORM rep_spaces_fs CHANGING lt_tab.

  WRITE: / 'Modified Table:'.
  PERFORM disp_tab USING lt_tab.
ENDFORM.

FORM rep_spaces_fs CHANGING lt_tab TYPE gtt_tab_24.
  FIELD-SYMBOLS: <fs_line> TYPE gty_line_24.

  LOOP AT lt_tab ASSIGNING <fs_line>.
    IF <fs_line>-fname IS NOT INITIAL.
      REPLACE ALL OCCURRENCES OF REGEX '\s' IN <fs_line>-fname WITH '_'.
    ENDIF.

    IF <fs_line>-lname IS NOT INITIAL.
      REPLACE ALL OCCURRENCES OF REGEX '\s' IN <fs_line>-lname WITH '_'.
    ENDIF.

    IF <fs_line>-dept IS NOT INITIAL.
      REPLACE ALL OCCURRENCES OF REGEX '\s' IN <fs_line>-dept WITH '_'.
    ENDIF.
  ENDLOOP.
ENDFORM.

FORM disp_tab USING lt_tab TYPE gtt_tab_24.
  DATA: ls_line TYPE gty_line_24.

  LOOP AT lt_tab INTO ls_line.
    WRITE: / ls_line-fname, ls_line-lname, ls_line-dept.
  ENDLOOP.
ENDFORM.

" Task 25
TYPES: gtt_str_tab TYPE TABLE OF string.

FORM task25.
  DATA: lt_str TYPE gtt_str_tab,
        lv_concat TYPE string.

  APPEND 'A' TO lt_str.
  APPEND 'B' TO lt_str.
  APPEND 'C' TO lt_str.
  APPEND 'D' TO lt_str.
  APPEND 'X' TO lt_str.
  APPEND 'Y' TO lt_str.
  APPEND 'Z' TO lt_str.
  APPEND 'M' TO lt_str.
  APPEND 'N' TO lt_str.
  APPEND 'O' TO lt_str.

  PERFORM concat_str USING lt_str '1' CHANGING lv_concat.
  WRITE: '1 - ', lv_concat, /.
  CLEAR lv_concat.

  PERFORM concat_str USING lt_str '2' CHANGING lv_concat.
  WRITE: '2 - ', lv_concat, /.
  CLEAR lv_concat.

  PERFORM concat_str USING lt_str '3' CHANGING lv_concat.
  WRITE: '3 - ', lv_concat, /.
  CLEAR lv_concat.

  PERFORM concat_str USING lt_str '4' CHANGING lv_concat.
  WRITE: '4 - ', lv_concat, /.
  CLEAR lv_concat.
ENDFORM.

FORM concat_str USING lt_str TYPE gtt_str_tab
                      lv_logic TYPE c
             CHANGING lv_concat TYPE string.
  DATA: lt_copy TYPE gtt_str_tab.
  lt_copy = lt_str.

  CASE lv_logic.
    WHEN '1'.
      PERFORM concat_linear USING lt_copy CHANGING lv_concat.
    WHEN '2'.
      SORT lt_copy.
      PERFORM concat_linear USING lt_copy CHANGING lv_concat.
    WHEN '3'.
      SORT lt_copy DESCENDING.
      PERFORM concat_linear USING lt_copy CHANGING lv_concat.
    WHEN '4'.
      DATA: lv_idx TYPE i.
      DESCRIBE TABLE lt_copy LINES lv_idx.
      WHILE lv_idx > 0.
        READ TABLE lt_copy INTO DATA(lv_str) INDEX lv_idx.
        IF sy-subrc = 0.
          CONCATENATE lv_concat lv_str INTO lv_concat.
        ENDIF.
        lv_idx = lv_idx - 1.
      ENDWHILE.
  ENDCASE.
ENDFORM.

FORM concat_linear USING lt_str TYPE gtt_str_tab
                CHANGING lv_concat TYPE string.
  LOOP AT lt_str INTO DATA(lv_str).
    CONCATENATE lv_concat lv_str INTO lv_concat.
  ENDLOOP.
ENDFORM.

" Task 26
SELECTION-SCREEN BEGIN OF BLOCK bt26 WITH FRAME TITLE TEXT-b26.
PARAMETERS:
  p_num_26 TYPE int8,
  p_len_26 TYPE i.
SELECTION-SCREEN END OF BLOCK bt26.

FORM task26.
  IF p_num_26 IS INITIAL OR p_len_26 IS INITIAL.
    RETURN.
  ENDIF.
  PERFORM fmt_num USING p_num_26 p_len_26 CHANGING sy-lisel.
  WRITE: / sy-lisel.
ENDFORM.

FORM fmt_num USING iv_num TYPE int8
                   iv_len TYPE i
          CHANGING cv_fmt TYPE char255.
  DATA: lv_num_str TYPE string,
        lv_num_len TYPE i,
        lv_pad_len TYPE i,
        lv_pad_num TYPE string.

  lv_num_str = |{ iv_num }|.
  lv_num_len = strlen( lv_num_str ).

  IF lv_num_len > iv_len.
    DATA(lv_idx) = lv_num_len - iv_len.
    lv_pad_num = lv_num_str+lv_idx(iv_len).
  ELSE.
    lv_pad_len = iv_len - lv_num_len.
    lv_pad_num = repeat( val = '0' occ = lv_pad_len ) && lv_num_str.
  ENDIF.

  cv_fmt = lv_pad_num.
ENDFORM.

" Task 27
SELECTION-SCREEN BEGIN OF BLOCK bt27 WITH FRAME TITLE TEXT-b27.
PARAMETERS:
  p_b_27   TYPE p LENGTH 5,
  p_exp_27 TYPE i.
SELECTION-SCREEN END OF BLOCK bt27.

FORM task27.
  DATA: lv_res TYPE f.
  lv_res = p_b_27 ** p_exp_27.
  WRITE: / lv_res EXPONENT 0.
ENDFORM.

" Task 28
SELECTION-SCREEN BEGIN OF BLOCK bt28 WITH FRAME TITLE TEXT-b28.
PARAMETERS:
  p_str_28 TYPE string DEFAULT 'HUYEN C',
  p_num_28 TYPE i DEFAULT 1.
SELECTION-SCREEN END OF BLOCK bt28.

FORM task28.
  IF p_num_28 IS INITIAL OR p_num_28 > 25.
    MESSAGE 'P_num is invalid, valid [1:25]' TYPE 'E'.
    LEAVE SCREEN.
  ENDIF.
  PERFORM prt_inc_str USING p_str_28 p_num_28.
ENDFORM.

FORM prt_inc_str USING iv_str TYPE string
                       iv_num TYPE i.
  DATA: lv_curr TYPE string,
        lv_idx  TYPE i.

  DO iv_num TIMES.
    lv_idx = sy-index.
    lv_curr = iv_str(lv_idx).
    WRITE: / |Line [{ lv_idx }]: { lv_curr }|.
  ENDDO.
ENDFORM.

" Task 29
TYPES: BEGIN OF gty_line_29,
         col1 TYPE string,
         col2 TYPE string,
       END OF gty_line_29.

DATA: gt_with_hdr TYPE TABLE OF gty_line_29 WITH HEADER LINE,
      gt_wo_hdr   TYPE TABLE OF gty_line_29,
      gs_wo_hdr   TYPE gty_line_29.

FORM task29.
  gt_with_hdr-col1 = 'Record 1 Col1'.
  gt_with_hdr-col2 = 'Record 1 Col2'.
  APPEND gt_with_hdr.

  gt_with_hdr-col1 = 'Record 2 Col1'.
  gt_with_hdr-col2 = 'Record 2 Col2'.
  APPEND gt_with_hdr.

  gt_with_hdr-col1 = 'Record 3 Col1'.
  gt_with_hdr-col2 = 'Record 3 Col2'.
  APPEND gt_with_hdr.

  gt_with_hdr-col1 = 'Record 4 Col1'.
  gt_with_hdr-col2 = 'Record 4 Col2'.
  APPEND gt_with_hdr.

  gt_with_hdr-col1 = 'Record 5 Col1'.
  gt_with_hdr-col2 = 'Record 5 Col2'.
  APPEND gt_with_hdr.

  gs_wo_hdr-col1 = 'Record 1 Col1'.
  gs_wo_hdr-col2 = 'Record 1 Col2'.
  APPEND gs_wo_hdr TO gt_wo_hdr.

  gs_wo_hdr-col1 = 'Record 2 Col1'.
  gs_wo_hdr-col2 = 'Record 2 Col2'.
  APPEND gs_wo_hdr TO gt_wo_hdr.

  gs_wo_hdr-col1 = 'Record 3 Col1'.
  gs_wo_hdr-col2 = 'Record 3 Col2'.
  APPEND gs_wo_hdr TO gt_wo_hdr.

  gs_wo_hdr-col1 = 'Record 4 Col1'.
  gs_wo_hdr-col2 = 'Record 4 Col2'.
  APPEND gs_wo_hdr TO gt_wo_hdr.

  gs_wo_hdr-col1 = 'Record 5 Col1'.
  gs_wo_hdr-col2 = 'Record 5 Col2'.
  APPEND gs_wo_hdr TO gt_wo_hdr.

  WRITE: / 'Table with Header:'.
  LOOP AT gt_with_hdr.
    WRITE: / gt_with_hdr-col1, gt_with_hdr-col2.
  ENDLOOP.

  WRITE: / 'Table without Header:'.
  LOOP AT gt_wo_hdr INTO gs_wo_hdr.
    WRITE: / gs_wo_hdr-col1, gs_wo_hdr-col2.
  ENDLOOP.
ENDFORM.

" Task 30
TYPES: BEGIN OF gty_line_30,
         col1 TYPE string,
         col2 TYPE string,
         col3 TYPE string,
       END OF gty_line_30.

TYPES: gtt_tab_30 TYPE TABLE OF gty_line_30 WITH EMPTY KEY.

DATA: gt_data_30 TYPE gtt_tab_30,
      gs_data_30 TYPE gty_line_30.

FORM task30.
  APPEND VALUE #( col1 = 'C' col2 = 'Row 3 Col2' col3 = 'Row 3 Col3' ) TO gt_data_30.
  APPEND VALUE #( col1 = 'A' col2 = 'Row 1 Col2' col3 = 'Row 1 Col3' ) TO gt_data_30.
  APPEND VALUE #( col1 = 'B' col2 = 'Row 2 Col2' col3 = 'Row 2 Col3' ) TO gt_data_30.
  APPEND VALUE #( col1 = 'D' col2 = 'Row 4 Col2' col3 = 'Row 4 Col3' ) TO gt_data_30.

  WRITE: / 'Unsorted Table:'.
  LOOP AT gt_data_30 INTO gs_data_30.
    WRITE: / gs_data_30-col1, gs_data_30-col2, gs_data_30-col3.
  ENDLOOP.

  PERFORM sort_tab USING gt_data_30.

  WRITE: / 'Sorted Table:'.
  LOOP AT gt_data_30 INTO gs_data_30.
    WRITE: / gs_data_30-col1, gs_data_30-col2, gs_data_30-col3.
  ENDLOOP.
ENDFORM.

FORM sort_tab CHANGING ct_tab TYPE gtt_tab_30.
  SORT ct_tab BY col1.
ENDFORM.

" Task 31
TYPES: BEGIN OF gty_line_31,
         col1 TYPE string,
         col2 TYPE string,
         col3 TYPE string,
       END OF gty_line_31.

TYPES: gtt_tab_31 TYPE TABLE OF gty_line_31 WITH EMPTY KEY.

DATA: gt_data_31 TYPE gtt_tab_31,
      gs_data_31 TYPE gty_line_31.

FORM task31.
  APPEND VALUE #( col1 = 'C' col2 = 'Row 3 Col2' col3 = 'Row 3 Col3' ) TO gt_data_31.
  APPEND VALUE #( col1 = 'A' col2 = 'Row 1 Col2' col3 = 'Row 1 Col3' ) TO gt_data_31.
  APPEND VALUE #( col1 = 'B' col2 = 'Row 2 Col2' col3 = 'Row 2 Col3' ) TO gt_data_31.
  APPEND VALUE #( col1 = 'D' col2 = 'Row 4 Col2' col3 = 'Row 4 Col3' ) TO gt_data_31.

  WRITE: / 'Unsorted Table:'.
  LOOP AT gt_data_31 INTO gs_data_31.
    WRITE: / gs_data_31-col1, gs_data_31-col2, gs_data_31-col3.
  ENDLOOP.

  PERFORM sort_tab_dyn USING 'col2' CHANGING gt_data_31.

  WRITE: / 'Sorted Table:'.
  LOOP AT gt_data_31 INTO gs_data_31.
    WRITE: / gs_data_31-col1, gs_data_31-col2, gs_data_31-col3.
  ENDLOOP.
ENDFORM.

FORM sort_tab_dyn USING iv_col TYPE string
               CHANGING ct_tab TYPE gtt_tab_31.
  FIELD-SYMBOLS: <fs_col> TYPE any.
  ASSIGN COMPONENT iv_col OF STRUCTURE gs_data_31 TO <fs_col>.
  IF sy-subrc = 0.
    SORT ct_tab BY (iv_col).
  ELSE.
    WRITE: / 'Invalid column:', iv_col.
  ENDIF.
ENDFORM.

" Task 32
TYPES: BEGIN OF gty_line_32,
         col1 TYPE string,
         col2 TYPE string,
         col3 TYPE string,
       END OF gty_line_32.

TYPES: gtt_tab_32 TYPE TABLE OF gty_line_32 WITH EMPTY KEY.

TYPES: BEGIN OF gty_sort_32,
         col_name TYPE string,
       END OF gty_sort_32.

TYPES: gtt_sort_32 TYPE TABLE OF gty_sort_32 WITH EMPTY KEY.

DATA: gt_data_32 TYPE gtt_tab_32,
      gs_data_32 TYPE gty_line_32,
      gt_sort_32 TYPE gtt_sort_32,
      gs_sort_32 TYPE gty_sort_32.

FORM task32.
  APPEND VALUE #( col1 = 'C' col2 = 'Row 3 Col2' col3 = '3' ) TO gt_data_32.
  APPEND VALUE #( col1 = 'A' col2 = 'Row 1 Col2' col3 = '2' ) TO gt_data_32.
  APPEND VALUE #( col1 = 'B' col2 = 'Row 2 Col2' col3 = '1' ) TO gt_data_32.
  APPEND VALUE #( col1 = 'A' col2 = 'Row 4 Col2' col3 = '3' ) TO gt_data_32.

  APPEND VALUE #( col_name = 'col1' ) TO gt_sort_32.
  APPEND VALUE #( col_name = 'col3' ) TO gt_sort_32.

  WRITE: / 'Unsorted Table:'.
  LOOP AT gt_data_32 INTO gs_data_32.
    WRITE: / gs_data_32-col1, gs_data_32-col2, gs_data_32-col3.
  ENDLOOP.

  PERFORM sort_tab_multi USING gt_sort_32 CHANGING gt_data_32.

  WRITE: / 'Sorted Table:'.
  LOOP AT gt_data_32 INTO gs_data_32.
    WRITE: / gs_data_32-col1, gs_data_32-col2, gs_data_32-col3.
  ENDLOOP.
ENDFORM.

FORM sort_tab_multi USING it_sort TYPE gtt_sort_32
                 CHANGING ct_tab TYPE gtt_tab_32.
  DATA: lt_sort TYPE abap_sortorder_tab.

  LOOP AT it_sort INTO gs_sort_32.
    FIELD-SYMBOLS: <fs_col> TYPE any.
    ASSIGN COMPONENT gs_sort_32-col_name OF STRUCTURE gs_data_32 TO <fs_col>.
    IF sy-subrc = 0.
      APPEND VALUE abap_sortorder( name = gs_sort_32-col_name ) TO lt_sort.
    ELSE.
      WRITE: / 'Invalid column:', gs_sort_32-col_name.
    ENDIF.
  ENDLOOP.

  IF lt_sort IS NOT INITIAL.
    SORT ct_tab BY (lt_sort).
  ELSE.
    WRITE: / 'No valid columns provided for sorting.'.
  ENDIF.
ENDFORM.

INITIALIZATION.

START-OF-SELECTION.
  WRITE: / 'Task 1'.
  PERFORM task1.
  ULINE.

  WRITE: / 'Task 2'.
  PERFORM task2.
  ULINE.

  WRITE: / 'Task 3'.
  PERFORM task3 USING p_num1 p_num2.
  ULINE.

  WRITE: / 'Task 4'.
  PERFORM task4.
  ULINE.

  WRITE: / 'Task 5'.
  PERFORM task5.
  ULINE.

  WRITE: / 'Task 6'.
  PERFORM task6.
  ULINE.

  WRITE: / 'Task 7'.
  PERFORM task7.
  ULINE.

  WRITE: / 'Task 8'.
  PERFORM task8.
  ULINE.

  WRITE: / 'Task 9'.
  PERFORM task9.
  ULINE.

  WRITE: / 'Task 10'.
  PERFORM task10.
  ULINE.

  WRITE: / 'Task 11'.
  PERFORM task11.
  ULINE.

  WRITE: / 'Task 12'.
  PERFORM task12.
  ULINE.

  WRITE: / 'Task 13'.
  PERFORM task13.
  ULINE.

  WRITE: / 'Task 14'.
  PERFORM task14.
  ULINE.

  WRITE: / 'Task 15'.
  PERFORM task15.
  ULINE.

  WRITE: / 'Task 16'.
  PERFORM task16.
  ULINE.

  WRITE: / 'Task 17'.
  PERFORM task17.
  ULINE.

  WRITE: / 'Task 18'.
  PERFORM task18.
  ULINE.

  WRITE: / 'Task 19'.
  PERFORM task19.
  ULINE.

  WRITE: / 'Task 20'.
  PERFORM task20.
  ULINE.

  WRITE: / 'Task 21'.
  PERFORM task21.
  ULINE.

  WRITE: / 'Task 22'.
  PERFORM task22.
  ULINE.

  WRITE: / 'Task 23'.
  PERFORM task23.
  ULINE.

  WRITE: / 'Task 24'.
  PERFORM task24.
  ULINE.

  WRITE: / 'Task 25'.
  PERFORM task25.
  ULINE.

  WRITE: / 'Task 26'.
  PERFORM task26.
  ULINE.

  WRITE: / 'Task 27'.
  PERFORM task27.
  ULINE.

  WRITE: / 'Task 28'.
  PERFORM task28.
  ULINE.

  WRITE: / 'Task 29'.
  PERFORM task29.
  ULINE.

  WRITE: / 'Task 30'.
  PERFORM task30.
  ULINE.

  WRITE: / 'Task 31'.
  PERFORM task31.
  ULINE.

  WRITE: / 'Task 32'.
  PERFORM task32.
  ULINE.
