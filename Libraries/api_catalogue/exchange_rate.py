import requests
from robot.libraries.BuiltIn import BuiltIn

from Libraries.utilities import send_get_request


def get_exchange_rate(api_key, base_currency):
    url = "v6.exchangerate-api.com/v6/{api_key}/latest/{base_currency}"
    headers = {
        "Accept": "application/json"
    }
    params = {
        "api_key": api_key,
        "base_currency": base_currency
    }
    try:
        response = send_get_request(url, headers=headers, params=params)
    except (requests.exceptions.RequestException, ValueError) as e:
        # handle the exception here
        BuiltIn.log_to_console(f"Error occurred: {str(e)}")
        return None
    return response


def get_the_symbol_exchange_rate(api_key, base_currency, target_currency):
    url = "v6.exchangerate-api.com/v6/{api_key}/latest/{base_currency}"
    headers = {
        "Accept": "application/json"
    }
    params = {
        "api_key": api_key,
        "base_currency": base_currency,
        "symbols": target_currency
    }
    try:
        response = send_get_request(url, headers=headers, params=params)
    except (requests.exceptions.RequestException, ValueError) as e:
        # handle the exception here
        BuiltIn.log_to_console(f"Error occurred: {str(e)}")
        return None
    return response
