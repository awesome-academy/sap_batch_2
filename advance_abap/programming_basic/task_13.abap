*&---------------------------------------------------------------------*
*& Report ZSYR8411
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsyr8411.

*-----------------------Declare----------------------------------
TYPES: BEGIN OF lty_employee,
         persno    TYPE persno,       " Employee ID
         pad_name2 TYPE pad_name2,    " Full name
         gbdat     TYPE gbdat,        " Birthday
         gesch     TYPE gesch,        " Gender
         natsl     TYPE natsl,        " Nationality
       END OF lty_employee.

TYPES: BEGIN OF lty_nationality,
         natsl  TYPE natsl,           " Nationality
         natios TYPE char50,         " Description
       END OF lty_nationality.

TYPES: BEGIN OF lty_gender,
         gesch    TYPE gesch,         " Gender Key
         val_text TYPE val_text,      " Gender Description
       END OF lty_gender.

TYPES: BEGIN OF lty_gender_count,
         gesch    TYPE gesch,
         val_text TYPE val_text,
         count    TYPE i,
       END OF lty_gender_count.

DATA: lt_employee    TYPE TABLE OF lty_employee,
      lt_nationality TYPE TABLE OF lty_nationality,
      lt_gender      TYPE TABLE OF lty_gender,
      ls_employee    TYPE lty_employee,
      ls_nationality TYPE lty_nationality,
      ls_gender      TYPE lty_gender.

TYPES: BEGIN OF lty_age_group,
         natsl     TYPE natsl,
         gesch     TYPE gesch,
         val_text  TYPE val_text,
         natios    TYPE char50,
         total_age TYPE i,
       END OF lty_age_group.

DATA: lt_gender_count TYPE TABLE OF lty_gender_count,
      ls_gender_count TYPE lty_gender_count,
      lt_age_group    TYPE TABLE OF lty_age_group,
      ls_age_group    TYPE lty_age_group.

" Employee table
ls_employee-persno = '1441'.
ls_employee-pad_name2 = 'Rilke'.
ls_employee-gbdat = '19690622'.
ls_employee-gesch = '2'.
ls_employee-natsl = 'DE'.
APPEND ls_employee TO lt_employee.

ls_employee-persno = '14999'.
ls_employee-pad_name2 = 'Bee Hua'.
ls_employee-gbdat = '19800214'.
ls_employee-gesch = '2'.
ls_employee-natsl = 'MY'.
APPEND ls_employee TO lt_employee.

ls_employee-persno = '50000'.
ls_employee-pad_name2 = 'Schmidt'.
ls_employee-gbdat = '19641026'.
ls_employee-gesch = '2'.
ls_employee-natsl = 'DE'.
APPEND ls_employee TO lt_employee.

ls_employee-persno = '100080'.
ls_employee-pad_name2 = 'Harris'.
ls_employee-gbdat = '19560816'.
ls_employee-gesch = '1'.
ls_employee-natsl = 'US'.
APPEND ls_employee TO lt_employee.

ls_employee-persno = '100301'.
ls_employee-pad_name2 = 'Patricia'.
ls_employee-gbdat = '19500214'.
ls_employee-gesch = '2'.
ls_employee-natsl = 'US'.
APPEND ls_employee TO lt_employee.

ls_employee-persno = '109551'.
ls_employee-pad_name2 = 'Ethel Ballman'.
ls_employee-gbdat = '19521020'.
ls_employee-gesch = '2'.
ls_employee-natsl = 'US'.
APPEND ls_employee TO lt_employee.

" Nationality table
ls_nationality-natsl = 'DE'.
ls_nationality-natios = 'German'.
APPEND ls_nationality TO lt_nationality.

ls_nationality-natsl = 'MY'.
ls_nationality-natios = 'Malaysian'.
APPEND ls_nationality TO lt_nationality.

ls_nationality-natsl = 'US'.
ls_nationality-natios = 'American'.
APPEND ls_nationality TO lt_nationality.

" Gender Table
ls_gender-gesch = '1'.
ls_gender-val_text = 'Male'.
APPEND ls_gender TO lt_gender.

