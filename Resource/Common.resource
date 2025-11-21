*** Settings ***
Library     SeleniumLibrary
Library     OperatingSystem
Library     Process
Library     String
Library     ../Plugin/Helper.py
Library     ../Plugin/Android.py

*** Variables ***
${URL}     https://robotcode.io/
${DEVICE_SERIAL}    R5CX90YBT0R


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
    Set Window Size    1920    1080

Close Web
    [Documentation]     Đóng browser
    Close Browser

Search Keyword
    [Documentation]     Open web browser to research the object
    [Arguments]    ${keyword}
    Input Text  name="search_query"     ${keyword}
    Press Keys  name="search_query"     ENTER
    Wait Until Page Contains    ${keyword}

Find Text
    [Documentation]     Sử dụng keyword page should contain trong thư viện selenium kiểm tra element "text" xuất hiện trên web đang mở
    [Arguments]     ${text}
    Page Should Contain     ${text}

Go To Android Settings
    [Documentation]     Go to settings on android device
    [Arguments]     ${ADB_SERIAL}=${DEVICE_SERIAL}
    Run    adb -s ${ADB_SERIAL} shell am start -a android.settings.SETTINGS

Enable Switch Dark Mode
    [Documentation]    Enable Dark Mode on web
    [Arguments]    ${locators}
    Wait Until Element Is Visible        ${locators}
    ${state}=    Get Element Attribute    ${locators}    aria-checked
    Run Keyword If    "${state}" == "false"    Click Element    ${locators}
    
    
Open YouTube
    Open Browser    https://www.youtube.com    chrome
    Set Window Size    1920    1080

Search And Open Video
    [Arguments]    ${keyword}
    Input Text    name:search_query    ${keyword}
    Press Keys    name:search_query    ENTER
    Wait Until Page Contains Element    xpath:(//a[@id='video-title'])[1]
    Click Element    xpath:(//a[@id='video-title'])[1]

Pause Current Video
    Execute JavaScript    document.querySelector("video").pause();
