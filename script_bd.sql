-- =============================================================================
-- DDL - SISTEMA DE RASTREAMENTO DE MOTOS
-- Gerado a partir das Migrations do Entity Framework
-- Projeto: FIAP DevOps - Tracking Code API
-- =============================================================================

-- Tabela SETOR
CREATE TABLE [SETOR] (
    [id_setor] int NOT NULL IDENTITY(1,1),
    [nome] nvarchar(450) NOT NULL,
    [descricao] nvarchar(max) NULL,
    [coordenadas_limite] float NULL,
    CONSTRAINT [PK_SETOR] PRIMARY KEY ([id_setor])
);

-- Tabela TAG
CREATE TABLE [TAG] (
    [codigo_tag] nvarchar(450) NOT NULL,
    [status] nvarchar(max) NOT NULL,
    [data_vinculo] datetime2 NOT NULL,
    [chassi] nvarchar(max) NULL,
    CONSTRAINT [PK_TAG] PRIMARY KEY ([codigo_tag])
);

-- Tabela USUARIO
CREATE TABLE [USUARIO] (
    [id_funcionario] int NOT NULL IDENTITY(1,1),
    [nome] nvarchar(max) NOT NULL,
    [email] nvarchar(450) NOT NULL,
    [senha] nvarchar(max) NOT NULL,
    [funcao] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_USUARIO] PRIMARY KEY ([id_funcionario])
);

-- Tabela AUDITORIA_MOVIMENTACAO
CREATE TABLE [AUDITORIA_MOVIMENTACAO] (
    [id_audit] int NOT NULL IDENTITY(1,1),
    [id_funcionario] int NOT NULL,
    [tipo_operacao] nvarchar(max) NOT NULL,
    [data_operacao] datetime2 NOT NULL,
    [valores_novos] nvarchar(max) NULL,
    [valores_anteriores] nvarchar(max) NULL,
    CONSTRAINT [PK_AUDITORIA_MOVIMENTACAO] PRIMARY KEY ([id_audit]),
    CONSTRAINT [FK_AUDITORIA_MOVIMENTACAO_USUARIO_id_funcionario] FOREIGN KEY ([id_funcionario]) REFERENCES [USUARIO] ([id_funcionario]) ON DELETE NO ACTION
);

-- Tabela LOCALIZACAO
CREATE TABLE [LOCALIZACAO] (
    [id_localizacao] int NOT NULL IDENTITY(1,1),
    [x] decimal(12,8) NOT NULL,
    [y] decimal(12,8) NOT NULL,
    [codigo_tag] nvarchar(450) NOT NULL,
    [id_setor] int NOT NULL,
    [data_registro] datetime2 NOT NULL,
    CONSTRAINT [PK_LOCALIZACAO] PRIMARY KEY ([id_localizacao]),
    CONSTRAINT [FK_LOCALIZACAO_SETOR_id_setor] FOREIGN KEY ([id_setor]) REFERENCES [SETOR] ([id_setor]) ON DELETE NO ACTION,
    CONSTRAINT [FK_LOCALIZACAO_TAG_codigo_tag] FOREIGN KEY ([codigo_tag]) REFERENCES [TAG] ([codigo_tag]) ON DELETE NO ACTION
);

-- Tabela MOTO
CREATE TABLE [MOTO] (
    [chassi] nvarchar(450) NOT NULL,
    [placa] nvarchar(450) NULL,
    [modelo] nvarchar(max) NOT NULL,
    [data_cadastro] datetime2 NOT NULL,
    [codigo_tag] nvarchar(450) NULL,
    [id_setor] int NOT NULL,
    [id_audit] int NULL,
    CONSTRAINT [PK_MOTO] PRIMARY KEY ([chassi]),
    CONSTRAINT [FK_MOTO_AUDITORIA_MOVIMENTACAO_id_audit] FOREIGN KEY ([id_audit]) REFERENCES [AUDITORIA_MOVIMENTACAO] ([id_audit]),
    CONSTRAINT [FK_MOTO_SETOR_id_setor] FOREIGN KEY ([id_setor]) REFERENCES [SETOR] ([id_setor]) ON DELETE NO ACTION,
    CONSTRAINT [FK_MOTO_TAG_codigo_tag] FOREIGN KEY ([codigo_tag]) REFERENCES [TAG] ([codigo_tag])
);

-- Índices
CREATE INDEX [IX_AUDITORIA_MOVIMENTACAO_id_funcionario] ON [AUDITORIA_MOVIMENTACAO] ([id_funcionario]);
CREATE INDEX [IX_LOCALIZACAO_codigo_tag] ON [LOCALIZACAO] ([codigo_tag]);
CREATE INDEX [IX_LOCALIZACAO_id_setor] ON [LOCALIZACAO] ([id_setor]);
CREATE UNIQUE INDEX [IX_MOTO_codigo_tag] ON [MOTO] ([codigo_tag]) WHERE [codigo_tag] IS NOT NULL;
CREATE INDEX [IX_MOTO_id_audit] ON [MOTO] ([id_audit]);
CREATE INDEX [IX_MOTO_id_setor] ON [MOTO] ([id_setor]);
CREATE UNIQUE INDEX [IX_MOTO_placa] ON [MOTO] ([placa]) WHERE [placa] IS NOT NULL;
CREATE UNIQUE INDEX [IX_SETOR_nome] ON [SETOR] ([nome]);
CREATE UNIQUE INDEX [IX_USUARIO_email] ON [USUARIO] ([email]);

