*&---------------------------------------------------------------------*
*& Report ZSYRO1110_T13_GNV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsyro1110_t13_gnv.

*----------------------------------------------------------------------*
* Type definitions and data declarations
*----------------------------------------------------------------------*
TYPES: BEGIN OF ty_employee,
         gender      TYPE gesch,
         nationality TYPE natsl,
         id          TYPE persno,
         full_name   TYPE pad_name2,
         birthday    TYPE gbdat,
       END OF ty_employee,

       BEGIN OF ty_nationality,
         code        TYPE natsl,
         description TYPE natio50,
       END OF ty_nationality,

       BEGIN OF ty_gender,
         key         TYPE gesch,
         description TYPE val_text,
       END OF ty_gender.

DATA: gt_employee    TYPE TABLE OF ty_employee,
      gt_nationality TYPE TABLE OF ty_nationality,
      gt_gender      TYPE TABLE OF ty_gender,
      gs_employee    TYPE ty_employee,
      gs_nationality TYPE ty_nationality,
      gs_gender      TYPE ty_gender,
      gv_age         TYPE i,
      gv_count       TYPE i,
      lv_total_age   TYPE i.

*----------------------------------------------------------------------*
* Fill sample data
*----------------------------------------------------------------------*
START-OF-SELECTION.
  " Fill employee data
  gs_employee-id = '10000'.  gs_employee-full_name = 'Rilke'.
  gs_employee-birthday = '19600622'.  gs_employee-gender = 2.
  gs_employee-nationality = 'DE'.  APPEND gs_employee TO gt_employee.

  gs_employee-id = '14999'.  gs_employee-full_name = 'Bee Hua'.
  gs_employee-birthday = '19800214'.  gs_employee-gender = 2.
  gs_employee-nationality = 'MY'.  APPEND gs_employee TO gt_employee.

  gs_employee-id = '50000'.  gs_employee-full_name = 'Schmidt'.
  gs_employee-birthday = '19641026'.  gs_employee-gender = 2.
  gs_employee-nationality = 'DE'.  APPEND gs_employee TO gt_employee.

  gs_employee-id = '100080'.  gs_employee-full_name = 'Harris'.
  gs_employee-birthday = '19560816'.  gs_employee-gender = 1.
  gs_employee-nationality = 'US'.  APPEND gs_employee TO gt_employee.

  gs_employee-id = '100301'.  gs_employee-full_name = 'Patricia'.
  gs_employee-birthday = '19500214'.  gs_employee-gender = 2.
  gs_employee-nationality = 'US'.  APPEND gs_employee TO gt_employee.

  gs_employee-id = '100051'.  gs_employee-full_name = 'Ethel Ballman'.
  gs_employee-birthday = '19621020'.  gs_employee-gender = 2.
  gs_employee-nationality = 'US'.  APPEND gs_employee TO gt_employee.

  " Fill nationality data
  gs_nationality-code = 'DE'.  gs_nationality-description = 'German'.
  APPEND gs_nationality TO gt_nationality.
  gs_nationality-code = 'MY'.  gs_nationality-description = 'Malaysian'.
  APPEND gs_nationality TO gt_nationality.
  gs_nationality-code = 'US'.  gs_nationality-description = 'American'.
  APPEND gs_nationality TO gt_nationality.

  " Fill gender data
  gs_gender-key = 1.  gs_gender-description = 'Male'.
  APPEND gs_gender TO gt_gender.
  gs_gender-key = 2.  gs_gender-description = 'Female'.
  APPEND gs_gender TO gt_gender.

