*** Settings ***
Resource    ../Resource/Common.resource
Suite Setup     Test-precondition
Suite Teardown      Test-postCondition

*** Variables ***
${TextExpected}     Import order decides: For variables with identical names:
${Expected Result}    true
${css}    css=button.VPSwitch.VPSwitchAppearance
${more}


*** Test Cases ***
Search in Google
    Open Web
    Sleep    2
    Search Keyword    framework
    Sleep    2
    Find Text       ${TextExpected}
    Sleep    2
    Close Web
    
Enable Dark Mode
    Open Web
    Sleep    1
    Enable Switch Dark Mode    ${css}
    Element Attribute Value Should Be      ${css}    aria-checked    ${Expected Result}
    Sleep    2
    Close Web



Pause video
    Open YouTube
    Sleep    1
    Search And Open Video    conan 944
    Sleep    20
    Pause Current Video
    Sleep    1
    Search And Open Video    conan 945
    Sleep    10
    Pause Current Video
    Sleep    1
    Close Web


