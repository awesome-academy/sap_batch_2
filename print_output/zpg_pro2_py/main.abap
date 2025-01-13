*&---------------------------------------------------------------------*
*& Report ZPG_PRO2_PY
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zpg_pro2_py.

DATA: gt_scarr     TYPE TABLE OF zyairl3t,
      go_alv_table TYPE REF TO cl_gui_alv_grid,
      gt_fieldcat  TYPE lvc_t_fcat,
      gs_layout    TYPE lvc_s_layo.

START-OF-SELECTION.
  SELECT * FROM zyairl3t INTO CORRESPONDING FIELDS OF TABLE gt_scarr.

  PERFORM handle_alv.

*&---------------------------------------------------------------------*
*& Form HANDLE_ALV
*&---------------------------------------------------------------------*
*& handle alv
*&---------------------------------------------------------------------*
FORM handle_alv .
  PERFORM create_alv_object.
  PERFORM prepare_alv.
  PERFORM display_alv.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form CREATE_ALV_OBJECT
*&---------------------------------------------------------------------*
*& Tạo đối tượng ALV Grid và gán nó cho biến toàn cục go_alv_table
*&---------------------------------------------------------------------*
FORM create_alv_object.
  " Tạo mới một đối tượng ALV Grid (cl_gui_alv_grid)
  " Tham số i_parent xác định container chứa ALV Grid.
  " Ở đây, container mặc định là màn hình tiêu chuẩn (default_screen).
  go_alv_table = NEW cl_gui_alv_grid(
                    i_parent = cl_gui_custom_container=>default_screen
                  ).

ENDFORM.

*&---------------------------------------------------------------------*
*& Form PREPARE_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      <-- go_alv_table
*&---------------------------------------------------------------------*
FORM prepare_alv.

  DATA: lv_struct  TYPE dd02l-tabname,
        lt_exclude TYPE TABLE OF string
        .

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZYAIRL3T'
    CHANGING
      ct_fieldcat            = gt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc <> 0.
* Implement suitable error handling here
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  LOOP AT gt_fieldcat INTO DATA(gs_fcat).
    gs_fcat-edit = abap_true.
    MODIFY gt_fieldcat FROM gs_fcat.
  ENDLOOP.

  gs_layout-cwidth_opt = abap_true.
  gs_layout-col_opt    = abap_true.
  gs_layout-zebra      = abap_true.
  gs_layout-sel_mode   = 'A'.

  gs_layout-edit_mode = abap_true. " Bật chế độ chỉnh sửa cho tất cả cột
ENDFORM.

*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV
*&---------------------------------------------------------------------*
*& display alv
*&---------------------------------------------------------------------*
*&      <-- go_alv_table
*&---------------------------------------------------------------------*
FORM display_alv.
  go_alv_table->set_table_for_first_display(
    EXPORTING
      is_layout                     = gs_layout
    CHANGING
      it_outtab                     = gt_scarr
      it_fieldcatalog               = gt_fieldcat
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4
    ).

  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  CALL SCREEN 9000.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form SAVE_DB
*&---------------------------------------------------------------------*
*& lưu các dòng được chọn vào db
*&---------------------------------------------------------------------*
FORM save_db .

  DATA: lv_index          TYPE  sy-tabix,
        lt_scarr_selected TYPE TABLE OF zyairl3t,
        lt_selected_rows  TYPE lvc_t_row.

  " Xác minh dữ liệu đã được thay đổi trong ALV Grid
  go_alv_table->check_changed_data( ).

  " Lấy danh sách các dòng được chọn từ ALV Grid
  go_alv_table->get_selected_rows(
    IMPORTING
      et_index_rows = lt_selected_rows " Dữ liệu index các dòng được chọn
   ).

  " Kiểm tra nếu không có dòng nào được chọn
  IF lt_selected_rows IS INITIAL.
    MESSAGE TEXT-i02 TYPE 'I'.
  ENDIF.

  LOOP AT gt_scarr INTO DATA(ls_scarr).
    lv_index = sy-tabix. " Lấy chỉ số dòng hiện tại

    " Bỏ qua dòng nếu không nằm trong danh sách dòng được chọn
    IF NOT line_exists( lt_selected_rows[ index = lv_index ] ).
      CONTINUE.
    ENDIF.

    " Thêm cấu trúc tạm vào bảng dữ liệu được chọn
    APPEND ls_scarr TO lt_scarr_selected.
  ENDLOOP.

  IF lt_scarr_selected IS INITIAL.
    MESSAGE TEXT-i05 TYPE 'I'.

    RETURN.
  ENDIF.

  TRY.
      UPDATE zyairl3t FROM TABLE @lt_scarr_selected.
      MESSAGE 'Success' TYPE 'S'.
    CATCH cx_sy_open_sql_db INTO DATA(lx_sql_error).
      " Xử lý lỗi nếu chèn dữ liệu không thành công
      MESSAGE 'Error' TYPE 'E'.
  ENDTRY.

ENDFORM.

*&---------------------------------------------------------------------*
*& Module STATUS_9000 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_9000 OUTPUT.
  SET PF-STATUS 'ZGS_ALV_PY'.
ENDMODULE.

*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_9000  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_9000 INPUT.
  CASE sy-ucomm.
    WHEN 'BACK'.
      LEAVE TO SCREEN 0.
    WHEN 'EXIT'.
      LEAVE PROGRAM.
    WHEN 'CANCEL'.
      LEAVE TO SCREEN 0.
    WHEN 'SAVE'.
      PERFORM save_db.
  ENDCASE.
ENDMODULE.
