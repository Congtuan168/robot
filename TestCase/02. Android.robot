*** Settings ***
Resource    ../Resource/Common.resource
Suite Setup     Test-precondition
Suite Teardown      Test-postCondition

*** Variables ***
${Phone_Name}   Galaxy A55 5G
${Dev mode}    Tùy chọn cho nhà phát triển
${Screen}    Màn hình
${Light mode}    Sáng


*** Test Cases ***
Verify About Phone
    Connect Adb server    ${DEVICE_SERIAL}

    Run     adb -s ${DEVICE_SERIAL} shell am start -n com.android.settings/com.android.settings.Settings
#    Go To Android Settings
    Sleep    3

    Run    adb -s ${DEVICE_SERIAL} shell input swipe 100 1600 200 0
    Sleep    3

    Click by text    ${DEVICE_SERIAL}    Thông tin điện thoại
    Sleep    3

    ${result}=     Find text on screen     ${DEVICE_SERIAL}    ${Phone_Name}
    Sleep    3

    IF    '${result}' == 'True'
    Log    The Phone name correct
    ELSE
    Fail    The Phone name incorrect
    END

    Run    adb -s ${DEVICE_SERIAL} shell input keyevent 3

Check Dev Mode Exist
    Connect Adb server    ${DEVICE_SERIAL}

    Run     adb -s ${DEVICE_SERIAL} shell am start -n com.android.settings/com.android.settings.Settings
#    Go To Android Settings
    Sleep    3

    Run    adb -s ${DEVICE_SERIAL} shell input swipe 400 2200 400 300 300
    Sleep    3


    ${result}=     Find text on screen     ${DEVICE_SERIAL}    ${Dev mode}
    Sleep    3

    IF    '${result}' == 'True'
    Log    The Dev Mode is enabling
    ELSE
    Fail    The Dev Mode is disable
    END

    Run    adb -s ${DEVICE_SERIAL} shell input keyevent 3


Enable Light Mode
    Connect Adb Server    ${DEVICE_SERIAL}
    Run     adb -s ${DEVICE_SERIAL} shell am start -n com.android.settings/com.android.settings.Settings
#    Go To Android Settings
    Sleep    3
    ${screen-exist}=     Find Text On Screen    ${DEVICE_SERIAL}     ${Screen}
    WHILE     ${screen-exist} == 'False'
         Run    adb -s ${DEVICE_SERIAL} shell input swipe 400 2200  400 1900
         ${screen-exist}=     Find Text On Screen    ${DEVICE_SERIAL}     ${Screen}
    END
    Click by text    ${DEVICE_SERIAL}    ${Screen}
    ${result}=    Find text on screen    ${DEVICE_SERIAL}    ${Light mode}

    IF    '${result}' == 'True'
        Log    Light mode found → enabling
        Click by text    ${DEVICE_SERIAL}     ${Light mode}
    ELSE
        Fail    Cannot find the Light mode text
    END
    Run    adb -s ${DEVICE_SERIAL} shell input keyevent 3


#
#Enable Light Mode
#    Connect Adb Server    ${DEVICE_SERIAL}
#    Run     adb -s ${DEVICE_SERIAL} shell am start -n com.android.settings/com.android.settings.Settings
#    Sleep   2
#
#    # Lần kiểm tra đầu tiên
#    ${screen_exist}=    Find Text On Screen    ${DEVICE_SERIAL}    ${Screen}
#
#    WHILE    '${screen_exist}' == 'False'
#        Run    adb -s ${DEVICE_SERIAL} shell input swipe 400 2200 400 1500
#        Sleep    1
#        ${screen_exist}=    Find Text On Screen    ${DEVICE_SERIAL}    ${Screen}
#    END
#
#    Log    Found screen: ${Screen}
#
#    ${result}=    Find Text On Screen    ${DEVICE_SERIAL}    ${Light mode}
#
#    IF    '${result}' == 'True'
#        Log    Light mode found → enabling
#        Click by text    ${DEVICE_SERIAL}    ${Light mode}
#    ELSE
#        Fail    Cannot find the Light mode text
#    END
#
#    Run    adb -s ${DEVICE_SERIAL} shell input keyevent 3