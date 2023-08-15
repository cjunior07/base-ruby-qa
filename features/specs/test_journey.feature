#language: pt
#utf-8

@make_all @make_journey
Funcionalidade: Garantir que o projeto de QA foi criado e está executando com sucesso - Journey
  Eu como um QA
  Quero garantir que o projeto foi criado com sucesso e está executando local e no Jenkins
  Para poder realizar as automações da squad

  @basic_test_1
  Cenário: Rodar um teste básico 1
    Dado que possua a mensagem "Deu tudo certo 1"
    Quando o valor da variável de mensagem for exibida no terminal
    Então o projeto foi criado com sucesso

  @basic_test_2
  Cenário: Rodar um teste básico 2
    Dado que possua a mensagem "Deu tudo certo 2"
    Quando o valor da variável de mensagem for exibida no terminal
    Então o projeto foi criado com sucesso

  @basic_test3
  Cenário: Rodar um teste básico 3
    Dado que possua a mensagem "Deu tudo certo 3"
    Quando o valor da variável de mensagem for exibida no terminal
    Então o projeto foi criado com sucesso