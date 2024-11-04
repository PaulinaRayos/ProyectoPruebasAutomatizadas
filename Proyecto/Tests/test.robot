*** Settings ***
Documentation     Suite de pruebas para validar la funcionalidad de la aplicación "The Internet".
Library      SeleniumLibrary
Resource    ../Datos/variables.robot
Resource    ../Recursos/keywords.robot
Test Teardown    Cerrar el navegador

*** Test Cases ***
# Prueba para agregar y quitar elementos
Agregar y Quitar Elementos
    [Documentation]    Este test case verifica la funcionalidad de agregar y eliminar elementos.
    ...                Primero, se agregan 20 elementos a la lista y se valida que todos fueron agregados.
    ...                Luego, se eliminan uno por uno y se valida que al final la lista esté vacía.

    Inicializar el navegador con URL    ${ADD_REMOVE_URL}

    #Agregar 20 elementos
    FOR     ${i}    IN RANGE    20
        Click Element       xpath= //*[@id="content"]/div/button
    END

    # Validar que los 20 elementos se han agregado
    Wait Until Element Is Visible    xpath=//*[@id="elements"]/button[1]
    ${count}=   Get Element Count       xpath=//*[@id="elements"]/button
    Should Be Equal As Numbers      ${count}    20

    # Eliminar los 20 elementos uno por uno
    WHILE   ${count} > 0
        Click Element    xpath=//*[@id="elements"]/button[1]  # Elimina el primer elemento
        ${count}=   Get Element Count    xpath=//*[@id="elements"]/button  # Actualiza el conteo de elementos
    END

    # Verifica que no queden elementos
    ${count}=   Get Element Count    xpath=//*[@id="elements"]/button
    Should Be Equal As Numbers      ${count}    0

# Prueba para autenticación básica con credenciales válidas
Prueba de Autenticación Básica - Válida
    [Documentation]    Verifica que el usuario pueda autenticarse con credenciales válidas.
    ...                Se espera que después de la autenticación, la página muestre un mensaje de éxito.
    Autenticación con credenciales    ${VALID_USER}    ${VALID_PASS}
    Wait Until Page Contains    Congratulations! You must have the proper credentials.

# Prueba para autenticación básica con credenciales inválidas
Prueba de Autenticación Básica - Inválida
    [Documentation]    Verifica que la autenticación falle al usar credenciales inválidas.
    ...                La página debería mostrar un error o no cargar la autenticación.

    Autenticación con credenciales    ${INVALID_USER}    ${INVALID_PASS}
    Wait Until Page Contains Element    xpath=/html/body

# Prueba de validación de checkboxes
Validación de Checkboxes
    [Documentation]    Verifica la selección de los checkboxes en la página.
    ...                Se selecciona cada checkbox y se valida que esté marcado. Si ya está marcado, se deja como está.

    Inicializar el navegador con URL    ${CHECKBOX_URL}

    Wait Until Page Contains Element    //*[@id="content"]/div/h3
    # Seleccionar el checkbox "Checkbox 1"
    Click Element    xpath=//*[@id="checkboxes"]/input[1]

    # Validar que el checkbox "Checkbox 1" fue seleccionado
    ${is_selected1}=    Get Element Attribute    xpath=//*[@id="checkboxes"]/input[1]    checked
    Should Not Be Empty    ${is_selected1}

    # Validar que el checkbox "Checkbox 2" fue seleccionado
    ${is_selected2}=    Get Element Attribute    xpath=//*[@id="checkboxes"]/input[2]    checked
    Should Not Be Empty    ${is_selected2}


#Prueba Context Menu
Prueba Context Menu
    [Tags]    context_menu
    [Documentation]     Verifica que se seleccione el context menú y despliegue la alerta

    Inicializar el navegador Safari con URL     ${CONTEXT_URL}

    Wait Until Page Contains Element    xpath=//*[@id="hot-spot"]

    # Hacer clic derecho en la caja
    Execute JavaScript    document.querySelector('#hot-spot').dispatchEvent(new MouseEvent('contextmenu', {bubbles: true}))

    Sleep   2s

    # Validar que el texto de la alerta es igual a "You selected a context menu"
    ${alert_text}=    Get Alert Text
    Should Be Equal As Strings    ${alert_text}    You selected a context menu

    Handle Alert

    # Validar que la alerta fue cerrada
    ${alert_present}=    Run Keyword And Return Status    Is Alert Present
    Should Be False    ${alert_present}


