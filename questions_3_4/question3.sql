-- Passos 3.3 e 3.4:
CREATE TABLE IF NOT EXISTS saldos_contabeis (
    data DATE,
    reg_ans INTEGER
    cd_conta_contabil TEXT,
    descricao TEXT,
    vl_saldo_inicial NUMERIC,
    vl_saldo_final NUMERIC,
    period TEXT
);

CREATE TEMP TABLE IF NOT EXISTS temp_saldos_contabeis (
    data DATE,
    reg_ans INTEGER
    cd_conta_contabil TEXT,
    descricao TEXT,
    vl_saldo_inicial NUMERIC,
    vl_saldo_final NUMERIC
);

CREATE TABLE IF NOT EXISTS relatorio_cadop(
    registro_ans INTEGER,
    cnpj VARCHAR(20),
    razao_social TEXT,
    nome_fantasia TEXT,
    modalidade TEXT,
    logradouro TEXT,
    numero TEXT,
    complemento TEXT,
    bairro TEXT,
    cidade TEXT,
    uf CHAR(2),
    cep INTEGER,
    ddd VARCHAR(5) NULL,
    telefone BIGINT NULL,
    fax BIGINT NULL,
    endereco_eletronico TEXT NULL,
    representante TEXT NULL,
    cargo_representante TEXT NULL,
    regiao_de_comercializacao INTEGER NULL,
    data_registro_ans DATE
);

COPY relatorio_cadop FROM '/zip_files/Relatorio_cadop.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';

TRUNCATE TABLE temp_saldos_contabeis;
COPY temp_saldos_contabeis FROM '/zip_files/1T2023.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';
INSERT INTO saldos_contabeis SELECT *, '1T2023' FROM temp_saldos_contabeis;

TRUNCATE TABLE temp_saldos_contabeis;
COPY temp_saldos_contabeis FROM '/zip_files/2T2023.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';
INSERT INTO saldos_contabeis SELECT *, '2T2023' FROM temp_saldos_contabeis;

TRUNCATE TABLE temp_saldos_contabeis;
COPY temp_saldos_contabeis FROM '/zip_files/3T2023.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';
INSERT INTO saldos_contabeis SELECT *, '3T2023' FROM temp_saldos_contabeis;

TRUNCATE TABLE temp_saldos_contabeis;
COPY temp_saldos_contabeis FROM '/zip_files/4T2023.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';
INSERT INTO saldos_contabeis SELECT *, '4T2023' FROM temp_saldos_contabeis;

TRUNCATE TABLE temp_saldos_contabeis;
COPY temp_saldos_contabeis FROM '/zip_files/1T2024.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';
INSERT INTO saldos_contabeis SELECT *, '1T2024' FROM temp_saldos_contabeis;

TRUNCATE TABLE temp_saldos_contabeis;
COPY temp_saldos_contabeis FROM '/zip_files/2T2024.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';
INSERT INTO saldos_contabeis SELECT *, '2T2024' FROM temp_saldos_contabeis;

TRUNCATE TABLE temp_saldos_contabeis;
COPY temp_saldos_contabeis FROM '/zip_files/3T2024.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';
INSERT INTO saldos_contabeis SELECT *, '3T2024' FROM temp_saldos_contabeis;

TRUNCATE TABLE temp_saldos_contabeis;
COPY temp_saldos_contabeis FROM '/zip_files/4T2024.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';
INSERT INTO saldos_contabeis SELECT *, '4T2024' FROM temp_saldos_contabeis;

-- Passo 3.5

SELECT 
    "reg_ans",
    SUM("vl_saldo_inicial" - "vl_saldo_final") AS diferenca
FROM 
    saldos_contabeis
WHERE 
    period = '4T2024' 
    AND "descricao" = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '
GROUP BY "reg_ans"
ORDER BY 
    diferenca DESC
LIMIT 10;


SELECT 
    "reg_ans",
    SUM("vl_saldo_inicial" - "vl_saldo_final") AS diferenca
FROM 
    saldos_contabeis
WHERE 
    "period" LIKE '%2024'
    AND "descricao" = 'EVENTOS/ SINISTROS CONHECIDOS OU AVISADOS DE ASSISTÊNCIA A SAÚDE MEDICO HOSPITALAR '
GROUP BY "reg_ans"
ORDER BY 
    diferenca DESC
LIMIT 10;
