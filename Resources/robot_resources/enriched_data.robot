*** Settings ***
Library    ../../Libraries/api_library.py

*** Keywords ***
Get the target currency enriched data by api key ${API_KEY} from currency ${base_currency} to currency ${target_currency}
    ${enriched_data_json}=     Get the target currency enriched data    ${API_KEY}    ${base_currency}    ${target_currency}
    Set Suite Variable    ${enriched_data_json}
