#language: pt
#utf-8

@make_all @make_parallel
Funcionalidade: Garantir que o projeto de QA foi criado e está executando com sucesso - Parallel
  Eu como um QA
  Quero garantir que o projeto foi criado com sucesso e está executando local e no Jenkins
  Para poder realizar as automações da squad

  @basic_test
  Esquema do Cenário: Rodar um teste básico em paralelo
    Dado que possua a mensagem "<message>"
    Quando o valor da variável de mensagem for exibida no terminal
    Então o projeto foi criado com sucesso

    Exemplos:
    | message           |
    | Deu tudo certo 1  |
    | Deu tudo certo 2  |
    | Deu tudo certo 3  |
    | Deu tudo certo 4  |
    | Deu tudo certo 5  |
    | Deu tudo certo 6  |
    | Deu tudo certo 7  |
    | Deu tudo certo 8  |
    | Deu tudo certo 9  |
    | Deu tudo certo 10 |

