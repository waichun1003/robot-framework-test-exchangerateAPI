*** Settings ***
Resource    ../../Resources/robot_resources/common.robot
Resource    ../../Resources/robot_resources/api_request_quota.robot
Test Tags   smoke

*** Variables ***
${API_KEY}    a54f9e17254e056d54ab74c8

*** Test Cases ***
Test getting the plan quota with valid API key
   [Documentation]    Test plan quota API endpoint
   Given Get the plan quota by api key ${API_KEY}
   ${response}=    Set Variable    ${quota_json['result']}
   ${documentation}=     Set Variable   ${quota_json['documentation']}
   ${terms_of_use}=     Set Variable   ${quota_json['terms_of_use']}
   ${plan_quota}=    Set Variable    ${quota_json['plan_quota']}
   ${requests_remaining}=    Set Variable    ${quota_json['requests_remaining']}
   ${refresh_day_of_month}=    Set Variable    ${quota_json['refresh_day_of_month']}

   Then Should Be Equal    ${response}    success
   Then Should Be Equal    ${documentation}    https://www.exchangerate-api.com/docs
   Then Should Be Equal    ${terms_of_use}    https://www.exchangerate-api.com/terms
   Then Should Be True    ${plan_quota} != None
   Then Should Be True    ${requests_remaining} !=  None
   Then Should Be True    ${refresh_day_of_month} != None

Test inactive-account error
   [Documentation]    Test inactive-account error
   ${API_KEY}=           Set Variable   nln2
   Given Get the plan quota by api key ${API_KEY}
   ${error}=    Set Variable    ${quota_json['result']}
   ${error_type}=     Set Variable   ${quota_json['error-type']}

   Then Should Be Equal    ${error}    error
   Then Should Be Equal    ${error_type}    inactive-account
   Then Wait for 5000 milliseconds


Test invalid-key error
   [Documentation]    Test invalid-key error
   ${API_KEY}=           Set Variable   fa
   Given Get the plan quota by api key ${API_KEY}
   ${error}=    Set Variable    ${quota_json['result']}
   ${error_type}=     Set Variable   ${quota_json['error-type']}

   Then Should Be Equal    ${error}    error
   Then Should Be Equal    ${error_type}    invalid-key
   Then Wait for 5000 milliseconds


