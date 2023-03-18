import os
import sys
import datetime
import time
import json
import requests

sys.path.append('/Users/waichuncheng/PycharmProjects/robotframework-test-main 2')
from robot.api.deco import keyword
from robot.libraries.BuiltIn import BuiltIn


def write_to_console(message, url=None):
    now = datetime.datetime.now()
    if isinstance(message, str):
        message = f"{now} - {message}"
    if isinstance(message, dict):
        message = f"{now} - API request response:{url}\n{json.dumps(message, indent=4)}"
    BuiltIn().log_to_console(message)


def apply_mask(expected, mask):
    """
    Replaces masked values in the expected JSON with the corresponding values in the mask.
    """
    if isinstance(expected, dict):
        for key in list(expected.keys()):  # Create a copy of the dictionary keys
            if key in mask:
                del expected[key]
            else:
                expected[key] = apply_mask(expected[key], mask)
    elif isinstance(expected, list):
        for i in range(len(expected)):
            expected[i] = apply_mask(expected[i], mask)
    return expected


@keyword("Wait for milliseconds")
def wait_for_milliseconds(milliseconds):
    now = datetime.datetime.now()
    milliseconds = int(milliseconds)
    BuiltIn().log_to_console(f"{now}: System is sleeping for {milliseconds / 1000}s")
    time.sleep(milliseconds / 1000)


@keyword("Deep match json")
def deep_match_json(response, expected_path, mask_path=None):
    """
    Compares two JSON objects deeply and returns True if they match, and False otherwise.
    """

    def get_json_from_file(file_path):
        with open(file_path, 'r', encoding='utf-8') as file:
            result = json.load(file)
            return result

    expected_json = get_json_from_file(expected_path)

    mask = None
    if mask_path is not None and mask_path.strip() != '':
        with open(mask_path, 'r', encoding='utf-8') as f:
            mask = [line.strip() for line in f.readlines()]
            # rest of your code
            expected_json = apply_mask(expected_json, mask)
            response_json = apply_mask(response, mask)

    else:
        expected_json = get_json_from_file(expected_path)
        response_json = response

    write_to_console(f'Expected Result: {json.dumps(expected_json, indent=4)}')
    write_to_console(f'Actual Result: {json.dumps(response_json, indent=4)}')

    if response_json is None:
        return False

    if type(response_json) != type(expected_json):
        return False

    if isinstance(response_json, dict):
        if set(response_json.keys()) != set(expected_json.keys()):
            return False
        for key in response_json:
            if key not in expected_json:
                return False
            if response_json[key] != expected_json[key]:
                return False
        return True

    elif isinstance(response_json, list):
        if len(response_json) != len(expected_json):
            return False
        for i in range(len(response_json)):
            if not deep_match_json(response_json[i], expected_json[i]):
                return False
        return True

    else:
        return response_json == expected_json


def send_get_request(url, headers=None, params=None):
    """
        Send a GET request to the specified endpoint and return the response in JSON format.
    """

    protocols = 'https://'
    full_url = protocols + url
    full_url = full_url.format(**params)
    response = requests.get(full_url, headers=headers, params=params)
    json_dict = json.dumps(response.json(), indent=4)
    json_response = json.loads(json_dict)

    try:
        write_to_console(json_response, full_url)
    except json.JSONDecodeError:
        write_to_console(f"API request unsuccessful - Could not decode response as JSON {json_response}")
        raise ValueError("Response is not a valid JSON object")

    # Handle errors
    if response.status_code != 200:
        write_to_console(f"API Request Error: {response.status_code} {response.reason}")
        write_to_console(f"API Request Error response: {json.dumps(json_response)}")
        return json_response

    return json_response


def compare_json_result_with_expected_result(test_case_dir, test_case_name, expected_result):
    result_file_path = os.path.join(test_case_dir, f"{test_case_name}.result")
    with open(result_file_path, "r") as result_file:
        result = json.load(result_file)
    expected_result_dict = json.loads(expected_result)
    assert result == expected_result_dict, f"JSON result {result} does not match expected result {expected_result_dict}"
