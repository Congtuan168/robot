*** Settings ***
Resource    ../Resource/Common.resource
Suite Setup     Test-precondition
Suite Teardown      Test-postCondition

*** Variables ***
${Phone_Name}   Galaxy S7 edge

*** Test Cases ***
Verify About Phone
    Connect Adb server    ${DEVICE_SERIAL}

    Run    adb -s ${DEVICE_SERIAL} shell am start -a android.settings.SETTINGS
#    Go To Android Settings
    Sleep    3

    Scroll into view    ${DEVICE_SERIAL}    About phone
    Sleep    3

    Click by text    ${DEVICE_SERIAL}    About phone
    Sleep    3

    ${result}=     Find text on screen     ${DEVICE_SERIAL}    ${Phone_Name}
    Sleep    3

    Run Keyword If    '${result}' == 'True'  Log    The Phone name correct
    Run Keyword If    '${result}' != 'True'     Run Keyword And Return    Fail  The Phone name incorrect

    Run    adb -s ${DEVICE_SERIAL} shell input keyevent 3




