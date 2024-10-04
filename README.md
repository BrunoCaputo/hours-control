# PD Hours Control

Este projeto tem como objetivo desenvolver uma aplicação que permita à empresa controlar as horas trabalhadas pelos funcionários, organizando-os por squads, e fornecendo um resumo das horas dedicadas por cada equipe.

## Sobre

O sistema é composto por duas partes principais: `Server` (lado do servidor) e `UI` (interface do usuário).

### Server

No lado do servidor, foi desenvolvida uma `API` utilizando [Node.js](https://nodejs.org/pt) com o framework [Fastify](https://fastify.dev/) para criação das rotas.

O banco de dados utilizado é o [PostgreSQL](https://www.postgresql.org/), e o gerenciamento das operações é realizado através do [Drizzle ORM](https://orm.drizzle.team/).

### UI

A interface do usuário foi desenvolvida em `Flutter`, garantindo uma experiência visual e funcional fluida.

## Como executar

### Server

1. **Criar o container Docker**: Na pasta do [servidor](./server/package.json), inicie um `container Docker` do `postgreSQL` para armazenar os dados da aplicação:

```bash
docker compose up
```

2. **Instalar as dependências**: Utilize o gerenciador de pacotes de sua preferência (aqui, estamos utilizando o yarn):

```bash
yarn
```

3. **Criar as tabelas no banco de dados**: Com o container em execução e as dependências instaladas, utilize o `Drizzle` para gerar as `migrações` e criar as tabelas:

```bash
yarn run drizzle:generate && yarn run drizzle:migrate
```

4. **Visualizar as tabelas**: O `Drizzle` fornece uma ferramenta de estúdio para visualizar as tabelas do banco:

```bash
yarn run drizzle:studio
```

5. **Executar a API**: Por fim, inicie a API para permitir as requisições:

```bash
yarn run start
```

A partir desse ponto, as requisições para a API estarão prontas para uso. Há também uma [documentação das rotas do insomnia](./server/docs/Insomnia_requests.json).

### UI

Antes de iniciar a interface do usuário, certifique-se de ter o [flutter](https://docs.flutter.dev/get-started/install) instalado e configurado em seu ambiente.

1. **Instalar as dependências**: Na pasta da [interface de usuário](./ui/pubspec.yaml), execute os comandos abaixo para instalar as dependências listadas no [pubspec.yaml](./ui/pubspec.yaml).

```bash
flutter clean && flutter pub get && dart run build_runner build --delete-conflicting-outputs
```
