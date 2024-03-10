# Arch Developer


Repositorio contendo código fonte referente a Arquitetura de Soluções em Geral

## 🚀 Começando

Essas instruções permitirão que você obtenha uma cópia do projeto em operação na sua máquina local para fins de desenvolvimento e teste.



### 📋 Pré-requisitos

- Necessário a instalação do Docker na sua máquina 
- Necessário a instalação da OpenJDK(Free) de acordo com a versão do projeto 
- Necessário como gerenciador de dependência gradle

### 🔧 Links para as versões do Projeto

  - Segue Link da documentação:

| Assunto                   | Link                                                                                                           |
| ------------------------- | -------------------------------------------------------------------------------------------------------------- |
| 01-01-example-sqs-sns-s3  | [Localstack+SQS+S3]()   |

## 🖇️ Comandos LocalStack 

## ✒️ Autores
	A descrição das funcionalidades foram copias do perfil: https://github.com/Daniel-iel/LocalStack/blob/main/readme.md
Sendo ele responsável por essa fase do catálogo.	

## Simple Queue Service (SQS)

O primeiro passo ao trabalhar com o SQS é se familiarizar com a [documentação](https://aws.amazon.com/pt/sqs/).

Ao interagir com o comando `aws sqs`, você terá acesso às seguintes opções. Embora não iremos nos aprofundar em todas elas, é útil conhecer quais são essas opções.

```shell
add-permission                           | change-message-visibility
change-message-visibility-batch          | create-queue
delete-message                           | delete-message-batch
delete-queue                             | get-queue-attributes
get-queue-url                            | list-dead-letter-source-queues
list-queue-tags                          | list-queues
purge-queue                              | receive-message
remove-permission                        | send-message
send-message-batch                       | set-queue-attributes
tag-queue                                | untag-queue
```

### Criando Fila

Utilizado para criar uma nova fila (fila de mensagens) no Amazon Simple Queue Service (SQS).

```shell
# fila standard
aws sqs create-queue <nome da fila> --endpoint-url http://localhost:4566 --profile  <nome do profile>

# fila fifo
aws sqs create-queue <nome da fila> --endpoint-url http://localhost:4566 --profile  <nome do profile> --attributes FifoQueue=true
```

---
**NOTE**

Para filas do tipo FIFO, é necessário que o nome da fila termine com .fifo, e é essencial incluir a tag *--attributes FifoQueue=true* ao utilizar o comando `aws sqs create-queue`.

---

### Deletando Fila

Usado para excluir uma fila (fila de mensagens) específica no Amazon Simple Queue Service (SQS).

```shell
aws sqs delete-queue --queue-url <url da fila> --endpoint-url http://localhost:4566 --profile <nome do profile>
```

### Deletando Mensagem

Utilizado para remover uma mensagem específica de uma fila no Amazon Simple Queue Service (SQS), é fundamental fornecer a URL da fila e o identificador de recebimento (receipt handle) da mensagem nos parâmetros *--queue-url* e *--receipt-handle*, respectivamente.

```shell
aws sqs delete-message --queue-url <url da fila> --receipt-handle <receipt-handle da mensagem> --endpoint-url http://localhost:4566 --profile <nome do profile>
```

### Listando Filas

Usado para listar as filas (filas de mensagens) existentes no Amazon Simple Queue Service (SQS).

```shell
aws sqs list-queues --endpoint-url http://localhost:4566 --profile <nome do profile>
```

### Receber Mensagens

Usado para recuperar mensagens da fila (fila de mensagens) no Amazon Simple Queue Service (SQS), é imprescindível indicar a URL da fila no parâmetro *--queue-url*.

```shell
aws sqs receive-message --queue-url <url da fila> --endpoint-url http://localhost:4566 --profile <nome do profile>
```

### Enviando uma mensagem

Usado para enviar uma mensagem para uma fila (fila de mensagens) no Amazon Simple Queue Service (SQS), é imprescindível indicar a URL da fila no parâmetro *--queue-url*..

```shell
aws sqs send-message --queue-url <url da fila> --message-body "<mensagem>" --endpoint-url http://localhost:4566 --profile <nome do profile>
```

---
**NOTE**

Se o seu processo de leitura de mensagens requer informações adicionais, como o nome do evento, por exemplo, esses detalhes podem ser incluídos usando uma tag *--message-attributes '{"AttributeName":{"DataType":"String","StringValue":"AttributeValue"}}'*

---

### Configuração da Fila

Usado para obter os atributos de uma fila Amazon Simple Queue Service (SQS).

```shell
aws sqs get-queue-attributes --queue-url <url da fila> --endpoint-url http://localhost:4566 --profile <nome do profile>
```

### Dead-Letter Queue (DQL)

Para configurar o redirecionamento de mensagens para uma DLQ (Dead-Letter Queue), é importante que ambas as filas sejam do mesmo tipo, seja Standard ou FIFO. Além disso, é necessário se familiarizar com essa funcionalidade por meio da [documentação](https://docs.aws.amazon.com/pt_br/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-dead-letter-queues.html).

```shell
# Criar fila
aws sqs create-queue <nome da fila> --endpoint-url http://localhost:4566 --profile  <nome do profile>

# Criar fila Morta
aws sqs create-queue <nome da fila morta> --endpoint-url http://localhost:4566 --profile  <nome do profile>

aws sqs set-queue-attributes \
--queue-url <url da fila> \
--attributes '{
    "RedrivePolicy": "{\"deadLetterTargetArn\":\"<ARN da fila morta>\",\"maxReceiveCount\":\"3\"}",
    "VisibilityTimeout": "90"
}'
```

---
**NOTE**

O comando `aws sqs set-queue-attributes` permite configurar a fila principal para redirecionar mensagens após 3 tentativas.

---

## Simple Notification Service (SNS)

O primeiro passo ao trabalhar com o SNS é se familiarizar com a [documentação](https://aws.amazon.com/pt/sns/).

Ao interagir com o comando `aws sns`, você terá acesso às seguintes opções. Embora não iremos nos aprofundar em todas elas, é útil conhecer quais são essas opções.

```shell
add-permission                           | check-if-phone-number-is-opted-out
confirm-subscription                     | create-platform-application
create-platform-endpoint                 | create-sms-sandbox-phone-number
create-topic                             | delete-endpoint
delete-platform-application              | delete-sms-sandbox-phone-number
delete-topic                             | get-data-protection-policy
get-endpoint-attributes                  | get-platform-application-attributes
get-sms-attributes                       | get-sms-sandbox-account-status
get-subscription-attributes              | get-topic-attributes
list-endpoints-by-platform-application   | list-origination-numbers
list-phone-numbers-opted-out             | list-platform-applications
list-sms-sandbox-phone-numbers           | list-subscriptions
list-subscriptions-by-topic              | list-tags-for-resource
list-topics                              | opt-in-phone-number
publish                                  | publish-batch
put-data-protection-policy               | remove-permission
set-endpoint-attributes                  | set-platform-application-attributes
set-sms-attributes                       | set-subscription-attributes
set-topic-attributes                     | subscribe
tag-resource                             | unsubscribe
untag-resource                           | verify-sms-sandbox-phone-number
```

### Criando Tópico

Usado para criar um novo tópico (topic) no Amazon Simple Notification Service (SNS).

```shell
# tópico standard
aws sns create-topic --name <nome do tópico> --endpoint-url http://localhost:4566 --profile  <nome do profile>

# tópico fifo
aws sns create-topic --name <nome do tópico> --endpoint-url http://localhost:4566 --profile  <nome do profile> --attributes FifoTopic=true
```

---
**NOTE**

1. No caso de tópicos do tipo FIFO, é fundamental que o nome do tópico seja finalizado com a extensão ".fifo". Além disso, ao utilizar o comando `aws sns create-topic`, é essencial adicionar a tag *--attributes FifoTopic=true*.
2. É importante destacar que apenas é viável associar filas e tópicos que compartilhem o mesmo tipo: tópicos FIFO devem ser vinculados a filas FIFO, enquanto tópicos do tipo standard devem ser conectados a filas do tipo standard.

---

### Deletando Tópico

Utilizado para excluir um tópico (topic) específico do Amazon Simple Notification Service (SNS).

```shell
aws sns delete-topic --topic-arn <arn do topic> --endpoint-url http://localhost:4566 --profile <nome do profile>
```

### Listando Tópicos

Usado para listar os tópicos (topics) existentes no Amazon Simple Notification Service (SNS).

```shell
aws sns list-topics --endpoint-url http://localhost:4566 --endpoint-url http://localhost:4566 --profile <nome do profile>
```

### Conectando uma fila a um tópico

Para estabelecer uma conexão entre uma fila SQS e um tópico, proceda com o comando abaixo.

```shell
aws sns subscribe --topic-arn <arn do topico> --protocol sqs --notification-endpoint <arn da fila> --endpoint-url http://localhost:4566 --profile <nome do profile>
```

---
**NOTE**

Após realizar a inscrição, será necessário confirmá-la, o que pode ser feito ao listar todas as mensagens presentes na fila.

```shell
aws sqs receive-message --queue-url <url da fila> --endpoint-url http://localhost:4566 --profile <nome do profile>
```

---

### Enviando mensagem

Utilizado para publicar (enviar) uma mensagem para um tópico (topic) no Amazon Simple Notification Service (SNS),

```shell
aws sns publish --topic-arn <arn do topico> --message "<mensagem>" --endpoint-url http://localhost:4566 --profile <nome do profile>
```

---
**NOTE**

Se o seu processo de leitura de mensagens requer informações adicionais, como o nome do evento, por exemplo, esses detalhes podem ser incluídos usando uma tag *--message-attributes '{"AttributeName":{"DataType":"String","StringValue":"AttributeValue"}}'*

---

## Simple Storage Service (S3)

O primeiro passo ao trabalhar com o S3 é se familiarizar com a [documentação](https://aws.amazon.com/pt/s3/).

Ao interagir com o comando `aws S3api`, você terá acesso às seguintes opções. Embora não iremos nos aprofundar em todas elas, é útil conhecer quais são essas opções.

```shell
abort-multipart-upload                   | complete-multipart-upload
copy-object                              | create-bucket
create-multipart-upload                  | delete-bucket
delete-bucket-analytics-configuration    | delete-bucket-cors
delete-bucket-encryption                 | delete-bucket-intelligent-tiering-configuration
delete-bucket-inventory-configuration    | delete-bucket-lifecycle
delete-bucket-metrics-configuration      | delete-bucket-ownership-controls
delete-bucket-policy                     | delete-bucket-replication
delete-bucket-tagging                    | delete-bucket-website
delete-object                            | delete-object-tagging
delete-objects                           | delete-public-access-block
get-bucket-accelerate-configuration      | get-bucket-acl
get-bucket-analytics-configuration       | get-bucket-cors
get-bucket-encryption                    | get-bucket-intelligent-tiering-configuration
get-bucket-inventory-configuration       | get-bucket-lifecycle
get-bucket-lifecycle-configuration       | get-bucket-location
get-bucket-logging                       | get-bucket-metrics-configuration
get-bucket-notification                  | get-bucket-notification-configuration
get-bucket-ownership-controls            | get-bucket-policy
get-bucket-policy-status                 | get-bucket-replication
get-bucket-request-payment               | get-bucket-tagging
get-bucket-versioning                    | get-bucket-website
get-object                               | get-object-acl
get-object-attributes                    | get-object-legal-hold
get-object-lock-configuration            | get-object-retention
get-object-tagging                       | get-object-torrent
get-public-access-block                  | head-bucket
head-object                              | list-bucket-analytics-configurations
list-bucket-intelligent-tiering-configurations | list-bucket-inventory-configurations
list-bucket-metrics-configurations       | list-buckets
list-multipart-uploads                   | list-object-versions
list-objects                             | list-objects-v2
list-parts                               | put-bucket-accelerate-configuration
put-bucket-acl                           | put-bucket-analytics-configuration
put-bucket-cors                          | put-bucket-encryption
put-bucket-intelligent-tiering-configuration | put-bucket-inventory-configuration
put-bucket-lifecycle                     | put-bucket-lifecycle-configuration
put-bucket-logging                       | put-bucket-metrics-configuration
put-bucket-notification                  | put-bucket-notification-configuration
put-bucket-ownership-controls            | put-bucket-policy
put-bucket-replication                   | put-bucket-request-payment
put-bucket-tagging                       | put-bucket-versioning
put-bucket-website                       | put-object
put-object-acl                           | put-object-legal-hold
put-object-lock-configuration            | put-object-retention
put-object-tagging                       | put-public-access-block
restore-object                           | select-object-content
upload-part                              | upload-part-copy
write-get-object-response                | wait
```

### Listando Buckets

Utilizado para listar todos os buckets (recipientes de armazenamento) presentes no s3 associada ao profile configurado.

```shell
aws s3api list-buckets --endpoint-url http://localhost:4566 --profile <nome do profile>
```

### Listando Objeto do Bucket

Usado para listar os objetos (arquivos) armazenados em um bucket específico no s3.

```shell
aws s3api list-objects --bucket <nome do bucket> --endpoint-url http://localhost:4566 --profile <nome do profile>
```

### Criando Bucket

Utilizado para criar um novo bucket (recipientes de armazenamento) no s3.

```shell
aws s3api create-bucket --bucket <nome do bucket> --endpoint-url http://localhost:4566 --profile <nome do profile>
```

### Deletando Bucket

Usado para excluir um bucket (recipientes de armazenamento) específico no s3.

```shell
aws s3api delete-bucket --endpoint-url http://localhost:4566 --profile <nome do profile>
```

### Enviando Arquivo

Utilizado para criar ou substituir um objeto (arquivo) em um bucket específico no s3.

```shell
aws s3api put-object --bucket <nome do bucket> --key <path do arquivo no bucket> --body <path do arquivo da maquina local> --endpoint-url http://localhost:4566 --profile <nome do profile>
```

### Deletando Arquivo

Usado para excluir um objeto (arquivo) específico em um bucket no s3.

```shell
aws s3api delete-object --bucket <nome do bucket> --key <path do arquivo no bucket> --endpoint-url http://localhost:4566 --profile <nome do profile>
```

## Secrets Manager

O primeiro passo ao trabalhar com o Secrets Manager é se familiarizar com a [documentação](https://aws.amazon.com/pt/secrets-manager/).

Ao interagir com o comando `aws secretsmanager`, você terá acesso às seguintes opções. Embora não iremos nos aprofundar em todas elas, é útil conhecer quais são essas opções.

```shell
cancel-rotate-secret                     | create-secret
delete-resource-policy                   | delete-secret
describe-secret                          | get-random-password
get-resource-policy                      | get-secret-value
list-secret-version-ids                  | list-secrets
put-resource-policy                      | put-secret-value
remove-regions-from-replication          | replicate-secret-to-regions
restore-secret                           | rotate-secret
stop-replication-to-replica              | tag-resource
untag-resource                           | update-secret
update-secret-version-stage              | validate-resource-policy
```

### Criando Secret

Usado para criar um novo segredo (informação sensível) no Secrets Manager.

```shell
aws secretsmanager create-secret --name <nome da secret> --secret-string "<texto do segredo>" --endpoint-url http://localhost:4566 --profile <nome do profile>
```

### Listando Secret

Utilizado para listar os segredos (informações sensíveis) armazenados no Secrets Manager.

```shell
aws secretsmanager list-secrets --endpoint-url http://localhost:4566 --profile <nome do profile>
```

### Deletando Secret

Usado para excluir um segredo (informação sensível) específico do Secrets Manager.

```shell
aws secretsmanager delete-secret --secret-id <nome da secret> --endpoint-url http://localhost:4566 --profile <nome do profile>
```

### Consulta Valor da Secret

Utilizado para recuperar o valor de um segredo específico do Secrets Manager.

```shell
aws secretsmanager get-secret-value --secret-id <nome da secret> --endpoint-url http://localhost:4566 --profile <nome do profile>
```















## 🖇️ Colaborando

Por favor, leia o [COLABORACAO.md](https://gist.github.com/usuario/linkParaInfoSobreContribuicoes) para obter detalhes sobre o nosso código de conduta e o processo para nos enviar pedidos de solicitação.

## 📌 Versão

Nós usamos [SemVer](http://semver.org/) para controle de versão. Para as versões disponíveis, observe as [tags neste repositório](https://github.com/suas/tags/do/projeto). 

## ✒️ Autores

* **Carlos Roberto - dev ** - *Trabalho e Documentação*

## 📄 Licença

Este projeto está sob a licença (sua licença) - veja o arquivo [LICENSE.md](https://github.com/usuario/projeto/licenca) para detalhes.

## 🎁 Expressões de gratidão

* Obrigado Deus pela execução do projeto;

---
⌨️ com ❤️ por [Carlos Roberto] 😊
