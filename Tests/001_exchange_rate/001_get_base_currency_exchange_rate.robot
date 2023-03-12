*** Settings ***
Resource    ../../Resources/robot_resources/common.robot
Test Tags   TestCase

*** Variables ***
${API_KEY}    a54f9e17254e056d54ab74c8
${base_currency}    USD
${target_currency}      EUR
${json_result}        Tests/001_exchange_rate/001_get_base_currency_exchange_rate.result
${mask_path}           Tests/001_exchange_rate/001_get_base_currency_exchange_rate.mask
*** Test Cases ***
Test getting exchange rates with valid API key for USD
    [Documentation]    Test exchange rate API endpoint for USD
    Given Get exchange rate by api key ${API_KEY} and base currency ${base_currency}
    When Wait for 5000 milliseconds
    Then Actual result ${exchange_rate_json} should be deeply match to ${json_result} expected result after masked values ${mask_path}
    When Wait for 5000 milliseconds
    Then Get latest base currency and verification by api key ${API_KEY} and base currency ${base_currency}

#Test invalid-key error
#   [Documentation]    Test invalid-key error
#   ${API_KEY}=           Set Variable   aa
#   Given Get exchange rate by api key ${API_KEY} and base currency ${base_currency}
#   ${error}=    Set Variable    ${exchange_rate_json['result']}
#   ${error_type}=     Set Variable   ${exchange_rate_json['error-type']}
#
#   Then Should Be Equal    ${error}    error
#   Then Should Be Equal    ${error_type}    invalid-key
#   Then Wait for 5000 milliseconds
#
#Test unsupported-code error
#   [Documentation]    Test unsupported-code error
#   ${base_currency}=           Set Variable   test
#   Given Get exchange rate by api key ${API_KEY} and base currency ${base_currency}
#   ${error}=    Set Variable    ${exchange_rate_json['result']}
#   ${error_type}=     Set Variable   ${exchange_rate_json['error-type']}
#
#   Then Should Be Equal    ${error}    error
#   Then Should Be Equal    ${error_type}    unsupported-code
#   Then Wait for 5000 milliseconds
#
# Test plan-upgrade-required
#   [Documentation]    Test plan-upgrade-required error
#   Given Get exchange rate by api key ${API_KEY} and base currency ${base_currency}
#   ${error}=    Set Variable    ${exchange_rate_json['result']}
#   ${error_type}=     Set Variable   ${exchange_rate_json['error-type']}
#
#   Then Should Be Equal    ${error}    error
#   Then Should Be Equal    ${error_type}    plan-upgrade-required
#   Then Wait for 5000 milliseconds
#
# Test inactive-account error
#   [Documentation]    Test inactive-account error
#   ${API_KEY}=           Set Variable   nln2
#   Given Get exchange rate by api key ${API_KEY} and base currency ${base_currency}
#   ${error}=    Set Variable    ${exchange_rate_json['result']}
#   ${error_type}=     Set Variable   ${exchange_rate_json['error-type']}
#
#   Then Should Be Equal    ${error}    error
#   Then Should Be Equal    ${error_type}    inactive-account
#   Then Wait for 5000 milliseconds