*** Settings ***
Library    ../../Libraries/utilities.py
Library    ../../Libraries/api_library.py
Library    BuiltIn

*** Keywords ***
Get exchange rate by api key ${API_KEY} and base currency ${base_currency}
    ${exchange_rate_json}=    Get base currency exchange rate  ${API_KEY}   ${base_currency}
    Set Test Variable        ${exchange_rate_json}

Get latest base currency and verification by api key ${API_KEY} and base currency ${base_currency}
    ${base_code_verification}=  Get latest base currency and verification   ${API_KEY}   ${base_currency}
    Set Test Variable           ${base_code_verification}

Get pair conversion by api key ${API_KEY} from currency ${from_currency} to currency ${to_currency} and amount ${amount}
    ${pair_conversion_json}=     Get currency pair conversion    ${API_KEY}    ${from_currency}    ${to_currency}    ${amount}
    Set Test Variable    ${pair_conversion_json}

Verify pair conversion rate by api key ${API_KEY} from currency ${from_currency} to currency ${to_currency} and amount ${amount}
    ${pair_conversion_verification}=    Verify Currency Conversion Rate   ${API_KEY}    ${from_currency}    ${to_currency}    ${amount}
    Set Test Variable  ${pair_conversion_verification}

Wait for ${milliseconds} milliseconds
    Wait for milliseconds   ${milliseconds}

Actual result ${response} should be deeply match to ${expected_path} expected result after masked values ${mask_path}
    ${expected}=    Deep match json  ${response}  ${expected_path}  ${mask_path}
    Set Test Variable    ${expected}
    Should Be True       ${expected}
