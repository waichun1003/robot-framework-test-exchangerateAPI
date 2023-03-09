*** Settings ***
Library    ../../Libraries/api_library.py

*** Keywords ***
Get pair conversion by api key ${API_KEY} from currency ${from_currency} to currency ${to_currency} and amount ${amount}
    ${pair_conversion_json}=     Get currency pair conversion    ${API_KEY}    ${from_currency}    ${to_currency}    ${amount}
    Set Suite Variable    ${pair_conversion_json}
