CLASS z_class_demo_01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z_class_demo_01 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  out->write('Hello Sujeet Yadav!').
  ENDMETHOD.
ENDCLASS.
