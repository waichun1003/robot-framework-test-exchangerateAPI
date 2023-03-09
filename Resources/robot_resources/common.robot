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

Wait for ${milliseconds} milliseconds
    Wait for milliseconds   ${milliseconds}

