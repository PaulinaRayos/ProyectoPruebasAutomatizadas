*** Variables ***
${BASE_URL}         https://the-internet.herokuapp.com
${ADD_REMOVE_URL}   ${BASE_URL}/add_remove_elements/
${AUTH_URL}         ${BASE_URL}/basic_auth
${CHECKBOX_URL}     ${BASE_URL}/checkboxes
${CONTEXT_URL}      ${BASE_URL}/context_menu
${ELEMENTOS_URL}    ${BASE_URL}/disappearing_elements
${DRAGDROP_URL}     ${BASE_URL}/drag_and_drop
${VALID_USER}       admin
${VALID_PASS}       admin
${INVALID_USER}     admin1
${INVALID_PASS}     admin1
${GALLERY_BUTTON}    xpath=//*[@id="content"]/div/ul/li[5]/a
${BOX_A}    xpath=//*[@id="column-a"]
${BOX_B}    xpath=//*[@id="column-b"]
