-- SCRIPTS USADOS NO QUERY EDITOR DO BANCO AZURE (VÍDEO)

INSERT INTO "SETOR" (nome, descricao, coordenadas_limite)
VALUES 
('Prontas para aluguel', 'Setor para motos disponiveis para locacao', 1.0), 
('Minha Mottu', 'Minha Mottu', 2.0), 
('Pendente', 'Setor para motos com pendencias', 3.0);

INSERT INTO "SETOR" (nome, descricao, coordenadas_limite)
VALUES
('Sem placa', 'Setor para motos que estao sem placa', 4.0),
('Reparo Simples', 'Setor para motos com reparos simples', 5.0),
('Danos estruturais graves', 'Setor para motos com danos graves', 6.0),
('Motor defeituoso', 'Setor para motos com problemas no motor', 7.0),
('Agendada para manutenção', 'Setor para motos com manutencao agendada', 8.0);

INSERT INTO TAG (codigo_tag, status, data_vinculo, chassi)
VALUES
('RFID001', 'inativo', '2024-01-15T08:00:00', NULL),
('RFID002', 'inativo', '2024-01-20T09:30:00', NULL),
('RFID003', 'inativo', '2024-01-25T10:15:00', NULL),
('RFID004', 'inativo', '2024-02-01T11:45:00', NULL);

-- 4. INSERIR MOTOS
INSERT INTO MOTO (chassi, placa, modelo, data_cadastro, codigo_tag, id_setor) 
VALUES
('9C2JC30007R123456', 'ABC-1234', 'Mottu Sport ESD', '2024-01-15T10:00:00', 'RFID001', 1),
('9C2KC40008R789123', 'DEF-5678', 'Honda Pop 110I', '2024-01-20T11:00:00', 'RFID002', 2);

INSERT INTO MOTO (chassi, placa, modelo, data_cadastro, codigo_tag, id_setor)
VALUES
('9C6KE040009R456789', 'GHI-9012', 'Mottu Sport ESD', '2024-01-25T14:30:00', 'RFID003', 1),
('9C2JD50010R987654', 'JKL-3456', 'Mottu Sport', '2024-02-01T16:15:00',

-- 5. ATUALIZAR SETOR DE MOTOS 

UPDATE MOTO SET id_setor = 4 WHERE chassi = '9C2KC40008R789123'; --era setor 2 e vai para setor 4
UPDATE MOTO SET id_setor = 5 WHERE chassi = '9C2JC30007R123456'; --era setor 1 e vai para o 5

-- 6. 
SELECT * FROM MOTO -- verificar UPDATE

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