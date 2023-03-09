*** Settings ***
Resource    ../../Resources/robot_resources/common.robot
Resource    ../../Resources/robot_resources/enriched_data.robot
Test Tags   smoke

*** Variables ***
${API_KEY}    a54f9e17254e056d54ab74c8
${base_currency}    USD
${target_currency}      EUR

*** Test Cases ***
Test getting target currency enriched data with valid API key for USD to EUR
   [Documentation]    Test target currency entriched data endpoint for USD to EUR
   Given Get the target currency enriched data by api key ${API_KEY} from currency ${base_currency} to currency ${target_currency}
   ${response}=    Set Variable    ${enriched_data_json['result']}
   ${base_code}=     Set Variable   ${enriched_data_json['base_code']}
   ${target_code}=     Set Variable   ${enriched_data_json['target_code']}
   ${documentation}=     Set Variable   ${enriched_data_json['documentation']}
   ${terms_of_use}=     Set Variable   ${enriched_data_json['terms_of_use']}
   ${time_last_update_unix}=     Set Variable   ${enriched_data_json['time_last_update_unix']}
   ${time_last_update_utc}=     Set Variable   ${enriched_data_json['time_last_update_utc']}
   ${time_next_update_unix}=     Set Variable   ${enriched_data_json['time_next_update_unix']}
   ${time_next_update_utc}=     Set Variable   ${enriched_data_json['time_next_update_utc']}
   ${conversion_rates}=    Set Variable    ${enriched_data_json['conversion_rates']}
   ${conversion_rates_usd}=    Set Variable    ${enriched_data_json['conversion_rates']['USD']}

   Then Should Be Equal    ${response}    success
   Then Should Be Equal    ${base_code}    USD
   Then Should Be Equal    ${target_code}    EUR
   Then Should Be Equal    ${documentation}    https://www.exchangerate-api.com/docs
   Then Should Be Equal    ${terms_of_use}    https://www.exchangerate-api.com/terms
   Then Should Be True    ${conversion_rates} !=  None
   Then Should Be Equal As Integers    ${conversion_rates_usd}  1
   Then Wait for 5000 milliseconds

 Test invalid-key error
   [Documentation]    Test invalid-key error
   ${API_KEY}=           Set Variable   ba
   Given Get the target currency enriched data by api key ${API_KEY} from currency ${base_currency} to currency ${target_currency}
   ${error}=    Set Variable    ${enriched_data_json['result']}
   ${error_type}=     Set Variable   ${enriched_data_json['error-type']}

   Then Should Be Equal    ${error}    error
   Then Should Be Equal    ${error_type}    invalid-key
   Then Wait for 5000 milliseconds

Test unsupported-code error
   [Documentation]    Test unsupported-code error
   ${base_currency}=           Set Variable   test
   Given Get the target currency enriched data by api key ${API_KEY} from currency ${base_currency} to currency ${target_currency}
   ${error}=    Set Variable    ${enriched_data_json['result']}
   ${error_type}=     Set Variable   ${enriched_data_json['error-type']}

   Then Should Be Equal    ${error}    error
   Then Should Be Equal    ${error_type}    unsupported-code
   Then Wait for 5000 milliseconds

 Test plan-upgrade-required
   [Documentation]    Test plan-upgrade-required error
   Given Get the target currency enriched data by api key ${API_KEY} from currency ${base_currency} to currency ${target_currency}
   ${error}=    Set Variable    ${enriched_data_json['result']}
   ${error_type}=     Set Variable   ${enriched_data_json['error-type']}

   Then Should Be Equal    ${error}    error
   Then Should Be Equal    ${error_type}    plan-upgrade-required
   Then Wait for 5000 milliseconds

 Test inactive-account error
   [Documentation]    Test inactive-account error
   ${API_KEY}=           Set Variable   nln2
   Given Get the target currency enriched data by api key ${API_KEY} from currency ${base_currency} to currency ${target_currency}
   ${error}=    Set Variable    ${enriched_data_json['result']}
   ${error_type}=     Set Variable   ${enriched_data_json['error-type']}

   Then Should Be Equal    ${error}    error
   Then Should Be Equal    ${error_type}    inactive-account
   Then Wait for 5000 milliseconds