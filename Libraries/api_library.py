import sys

from Libraries.utilities import write_to_console

sys.path.append('/Users/waichuncheng/PycharmProjects/robotframework-test-main 2')
from robot.api.deco import keyword
from Libraries.api_catalogue import pair_conversion
from Libraries.api_catalogue import exchange_rate
from Libraries.api_catalogue import enriched_data
from Libraries.api_catalogue import historical_data
from Libraries.api_catalogue import api_request_quota
from Libraries.api_catalogue import supported_codes
from robot.libraries.BuiltIn import BuiltIn


@keyword("Get currency pair conversion")
def get_currency_pair_conversion(api_key, from_currency, to_currency, amount):
    return pair_conversion.get_pair_conversion(api_key, from_currency, to_currency, amount)


@keyword("Get base currency exchange rate")
def get_base_currency_exchange_rate(api_key, base_currency):
    return exchange_rate.get_exchange_rate(api_key, base_currency)


@keyword("Get latest base currency and verification")
def get_latest_base_currency_and_verification(api_key, base_currency):
    exchange_rate_response = get_base_currency_exchange_rate(api_key, base_currency)
    base_code = exchange_rate_response['base_code']
    if base_code == base_currency:
        write_to_console("API request successful", f"Base Code Verification is True: {base_code} : {base_currency}")
        return True
    else:
        raise Exception(f"Base code is not equal to target {base_currency}")


@keyword("Get the target currency exchange rate")
def get_the_target_currency_exchange_rate(api_key, base_currency, target_currency):
    return exchange_rate.get_the_symbol_exchange_rate(api_key, base_currency, target_currency)


@keyword("Get the target currency enriched data")
def get_the_target_currency_enriched_data(api_key, base_currency, target_currency):
    return enriched_data.get_enriched(api_key, base_currency, target_currency)


@keyword("Get the historical exchange rate")
def get_the_historical_exchange_rate(api_key, base_currency, year, month, day):
    return historical_data.get_historical(api_key, base_currency, year, month, day)


@keyword("Get the supported codes")
def get_the_supported_codes(api_key):
    return supported_codes.get_supported_codes(api_key)


@keyword("Get the plan quota")
def get_the_plan_quota(api_key):
    return api_request_quota.get_quota(api_key)
