*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://reqres.in/api

*** Test Cases ***
Get Single User
    Given the API base URL is set
    When I send a GET request to "/users/2"
    Then the response status code should be 200
    And the response should be display data of users details

POST Create User
    Given the API base URL is set
    ${body}=    Set Variable    {"name": "morpheus", "job": "leader"}
    When I send a POST request to "/users" with body    ${body}
    Then the response status code should be 201
    And the response should contain user data

*** Keywords ***
Given the API base URL is set
    No Operation

When I send a GET request to "${endpoint}"
    ${response}    GET    ${BASE_URL}${endpoint}
    Set Test Variable    ${GET_RESPONSE}    ${response}

Then the response status code should be ${status}
    Should Be Equal As Numbers    ${GET_RESPONSE.status_code}    ${status}

And the response should be display data of users details
    ${data}    Set Variable    ${GET_RESPONSE.json()}
    Dictionary Should Contain Key    ${data}    data
    Log    ${data["data"]}

When I send a POST request to "${endpoint}" with body
    [Arguments]    ${body}
    ${response}    POST    ${BASE_URL}${endpoint}    json=${body}
    Set Test Variable    ${POST_RESPONSE}    ${response}

And the response should contain user data
    ${data}    Set Variable    ${POST_RESPONSE.json()}
    Dictionary Should Contain Key    ${data}    name
    Dictionary Should Contain Key    ${data}    job
    Log    ${data}