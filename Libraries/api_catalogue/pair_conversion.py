import requests
from robot.libraries import BuiltIn

from Libraries.utilities import send_get_request


def get_pair_conversion(api_key, from_currency, to_currency, amount):
    url = "v6.exchangerate-api.com/v6/{api_key}/pair/{from_currency}/{to_currency}/{amount}"
    headers = {
        "Content-Type": "application/json"
    }
    params = {
        "api_key": api_key,
        "from_currency": from_currency,
        "to_currency": to_currency,
        "amount": amount,
    }
    try:
        response = send_get_request(url, headers=headers, params=params)
    except (requests.exceptions.RequestException, ValueError) as e:
        # handle the exception here
        BuiltIn.log_to_console(f"Error occurred: {str(e)}")
        return None
    return response

