*** Settings ***
Resource    ../../Resources/robot_resources/common.robot
Test Tags   TestCase

*** Variables ***
${API_KEY}    aa
${base_currency}    USD
${target_currency}      EUR
${json_result}        Tests/001_exchange_rate/002_get_base_currency_exchange_rate_with_invalid_key.result
${mask_path}

*** Test Cases ***
Test invalid-key error
   [Documentation]    Test invalid-key error
   Given Get exchange rate by api key ${API_KEY} and base currency ${base_currency}
   When Wait for 5000 milliseconds
   Then Actual result ${exchange_rate_json} should be deeply match to ${json_result} expected result after masked values ${mask_path}