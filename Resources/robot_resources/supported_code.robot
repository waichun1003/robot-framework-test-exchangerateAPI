*** Settings ***
Library    ../../Libraries/api_library.py

*** Keywords ***
Get the supported codes by api key ${API_KEY}
    ${supported_codes_json}=     Get the supported codes    ${API_KEY}
    Set Suite Variable    ${supported_codes_json}