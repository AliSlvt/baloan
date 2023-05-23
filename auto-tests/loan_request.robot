*** Settings ***
Library                                         SeleniumLibrary               run_on_failure=Capture Embed Screenshot
Variables                                       ../vars/vars.py
Test Setup                                      Open Baloan Login Page
Test Teardown                                   Close Browser

*** Test Cases ***
Registration of Loan Request
    Login to Baloan by Phone Number
    Enter the National Code and BirthDate
    Select Desired Online Shop
    Specify the Terms of the Loan

*** Keywords ***
Open Baloan Login Page
    Open Browser                                url=${baloan_url}             browser=Chrome            executable_path=${CURDIR}/../chromedriver/chromedriver
    Wait Until Page Contains                    ${login_text}                 timeout=10s
    Maximize Browser Window

Login to Baloan by Phone Number
    Enter the Phone Number
    Enter the OTP Code

Enter the Phone Number
    Input Text                                  ${phone_number_input}         ${phone_number}
    Click Button                                ورود به بالون
    Wait Until Page Contains Element            ${otp_code_input}             timeout=5s

Enter the OTP Code
    Input Text                                  ${otp_code_input}             ${otp_code}
    Wait for the Page Header                    اطلاعات هویتی

Enter the National Code and BirthDate
    Input National Code
    Select the BirthDate
    Click Button                                ادامه
    Wait for the Page Header                    انتخاب فروشگاه

Input National Code
    Input Text                                  ${national_code_input}        ${national_code}

Select the BirthDate
    Open BirthDate Picker
    Select Year of BirthDate
    Select Month of BirthDate
    Select Day of BirthDate
    Validate Selected BirthDate

Open BirthDate Picker
    Click Element                               ${birthdate_input}
    Wait Until Page Contains Element            ${date_picker}                timeout=1s

Select Year of BirthDate
    Click Element                               ${birthdate_year}
    Wait Until Element Is Visible               ${year_picker}                timeout=1s
    Click Element                               ${year}
    Wait Until Element Is Not Visible           ${year_picker}                timeout=1s

Select Month of BirthDate
    Click Element                               ${birthdate_month}
    Wait Until Element Is Visible               ${month_picker}               timeout=1s
    Click Element                               ${month}
    Wait Until Element Is Not Visible           ${month_picker}               timeout=1s


Select Day of BirthDate
    Click Element                               ${day}
    Wait Until Page Does Not Contain Element    ${date_picker}                timeout=1s

Validate Selected BirthDate
    Textfield Value Should Be                   ${birthdate_input}            ${date}

Select Desired Online Shop
    Click Element                               ${shop}
    Wait Until Button Is Enabled                ادامه
    Click Button                                ادامه
    Wait for the Page Header                    تعیین مبلغ وام

Specify the Terms of the Loan
    Select Checkbox                             ${checkbox_role}
    Wait Until Button Is Enabled                درخواست وام
    Click Button                                درخواست وام
    Wait for the Page Header                   گزارش اعتبارسنجی ایران

Wait for the Page Header
    [Arguments]                                 ${text}                       ${timeout}=5s
    Wait Until Element Contains                 ${page_header}                ${text}                   timeout=${timeout}

Wait Until Button Is Enabled
    [Arguments]                                 ${button_text}
    Wait Until Element Is Enabled               ${enable_btn.format("${button_text}")}                  timeout=1s

Capture Embed Screenshot
    Capture Page Screenshot	                    EMBED