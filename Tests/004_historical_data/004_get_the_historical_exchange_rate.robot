*** Settings ***
Resource    ../../Resources/robot_resources/common.robot
Resource    ../../Resources/robot_resources/historical_data.robot
Test Tags   smoke

*** Variables ***
${API_KEY}    a54f9e17254e056d54ab74c8
${base_currency}    USD
${year}      2023
${month}     2
${day}       1

*** Test Cases ***
Test getting historical exchange rate with valid API key from USD at 1 FEBRUARY 2023
   [Documentation]    Test historical exchange rate endpoint from USD at 1 FEBRUARY 2023
   Given Get the historical exchange rate by api key ${API_KEY} from currency ${base_currency} at year ${year} month ${month} and day ${day}
   ${response}=    Set Variable    ${hitory_json['result']}
   ${base_code}=     Set Variable   ${hitory_json['base_code']}
   ${documentation}=     Set Variable   ${hitory_json['documentation']}
   ${terms_of_use}=     Set Variable   ${hitory_json['terms_of_use']}
   ${Hyear}=     Set Variable   ${hitory_json['year']}
   ${Hmonth}=     Set Variable   ${hitory_json['month']}
   ${Hday}=     Set Variable   ${hitory_json['day']}
   ${conversion_rates}=    Set Variable    ${hitory_json['conversion_rates']}
   ${conversion_rates_usd}=    Set Variable    ${hitory_json['conversion_rates']['USD']}

   Then Should Be Equal    ${response}    success
   Then Should Be Equal    ${base_code}    USD
   Then Should Be Equal    ${documentation}    https://www.exchangerate-api.com/docs
   Then Should Be Equal    ${terms_of_use}    https://www.exchangerate-api.com/terms
   Then Should Be Equal    ${Hyear}    ${year}
   Then Should Be Equal    ${Hmonth}    ${month}
   Then Should Be Equal    ${Hday}    ${day}
   Then Should Be True    ${conversion_rates} != None
   Then Should Be Equal As Integers    ${conversion_rates_usd}  1
   Then Wait for 5000 milliseconds

Test inactive-account error
   [Documentation]    Test inactive-account error
   ${API_KEY}=           Set Variable   nln2
   Given Get the historical exchange rate by api key ${API_KEY} from currency ${base_currency} at year ${year} month ${month} and day ${day}
   ${error}=    Set Variable    ${hitory_json['result']}
   ${error_type}=     Set Variable   ${hitory_json['error-type']}

   Then Should Be Equal    ${error}    error
   Then Should Be Equal    ${error_type}    inactive-account
   Then Wait for 5000 milliseconds

Test invalid-key error
   [Documentation]    Test invalid-key error
   ${API_KEY}=           Set Variable   da
   Given Get the historical exchange rate by api key ${API_KEY} from currency ${base_currency} at year ${year} month ${month} and day ${day}
   ${error}=    Set Variable    ${hitory_json['result']}
   ${error_type}=     Set Variable   ${hitory_json['error-type']}

   Then Should Be Equal    ${error}    error
   Then Should Be Equal    ${error_type}    invalid-key
   Then Wait for 5000 milliseconds

Test plan-upgrade-required
   [Documentation]    Test plan-upgrade-required error
   Given Get the historical exchange rate by api key ${API_KEY} from currency ${base_currency} at year ${year} month ${month} and day ${day}
   ${error}=    Set Variable    ${hitory_json['result']}
   ${error_type}=     Set Variable   ${hitory_json['error-type']}

   Then Should Be Equal    ${error}    error
   Then Should Be Equal    ${error_type}    plan-upgrade-required
   Then Wait for 5000 milliseconds

Test unsupported-code error
   [Documentation]    Test unsupported-code error
   ${base_currency}=           Set Variable   test
   Given Get the historical exchange rate by api key ${API_KEY} from currency ${base_currency} at year ${year} month ${month} and day ${day}
   ${error}=    Set Variable    ${hitory_json['result']}
   ${error_type}=     Set Variable   ${hitory_json['error-type']}

   Then Should Be Equal    ${error}    error
   Then Should Be Equal    ${error_type}    unsupported-code
   Then Wait for 5000 milliseconds