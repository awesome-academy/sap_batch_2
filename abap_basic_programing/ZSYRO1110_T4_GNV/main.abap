*&---------------------------------------------------------------------*
*& Report ZSYRO1110_T4_GNV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zsyro1110_t4_gnv.

" Step 1: Declare a TYPE as a character with 10 positions.
TYPES: gty_char10 TYPE c LENGTH 10.

" Step 2: Declare an integer.
DATA: lv_integer TYPE i.

" Step 3: Declare a TYPE as a number with 7 positions.
TYPES: gty_num7 TYPE n LENGTH 7.

" Step 4: Declare a date type.
DATA: lv_date TYPE d.

" Step 5: Declare a time type.
DATA: lv_time TYPE t.

" Step 6: Declare a structure type with 5 fields of specified types.
TYPES: BEGIN OF gty_struct1,
         field1 TYPE gty_char10,
         field2 TYPE i,
         field3 TYPE gty_num7,
         field4 TYPE d,
         field5 TYPE t,
       END OF gty_struct1.

" Step 7: Declare a type using the global structure SFLIGHT.
TYPES: gty_sflight TYPE sflight.

" Step 8: Declare a structure type with specific components of SFLIGHT.
TYPES: BEGIN OF gty_sfl_partial, " Shortened from gty_sflight_partial
         carrid    TYPE sflight-carrid,
         connid    TYPE sflight-connid,
         fldate    TYPE sflight-fldate,
         price     TYPE sflight-price,
         currency  TYPE sflight-currency,
         planetype TYPE sflight-planetype,
         seatsmax  TYPE sflight-seatsmax,
         seatsocc  TYPE sflight-seatsocc,
       END OF gty_sfl_partial.

" Step 9: Declare a structure type with specific components of SBOOK.
TYPES: BEGIN OF gty_sbook_part, " Shortened from gty_sbook_partial
         carrid   TYPE sbook-carrid,
         connid   TYPE sbook-connid,
         fldate   TYPE sbook-fldate,
         bookid   TYPE sbook-bookid,
         customid TYPE sbook-customid,
       END OF gty_sbook_part.

" Step 10: Declare a structure containing all fields from Steps 8 and 9.
TYPES: BEGIN OF gty_comb_struct, " Shortened from gty_combined_struct
         bookid   TYPE sbook-bookid,
         customid TYPE sbook-customid,
         include  TYPE gty_sfl_partial.
TYPES: END OF gty_comb_struct.

DATA: ls_comb_struct TYPE gty_comb_struct.

" Step 11: Declare a table type of integers.
TYPES: gtt_int_table TYPE TABLE OF i.

" Step 12: Declare a table type with all components of SFLIGHT.
TYPES: gtt_sflight TYPE TABLE OF sflight.

" Step 13: Declare a table type using the structure type created in Step 8.
TYPES: gtt_sfl_partial TYPE TABLE OF gty_sfl_partial.

" Step 14: Declare a table type with specific fields of SBOOK and CUSTOMID as part of the key.
TYPES: gtt_sbook_keyed TYPE TABLE OF gty_sbook_part WITH KEY carrid connid
fldate customid.

" Step 15: Declare a character variable with 10 positions and initial value 'Hello ABAP'.
##NO_TEXT
DATA: lv_hello TYPE gty_char10 VALUE 'Hello ABAP'.

" Step 16: Declare a numeric variable with 4 positions and initial value 1234.
DATA: lv_num4 TYPE n LENGTH 4 VALUE '1234'. " Shortened from lv_numeric

" Step 17: Declare an integer variable with initial value 42.
DATA: lv_int42 TYPE i VALUE 42.

" Step 18: Declare an integer variable with initial value 12.72.
DATA: lv_int12 TYPE i VALUE 12.

" Step 19: Declare a date variable with Halloween day.
DATA: lv_halloween TYPE d VALUE '20231031'.

" Step 20: Declare a packed number variable with 7 decimal places.
DATA: lv_packed7 TYPE p DECIMALS 7. " Shortened from lv_packed

" Step 21: Declare a variable of type S_CARR_ID.
DATA: lv_carr_id TYPE s_carr_id. " Shortened from lv_s_carr_id

" Step 22: Declare a variable of the same type as field carrid from table SPFLI.
DATA: lv_carrid TYPE spfli-carrid.

