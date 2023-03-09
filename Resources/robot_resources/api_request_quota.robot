*** Settings ***
Library    ../../Libraries/api_library.py

*** Keywords ***
Get the plan quota by api key ${API_KEY}
    ${quota_json}=     Get the plan quota    ${API_KEY}
    Set Suite Variable    ${quota_json}