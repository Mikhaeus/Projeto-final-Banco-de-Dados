-- =====================================================
-- CONSULTA 1 (SIMPLES)
-- Lista todos os livros cadastrados na biblioteca
-- =====================================================
SELECT *
FROM livro;

-- =====================================================
-- CONSULTA 2 (SIMPLES)
-- Lista todos os usuários ativos
-- =====================================================
SELECT *
FROM usuario
WHERE status = 'ATIVO';

-- =====================================================
-- CONSULTA 3 (SIMPLES)
-- Exibe os livros publicados após 1900
-- =====================================================
SELECT titulo, ano_publicacao
FROM livro
WHERE ano_publicacao > 1900;

-- =====================================================
-- CONSULTA 4 (SIMPLES)
-- Lista os exemplares disponíveis para empréstimo
-- =====================================================
SELECT *
FROM exemplar
WHERE disponibilidade = 'DISPONIVEL';

-- =====================================================
-- CONSULTA 5 (SIMPLES)
-- Exibe as reservas pendentes
-- =====================================================
SELECT *
FROM reserva
WHERE status = 'PENDENTE';

-- =====================================================
-- CONSULTA 6 (JOIN)
-- Lista os livros e seus respectivos autores
-- =====================================================
SELECT
    l.titulo,
    a.nome AS autor
FROM livro l
INNER JOIN livro_autor la
    ON l.id_livro = la.id_livro
INNER JOIN autor a
    ON la.id_autor = a.id_autor
ORDER BY l.titulo;

-- =====================================================
-- CONSULTA 7 (JOIN)
-- Lista os livros e suas categorias
-- =====================================================
SELECT
    l.titulo,
    c.nome AS categoria
FROM livro l
INNER JOIN livro_categoria lc
    ON l.id_livro = lc.id_livro
INNER JOIN categoria c
    ON lc.id_categoria = c.id_categoria
ORDER BY l.titulo;

-- =====================================================
-- CONSULTA 8 (JOIN)
-- Mostra os empréstimos realizados por cada usuário
-- =====================================================
SELECT
    u.nome AS usuario,
    e.id_emprestimo,
    e.data_emprestimo,
    e.data_prevista,
    e.multa
FROM usuario u
INNER JOIN emprestimo e
    ON u.id_usuario = e.id_usuario
ORDER BY u.nome;

-- =====================================================
-- CONSULTA 9 (JOIN)
-- Mostra quais funcionários registraram empréstimos
-- =====================================================
SELECT
    f.nome AS funcionario,
    f.cargo,
    e.id_emprestimo,
    e.data_emprestimo
FROM funcionario f
INNER JOIN emprestimo e
    ON f.id_funcionario = e.id_funcionario
ORDER BY f.nome;

-- =====================================================
-- CONSULTA 10 (JOIN + GROUP BY)
-- Ranking dos livros mais emprestados
-- =====================================================
SELECT
    l.titulo,
    COUNT(*) AS total_emprestimos
FROM emprestimo e
INNER JOIN exemplar ex
    ON e.id_exemplar = ex.id_exemplar
INNER JOIN livro l
    ON ex.id_livro = l.id_livro
GROUP BY l.id_livro, l.titulo
ORDER BY total_emprestimos DESC;
