*&---------------------------------------------------------------------*
*& Report ZSYR8412
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsyr8412.

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

" Nhóm dữ liệu theo giới tính và quốc tịch
LOOP AT lt_employee INTO ls_employee
  GROUP BY ( gesch = ls_employee-gesch
             natsl = ls_employee-natsl ) ASCENDING
  INTO DATA(ls_group).

  " Đọc mô tả giới tính và quốc tịch từ các bảng
  READ TABLE lt_gender INTO ls_gender WITH KEY gesch = ls_group-gesch.
  READ TABLE lt_nationality INTO ls_nationality WITH KEY natsl = ls_group-natsl.

  " Bài tập 2: Tính tổng số người theo giới tính
  ls_gender_count-gesch = ls_group-gesch.
  ls_gender_count-val_text = ls_gender-val_text.
  ls_gender_count-count = 0.

  LOOP AT GROUP ls_group INTO ls_employee.
    ls_gender_count-count = ls_gender_count-count + 1.
  ENDLOOP.

  COLLECT ls_gender_count INTO lt_gender_count.

  " Bài tập 3: Tính tổng tuổi theo quốc tịch và giới tính
  ls_age_group-natsl = ls_group-natsl.
  ls_age_group-gesch = ls_group-gesch.
  ls_age_group-val_text = ls_gender-val_text.
  ls_age_group-natios = ls_nationality-natios.
  ls_age_group-total_age = 0.

  LOOP AT GROUP ls_group INTO ls_employee.
    ls_age_group-total_age = ls_age_group-total_age + ( sy-datum(4) - ls_employee-gbdat(4) ).
  ENDLOOP.

  COLLECT ls_age_group INTO lt_age_group.
ENDLOOP.

" 14.1
WRITE: / 'Task 1'.
LOOP AT lt_gender_count INTO ls_gender_count.
  WRITE: / 'Gender:', ls_gender_count-val_text, 'Count:', ls_gender_count-count.
ENDLOOP.
ULINE.

" 14.2
WRITE: / 'Task 2'.
LOOP AT lt_age_group INTO ls_age_group.
  WRITE: / 'Nationality:', ls_age_group-natios,
         'Gender:', ls_age_group-val_text,
         'Total Age:', ls_age_group-total_age.
ENDLOOP.
