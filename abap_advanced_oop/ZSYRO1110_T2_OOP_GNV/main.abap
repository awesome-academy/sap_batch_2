*&---------------------------------------------------------------------*
*& Report ZSYRO1110_T2_OOP_GNV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSYRO1110_T2_OOP_GNV.

* Local Class Definition
CLASS lcl_num_processor DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING iv_num1 TYPE i
                                   iv_num2 TYPE i,
             compare_numbers,
             calculate_result.

  PRIVATE SECTION.
    DATA: mv_num1 TYPE i,
          mv_num2 TYPE i.
ENDCLASS.

* Local Class Implementation
CLASS lcl_num_processor IMPLEMENTATION.
  METHOD constructor.
    mv_num1 = iv_num1.
    mv_num2 = iv_num2.
  ENDMETHOD.

  METHOD compare_numbers.
    IF mv_num1 > mv_num2.
      WRITE: / |{ mv_num1 } > { mv_num2 }|.
    ELSEIF mv_num1 < mv_num2.
      WRITE: / |{ mv_num1 } < { mv_num2 }|.
    ELSE.
      WRITE: / |{ mv_num1 } = { mv_num2 }|.
    ENDIF.
  ENDMETHOD.

  METHOD calculate_result.
    DATA: lv_result TYPE i.
    lv_result = mv_num2 * ( mv_num1 + mv_num1 * mv_num2 ).
    WRITE: / 'Calculation Result:', lv_result.
  ENDMETHOD.
ENDCLASS.

* Selection Screen Definition
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_num01 TYPE n OBLIGATORY, " Num. 1
            p_num02 TYPE n OBLIGATORY. " Num. 2
SELECTION-SCREEN END OF BLOCK b1.

* Start of Selection
START-OF-SELECTION.
  DATA: go_num_processor TYPE REF TO lcl_num_processor.

  " Create object and pass input parameters
  CREATE OBJECT go_num_processor
    EXPORTING
      iv_num1 = CONV i( p_num01 )
      iv_num2 = CONV i( p_num02 ).

  " Compare numbers
  go_num_processor->compare_numbers( ).

  " Calculate and display result
  go_num_processor->calculate_result( ).
