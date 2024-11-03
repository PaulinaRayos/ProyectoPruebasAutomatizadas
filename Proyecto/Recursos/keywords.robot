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


