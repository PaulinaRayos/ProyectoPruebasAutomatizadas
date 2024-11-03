*** Keywords ***
Inicializar el navegador con URL
    [Arguments]    ${url}
    Open Browser    ${url}    chrome
    Maximize Browser Window

Cerrar el navegador
    Close Browser

Autenticación con credenciales
    [Arguments]    ${user}    ${password}
    ${auth_url}=    Set Variable    https://${user}:${password}@the-internet.herokuapp.com/basic_auth
    Open Browser    ${auth_url}    chrome


Inicializar el navegador Safari con URL
    [Arguments]    ${url}
    Open Browser    ${url}    safari
    Maximize Browser Window


Drag And Drop A To B
    ${a}=    Get WebElement    ${BOX_A}
    ${b}=    Get WebElement    ${BOX_B}
    Drag And Drop     ${a}    ${b}

Drag And Drop B To A
    ${a}=    Get WebElement    ${BOX_A}
    ${b}=    Get WebElement    ${BOX_B}
    Drag And Drop     ${b}    ${a}

Validate Boxes Swapped
    ${text_a}=    Get Text    ${BOX_A}
    ${text_b}=    Get Text    ${BOX_B}
    Should Not Be Equal    ${text_a}    ${text_b}