# Habit Tracker

Aplicacao Ruby on Rails para acompanhamento de habitos, com autenticacao via Devise, calendario de conclusoes e pipeline de CI no GitHub Actions.

## Stack

- Ruby 3.4.9
- Rails 7.2
- SQLite3
- Devise
- Simple Calendar
- RuboCop
- Brakeman

## Pre-requisitos

Antes de rodar localmente, voce precisa ter instalado:

- Ruby 3.4.9
- Bundler 2.6.9
- SQLite3
- Git

Opcional para testes de sistema locais:

- Google Chrome ou Chromium
- Chromedriver compativel

## Instalacao

1. Clone o repositorio

	git clone https://github.com/GBugliani/habit_tracker.git
	cd habit_tracker

2. Instale as dependencias

	bundle install

3. Prepare o banco de dados

	bin/rails db:prepare

4. Inicie a aplicacao

	bin/rails server

5. Acesse no navegador

	http://localhost:3000

## Como rodar em desenvolvimento

Com o servidor iniciado, voce pode usar normalmente:

- Cadastro e login de usuario
- CRUD de habitos
- Filtros e paginacao
- Conclusao diaria e visualizacao em calendario

## Comandos uteis

Rodar testes:

	bin/rails test

Rodar testes de sistema:

	bin/rails test:system

Rodar lint:

	bin/rubocop -f github

Rodar analise de seguranca:

	bin/brakeman --no-pager

## CI (GitHub Actions)

O pipeline em [.github/workflows/ci.yml](.github/workflows/ci.yml) executa:

- scan_ruby (Brakeman)
- scan_js (Importmap audit)
- lint (RuboCop)
- test (suite Rails)

Nota importante de compatibilidade:

- Este projeto fixa Minitest em versao menor que 6 no [Gemfile](Gemfile), por compatibilidade com Rails 7.2 no ambiente de CI.
- Se voce remover esse pin, pode ocorrer erro no job de teste relacionado a line filtering.

## Estrutura principal

- Aplicacao Rails: [app](app)
- Configuracoes: [config](config)
- Banco e migrations: [db](db)
- Testes: [test](test)

## Troubleshooting rapido

Se o projeto nao subir:

1. Garanta a versao correta do Ruby
2. Rode bundle install novamente
3. Rode bin/rails db:prepare
4. Limpe cache temporario, se necessario:

	bin/rails tmp:clear log:clear