" Step 23: Declare a variable of the same type as field fldate from SFLIGHT.
DATA: lv_fldate TYPE sflight-fldate.

" Step 24: Declare a structure of the same type as SBOOK.
DATA: ls_sbook TYPE sbook. " Shortened from ls_sbook_struct

" Step 25: Declare a structure with specific fields of SFLIGHT.
DATA: BEGIN OF ls_sfl_fields, " Shortened from ls_sflight_fields
        carrid    TYPE sflight-carrid,
        connid    TYPE sflight-connid,
        fldate    TYPE sflight-fldate,
        price     TYPE sflight-price,
        currency  TYPE sflight-currency,
        planetype TYPE sflight-planetype,
        seatsmax  TYPE sflight-seatsmax,
        seatsocc  TYPE sflight-seatsocc,
      END OF ls_sfl_fields.

" Step 26: Declare a structure with all fields of SBOOK and TELEPHONE from SCUSTOM.
DATA: BEGIN OF ls_sbook_scust, " Shortened from ls_sbook_scust_fields
        include   TYPE sbook,
        telephone TYPE scustom-telephone,
      END OF ls_sbook_scust.

" Step 27: Declare an internal table with specific fields of SBOOK.
DATA: lt_sbook TYPE TABLE OF gty_sbook_part. " Shortened from lt_sbook_table

" Step 28: Declare an internal table with all fields of SCARR.
DATA: lt_scarr TYPE TABLE OF scarr. " Shortened from lt_scarr_table

" Step 29: Declare an internal table with all fields of SPFLI.
DATA: lt_spfli TYPE TABLE OF spfli. " Shortened from lt_spfli_table

" Step 30: Declare an internal table with fields of SCARR and TELEPHONE from SCUSTOM.
DATA: BEGIN OF lt_scarr_scust OCCURS 0, " Shortened from lt_scarr_scust_table
        include   TYPE scarr,
        telephone TYPE scustom-telephone,
      END OF lt_scarr_scust.

" Step 31: Declare a constant containing your name.
##NO_TEXT
CONSTANTS: gc_my_name TYPE c LENGTH 50 VALUE 'Your Name'.

" Step 32: Declare constants for 'X' (true) and ' ' (false).
CONSTANTS: gc_true  TYPE c LENGTH 1 VALUE 'X',
           gc_false TYPE c LENGTH 1 VALUE ' '.

" Step 33: Declare a constant containing the first 5 decimals of Pi.
CONSTANTS: gc_pi TYPE p DECIMALS 5 VALUE '3.14159'.

" Step 34: Declare a work area of constants with integer components.
DATA: BEGIN OF wa_constants,
        const1 TYPE i VALUE 1,
        const2 TYPE i VALUE 2,
        const3 TYPE i VALUE 3,
        const4 TYPE i VALUE 4,
        const5 TYPE i VALUE 5,
      END OF wa_constants.

" Step 35: Declare a work area of 5 constant components of different primitive types.
DATA: BEGIN OF wa_mixed_const,
        const_char   TYPE c LENGTH 10 VALUE 'CONST',
        const_num    TYPE n LENGTH 7 VALUE '1234567',
        const_date   TYPE d VALUE '20240101',
        const_time   TYPE t VALUE '123456',
        const_packed TYPE p DECIMALS 2 VALUE '12.34',
      END OF wa_mixed_const.

" Step 36: Is it possible to declare an internal table of constants?
" Answer: No, constants cannot be directly declared as an internal table.

" Step 37: Declare all types and constants from type-pools ABAP and ICON.
TYPE-POOLS: abap, icon.

" Step 38: Declare a constant with the same type as another constant.
CONSTANTS: gc_pi_copy TYPE p DECIMALS 5 VALUE gc_pi.

" Step 39: Declare a type used in other constructs.
TYPES: gty_common TYPE c LENGTH 20.
DATA: lv_common  TYPE gty_common,
      ls_common  TYPE gty_common,
      lt_common  TYPE TABLE OF gty_common,
      gc_common  TYPE gty_common VALUE 'COMMON'.

" Step 40: Declare a variable used in other constructs.
DATA: lv_reusable TYPE c LENGTH 15.
TYPES: gty_reusable TYPE c LENGTH 15.
DATA: ls_reusable TYPE gty_reusable.
DATA: lt_reusable TYPE TABLE OF gty_reusable.
CONSTANTS: gc_reusable TYPE gty_reusable VALUE '123'.