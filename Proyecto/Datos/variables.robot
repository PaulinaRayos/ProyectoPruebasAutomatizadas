*** Variables ***
${BASE_URL}         https://the-internet.herokuapp.com
${ADD_REMOVE_URL}   ${BASE_URL}/add_remove_elements/
${AUTH_URL}         ${BASE_URL}/basic_auth
${CHECKBOX_URL}     ${BASE_URL}/checkboxes
${CONTEXT_URL}      ${BASE_URL}/context_menu
${ELEMENTOS_URL}    ${BASE_URL}/disappearing_elements
${DRAGDROP_URL}     ${BASE_URL}/drag_and_drop
${MENU_OPTIONS_URL}  ${BASE_URL}/floating_menu
${CONTROL_DINAMICO_URL}  ${BASE_URL}/dynamic_controls
${VALID_USER}       admin
${VALID_PASS}       admin
${INVALID_USER}     admin1
${INVALID_PASS}     admin1
${GALLERY_BUTTON}    xpath=//*[@id="content"]/div/ul/li[5]/a
${BOX_A}    xpath=//*[@id="column-a"]
${BOX_B}    xpath=//*[@id="column-b"]
${REMOVE_BUTTON}           xpath=//button[text()='Remove']
${CHECKBOX}                xpath=//form[@id='checkbox-example']//input[@type='checkbox']
${ENABLE_BUTTON}           xpath=//button[text()='Enable']
${INPUT_FIELD}             xpath=//form[@id='input-example']//input[@type='text']
${MENU_OPTIONS}            xpath=//div[@id='content']//a[contains(@href, '/')]