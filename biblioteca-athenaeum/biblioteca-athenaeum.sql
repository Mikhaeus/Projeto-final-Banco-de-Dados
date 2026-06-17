-- =====================================================
-- BIBLIOTECA CLÁSSICA ATHENAEUM
-- Integrantes:
-- Gustavo Caiuã Martins Mendes
-- Maria Fernanda Bicalho Veloso
-- =====================================================

DROP DATABASE IF EXISTS biblioteca_athenaeum;
CREATE DATABASE biblioteca_athenaeum;
USE biblioteca_athenaeum;

-- =====================================================
-- TABELA USUARIO
-- =====================================================
CREATE TABLE usuario (
    id_usuario    INT          AUTO_INCREMENT PRIMARY KEY,
    nome          VARCHAR(100) NOT NULL,
    cpf           VARCHAR(14)  NOT NULL UNIQUE,
    email         VARCHAR(100) NOT NULL UNIQUE,
    telefone      VARCHAR(20)  NOT NULL,
    data_cadastro DATE         NOT NULL DEFAULT (CURRENT_DATE),
    status        VARCHAR(10)  NOT NULL DEFAULT 'ATIVO',
    CHECK (status IN ('ATIVO','INATIVO'))
);

-- =====================================================
-- TABELA CARTEIRINHA
-- RELACIONAMENTO 1:1 COM USUARIO
-- =====================================================
CREATE TABLE carteirinha (
    id_carteirinha INT         AUTO_INCREMENT PRIMARY KEY,
    numero         VARCHAR(20) NOT NULL UNIQUE,
    data_emissao   DATE        NOT NULL,
    id_usuario     INT         NOT NULL UNIQUE,
    CONSTRAINT fk_carteirinha_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- =====================================================
-- TABELA FUNCIONARIO
-- =====================================================
CREATE TABLE funcionario (
    id_funcionario INT          AUTO_INCREMENT PRIMARY KEY,
    nome           VARCHAR(100) NOT NULL,
    cpf            VARCHAR(14)  NOT NULL UNIQUE,
    cargo          VARCHAR(50)  NOT NULL,
    email          VARCHAR(100) UNIQUE
);

-- =====================================================
-- TABELA LIVRO
-- =====================================================
CREATE TABLE livro (
    id_livro       INT          AUTO_INCREMENT PRIMARY KEY,
    titulo         VARCHAR(200) NOT NULL,
    isbn           VARCHAR(20)  NOT NULL UNIQUE,
    ano_publicacao YEAR         NOT NULL
);

-- =====================================================
-- TABELA AUTOR
-- =====================================================
CREATE TABLE autor (
    id_autor      INT         AUTO_INCREMENT PRIMARY KEY,
    nome          VARCHAR(100) NOT NULL,
    nacionalidade VARCHAR(50)  NOT NULL
);

-- =====================================================
-- TABELA CATEGORIA
-- =====================================================
CREATE TABLE categoria (
    id_categoria INT          AUTO_INCREMENT PRIMARY KEY,
    nome         VARCHAR(50)  NOT NULL UNIQUE,
    descricao    VARCHAR(200)
);

-- =====================================================
-- TABELA EXEMPLAR
-- =====================================================
CREATE TABLE exemplar (
    id_exemplar       INT         AUTO_INCREMENT PRIMARY KEY,
    codigo_exemplar   VARCHAR(20) NOT NULL UNIQUE,
    estado_conservacao VARCHAR(20) NOT NULL,
    disponibilidade   VARCHAR(20) NOT NULL DEFAULT 'DISPONIVEL',
    localizacao       VARCHAR(50) NOT NULL,
    id_livro          INT         NOT NULL,
    CHECK (estado_conservacao IN ('OTIMO','BOM','REGULAR','RUIM')),
    CHECK (disponibilidade IN ('DISPONIVEL','EMPRESTADO')),
    CONSTRAINT fk_exemplar_livro
        FOREIGN KEY (id_livro)
        REFERENCES livro(id_livro)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- =====================================================
-- TABELA EMPRESTIMO
-- =====================================================
CREATE TABLE emprestimo (
    id_emprestimo   INT          AUTO_INCREMENT PRIMARY KEY,
    data_emprestimo DATE         NOT NULL,
    data_prevista   DATE         NOT NULL,
    data_devolucao  DATE,
    multa           DECIMAL(8,2) DEFAULT 0,
    id_usuario      INT          NOT NULL,
    id_funcionario  INT          NOT NULL,
    id_exemplar     INT          NOT NULL,
    CHECK (multa >= 0),
    CONSTRAINT fk_emprestimo_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_emprestimo_funcionario
        FOREIGN KEY (id_funcionario)
        REFERENCES funcionario(id_funcionario)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,
    CONSTRAINT fk_emprestimo_exemplar
        FOREIGN KEY (id_exemplar)
        REFERENCES exemplar(id_exemplar)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- =====================================================
-- TABELA RESERVA
-- =====================================================
CREATE TABLE reserva (
    id_reserva  INT  AUTO_INCREMENT PRIMARY KEY,
    data_reserva DATE NOT NULL,
    status       VARCHAR(20) DEFAULT 'PENDENTE',
    id_usuario   INT NOT NULL,
    id_livro     INT NOT NULL,
    CHECK (status IN ('PENDENTE','ATENDIDA','CANCELADA')),
    CONSTRAINT fk_reserva_usuario
        FOREIGN KEY (id_usuario)
        REFERENCES usuario(id_usuario)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_reserva_livro
        FOREIGN KEY (id_livro)
        REFERENCES livro(id_livro)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- =====================================================
-- TABELA LIVRO_AUTOR
-- RELACIONAMENTO N:N
-- =====================================================
CREATE TABLE livro_autor (
    id_livro INT NOT NULL,
    id_autor INT NOT NULL,
    PRIMARY KEY (id_livro, id_autor),
    CONSTRAINT fk_la_livro
        FOREIGN KEY (id_livro)
        REFERENCES livro(id_livro)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_la_autor
        FOREIGN KEY (id_autor)
        REFERENCES autor(id_autor)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- =====================================================
-- TABELA LIVRO_CATEGORIA
-- RELACIONAMENTO N:N
-- =====================================================
CREATE TABLE livro_categoria (
    id_livro     INT NOT NULL,
    id_categoria INT NOT NULL,
    PRIMARY KEY (id_livro, id_categoria),
    CONSTRAINT fk_lc_livro
        FOREIGN KEY (id_livro)
        REFERENCES livro(id_livro)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_lc_categoria
        FOREIGN KEY (id_categoria)
        REFERENCES categoria(id_categoria)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

INSERT INTO usuario (nome, cpf, email, telefone, data_cadastro, status)
VALUES
    ('Ana Paula Souza',       '111.111.111-11', 'ana.souza@email.com',      '38999110001', '2025-01-10', 'ATIVO'),
    ('Bruno Henrique Silva',  '222.222.222-22', 'bruno.silva@email.com',    '38999110002', '2025-01-12', 'ATIVO'),
    ('Carla Mendes Oliveira', '333.333.333-33', 'carla.oliveira@email.com', '38999110003', '2025-01-15', 'ATIVO'),
    ('Daniel Rodrigues Lima', '444.444.444-44', 'daniel.lima@email.com',    '38999110004', '2025-01-18', 'ATIVO'),
    ('Eduarda Costa Pereira', '555.555.555-55', 'eduarda.costa@email.com',  '38999110005', '2025-01-20', 'ATIVO'),
    ('Felipe Martins Rocha',  '666.666.666-66', 'felipe.rocha@email.com',   '38999110006', '2025-01-22', 'ATIVO'),
    ('Gabriela Ferreira Alves','777.777.777-77','gabriela.alves@email.com', '38999110007', '2025-01-25', 'ATIVO'),
    ('Henrique Barbosa Santos','888.888.888-88','henrique.santos@email.com','38999110008', '2025-01-27', 'ATIVO'),
    ('Isabela Teixeira Gomes','999.999.999-99', 'isabela.gomes@email.com',  '38999110009', '2025-02-01', 'ATIVO'),
    ('João Pedro Ribeiro',    '101.101.101-10', 'joao.ribeiro@email.com',   '38999110010', '2025-02-03', 'ATIVO'),
    ('Karina Lopes Dias',     '202.202.202-20', 'karina.dias@email.com',    '38999110011', '2025-02-05', 'INATIVO'),
    ('Lucas Fernandes Melo',  '303.303.303-30', 'lucas.melo@email.com',     '38999110012', '2025-02-07', 'ATIVO'),
    ('Mariana Carvalho Reis', '404.404.404-40', 'mariana.reis@email.com',   '38999110013', '2025-02-10', 'ATIVO'),
    ('Nicolas Vieira Castro', '505.505.505-50', 'nicolas.castro@email.com', '38999110014', '2025-02-12', 'ATIVO'),
    ('Patrícia Nunes Rocha',  '606.606.606-60', 'patricia.rocha@email.com', '38999110015', '2025-02-15', 'ATIVO');

INSERT INTO carteirinha (numero, data_emissao, id_usuario)
VALUES
    ('CAR0001', '2025-01-10',  1),
    ('CAR0002', '2025-01-12',  2),
    ('CAR0003', '2025-01-15',  3),
    ('CAR0004', '2025-01-18',  4),
    ('CAR0005', '2025-01-20',  5),
    ('CAR0006', '2025-01-22',  6),
    ('CAR0007', '2025-01-25',  7),
    ('CAR0008', '2025-01-27',  8),
    ('CAR0009', '2025-02-01',  9),
    ('CAR0010', '2025-02-03', 10),
    ('CAR0011', '2025-02-05', 11),
    ('CAR0012', '2025-02-07', 12),
    ('CAR0013', '2025-02-10', 13),
    ('CAR0014', '2025-02-12', 14),
    ('CAR0015', '2025-02-15', 15);

INSERT INTO funcionario (nome, cpf, cargo, email)
VALUES
    ('Marcos Antônio Costa', '111.222.333-01', 'Bibliotecário', 'marcos@athenaeum.com'),
    ('Juliana Ferreira',     '111.222.333-02', 'Bibliotecária', 'juliana@athenaeum.com'),
    ('Ricardo Almeida',      '111.222.333-03', 'Auxiliar',      'ricardo@athenaeum.com'),
    ('Fernanda Moura',       '111.222.333-04', 'Bibliotecária', 'fernanda@athenaeum.com'),
    ('Paulo Henrique',       '111.222.333-05', 'Auxiliar',      'paulo@athenaeum.com'),
    ('Camila Ribeiro',       '111.222.333-06', 'Bibliotecária', 'camila@athenaeum.com'),
    ('Rodrigo Santos',       '111.222.333-07', 'Auxiliar',      'rodrigo@athenaeum.com'),
    ('Amanda Souza',         '111.222.333-08', 'Bibliotecária', 'amanda@athenaeum.com'),
    ('Gustavo Barbosa',      '111.222.333-09', 'Auxiliar',      'gustavo@athenaeum.com'),
    ('Larissa Teixeira',     '111.222.333-10', 'Bibliotecária', 'larissa@athenaeum.com'),
    ('Carlos Mendes',        '111.222.333-11', 'Supervisor',    'carlos@athenaeum.com'),
    ('Patrícia Oliveira',    '111.222.333-12', 'Bibliotecária', 'patricia@athenaeum.com'),
    ('Mateus Costa',         '111.222.333-13', 'Auxiliar',      'mateus@athenaeum.com'),
    ('Renata Alves',         '111.222.333-14', 'Bibliotecária', 'renata@athenaeum.com'),
    ('Thiago Lima',          '111.222.333-15', 'Supervisor',    'thiago@athenaeum.com');

INSERT INTO livro (titulo, isbn, ano_publicacao)
VALUES
    ('Dom Casmurro',           '9788535910663', 1899),
    ('1984',                   '9780451524935', 1949),
    ('Orgulho e Preconceito',  '9780141439518', 1813),
    ('O Senhor dos Anéis',     '9780618640157', 1954),
    ('Hamlet',                 '9780743477123', 1603),
    ('Crime e Castigo',        '9780143058144', 1866),
    ('Moby Dick',              '9780142437247', 1851),
    ('A Revolução dos Bichos', '9780451526342', 1945),
    ('O Pequeno Príncipe',     '9780156012195', 1943),
    ('Drácula',                '9780486411095', 1897),
    ('A Divina Comédia',       '9780142437223', 1321),
    ('Os Miseráveis',          '9780451419439', 1862),
    ('Frankenstein',           '9780486282114', 1818),
    ('A Metamorfose',          '9780553213690', 1915),
    ('O Processo',             '9780805209990', 1925);

INSERT INTO autor (nome, nacionalidade)
VALUES
    ('Machado de Assis',         'Brasileira'),
    ('George Orwell',            'Britânica'),
    ('Jane Austen',              'Britânica'),
    ('J. R. R. Tolkien',         'Britânica'),
    ('William Shakespeare',      'Britânica'),
    ('Fiódor Dostoiévski',       'Russa'),
    ('Herman Melville',          'Estadunidense'),
    ('Antoine de Saint-Exupéry', 'Francesa'),
    ('Bram Stoker',              'Irlandesa'),
    ('Dante Alighieri',          'Italiana'),
    ('Victor Hugo',              'Francesa'),
    ('Mary Shelley',             'Britânica'),
    ('Franz Kafka',              'Tcheca'),
    ('Júlio Verne',              'Francesa'),
    ('Miguel de Cervantes',      'Espanhola');

INSERT INTO categoria (nome, descricao)
VALUES
    ('Romance',              'Narrativas românticas e clássicas'),
    ('Ficção Científica',    'Obras de ficção científica'),
    ('Fantasia',             'Universos fantásticos'),
    ('Drama',                'Obras dramáticas'),
    ('Terror',               'Literatura de terror'),
    ('Aventura',             'Narrativas de aventura'),
    ('Filosofia',            'Reflexões filosóficas'),
    ('História',             'Conteúdo histórico'),
    ('Literatura Brasileira','Autores brasileiros'),
    ('Literatura Inglesa',   'Autores ingleses'),
    ('Literatura Russa',     'Autores russos'),
    ('Literatura Francesa',  'Autores franceses'),
    ('Literatura Italiana',  'Autores italianos'),
    ('Literatura Alemã',     'Autores de língua alemã'),
    ('Clássicos Universais', 'Grandes clássicos da literatura');

INSERT INTO exemplar (codigo_exemplar, estado_conservacao, disponibilidade, localizacao, id_livro)
VALUES
    ('EX0001', 'OTIMO',   'DISPONIVEL', 'Estante A1',          1),
    ('EX0002', 'OTIMO',   'EMPRESTADO', 'Estante A2',          2),
    ('EX0003', 'BOM',     'DISPONIVEL', 'Estante A3',          3),
    ('EX0004', 'OTIMO',   'EMPRESTADO', 'Estante B1',          4),
    ('EX0005', 'REGULAR', 'DISPONIVEL', 'Estante B2',          5),
    ('EX0006', 'OTIMO',   'EMPRESTADO', 'Estante B3',          6),
    ('EX0007', 'BOM',     'DISPONIVEL', 'Estante C1',          7),
    ('EX0008', 'OTIMO',   'EMPRESTADO', 'Estante C2',          8),
    ('EX0009', 'OTIMO',   'DISPONIVEL', 'Estante C3',          9),
    ('EX0010', 'BOM',     'EMPRESTADO', 'Estante D1',         10),
    ('EX0011', 'OTIMO',   'DISPONIVEL', 'Acervo Histórico',   11),
    ('EX0012', 'BOM',     'EMPRESTADO', 'Estante D2',         12),
    ('EX0013', 'OTIMO',   'DISPONIVEL', 'Estante D3',         13),
    ('EX0014', 'REGULAR', 'EMPRESTADO', 'Sala de Obras Raras',14),
    ('EX0015', 'OTIMO',   'DISPONIVEL', 'Sala de Obras Raras',15);

INSERT INTO livro_autor (id_livro, id_autor)
VALUES
    ( 1,  1),
    ( 2,  2),
    ( 3,  3),
    ( 4,  4),
    ( 5,  5),
    ( 6,  6),
    ( 7,  7),
    ( 8,  2),
    ( 9,  8),
    (10,  9),
    (11, 10),
    (12, 11),
    (13, 12),
    (14, 13),
    (15, 13);

INSERT INTO livro_categoria (id_livro, id_categoria)
VALUES
    ( 1,  9),
    ( 1, 15),
    ( 2,  2),
    ( 2, 15),
    ( 3,  1),
    ( 3, 10),
    ( 4,  3),
    ( 4,  6),
    ( 5,  4),
    ( 5, 10),
    ( 6, 11),
    ( 6, 15),
    ( 7,  6),
    ( 7, 15),
    ( 8,  2),
    ( 8, 15),
    ( 9,  1),
    ( 9, 12),
    (10,  5),
    (10, 15);

INSERT INTO reserva (data_reserva, status, id_usuario, id_livro)
VALUES
    ('2025-03-01', 'PENDENTE',   1,  4),
    ('2025-03-02', 'ATENDIDA',   2,  2),
    ('2025-03-03', 'PENDENTE',   3, 10),
    ('2025-03-04', 'CANCELADA',  4,  5),
    ('2025-03-05', 'PENDENTE',   5, 12),
    ('2025-03-06', 'ATENDIDA',   6,  8),
    ('2025-03-07', 'PENDENTE',   7, 15),
    ('2025-03-08', 'ATENDIDA',   8,  1),
    ('2025-03-09', 'PENDENTE',   9,  6),
    ('2025-03-10', 'PENDENTE',  10, 14),
    ('2025-03-11', 'ATENDIDA',  11,  3),
    ('2025-03-12', 'PENDENTE',  12,  9),
    ('2025-03-13', 'CANCELADA', 13, 11),
    ('2025-03-14', 'ATENDIDA',  14,  7),
    ('2025-03-15', 'PENDENTE',  15, 13);

INSERT INTO emprestimo (data_emprestimo, data_prevista, data_devolucao, multa, id_usuario, id_funcionario, id_exemplar)
VALUES
    ('2025-03-01', '2025-03-15', '2025-03-14', 0,    1,  1,  2),
    ('2025-03-02', '2025-03-16', '2025-03-23', 14.00, 2,  2,  4),
    ('2025-03-03', '2025-03-17', NULL,          0,    3,  3,  6),
    ('2025-03-04', '2025-03-18', '2025-03-18', 0,    4,  4,  8),
    ('2025-03-05', '2025-03-19', NULL,          0,    5,  5, 10),
    ('2025-03-06', '2025-03-20', '2025-03-19', 0,    6,  6, 12),
    ('2025-03-07', '2025-03-21', NULL,          0,    7,  7, 14),
    ('2025-03-08', '2025-03-22', '2025-03-22', 0,    8,  8,  2),
    ('2025-03-09', '2025-03-23', '2025-03-26', 6.00, 9,  9,  4),
    ('2025-03-10', '2025-03-24', NULL,          0,   10, 10,  6),
    ('2025-03-11', '2025-03-25', '2025-03-25', 0,   11, 11,  8),
    ('2025-03-12', '2025-03-26', NULL,          0,   12, 12, 10),
    ('2025-03-13', '2025-03-27', '2025-03-29', 4.00,13, 13, 12),
    ('2025-03-14', '2025-03-28', NULL,          0,   14, 14, 14),
    ('2025-03-15', '2025-03-29', '2025-03-29', 0,   15, 15,  4);

-- =====================================================
-- TRIGGER PARA CALCULAR MULTA AUTOMATICAMENTE
-- R$ 2,00 POR DIA DE ATRASO
-- =====================================================

DELIMITER $$

CREATE TRIGGER trg_calcular_multa
BEFORE UPDATE ON emprestimo
FOR EACH ROW
BEGIN
    IF NEW.data_devolucao IS NOT NULL THEN

        SET NEW.multa =
        CASE
            WHEN DATEDIFF(NEW.data_devolucao, NEW.data_prevista) > 0
            THEN DATEDIFF(NEW.data_devolucao, NEW.data_prevista) * 2.00
            ELSE 0
        END;

    END IF;
END$$

DELIMITER ;