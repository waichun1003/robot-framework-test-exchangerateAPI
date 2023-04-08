*** Settings ***
Resource    ../../Resources/robot_resources/common.robot
Default Tags   TestCase

*** Variables ***
${API_KEY}    a54f9e17254e056d54ab74c8
${from_currency}    USD
${to_currency}      EUR
${amount}           160
${json_result}        Tests/003_pair_conversation/001_get_currency_pair_conversion.result
${mask_path}           Tests/003_pair_conversation/001_get_currency_pair_conversion.mask


*** Test Cases ***
Test getting pair conversion with valid API key for USD to EUR of 160
   [Documentation]    Test pair conversion API endpoint for USD to EUR of 160
   Given Get pair conversion by api key ${API_KEY} from currency ${from_currency} to currency ${to_currency} and amount ${amount}
   When Wait for 5000 milliseconds
   Then Actual result ${pair_conversion_json} should be deeply match to ${json_result} expected result after masked values ${mask_path}
   When Wait for 5000 milliseconds
   Then Verify Pair Conversion Rate By Api Key ${API_KEY} From Currency ${from_currency} To Currency ${to_currency} And Amount ${amount}

#Test invalid-key error
#   [Documentation]    Test invalid-key error
#   ${API_KEY}=           Set Variable   ca
#   Given Get pair conversion by api key ${API_KEY} from currency ${from_currency} to currency ${to_currency} and amount ${amount}
#   ${error}=    Set Variable    ${pair_conversion_json['result']}
#   ${error_type}=     Set Variable   ${pair_conversion_json['error-type']}
#
#   Then Should Be Equal    ${error}    error
#   Then Should Be Equal    ${error_type}    invalid-key
#   Then Wait for 5000 milliseconds
#
#
#Test unsupported-code error
#   [Documentation]    Test unsupported-code error
#   ${from_currency}=           Set Variable   test
#   Given Get pair conversion by api key ${API_KEY} from currency ${from_currency} to currency ${to_currency} and amount ${amount}
#   ${error}=    Set Variable    ${pair_conversion_json['result']}
#   ${error_type}=     Set Variable   ${pair_conversion_json['error-type']}
#
#   Then Should Be Equal    ${error}    error
#   Then Should Be Equal    ${error_type}    unsupported-code
#   Then Wait for 5000 milliseconds
#
# Test plan-upgrade-required
#   [Documentation]    Test plan-upgrade-required error
#   Given Get pair conversion by api key ${API_KEY} from currency ${from_currency} to currency ${to_currency} and amount ${amount}
#   ${error}=    Set Variable    ${pair_conversion_json['result']}
#   ${error_type}=     Set Variable   ${pair_conversion_json['error-type']}
#
#   Then Should Be Equal    ${error}    error
#   Then Should Be Equal    ${error_type}    plan-upgrade-required
#   Then Wait for 5000 milliseconds
#
# Test inactive-account error
#   [Documentation]    Test inactive-account error
#   ${API_KEY}=           Set Variable   nln2
#   Given Get pair conversion by api key ${API_KEY} from currency ${from_currency} to currency ${to_currency} and amount ${amount}
#   ${error}=    Set Variable    ${pair_conversion_json['result']}
#   ${error_type}=     Set Variable   ${pair_conversion_json['error-type']}
#
#   Then Should Be Equal    ${error}    error
#   Then Should Be Equal    ${error_type}    inactive-account
#   Then Wait for 5000 milliseconds