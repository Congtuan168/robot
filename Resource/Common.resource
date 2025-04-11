*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Library     Process
Library     String
Library     ../Plugin/Android.py
Library     ../Plugin/Helper.py

*** Variables ***
${URL}     https://www.google.com
${DEVICE_SERIAL}    ce11160baddc4c2c04


*** Keywords ***
Test-precondition
    [Documentation]     Tiền điều kiện để thực thi test
    Log    Pre-condition

Test-postCondition
    [Documentation]     Trả lại môi trường ban đầu để sẵn sàng cho test case mới
    Log    Post-condition

Open Web
    [Documentation]     Open 1 web với địa chỉ cụ thể trên trình duyệt example: open browser Chrome, truy cập tới trang google.com
    Open Browser    ${URL}   chrome

Close Web
    [Documentation]     Đóng browser
    Close Browser

Search Keyword
    [Documentation]     Open web browser to research the object
    [Arguments]    ${keyword}
    Input Text    name=q    ${keyword}
    Press Keys    name=q    ENTER
    Wait Until Page Contains    ${keyword}

Find Text
    [Documentation]     Sử dụng keyword page should contain trong thư viện selenium kiểm tra element "text" xuất hiện trên web đang mở
    [Arguments]     ${text}
    Page Should Contain     ${text}

Go To Android Settings
    [Documentation]     Go to settings on android device
    [Arguments]     ${ADB_SERIAL}=${DEVICE_SERIAL}
    Run    adb -s ${ADB_SERIAL} shell am start -a android.settings.SETTINGS
