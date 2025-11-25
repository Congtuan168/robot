*** Settings ***
Resource    ../Resource/Common.resource
Suite Setup     Test-precondition
Suite Teardown      Test-postCondition

*** Variables ***
${Phone_Name}   Galaxy A55 5G
${Dev mode}    Tùy chọn cho nhà phát triển
${Screen}    Màn hình
${Light mode}    Tối
${Software Update}    Cập nhật phần mềm
${Ready update}    Đã có bản cập nhật phần mềm
${Continue}    Tiếp tục cập nhật
${BATTERY_INFO_ID}           com.android.settings:id/battery_info_summary





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

    #Scroll until the screen to find the ${Screen}
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


Enable Màn hình chờ
    Connect Adb Server    ${DEVICE_SERIAL}
    Run     adb -s ${DEVICE_SERIAL} shell am start -n com.android.settings/com.android.settings.Settings
#    Go To Android Settings
    Sleep    1
    ${screen-exist}=     Find Text On Screen    ${DEVICE_SERIAL}     Màn hình chờ

    #Scroll until the screen to find the ${Screen}
    WHILE    '${screen-exist}'.lower() == 'false'
        Run    adb -s ${DEVICE_SERIAL} shell input swipe 540 1600 540 400 500
        Sleep    1.5
        ${screen-exist}=     Find Text On Screen    ${DEVICE_SERIAL}     Màn hình chờ
    END
    Click by text    ${DEVICE_SERIAL}    Màn hình chờ
    ${result}=    Find text on screen    ${DEVICE_SERIAL}    Nhãn ứng dụng

    IF    '${result}' == 'True'
        Log    Light mode found → enabling
        Click by text    ${DEVICE_SERIAL}     Nhãn ứng dụng
    ELSE
        Fail    Cannot find the Light mode text
    END
    Run    adb -s ${DEVICE_SERIAL} shell input keyevent 3

Check for Software Update
    Connect Adb Server    ${DEVICE_SERIAL}
    Run     adb -s ${DEVICE_SERIAL} shell am start -n com.android.settings/com.android.settings.Settings
    Sleep    3
#    ${result-after-check} =     Find text on screen    ${DEVICE_SERIAL}     ${Ready update}

#    IF    $result==     'True'
#        Click By Text    ${DEVICE_SERIAL}    ${DEVICE_SERIAL}    Mở
#        Sleep    3
#        Click By Text    ${DEVICE_SERIAL}     ${Continue}
#
#    ELSE
#        Fail    There is no available software update
#        Sleep    2

#    WHILE    ${result-after-check}== 'False'
    Run    adb -s ${DEVICE_SERIAL} shell input swipe 400 2200  400 1900
    Find Text On Screen    ${DEVICE_SERIAL}     ${Software Update}
#    END
    
    Click By Text    ${DEVICE_SERIAL}        ${Software Update}
    Click By Text    ${DEVICE_SERIAL}        Tải về và cài đặt
    Click By Text    ${DEVICE_SERIAL}        ${Continue}
    Run    adb -s ${DEVICE_SERIAL} shell input keyevent 3


Enable Màn hình chờ 2
    Connect Adb Server    ${DEVICE_SERIAL}
    # Mở cài đặt (Đảm bảo Settings đã sẵn sàng)
    Run     adb -s ${DEVICE_SERIAL} shell am start -n com.android.settings/com.android.settings.Settings
    Sleep    3

    # Số lần cuộn tối đa (để tránh vòng lặp vô tận)
    ${MAX_SCROLLS}=    Set Variable    10
    ${scroll_count}=   Set Variable    0

    ${screen-exist}=     Find Text On Screen    ${DEVICE_SERIAL}     Màn hình chờ

    # Vòng lặp cuộn cho đến khi tìm thấy hoặc hết số lần cuộn
    WHILE    '${screen-exist}'.lower() == 'false' and ${scroll_count} < ${MAX_SCROLLS}
        Log    Đang cuộn tìm 'Màn hình chờ'. Lần cuộn: ${scroll_count}
        Run    adb -s ${DEVICE_SERIAL} shell input swipe 540 1600 540 400 500
        Sleep    1.5

        ${screen-exist}=     Find Text On Screen    ${DEVICE_SERIAL}     Màn hình chờ
        ${scroll_count}=     Evaluate    ${scroll_count} + 1
    END

    # Kiểm tra kết quả cuộn
    IF    '${screen-exist}'.lower() == 'true'
        Click by text    ${DEVICE_SERIAL}    Màn hình chờ
        # ... Tiếp tục các bước kiểm tra Nhãn ứng dụng ...
        ${result}=    Is Text Existed    ${DEVICE_SERIAL}    Nhãn ứng dụng

        IF    '${result}' == 'True'
            Log    Nhãn ứng dụng được tìm thấy → đang bật
            Click by text    ${DEVICE_SERIAL}     Nhãn ứng dụng
        ELSE
            Fail    Không tìm thấy văn bản 'Nhãn ứng dụng'
        END
        Run    adb -s ${DEVICE_SERIAL} shell input keyevent 3
    ELSE
        Fail    Không thể cuộn để tìm thấy 'Màn hình chờ' sau ${MAX_SCROLLS} lần thử
    END


Check batery left and enable batery saving
    Connect Adb Server    ${DEVICE_SERIAL}
    Run     adb -s ${DEVICE_SERIAL} shell am start -n com.android.settings/com.android.settings.Settings
    Sleep    3
    
   # ${MAX_Scroling}    Set Variable    10
   # ${Count_Scroling}    Set Variable    0
    
    ${check-for-battery}=    Is Text Existed    ${DEVICE_SERIAL}    Pin
   # '${screen-exist}'.lower() == 'false' and ${scroll_count} < ${MAX_SCROLLS}
    WHILE        '${check-for-battery}'.lower() == 'false'
      #  Log    Đang scrolling: ${Count_Scroling}
        Scrolling    ${DEVICE_SERIAL}    input swipe 540 1600 540 400 500
        ${check-for-battery}=    Is Text Existed    ${DEVICE_SERIAL}    Pin
    END

    Click By Text    ${DEVICE_SERIAL}    Pin
    Click By Text    ${DEVICE_SERIAL}    Tiết kiệm pin
    Run    adb -s ${DEVICE_SERIAL} shell input keyevent 3



Get Battery Time Remaining
    # ... (Đảm bảo đã cuộn đến mục Pin) ...

    # Gọi Keyword của bạn để lấy văn bản dynamic
    ${Remaining Time Text}=    Get Dynamic Text By ID    ${DEVICE_SERIAL}    ${BATTERY_INFO_ID}
    
    Log To Console    Thời gian Pin còn lại: ${Remaining Time Text}
    
    # Bạn có thể dùng Regex (Regular Expression) để trích xuất số liệu từ dòng text này
    # Ví dụ: Kiểm tra xem chuỗi có chứa từ "ngày" không
    Should Contain    ${Remaining Time Text}    ngày