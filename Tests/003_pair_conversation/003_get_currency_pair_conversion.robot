*** Settings ***
Resource    ../../Resources/robot_resources/common.robot
Resource    ../../Resources/robot_resources/pair_conversion.robot
Test Tags   smoke

*** Variables ***
${API_KEY}    a54f9e17254e056d54ab74c8
${from_currency}    USD
${to_currency}      EUR
${amount}           160

*** Test Cases ***
Test getting pair conversion with valid API key for USD to EUR of 160
   [Documentation]    Test pair conversion API endpoint for USD to EUR of 160
   Given Get pair conversion by api key ${API_KEY} from currency ${from_currency} to currency ${to_currency} and amount ${amount}
   ${response}=    Set Variable    ${pair_conversion_json['result']}
   ${base_code}=     Set Variable   ${pair_conversion_json['base_code']}
   ${target_code}=     Set Variable   ${pair_conversion_json['target_code']}
   ${documentation}=     Set Variable   ${pair_conversion_json['documentation']}
   ${terms_of_use}=     Set Variable   ${pair_conversion_json['terms_of_use']}
   ${conversion_rate}=    Set Variable    ${pair_conversion_json['conversion_rate']}

   Then Should Be Equal    ${response}    success
   Then Should Be Equal    ${base_code}    USD
   Then Should Be Equal    ${target_code}    EUR
   Then Should Be Equal    ${documentation}    https://www.exchangerate-api.com/docs
   Then Should Be Equal    ${terms_of_use}    https://www.exchangerate-api.com/terms
   Then Should Be True    ${conversion_rate} != None
   Then Should Be Equal As Integers    ${conversion_rate}  1
   Then Wait for 5000 milliseconds

Test invalid-key error
   [Documentation]    Test invalid-key error
   ${API_KEY}=           Set Variable   ca
   Given Get pair conversion by api key ${API_KEY} from currency ${from_currency} to currency ${to_currency} and amount ${amount}
   ${error}=    Set Variable    ${pair_conversion_json['result']}
   ${error_type}=     Set Variable   ${pair_conversion_json['error-type']}

   Then Should Be Equal    ${error}    error
   Then Should Be Equal    ${error_type}    invalid-key
   Then Wait for 5000 milliseconds


Test unsupported-code error
   [Documentation]    Test unsupported-code error
   ${from_currency}=           Set Variable   test
   Given Get pair conversion by api key ${API_KEY} from currency ${from_currency} to currency ${to_currency} and amount ${amount}
   ${error}=    Set Variable    ${pair_conversion_json['result']}
   ${error_type}=     Set Variable   ${pair_conversion_json['error-type']}

   Then Should Be Equal    ${error}    error
   Then Should Be Equal    ${error_type}    unsupported-code
   Then Wait for 5000 milliseconds

 Test plan-upgrade-required
   [Documentation]    Test plan-upgrade-required error
   Given Get pair conversion by api key ${API_KEY} from currency ${from_currency} to currency ${to_currency} and amount ${amount}
   ${error}=    Set Variable    ${pair_conversion_json['result']}
   ${error_type}=     Set Variable   ${pair_conversion_json['error-type']}

   Then Should Be Equal    ${error}    error
   Then Should Be Equal    ${error_type}    plan-upgrade-required
   Then Wait for 5000 milliseconds

 Test inactive-account error
   [Documentation]    Test inactive-account error
   ${API_KEY}=           Set Variable   nln2
   Given Get pair conversion by api key ${API_KEY} from currency ${from_currency} to currency ${to_currency} and amount ${amount}
   ${error}=    Set Variable    ${pair_conversion_json['result']}
   ${error_type}=     Set Variable   ${pair_conversion_json['error-type']}

   Then Should Be Equal    ${error}    error
   Then Should Be Equal    ${error_type}    inactive-account
   Then Wait for 5000 milliseconds