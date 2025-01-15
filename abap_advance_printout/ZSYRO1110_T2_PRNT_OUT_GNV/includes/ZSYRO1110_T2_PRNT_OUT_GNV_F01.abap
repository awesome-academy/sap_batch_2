*&---------------------------------------------------------------------*
*& Include          ZSYRO1110_T2_PRNT_OUT_GNV_F01
*&---------------------------------------------------------------------*

FORM fetch_data.
  SELECT * FROM zyscarr1t INTO CORRESPONDING FIELDS OF TABLE @gt_scarr.
ENDFORM.


FORM build_field_catalog.
  DATA: lt_fieldcat TYPE slis_t_fieldcat_alv,
        lv_tabname  TYPE slis_tabname VALUE 'ZYSCARR1T'.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name = lv_tabname
    CHANGING
      ct_fieldcat      = lt_fieldcat.

  gt_fieldcat = lt_fieldcat.
ENDFORM.


FORM display_alv.
  gs_layout-zebra = 'X'.
  gs_layout-colwidth_optimize = 'X'.
  gs_layout-edit = 'X'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program      = sy-repid
      i_callback_user_command = 'USER_COMMAND'
      is_layout               = gs_layout
      it_fieldcat             = gt_fieldcat
    TABLES
      t_outtab                = gt_scarr
    EXCEPTIONS
      program_error           = 1
      OTHERS                  = 2.

  IF sy-subrc <> 0.
    MESSAGE TEXT-003 TYPE 'E'.
  ENDIF.
ENDFORM.


FORM user_command USING r_ucomm LIKE sy-ucomm
                        rs_selfield TYPE slis_selfield.
  CASE r_ucomm.
    WHEN '&DATA_SAVE'.
      PERFORM save_data.
  ENDCASE.
ENDFORM.


FORM save_data.
  MODIFY zyscarr1t FROM TABLE gt_scarr.
  IF sy-subrc = 0.
    COMMIT WORK.
    MESSAGE TEXT-001 TYPE 'S'.
  ELSE.
    ROLLBACK WORK.
    MESSAGE TEXT-002 TYPE 'E'.
  ENDIF.
ENDFORM.
