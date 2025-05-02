CLASS zar_fill_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zar_fill_data IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    SELECT * FROM zdh_t_order_item INTO TABLE @DATA(lt_orderitem).
    IF sy-subrc = 0.
      DELETE zdh_t_order_item FROM TABLE @lt_orderitem.
    ENDIF.

    lt_orderitem = VALUE #(
        ( order_id = '0000001234' item_no = '00010' description = 'Accessories' isoutline = abap_true )

        ( order_id = '0000001234' item_no = '00020' description = 'I/O Devices' isoutline = abap_true )
            ( order_id = '0000001234' item_no = '00040' description = 'Headset'   parent_item_no = '00020'    net_price = 5000    currency = 'INR' )
            ( order_id = '0000001234' item_no = '00050' description = 'Mouse'     parent_item_no = '00020'    net_price = 800     currency = 'INR' )
            ( order_id = '0000001234' item_no = '00060' description = 'Keyboard'  parent_item_no = '00020'    net_price = 1500    currency = 'INR' )

        ( order_id = '0000001234' item_no = '00030' description = 'Memory Devices' isoutline = abap_true )
            ( order_id = '0000001234' item_no = '00070' description = 'Hard disk' parent_item_no = '00030'    net_price = 3500    currency = 'INR'  )
            ( order_id = '0000001234' item_no = '00080' description = 'USB Drive' parent_item_no = '00030'    net_price = 350     currency = 'INR' )


        ( order_id = '0000002345' item_no = '00020' description = 'I/O Devices' isoutline = abap_true )
            ( order_id = '0000002345' item_no = '00040' description = 'Headset'   parent_item_no = '00020'    net_price = 5000    currency = 'INR' )
            ( order_id = '0000002345' item_no = '00050' description = 'Mouse'     parent_item_no = '00020'    net_price = 800     currency = 'INR' )
            ( order_id = '0000002345' item_no = '00060' description = 'Keyboard'  parent_item_no = '00020'    net_price = 1500    currency = 'INR' )

        ( order_id = '0000002345' item_no = '00030' description = 'Memory Devices' isoutline = abap_true )
            ( order_id = '0000002345' item_no = '00070' description = 'Hard disk' parent_item_no = '00030'    net_price = 3500    currency = 'INR'  )
            ( order_id = '0000002345' item_no = '00080' description = 'USB Drive' parent_item_no = '00030'    net_price = 350     currency = 'INR' )
            ( order_id = '0000002345' item_no = '00060' description = 'Keyboard'  parent_item_no = '00030'    net_price = 1500    currency = 'INR' )
            ( order_id = '0000002345' item_no = '00090' description = 'Keyboard'  parent_item_no = '00030'    net_price = 1500    currency = 'INR' )
    ).

    MODIFY zdh_t_order_item FROM TABLE @lt_orderitem.

    out->write( |{ sy-dbcnt } rows modified| ).

    SELECT * FROM zdh_t_order INTO TABLE @DATA(lt_header).
    IF sy-subrc IS INITIAL.
      DELETE zdh_t_order FROM TABLE @lt_header.
    ENDIF.

    lt_header = VALUE #(
                         ( order_id = '0000001234'
                           description = 'Stuff'
                           total_amount = 30000
                           currency = 'INR'
                           status  = 'SELL'
                         )
                         ( order_id = '0000002345'
                           description = 'Stuff'
                           total_amount = 34000
                           currency = 'INR'
                           status  = 'BUY'
                         )
                        ).
    MODIFY zdh_t_order FROM TABLE @lt_header.
    out->write( |{ sy-dbcnt } rows modified| ).

  ENDMETHOD.
ENDCLASS.
