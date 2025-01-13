*&---------------------------------------------------------------------*
*& Report ZPG_OOP1_PY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpg_oop1_py NO STANDARD PAGE HEADING.

* Define a class to handle the logic
CLASS lcl_comparison_calculation DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING iv_num01 TYPE i
                                   iv_num02 TYPE i,
             compare_numbers,
             perform_calculation.
  PRIVATE SECTION.
    DATA: mv_num01 TYPE i,
          mv_num02 TYPE i.
ENDCLASS.

* Implement the class methods
CLASS lcl_comparison_calculation IMPLEMENTATION.
  METHOD constructor.
    mv_num01 = iv_num01.
    mv_num02 = iv_num02.
  ENDMETHOD.

  METHOD compare_numbers.
    IF mv_num01 > mv_num02.
      WRITE: / |{ mv_num01 } > { mv_num02 }|.
    ELSEIF mv_num01 < mv_num02.
      WRITE: / |{ mv_num01 } < { mv_num02 }|.
    ELSE.
      WRITE: / |{ mv_num01 } = { mv_num02 }|.
    ENDIF.
  ENDMETHOD.

  METHOD perform_calculation.
    DATA: lv_result TYPE i.
    lv_result = mv_num02 * ( mv_num01 + mv_num01 * mv_num02 ).
    WRITE: / 'Calculation Result:', lv_result.
  ENDMETHOD.
ENDCLASS.

* Selection screen definition
PARAMETERS: p_num01 TYPE i,
            p_num02 TYPE i.

* Start of the program
START-OF-SELECTION.
  DATA: lo_calculator TYPE REF TO lcl_comparison_calculation.

  CREATE OBJECT lo_calculator
    EXPORTING
      iv_num01 = p_num01
      iv_num02 = p_num02.

  lo_calculator->compare_numbers( ).
  lo_calculator->perform_calculation( ).
