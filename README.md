# PD Hours Control

Esse projeto tem como objetivo construir uma aplicação que permita a empresa ter o controle de horas dos funcionários, separando-os por squads, e obter um resumo das horas gastas pelos times.

## Sobre

O sistema está dividido em duas partes: `Server` e `UI`.

### Server

O lado do servidor, foi criado uma `API` utilizando [Node.js](https://nodejs.org/pt) com o [fastify](https://fastify.dev/) para criação das rotas.

Para o banco de dados está sendo usado o [postgreSQL](https://www.postgresql.org/) e para manipular todas as funções do banco é usado o [Drizzle ORM](https://orm.drizzle.team/).

### UI

## Como executar

### Server

Na pasta correspondente ao [servidor](./server/package.json), deve-se criar o `container Docker` do `postgreSQL` para armazenar os dados da aplicação.

```shell
docker compose up
```

Agora deve-se gerar os pacotes de dependências `node_modules`.

```shell
yarn
```

Com o container criado e rodando e os pacotes instalados, agora é possível fazer a criação das tabelas no banco (Aqui é usado o yarn como gerenciador de pacotes). Para isso, é necessário utilizar o drizzle para gerar as `migrations` e criar as tabelas no banco que está no container.

```shell
yarn run drizzle:generate && yarn run drizzle:migrate
```

Para visualizar as tabelas do banco, o drizzle disponibiliza o studio.

```shell
yarn run drizzle:studio
```

Por último, é necessário rodas a API para fazer as requisições.

```shell
yarn run start
```

Agora já é possível fazer as requisições para a API. Aqui tem disponível uma [Documentação das rotas do insomnia](./server/docs/Insomnia_requests.json).

### UI

Antes de tudo, é necessário ter o [flutter](https://docs.flutter.dev/get-started/install) instalado e configurado no seu ambiente.

Após instalar o flutter, na pasta correspondente à [interface de usuário](./ui/pubspec.yaml), é necessário instalar as dependências listadas no [pubspec.yaml](./ui/pubspec.yaml).

```shell
flutter clean && flutter pub get && dart run build_runner build --delete-conflicting-outputs
```
