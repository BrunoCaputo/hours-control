# PD Hours Control

Este projeto tem como objetivo desenvolver uma aplicação que permita à empresa controlar as horas trabalhadas pelos funcionários, organizando-os por squads, e fornecendo um resumo das horas dedicadas por cada equipe.

## Sobre

O sistema é composto por duas partes principais: `Server` (lado do servidor) e `UI` (interface do usuário).

### Server

No lado do servidor, foi desenvolvida uma `API` utilizando [Node.js](https://nodejs.org/pt) com o framework [Fastify](https://fastify.dev/) para criação das rotas.

O banco de dados utilizado é o [PostgreSQL](https://www.postgresql.org/), e o gerenciamento das operações é realizado através do [Drizzle ORM](https://orm.drizzle.team/).

> Nota: Certifique-se de executar o servidor primeiro.

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

1. **Instalar as dependências**: Navegue até a pasta da [interface de usuário](./ui/pubspec.yaml) e execute o comando abaixo para instalar todas as dependências listadas no arquivo [pubspec.yaml](./ui/pubspec.yaml).

```bash
flutter clean && flutter pub get && dart run build_runner build --delete-conflicting-outputs
```

> Nota: Para evitar problemas de conexão na rede local, recomenda-se utilizar um emulador Android.

2. **Executar em seu ambiente de teste**: Após a configuração, você pode executar o projeto no seu dispositivo. As opções de execução incluem Android e Web.

- **Android**: Para testar em um ambiente Android, execute:

  ```bash
  flutter run
  ```

  > Dica: Se você tiver um dispositivo físico Android conectado, ele será priorizado ao executar este comando sem especificação de dispositivo.

- **Web**: Para executar na Web, escolha entre o navegador Chrome ou Edge:

  ```bash
  flutter run -d "Chrome"
  ```

  ou

  ```bash
  flutter run -d "Edge"
  ```

3. **Conexão com o servidor**: Se for necessário alterar a URL do servidor, basta modificar o valor de `serverApiBaseUrl` no arquivo [ui/lib/config/servcer_url.dart](./ui/lib/config/server_url.dart)

> Dica: Se estiver usando um dispositivo Android físico, verifique o endereço IPv4 da máquina atual e atualize este arquivo com o novo IP.
