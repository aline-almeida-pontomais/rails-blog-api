# Blog - Rails
Blog simples utilizando Ruby on Rails, focado somente no Back-end. Utilizando docker

Inclui testes unitários de models, controller(request) e rotas, utilizando rspec e a gem **retest** (instruções para instalação e uso abaixo)

Neste blog é possível escrever, ler, editar e deletar artigos. Também é possível fazer o CRUD de comentários dentro de cada um desses artigos. 
Foi desenvolvido um sistema de autenticação simples utilizando http_basic_authenticate, que não é o método mais seguro de autenticação, mas utilizei a título de aprendizado.


![image](https://user-images.githubusercontent.com/82518612/157721507-49debcdc-6447-4d7d-b4b6-019443386aa4.png)

![image](https://user-images.githubusercontent.com/82518612/157720915-ecb1d14b-d56d-42a3-ac12-06700f933336.png)

![image](https://user-images.githubusercontent.com/82518612/157721044-45e3d56a-3743-4110-a973-cba0dd681286.png)

Ainda é possível escolher um status do artigo ou comentário, sendo público, privado ou arquivado.
![image](https://user-images.githubusercontent.com/82518612/157721377-d12651e6-7590-4409-9f9c-b3d66771ca4f.png)



# **Pré Requisitos**

- -> Ruby versão 2.7.0 ou superior 
- -> Rails versao 7.0.0 ou superior 
- -> Bundler versão 2.3.8 ou superior
- -> Sqlite3 versão 3.31.1 ou superior
- -> Docker

# **Gem Retest** 

- instalação: 

```docker-compose run api gem install retest```

use ```docker-compose run api retest -h``` para ver todas as opções, como por exemplo a tag --all

```docker-compose run api retest --all``` para rodar todos os testes


Para iniciar o servidor web dentro da pasta do projeto: 

``` docker-compose up ... ```

``` docker-compose run api ... ```
