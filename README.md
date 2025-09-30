# Sistema de Rastreamento de Motos - FIAP DevOps

## 📋 Descrição da Solução

Sistema de rastreamento e gerenciamento de motocicletas desenvolvido em .NET 9.0 com Azure SQL Database. A aplicação permite o controle completo do ciclo de vida das motos, desde o cadastro até a movimentação entre setores, utilizando tags RFID para rastreamento em tempo real.

### Funcionalidades Principais:
- **Gestão de Motos**: CRUD completo com controle de chassi, placa, modelo e localização
- **Sistema de Tags**: Gerenciamento de tags RFID com vinculação/desvinculação de motos
- **Controle de Setores**: Organização das motos por departamentos (Manutenção, Prontas para Aluguel, etc.)
- **Rastreamento**: Histórico de localizações e movimentações
- **API RESTful**: Endpoints completos

## 💼 Benefícios para o Negócio

1. **Redução de Perdas**: Rastreamento em tempo real minimiza extravios e furtos
2. **Otimização Operacional**: Visibilidade clara da localização de cada moto reduz tempo de busca
3. **Manutenção Preventiva**: Controle de setores permite identificar motos que necessitam manutenção
4. **Auditoria Completa**: Histórico de movimentações para compliance e análise
5. **Escalabilidade**: Infraestrutura em nuvem permite crescimento sob demanda
6. **Disponibilidade**: Aplicação hospedada no Azure com alta disponibilidade

---

## 🚀 Tecnologias Utilizadas

- **.NET 9.0** - Framework de desenvolvimento
- **Azure SQL Database** - Banco de dados relacional em nuvem
- **Azure App Service** - Hospedagem PaaS
- **Entity Framework Core** - ORM para acesso a dados
- **Azure CLI** - Automação de infraestrutura

---

## 📐 Arquitetura da Solução

A arquitetura proposta utiliza **Azure App Service** para hospedar a API em .NET 8, 
e um **Azure SQL Database (motodb)** para persistência dos dados.  
As requisições HTTP do usuário passam pelo App Service, que realiza consultas SQL ao banco.  
O fluxo de deploy é feito via GitHub → Azure.  

1. O usuário envia requisições HTTP → App Service.
2. O App Service processa a API e consulta o banco.
3. O Dev faz deploy a partir do GitHub (manual ou futuro CI/CD).
4. Tudo está dentro do Resource Group rg-fiap-tracking-api.

![Arquitetura da Solução](docs/Captura de Tela 2025-09-29 às 21.35.47.png)

---

## 📦 Pré-requisitos