ls_gender-gesch = '2'.
ls_gender-val_text = 'Female'.
APPEND ls_gender TO lt_gender.

" 13.1
WRITE: / 'Task 1'.
WRITE: / 'ID', 15 'Name', 30 'Birthday', 45 'Gender', 60 'Nationality'.
LOOP AT lt_employee INTO ls_employee.
  READ TABLE lt_nationality INTO ls_nationality WITH KEY natsl = ls_employee-natsl.
  READ TABLE lt_gender INTO ls_gender WITH KEY gesch = ls_employee-gesch.

  WRITE: / ls_employee-persno, 15 ls_employee-pad_name2, 30 ls_employee-gbdat,
           45 ls_gender-val_text, 60 ls_nationality-natios.
ENDLOOP.
ULINE.

"13.2
LOOP AT lt_employee INTO ls_employee.
  READ TABLE lt_gender INTO ls_gender WITH KEY gesch = ls_employee-gesch.
  ls_gender_count-gesch = ls_employee-gesch.
  ls_gender_count-val_text = ls_gender-val_text.
  ls_gender_count-count = 1.

  COLLECT ls_gender_count INTO lt_gender_count.
ENDLOOP.

WRITE: / 'Task 2'.
LOOP AT lt_gender_count INTO ls_gender_count.
  WRITE: / 'Gender:', 20 ls_gender_count-val_text, 30 'Count:', 40 ls_gender_count-count.
ENDLOOP.
ULINE.

"13.3
LOOP AT lt_employee INTO ls_employee.
  READ TABLE lt_nationality INTO ls_nationality WITH KEY natsl = ls_employee-natsl.
  READ TABLE lt_gender INTO ls_gender WITH KEY gesch = ls_employee-gesch.

  ls_age_group-natsl = ls_employee-natsl.
  ls_age_group-gesch = ls_employee-gesch.
  ls_age_group-val_text = ls_gender-val_text.
  ls_age_group-natios = ls_nationality-natios.
  ls_age_group-total_age = sy-datum(4) - ls_employee-gbdat(4).

  COLLECT ls_age_group INTO lt_age_group.
ENDLOOP.

WRITE: / 'Task 3'.
LOOP AT lt_age_group INTO ls_age_group.
  WRITE: / 'Nationality:', ls_age_group-natios,
         'Gender:', ls_age_group-val_text,
         'Total Age:', ls_age_group-total_age.
ENDLOOP.
ULINE.

" 13.4
LOOP AT lt_employee INTO ls_employee.
  " Bài tập 2: Đếm số lượng theo giới tính
  READ TABLE lt_gender INTO ls_gender WITH KEY gesch = ls_employee-gesch.
  ls_gender_count-gesch = ls_employee-gesch.
  ls_gender_count-val_text = ls_gender-val_text.
  ls_gender_count-count = 1.
  COLLECT ls_gender_count INTO lt_gender_count.

  " Bài tập 3: Tính tổng tuổi theo quốc tịch và giới tính
  READ TABLE lt_nationality INTO ls_nationality WITH KEY natsl = ls_employee-natsl.
  ls_age_group-natsl = ls_employee-natsl.
  ls_age_group-gesch = ls_employee-gesch.
  ls_age_group-val_text = ls_gender-val_text.
  ls_age_group-natios = ls_nationality-natios.
  ls_age_group-total_age = sy-datum(4) - ls_employee-gbdat(4).
  COLLECT ls_age_group INTO lt_age_group.
ENDLOOP.

" Hiển thị kết quả
WRITE: / 'Task 4'.
LOOP AT lt_gender_count INTO ls_gender_count.
  WRITE: / 'Gender:', 20 ls_gender_count-val_text, 30 'Count:', 40 ls_gender_count-count.
ENDLOOP.

LOOP AT lt_age_group INTO ls_age_group.
  WRITE: / 'Nationality:', ls_age_group-natios,
         'Gender:', ls_age_group-val_text,
         'Total Age:', ls_age_group-total_age.
ENDLOOP.
ULINE.
