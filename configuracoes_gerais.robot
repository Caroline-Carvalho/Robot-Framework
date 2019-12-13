*** Settings ***

Library           SeleniumLibrary

*** Variables ***

${url}            http://192.168.9.145:8080/
${browser}        chrome
${usuário}        id:user    
${senha}          id:password 
${senha_antiga}    id:old-password
${senha_nova}    id:new-password
${host_ip}    id:host  
${botão_login}    id:login-btn
${botão_aplicar}    class:btn-primary
${mensagem_login_inválido}    id:toast-container
${login_realizado}    class:nav-label
${geral}    http://192.168.9.145:8080/general.html
${segurança}    http://192.168.9.145:8080/security.html     
${dropdown_modo_de_operação}    name:operation-mode
${mensagem_ip_inválido}    id:toast-container
${mensagem_configuração_salva}    id:toast-container



*** Test Cases ***

Login 

    Open Browser    ${url}    ${browser}
    Input Text    ${usuário}    admin    
    Input Text    ${senha}    master    
    Click Button    ${botão_login}
    Sleep    1
    Page Should Contain Element    ${login_realizado}
       
Configurar modo de operação como SIP Trunk e IP inválido
    
    Go to    ${geral} 
    Select From List By Index    ${dropdown_modo_de_operação}    2
    Input Text    ${host_ip}    192.168.9
    Click Button    ${botão_aplicar}    
    Sleep    1
    Page Should Contain Element    ${mensagem_ip_inválido}
    Sleep    5

Configurar modo de operação como SIP Trunk e IP válido

    Input Text    ${host_ip}    192.168.9.30:5060
    Click Button    ${botão_aplicar}    
    Sleep    1

Alteração de nome de usuário e senha

    Go to    ${segurança}
    Input Text    ${senha_antiga}    master
    Input Text    ${senha_nova}    teste
    Click Button    ${botão_aplicar} 
    Sleep    5
    Close Browser  

    Open Browser    ${url}    ${browser}
    Sleep    90
    Input Text    ${usuário}    admin
    Input Text    ${senha}    teste
    Sleep    2
    Click Button    ${botão_login}
    Sleep    1

    Go to    ${segurança}
    Input Text    ${senha_antiga}    teste
    Input Text    ${senha_nova}    master
    Click Button    ${botão_aplicar} 
    Sleep    1
    Page Should Contain Element    ${mensagem_configuração_salva}