- [.NET 9.0 SDK](https://dotnet.microsoft.com/download/dotnet/9.0)
- [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli)
- Conta Azure ativa
- Git

---

## 🔧 Configuração e Deploy

### 1. Clonar o Repositório

```bash
git clone https://github.com/Lugia-Code/devops-tracking-code-api.git
cd devops-tracking-code-api
```

### 2. Fazer Login no Azure

```bash
az login
```

### 3. Criar Infraestrutura Azure

Execute os scripts na ordem:

```bash
# Passo 1: Criar Resource Group
chmod +x 01-create-resource-group.sh
./01-create-resource-group.sh

# Passo 2: Criar SQL Server
chmod +x 02-create-sql-server.sh
./02-create-sql-server.sh
# ATENÇÃO: Anote o nome do SQL Server gerado

# Passo 3: Criar Database
chmod +x 03-create-database.sh
# Edite o arquivo e substitua SQL_SERVER_NAME pelo nome anotado
./03-create-database.sh

# Passo 4: Configurar Firewall
chmod +x 04-configure-firewall.sh
# Edite o arquivo e substitua SQL_SERVER_NAME
./04-configure-firewall.sh

# Passo 5: Criar App Service
chmod +x 05-create-app-service.sh
./05-create-app-service.sh
# ATENÇÃO: Anote o nome do App Service gerado

# Passo 6: Configurar Connection String
chmod +x 06-configure-connection-string.sh
# Edite o arquivo e substitua SQL_SERVER_NAME e APP_SERVICE_NAME
./06-configure-connection-string.sh

# Passo 7: Configurar App Settings
chmod +x 07-configure-app-settings.sh
# Edite o arquivo e substitua APP_SERVICE_NAME
./07-configure-app-settings.sh
```

### 4. Configurar Aplicação Localmente

Edite `appsettings.json` com a connection string do seu banco:

```json
{
  "ConnectionStrings": {
    "FiapAzureDb": "Server=tcp:SEU_SQL_SERVER.database.windows.net,1433;Initial Catalog=motosdb;User ID=fiapAdmin;Password=FiapTracking2025!;Encrypt=True;Connection Timeout=30;"
  }
}
```

### 5. Executar Migrations

```bash
# Criar migrations
dotnet ef migrations add InitialCreate --context MotosDbContext

# Aplicar no banco Azure
dotnet ef database update --context MotosDbContext
```

### 6. Testar Localmente

```bash
dotnet run
```

Acesse: `https://localhost:5001/scalar/v1` para ver a documentação da API

### 7. Deploy no Azure

```bash
# Publicar aplicação
dotnet publish -c Release -o ./publish

# Criar pacote zip
cd publish
zip -r ../publish.zip .
cd ..

# Deploy
chmod +x 08-deploy-application.sh
# Edite o arquivo e substitua APP_SERVICE_NAME
./08-deploy-application.sh
```

### 8. Verificar Deploy

Acesse a URL do seu App Service:
```
https://SEU_APP_SERVICE.azurewebsites.net/health
```

---

## 📝 Estrutura do Banco de Dados

O arquivo `script_bd.sql` contém o DDL completo das tabelas. Principais entidades:

- **MOTO**: Informações das motocicletas (chassi, placa, modelo)
- **TAG**: Tags RFID para rastreamento
- **SETOR**: Departamentos/localizações
- **USUARIO**: Usuários do sistema
- **LOCALIZACAO**: Histórico de posições
- **AUDITORIA_MOVIMENTACAO**: Log de alterações

---

## 🧪 Testando CRUD no Banco de Dados Azure Portal

1. Criando setores
   
```bash
INSERT INTO "SETOR" (nome, descricao, coordenadas_limite)
VALUES 
('Prontas para aluguel', 'Setor para motos disponiveis para locacao', 1.0), 
('Minha Mottu', 'Minha Mottu', 2.0), 
('Pendente', 'Setor para motos com pendencias', 3.0),
('Sem placa', 'Setor para motos que estao sem placa', 4.0),
('Reparo Simples', 'Setor para motos com reparos simples', 5.0),
('Danos estruturais graves', 'Setor para motos com danos graves', 6.0),
('Motor defeituoso', 'Setor para motos com problemas no motor', 7.0),
('Agendada para manutenção', 'Setor para motos com manutencao agendada', 8.0);

```

2. Criando TAGs
   
```bash
INSERT INTO TAG (codigo_tag, status, data_vinculo, chassi)
VALUES
('RFID001', 'inativo', '2024-01-15T08:00:00', NULL),
('RFID002', 'inativo', '2024-01-20T09:30:00', NULL),
('RFID003', 'inativo', '2024-01-25T10:15:00', NULL);
```

3. Inserindo Motos

```bash
INSERT INTO MOTO (chassi, placa, modelo, data_cadastro, codigo_tag, id_setor) 
VALUES
('9C2JC30007R123456', 'ABC-1234', 'Mottu Sport ESD', '2024-01-15T10:00:00', 'RFID001', 1),
('9C2KC40008R789123', 'DEF-5678', 'Honda Pop 110I', '2024-01-20T11:00:00', 'RFID002', 2);
```

4. Atualizando setor da moto
   
```bash

UPDATE MOTO SET id_setor = 4 WHERE chassi = '9C2KC40008R789123'; --era setor 2 e vai para setor 4
UPDATE MOTO SET id_setor = 5 WHERE chassi = '9C2JC30007R123456'; --era setor 1 e vai para o 5
```

5. Verificar motos, suas tags e setores

```bash
-- Motos com suas tags e setores
SELECT
    M.chassi,
    M.placa,
    M.modelo,
    S.nome as setor,
    T.codigo_tag,
    T.status as status_tag
FROM MOTO M
         LEFT JOIN SETOR S ON M.id_setor = S.id_setor
         LEFT JOIN TAG T ON M.codigo_tag = T.codigo_tag;
```

---

## 🧪 Testando a API

### Exemplos de Requisições

#### 1. Listar Motos
```bash
curl https://SEU_APP_SERVICE.azurewebsites.net/api/v1/motos
```

#### 2. Atualizar setor da moto
```bash
curl -X PUT https://SEU_APP_SERVICE.azurewebsites.net/api/v1/motos/9C2JC30007R123456 -H "Content-Type: application/json" -d '{"idSetor": 5}'
```

#### 3. Listar Motos - conferir update
```bash
curl https://SEU_APP_SERVICE.azurewebsites.net/api/v1/motos
```

#### 4. # DELETE - Deletar moto
```bash
curl -X DELETE https://SEU_APP_SERVICE.azurewebsites.net/api/v1/motos/9C6KE040009R456789
```

### 5. Criar uma TAG

```bash
 curl -X POST https://SEU_APP_SERVICE.azurewebsites.net/api/v1/tags -H "Content-Type: application/json" -d '{"codigoTag": "RFID009"}'

```

---

## 🔍 Endpoints Principais

### Motos
- `GET /api/v1/motos` - Listar todas as motos (com paginação)
- `GET /api/v1/motos/{chassi}` - Buscar moto por chassi
- `GET /api/v1/motos/buscar/placa/{placa}` - Buscar por placa
- `POST /api/v1/motos` - Criar nova moto
- `PUT /api/v1/motos/{chassi}` - Atualizar moto
- `DELETE /api/v1/motos/{chassi}` - Deletar moto
- `PATCH /api/v1/motos/{chassi}/desvincular-tag` - Desvincular tag

### Tags
- `GET /api/v1/tags` - Listar todas as tags
- `GET /api/v1/tags/{codigo}` - Buscar tag por código
- `GET /api/v1/motos/tags-disponiveis` - Tags disponíveis
- `POST /api/v1/tags` - Criar nova tag
- `PUT /api/v1/tags/{codigo}` - Atualizar tag
- `DELETE /api/v1/tags/{codigo}` - Deletar tag

### Setores
- `GET /setores` - Listar setores
- `POST /setores` - Criar setor
- `PUT /setores/{id}` - Atualizar setor
- `DELETE /setores/{id}` - Deletar setor

### Health Check
- `GET /health` - Status da aplicação e banco de dados

---

## 🗑️ Limpeza de Recursos

Para deletar todos os recursos Azure criados:

```bash
chmod +x 99-cleanup.sh
./99-cleanup.sh
```

**ATENÇÃO**: Esta operação é irreversível e deletará todos os dados.

---

## 👥 Equipe

- - **Nathália Gomes da Silva** - RM: [554945]
- - **Nathan Magno Gustavo Cônsolo** - RM: [558987]
- - **Júlio César Nunes Oliveira** - RM: [557774]

---

## 📄 Licença

Este projeto foi desenvolvido para fins acadêmicos como parte do curso de DevOps da FIAP.

---

## 🔗 Links Úteis

- [Documentação do .NET](https://docs.microsoft.com/dotnet/)
- [Azure SQL Database](https://docs.microsoft.com/azure/azure-sql/)
- [Azure App Service](https://docs.microsoft.com/azure/app-service/)
- [Entity Framework Core](https://docs.microsoft.com/ef/core/)
