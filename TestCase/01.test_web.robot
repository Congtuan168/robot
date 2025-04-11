*** Settings ***
Resource    ../Resource/Common.resource
Suite Setup     Test-precondition
Suite Teardown      Test-postCondition

*** Variables ***
${TextExpected}     Sơn Tùng M-TP
${ImagePath}        E:\code\test\Resource\DB_IMG\J97.png
${element}      class="recaptcha-checkbox-border"

*** Test Cases ***
Search in Google
    Open Web
    Sleep    2
    Search Keyword    MTP
    Sleep    2
    Find Text       ${TextExpected}
    Sleep    2
    Close Web

