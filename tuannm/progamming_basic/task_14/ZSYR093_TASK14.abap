*&---------------------------------------------------------------------*
*& Programming Basic Task14 by TuanNM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSYR093_TASK14.

" Declare local types, tables and structures
TYPES:
  BEGIN OF lty_employee,
    gender      TYPE gesch,
    nationality TYPE natsl,
    emp_id      TYPE persno,
    full_name   TYPE pad_name2,
    birthday    TYPE gbdat,
  END OF lty_employee,

  BEGIN OF lty_gender,
    gender_key  TYPE gesch,
    description TYPE val_text,
  END OF lty_gender,

  BEGIN OF lty_nationality,
    nat_key     TYPE natsl,
    description TYPE natio50,
  END OF lty_nationality.

DATA:
  lt_employee     TYPE STANDARD TABLE OF lty_employee,
  ls_employee     TYPE lty_employee,
  lt_gender       TYPE STANDARD TABLE OF lty_gender,
  ls_gender       TYPE lty_gender,
  lt_nationality  TYPE STANDARD TABLE OF lty_nationality,
  ls_nationality  TYPE lty_nationality,
  lv_total_age1   TYPE i,
  lv_age          TYPE i,
  lv_current_year TYPE i,
  lt_aggregated   TYPE TABLE OF string,
  lv_count_male   TYPE i,
  lv_count_female TYPE i.

" Add data into table GENDER
ls_gender-gender_key = '1'.
ls_gender-description = 'Male'.
APPEND ls_gender TO lt_gender.

ls_gender-gender_key = '2'.
ls_gender-description = 'Female'.
APPEND ls_gender TO lt_gender.

ls_gender-gender_key = ''.
ls_gender-description = 'Unknown'.
APPEND ls_gender TO lt_gender.

" Add data into table NATIONALITY
ls_nationality-nat_key = 'DE'.
ls_nationality-description = 'German'.
APPEND ls_nationality TO lt_nationality.

ls_nationality-nat_key = 'MY'.
ls_nationality-description = 'Malaysian'.
APPEND ls_nationality TO lt_nationality.

ls_nationality-nat_key = 'US'.
ls_nationality-description = 'American'.
APPEND ls_nationality TO lt_nationality.

" Add data into table EMPLOYEE
ls_employee-emp_id = '1441'.
ls_employee-full_name = 'Rilke'.
ls_employee-birthday = '19690622'.
ls_employee-gender = '2'.
ls_employee-nationality = 'DE'.
APPEND ls_employee TO lt_employee.

ls_employee-emp_id = '14999'.
ls_employee-full_name = 'Bee Hua'.
ls_employee-birthday = '19800214'.
ls_employee-gender = '2'.
ls_employee-nationality = 'MY'.
APPEND ls_employee TO lt_employee.

ls_employee-emp_id = '50000'.
ls_employee-full_name = 'Schmidt'.
ls_employee-birthday = '19641026'.
ls_employee-gender = '2'.
ls_employee-nationality = 'DE'.
APPEND ls_employee TO lt_employee.

ls_employee-emp_id = '100080'.
ls_employee-full_name = 'Harris'.
ls_employee-birthday = '19560816'.
ls_employee-gender = '1'.
ls_employee-nationality = 'US'.
APPEND ls_employee TO lt_employee.

ls_employee-emp_id = '100301'.
ls_employee-full_name = 'Patricia'.
ls_employee-birthday = '19500214'.
ls_employee-gender = '2'.
ls_employee-nationality = 'US'.
APPEND ls_employee TO lt_employee.

ls_employee-emp_id = '109551'.
ls_employee-full_name = 'Ethel Ballman'.
ls_employee-birthday = '19521020'.
ls_employee-gender = '2'.
ls_employee-nationality = 'US'.
APPEND ls_employee TO lt_employee.

lv_current_year = sy-datum+0(4).

SORT lt_employee BY nationality gender.

" Calculate age using GROUP BY
LOOP AT lt_employee INTO ls_employee
  GROUP BY ( nationality = ls_employee-nationality
             gender      = ls_employee-gender )
  ASCENDING
  ASSIGNING FIELD-SYMBOL(<group1>).

  " count total with each group
  CLEAR lv_total_age1.
  LOOP AT GROUP <group1> ASSIGNING FIELD-SYMBOL(<employee1>).
    IF <employee1>-gender = '1'.
      Lv_count_male = lv_count_male + 1.
    ELSE.
      lv_count_female = lv_count_female + 1.
    ENDIF.

    " calculate age
    lv_age = lv_current_year - <employee1>-birthday+0(4).
    lv_total_age1 = lv_total_age1 + lv_age.
  ENDLOOP.

  WRITE: /'Nationality:', <group1>-nationality,
          'Gender:', <group1>-gender,
          'Total Age:', lv_total_age1.
  WRITE: / sy-uline(80).
ENDLOOP.

WRITE: / 'Gender Statistics:'.
WRITE: / 'Total male:', lv_count_male,
       / 'Total female:', lv_count_female.