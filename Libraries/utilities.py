import sys
import datetime
import time
import json
import os

import requests

sys.path.append('/Users/waichuncheng/PycharmProjects/robotframework-test-main 2')
from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn


@keyword("Wait for milliseconds")
def wait_for_milliseconds(milliseconds):
    now = datetime.datetime.now()
    milliseconds = int(milliseconds)
    BuiltIn().log_to_console(f"{now}: System is sleeping for {milliseconds / 1000}s")
    time.sleep(milliseconds / 1000)


def write_to_console(url, message):
    now = datetime.datetime.now()
    if isinstance(message, dict):
        message = f"{now}: \nAPI request response:{url}\n{json.dumps(message, indent=4)}"
    elif isinstance(message, str):
        message = f"{now}: {message}"
    BuiltIn().log_to_console(message)


def send_get_request(url, headers=None, params=None):
    """
        Send a GET request to the specified endpoint and return the response in JSON format.
    """

    protocols = 'https://'
    full_url = protocols + url
    full_url = full_url.format(**params)
    response = requests.get(full_url, headers=headers, params=params)
    json_response = response.json()

    try:
        write_to_console(full_url, json_response)
    except json.JSONDecodeError:
        write_to_console("API request unsuccessful", f"Could not decode response as JSON {json_response}")
        raise ValueError("Response is not a valid JSON object")

    # Handle errors
    if response.status_code != 200:
        write_to_console("API request unsuccessful", f"Error: {response.status_code} {response.reason}")
        BuiltIn().log_to_console("API request unsuccessful", f"Error response: {json.dumps(json_response)}")
        return None

    return response.json()


def compare_json_result_with_expected_result(test_case_dir, test_case_name, expected_result):
    result_file_path = os.path.join(test_case_dir, f"{test_case_name}.result")
    with open(result_file_path, "r") as result_file:
        result = json.load(result_file)
    expected_result_dict = json.loads(expected_result)
    assert result == expected_result_dict, f"JSON result {result} does not match expected result {expected_result_dict}"
