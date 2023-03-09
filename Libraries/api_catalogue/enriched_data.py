import requests
from robot.libraries import BuiltIn

from Libraries.utilities import send_get_request


def get_enriched(api_key, base_currency, target_currency):
    url = "v6.exchangerate-api.com/v6/{api_key}/enriched/{base_currency}/{target_currency}"
    headers = {
        "Content-Type": "application/json"
    }
    params = {
        "api_key": api_key,
        "base_currency": base_currency,
        "target_currency": target_currency
    }
    try:
        response = send_get_request(url, headers=headers, params=params)
    except (requests.exceptions.RequestException, ValueError) as e:
        # handle the exception here
        BuiltIn.log_to_console(f"Error occurred: {str(e)}")
        return None
    return response

