<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0ABAB5&height=260&section=header&text=Automation&fontSize=90&animation=fadeIn&fontAlignY=38&desc=Tech%20your%20business%20free&descAlignY=56&descAlign=50">
  <h1 align="center">Projeto de Automação de Testes Ruby</h1>
</p> 

<p align="center">
  <a href="#-produto">Produto</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-stack">Stack</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-estrutura">Estrutura</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-roadmap">Roadmap</a>&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
  <a href="#-execução">Execução</a>
</p> 

<p align="center">
  <img alt="License" src="https://img.shields.io/badge/ruby-%23CC342D.svg?style=for-the-badge&logo=ruby&logoColor=white">
  <img alt="License" src="https://img.shields.io/badge/Cucumber-23D96C?style=for-the-badge&logo=Cucumber&logoColor=FFFFFF">
  <img alt="License" src="https://img.shields.io/badge/Apache%20Groovy-4298B8.svg?style=for-the-badge&logo=Apache+Groovy&logoColor=white">
  <img alt="License" src="https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white">
  <img alt="License" src="https://img.shields.io/badge/Amazon_AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white">
  <img alt="License" src="https://img.shields.io/badge/Jenkins-D33833?style=for-the-badge&logo=jenkins&logoColor=white">
  <img alt="License" src="https://img.shields.io/badge/Slack-4A154B?style=for-the-badge&logo=slack&logoColor=white">
  <img alt="License" src="https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white">
</p>

<p align = "center">
<b> :earth_americas: XPTO xxxx  | :crossed_swords: XPTO xxxx </b>
</p>

## 💻 Produto

<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>

## ⚙ Stack

Esse projeto foi desenvolvido com as seguintes tecnologias:

|                                        |        Tecnologias                          |                                          |
| :-------------------:                  | :-------------------:                       |:---------------:                         |
| [Ruby](https://www.ruby-lang.org/pt/)  | [Apache](https://www.apache.org/)           | [Cucumber](https://cucumber.io/)         |
| [Jenkins](https://www.jenkins.io/)     | [Amazon AWS](https://aws.amazon.com/pt/)    | [Postgres](https://www.postgresql.org/)  |        

## 🎯 Objetivo

O projeto de automação tem como objetivo ajudar a executar muitos casos de testes de forma consistente e repetidamente
em diferentes ambientes, permitindo um melhor escalonamento dos casos de testes. Também é um objetivo a melhoria da
qualidade do software com um todo, pois testes automatizados proveem uma melhor cobertura quando se tratam de testes que
buscam validar se defeitos antigos e que já foram resolvidos não ressurgiram (testes de regressão).

## 🌌 Estrutura

Para organização do sistema o mesmo foi separado em diversas pastas para que ficassem distribuidas de acordo com suas
funções.

- ### **base-ruby-qa**
    - ***Clients***
        - Contém os arquivos Ruby que possuem métodos de validação, manipulação e tratamento de dados

    - ***Mocks***
        - Contém arquivos Ruby que possuem os payloads para realização de requisições.

    - ***Schemas***
        - Contém arquivos Json que possuem um contrato para validação dos responses das nossas requests

    - ***Specs***
        - Contém os arquivos ".feature" onde são expecificados os cenários de testes em linguagem Gerkin.

    - ***Step_definitions***
        - Contém os arquivos Ruby onde são expecificados os steps dos nossos cenários de teste.

    - ***Support***
        - Contém os arquivos Ruby onde são expecificadas as principais configurações do projeto.
    - ***Reports***
        - Contém os arquivos de report gerados após a execussão do projeto.

## ☑ Roadmap

**:heavy_check_mark: XXXX </br></br>
:heavy_check_mark: XXXX </br></br>
:heavy_check_mark: XXXX </br></br>
:heavy_check_mark: XXXX </br></br>
:hourglass: XXXX**

## ⏩ Execução

### Local

- Clone o repositório
- Baixe o Ruby - [Ruby](https://www.ruby-lang.org/pt/) - (2.7.1)
- Baixe a *Gem bundler*: ```gem install bundler```
- Executar o ```bundler install``` na raiz do projeto
- Executar o comando ```Cucumber``` para rodar os testes