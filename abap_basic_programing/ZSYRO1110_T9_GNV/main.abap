*&---------------------------------------------------------------------*
*& Report ZSYRO1110_T9_GNV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZSYRO1110_T9_GNV.



* Selection screen for user to choose which display they want
PARAMETERS: p_all   RADIOBUTTON GROUP g1 DEFAULT 'X',
           p_prime RADIOBUTTON GROUP g1.

* Main program
START-OF-SELECTION.
  IF p_all = 'X'.
    PERFORM display_all_numbers.
  ELSE.
    PERFORM display_prime_numbers.
  ENDIF.

*&---------------------------------------------------------------------*
*&      Form  display_all_numbers
*&---------------------------------------------------------------------*
FORM display_all_numbers.
  DATA: lv_counter TYPE i VALUE 0.

  WRITE: / 'Numbers from 0 to 20:'.
  SKIP.

  DO 21 TIMES.
    WRITE: / lv_counter.
    lv_counter = lv_counter + 1.
  ENDDO.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  display_prime_numbers
*&---------------------------------------------------------------------*
FORM display_prime_numbers.
  DATA: lv_number      TYPE i,
        lv_is_prime    TYPE c LENGTH 1.

  WRITE: / 'Prime numbers between 0 and 20:'.
  SKIP.

  DO 21 TIMES.
    lv_number = sy-index - 1.  "sy-index starts from 1

    PERFORM check_prime_number USING lv_number
                              CHANGING lv_is_prime.

    IF lv_is_prime = 'X'.
      WRITE: / lv_number.
    ENDIF.
  ENDDO.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  check_prime_number
*&---------------------------------------------------------------------*
FORM check_prime_number USING    p_number    TYPE i
                       CHANGING  p_is_prime  TYPE c.
  DATA: lv_divisor     TYPE i,
        lv_sqrt        TYPE i.

  " Initialize result
  p_is_prime = ''.

  " Skip numbers less than or equal to 1 (not prime)
  IF p_number <= 1.
    RETURN.
  ENDIF.

  " Check if number is 2 (only even prime)
  IF p_number = 2.
    p_is_prime = 'X'.
    RETURN.
  ENDIF.

  " Check if number is even (not prime)
  IF p_number MOD 2 = 0.
    RETURN.
  ENDIF.

  " Calculate square root of p_number
  lv_sqrt = sqrt( p_number ).

  " Check divisibility from 3 to square root of p_number, step 2 (skip even numbers)
  DO lv_sqrt TIMES.
    lv_divisor = sy-index * 2 + 1. " Start from 3 and increment by 2

    " Exit if divisor exceeds square root
    IF lv_divisor > lv_sqrt.
      EXIT.
    ENDIF.

    " If number is divisible by divisor, it's not prime
    IF p_number MOD lv_divisor = 0.
      RETURN.
    ENDIF.
  ENDDO.

  " If no divisors found, number is prime
  p_is_prime = 'X'.
ENDFORM.