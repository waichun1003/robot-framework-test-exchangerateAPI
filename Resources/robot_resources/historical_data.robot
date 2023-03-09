*** Settings ***
Library    ../../Libraries/api_library.py

*** Keywords ***
Get the historical exchange rate by api key ${API_KEY} from currency ${base_currency} at year ${year} month ${month} and day ${day}
    ${hitory_json}=     Get the historical exchange rate    ${API_KEY}    ${base_currency}    ${year}    ${month}     ${day}
    Set Suite Variable    ${hitory_json}