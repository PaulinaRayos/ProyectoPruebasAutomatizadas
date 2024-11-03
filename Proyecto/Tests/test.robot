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

