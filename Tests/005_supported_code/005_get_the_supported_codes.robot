*** Settings ***
Resource    ../../Resources/robot_resources/common.robot
Resource    ../../Resources/robot_resources/supported_code.robot
Test Tags   smoke

*** Variables ***
${API_KEY}    a54f9e17254e056d54ab74c8

*** Test Cases ***
Test getting supported codes with valid API key
   [Documentation]    Test supported codes API endpoint
   Given Get the supported codes by api key ${API_KEY}
   ${response}=    Set Variable    ${supported_codes_json['result']}
   ${documentation}=     Set Variable   ${supported_codes_json['documentation']}
   ${terms_of_use}=     Set Variable   ${supported_codes_json['terms_of_use']}
   ${supported_codes}=    Set Variable    ${supported_codes_json['supported_codes']}

   Then Should Be Equal    ${response}    success
   Then Should Be Equal    ${documentation}    https://www.exchangerate-api.com/docs
   Then Should Be Equal    ${terms_of_use}    https://www.exchangerate-api.com/terms
   Then Should Be True    ${supported_codes} != None
   Then Wait for 5000 milliseconds

Test inactive-account error
   [Documentation]    Test inactive-account error
   ${API_KEY}=           Set Variable   nln2
   Given Get the supported codes by api key ${API_KEY}
   ${error}=    Set Variable    ${supported_codes_json['result']}
   ${error_type}=     Set Variable   ${supported_codes_json['error-type']}

   Then Should Be Equal    ${error}    error
   Then Should Be Equal    ${error_type}    inactive-account
   Then Wait for 5000 milliseconds

Test invalid-key error
   [Documentation]    Test invalid-key error
   ${API_KEY}=           Set Variable   ea
   Given Get the supported codes by api key ${API_KEY}
   ${error}=    Set Variable    ${supported_codes_json['result']}
   ${error_type}=     Set Variable   ${supported_codes_json['error-type']}

   Then Should Be Equal    ${error}    error
   Then Should Be Equal    ${error_type}    invalid-key
   Then Wait for 5000 milliseconds
