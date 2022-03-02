CLASS zcl_bank_read_demo_06 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_bank_read_demo_06 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  " This Code Snippet uses the plain HTTP client to access an OData API.
" Using the more convenient OData client proxy instead requires a service consumption model to be in place.
" For documentation on how to create a service consumption model see:
" https://help.sap.com/viewer/c0d02c4330c34b3abca88bdd57eaccfc/DEV_CORR/en-US/5a6e4a72d3db49799bfd00073b2509ab.html
" and on how to use the OData client proxy see:
" https://help.sap.com/viewer/c0d02c4330c34b3abca88bdd57eaccfc/Cloud/en-US/98e06f2d2189412699fae82f35f66801.html

TRY.
*"create http destination by url; API endpoint for API sandbox
*DATA(lo_http_destination) =
*     cl_http_destination_provider=>create_by_url( 'https://sandbox.api.sap.com/s4hanacloud/sap/opu/odata/sap/API_BANKDETAIL_SRV/A_BankDetail' ).
*  "alternatively create HTTP destination via destination service
*    "cl_http_destination_provider=>create_by_cloud_destination( i_name = '<...>'
*     "                            i_service_instance_name = '<...>' )
*    "SAP Help: https://help.sap.com/viewer/65de2977205c403bbc107264b8eccf4b/Cloud/en-US/f871712b816943b0ab5e04b60799e518.html
*
*"Available API Endpoints
*"https://{host}:{port}/sap/opu/odata/sap/API_BANKDETAIL_SRV


DATA(lo_http_destination) = cl_http_destination_provider=>create_by_cloud_destination( i_name = 'HTTP_SANDBOX_DEMO_05' " <-- your destination name " -->
                                                                                       i_authn_mode = if_a4c_cp_service=>service_specific ).

"create HTTP client by destination
DATA(lo_web_http_client) = cl_web_http_client_manager=>create_by_http_destination( lo_http_destination ) .

"adding headers with API Key for API Sandbox
DATA(lo_web_http_request) = lo_web_http_client->get_http_request( ).
lo_web_http_request->set_uri_path( |/s4hanacloud/sap/opu/odata/sap/API_BANKDETAIL_SRV/A_BankDetail?$format=json| ).
lo_web_http_request->set_header_fields( VALUE #(
(  name = 'Accept' value = 'application/json' )
(  name = 'APIKey' value = 'lfPtPvAeUX4oUOFyBD02wveJue0urTmT' )
 ) ).

"Available Security Schemes for productive API Endpoints
"Bearer and Basic Authentication
"lo_web_http_request->set_authorization_bearer( i_bearer = '<...>' ).
"lo_web_http_request->set_authorization_basic( i_username = '<...>' i_password = '<...>' ).

"set request method and execute request
DATA(lo_web_http_response) = lo_web_http_client->execute( if_web_http_client=>get ).
DATA(lv_response) = lo_web_http_response->get_text( ).

CATCH cx_http_dest_provider_error cx_web_http_client_error cx_web_message_error.
    "error handling
ENDTRY.

"uncomment the following line for console output; prerequisite: code snippet is implementation of if_oo_adt_classrun~main
  out->write( |response:  { lv_response }| ).
  ENDMETHOD.
ENDCLASS.
