*** Settings ***
Documentation     Teste funcional do login na Netflix
Library           SeleniumLibrary
Suite Setup       Open Browser to Login Page
Suite Teardown    Close Browser

*** Keywords ***
Open Browser to Login Page
    Open Browser    https://www.netflix.com/br/login    firefox
    Maximize Browser Window

Perform Login
    Input Login Credentials
    Submit Login Form
    Verify Login Successful

Input Login Credentials
    Input Text    id::r0:   seu_email@example.com
    Input Text    id::r3:   sua_senha_secreta

Submit Login Form
    Click Button    xpath=//button[@data-uia='login-submit-button']

Verify Login Successful
    Wait Until Element Is Visible    xpath=//div[@class='centered-div list-profiles-container'][contains(.,'Quem está assistindo? Sandra Braz de Totz Amarildo Reino de lima Ester ♥ TesteGerenciar perfis')]    10s
    Element Should Be Visible    xpath=//div[@class='centered-div list-profiles-container'][contains(.,'Quem está assistindo? Sandra Braz de Totz Amarildo Reino de lima Ester ♥ TesteGerenciar perfis')]

Select Profile
    # Ajuste o XPath abaixo conforme necessário para selecionar o perfil desejado
    Wait Until Element Is Visible    xpath=//div[@data-profile-guid='CVZRQRSQP5CEFMKKA7JPWZI6UA']    10s
    Click Element    xpath=//div[@data-profile-guid='CVZRQRSQP5CEFMKKA7JPWZI6UA']  # Assumindo que você seleciona o perfil clicando neste elemento

Click Search Button
    # Ajuste o XPath abaixo conforme necessário para o botão de busca
    Wait Until Element Is Visible    xpath=//button[contains(@class,'searchTab')]    10s
    Click Button    xpath=//button[contains(@class,'searchTab')]

Search for Content
    [Arguments]    ${content}
    Wait Until Element Is Visible    xpath=//input[@name='searchInput']    10s
    Input Text    xpath=//input[@name='searchInput']    ${content}
    Press Keys    xpath=//input[@name='searchInput']    ENTER

Verify Search Results
    Wait Until Element Is Visible    xpath=//div[contains(@class, 'title-card-container')]    10s
    Element Should Be Visible    xpath=//div[contains(@class, 'title-card-container')]

Click on First Result
    Wait Until Element Is Visible    xpath=(//div[contains(@class, 'title-card-container')])[1]    10s
    Click Element    xpath=(//div[contains(@class, 'title-card-container')])[1]

Play Video
    Wait Until Element Is Visible    xpath=//button[@class='color-primary hasLabel hasIcon ltr-podnco'][contains(.,'Assistir')]    10s
    Click Button    xpath=//button[@class='color-primary hasLabel hasIcon ltr-podnco'][contains(.,'Assistir')]
    Wait Until Element Is Visible    xpath=//button[@class='color-primary hasLabel hasIcon ltr-podnco'][contains(.,'Assistir')]    15s


Verify Video Is Playing
    Wait Until Element Is Visible    xpath=//button[contains(@class, 'button-nfplayerPause')]    40s
    Element Should Be Visible    xpath=//button[contains(@class, 'button-nfplayerPause')]

Change Language and Subtitles
    Wait Until Element Is Visible    xpath=//button[@aria-label='Configurações de áudio e legendas']    15s
    Click Button    xpath=//button[@aria-label='Configurações de áudio e legendas']
    Wait Until Element Is Visible    xpath=//div[@class='track-list']    10s
    Click Element    xpath=//span[text()='English']
    Click Element    xpath=//span[text()='Português']
    Click Button    xpath=//button[@aria-label='Fechar']    10s

*** Test Cases ***
Login com Credenciais Válidas
    [Documentation]    Teste de login com credenciais válidas
    Perform Login
    Select Profile

Teste de Busca
    [Documentation]    Teste de busca na Netflix após login
    Perform Login
    Select Profile
    Click Search Button
    Search for Content    Stranger Things
    Verify Search Results

Reproduzir Vídeo
    [Documentation]    Teste de reprodução de vídeo na Netflix após busca
    Perform Login
    Select Profile
    Click Search Button
    Search for Content    Stranger Things
    Verify Search Results
    Click on First Result
    Play Video
    Verify Video Is Playing

Alterar Idioma e Legenda
    [Documentation]    Teste para alterar o idioma e a legenda de um vídeo na Netflix
    Perform Login
    Select Profile
    Click Search Button
    Search for Content    Stranger Things
    Verify Search Results
    Click on First Result
    Play Video
    Change Language and Subtitles