#Elementos que desaparecen 1
Prueba Elementos que Desaparecen Botón Gallery Existe
    [Tags]    boton_GallerySi
    [Documentation]     Verifica si el elemento Gallery aparece cuando se recaraga la página

    Inicializar el navegador Safari con URL     ${ELEMENTOS_URL}

    # Actualizar hasta que el botón sea visible
    Wait Until Element Is Visible    ${GALLERY_BUTTON}    timeout=15s
    # Validar que el botón "Gallery" existe
    Element Should Be Visible    ${GALLERY_BUTTON}


#Elementos que desaparecen 1
Prueba Elementos que Desaparecen Botón Gallery No Existe
    [Tags]    boton_GalleryNo
    [Documentation]     Verifica si el elemento Gallery aparece cuando se recaraga la página

    Inicializar el navegador Safari con URL     ${ELEMENTOS_URL}

    # Refrescar el navegador hasta que el botón no esté visible

    ${Reload}=  Run Keyword And Return Status  Wait Until Element Is Not Visible    ${GALLERY_BUTTON}
    WHILE    ${Reload} != ${TRUE}
        ${Reload}=  Run Keyword And Return Status  Element Should Not Be Visible    ${GALLERY_BUTTON}
        Sleep    1s
    END
    # Actualizar hasta que el botón sea visible
    Wait Until Element Is Not Visible    ${GALLERY_BUTTON}    timeout=2s
    # Validar que el botón "Gallery" existe
    Element Should Not Be Visible    ${GALLERY_BUTTON}


#Prueba Drag and Drop
Prueba Drag and Drop

    [Tags]    drag_drop
    Inicializar el navegador Safari con URL     ${DRAGDROP_URL}

    Drag And Drop A To B
    Validate Boxes Swapped
    Drag And Drop B To A
    Validate Boxes Swapped

#Prueba Controles Dinamicos
Prueba Control dinamico
    [Tags]    control_dinamico
    [Documentation]     Verifica que los controles dinamicos funcionan mostrando un mensaje de ejemplo
  Inicializar el navegador Safari con URL     ${CONTROL_DINAMICO_URL}

    Clic en Remove
    Validar Checkbox Removido
    Clic en Enable
    Validar Input Habilitado

#Prueba de Visibilidad de Opciones de Menú
Prueba de Visibilidad de Opciones de Menu
      [Tags]    opciones_menu
    [Documentation]     Verifica que las opciones del menu se vean aun si la pagina scrolleo hasta abajo
  Inicializar el navegador Safari con URL     ${CONTROL_DINAMICO_URL}

    Desplazarse Hasta el Fondo de la Página
    Validar Opciones del Menú Visibles
    Cerrar Navegador

#Prueba de autenticación de formulario
Autenticacion de formulario
    [Tags]  autenticacion_de_formulario
    [Documentation]    verifica que el formulario indique cuando sea valido o invalido el login
    Inicializar el navegador con URL    https://the-internet.herokuapp.com/login
    Sleep   5s

    Logearte    ${VALID_LOGIN_USER}     ${VALID_LOGIN_PASSWORD}
    Page should contain      You logged into a secure area!
    Sleep   1s

    Logout
    Page should contain     You logged out of the secure area!
    Sleep   3s

    Logearte    ${INVALID_LOGIN_USER}   ${VALID_LOGIN_PASSWORD}
    Sleep   1s
    Page should contain      Your username is invalid!

    Logearte    ${VALID_LOGIN_USER}   ${INVALID_LOGIN_PASSWORD}
    Sleep   1s
    Page should contain      Your password is invalid!

#Prueba de teclas presionadas
Teclas presionadas
    [Tags]  teclas_presionadas
    [Documentation]     prueba de presionar teclas
    Inicializar el navegador con URL     https://the-internet.herokuapp.com/key_presses
    Sleep   5s

    Click element   //*[@id="target"]
    Sleep   1s
    Press Key    //body   \uE00C
    Sleep   1s

    Page should contain     You entered: ESC

    Click element   //*[@id="target"]
    Sleep   1s
    Press Key    //body   \uE00D
    Sleep   1s

    Page should contain     You entered: SPACE