*----------------------------------------------------------------------*
* Exercise 1: Display employee information
*----------------------------------------------------------------------*
  SORT gt_employee BY id.

  WRITE: / 'Exercise 1: Display employee information'.
  ULINE.
  FORMAT COLOR COL_HEADING.
  WRITE: /3 'ID', 15 'Full Name', 40 'Birthday', 55 'Gender', 70 'Nationality'.
  FORMAT COLOR OFF.
  ULINE.

  LOOP AT gt_employee INTO gs_employee.
    " Get gender description
    READ TABLE gt_gender INTO gs_gender
      WITH KEY key = gs_employee-gender.

    " Get nationality description
    READ TABLE gt_nationality INTO gs_nationality
      WITH KEY code = gs_employee-nationality.

    WRITE: / gs_employee-id,
             gs_employee-full_name,
             gs_employee-birthday DD/MM/YYYY,
             gs_gender-description,
             gs_nationality-description.
  ENDLOOP.
  ULINE.

*----------------------------------------------------------------------*
* Exercise 2: Total of people grouped by gender and output screen
*----------------------------------------------------------------------*
  SORT gt_employee BY gender.
  WRITE: / 'Exercise 2: Total of people grouped by gender and output screen'.
  ULINE.
  CLEAR gv_count.

  LOOP AT gt_employee INTO gs_employee.
    AT NEW gender.
      gv_count = 0.
      READ TABLE gt_gender INTO gs_gender WITH KEY key = gs_employee-gender.
      WRITE: / 'Gender:', gs_gender-description.
    ENDAT.

    gv_count = gv_count + 1.

    AT END  OF gender.
      WRITE: / '  Total Count for Gender:', gv_count.
    ENDAT.
  ENDLOOP.
  ULINE.

*----------------------------------------------------------------------*
* Exercise 3: Total of age grouped by nationality and gender, output screen
*----------------------------------------------------------------------*
  SORT gt_employee BY  gender nationality.

  WRITE: / 'Exercise 3: Total of age grouped by nationality and gender, output screen'.
  ULINE.
  CLEAR: gv_age, lv_total_age.

  LOOP AT gt_employee INTO gs_employee.
    AT NEW nationality.
      READ TABLE gt_nationality INTO gs_nationality WITH KEY code = gs_employee-nationality.
    ENDAT.

    AT NEW gender.
      READ TABLE gt_gender INTO gs_gender WITH KEY key = gs_employee-gender.
    ENDAT.

    " Calculate age in years
    DATA(lv_age) = ( sy-datum - gs_employee-birthday ) / 365.

    " Accumulate total age for gender and nationality
    gv_age = gv_age + lv_age.

    AT END OF nationality.
      WRITE: / |Nationality: { gs_nationality-description }, Gender:, { gs_gender-description }, Total Age: { lv_total_age } |.
      gv_age = 0.
    ENDAT.
  ENDLOOP.
  ULINE.

*----------------------------------------------------------------------*
* Exercise 4: Use one loop with LOOP - AT…ENDAT to execute exercises 2 and 3
*----------------------------------------------------------------------*
  SORT gt_employee BY gender nationality.

  WRITE: / 'Exercise 4: Use one loop with LOOP - AT…ENDAT to execute exercises 2 and 3'.
  ULINE.
  CLEAR: gv_count, gv_age, lv_total_age.

  LOOP AT gt_employee INTO gs_employee.
    AT NEW nationality.
      READ TABLE gt_nationality INTO gs_nationality WITH KEY code = gs_employee-nationality.
    ENDAT.

    AT NEW gender.
      READ TABLE gt_gender INTO gs_gender WITH KEY key = gs_employee-gender.
    ENDAT.

    " Calculate age in years
    lv_age = ( sy-datum - gs_employee-birthday ) / 365.

    " Accumulate total age for gender and nationality
    gv_age = gv_age + lv_age.
    gv_count = gv_count + 1.

    AT END OF nationality.
      WRITE: / |Nationality: { gs_nationality-description }, Gender:, { gs_gender-description }, Total Age: { gv_age } |.
      gv_age = 0.
    ENDAT.

    AT END OF gender.
      WRITE: / |Gender:, { gs_gender-description }, Total COUNT: { gv_count } |.
      gv_count = 0.
    ENDAT.
  ENDLOOP.
  ULINE.
