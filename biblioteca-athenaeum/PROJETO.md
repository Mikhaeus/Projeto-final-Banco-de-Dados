# Biblioteca Clássica Athenaeum

## 1. Introdução

O presente projeto foi desenvolvido como atividade prática da disciplina de Banco de Dados do curso de Engenharia da Computação. O objetivo consiste em aplicar os conceitos estudados durante o semestre por meio da concepção, modelagem e implementação de um banco de dados relacional completo.

O domínio escolhido foi o gerenciamento de uma biblioteca tradicional denominada Biblioteca Clássica Athenaeum, especializada em obras literárias clássicas nacionais e internacionais.

---

## 2. Objetivo do Sistema

O sistema tem como finalidade controlar os principais processos administrativos de uma biblioteca, incluindo:

- Cadastro de usuários;
- Emissão de carteirinhas;
- Cadastro de funcionários;
- Gerenciamento de livros;
- Controle de exemplares físicos;
- Registro de empréstimos;
- Registro de reservas;
- Organização por autores e categorias.

---

## 3. Regras de Negócio

As seguintes regras foram consideradas durante a modelagem:

1. Cada usuário possui exatamente uma carteirinha.
2. Uma carteirinha pertence a apenas um usuário.
3. Um livro pode possuir vários exemplares.
4. Cada exemplar pertence a apenas um livro.
5. Um usuário pode realizar vários empréstimos.
6. Um funcionário pode registrar vários empréstimos.
7. Um usuário pode realizar várias reservas.
8. Um livro pode ser reservado por diferentes usuários.
9. Um livro pode possuir vários autores.
10. Um autor pode escrever vários livros.
11. Um livro pode pertencer a várias categorias.
12. Uma categoria pode agrupar vários livros.

---

## 4. Decisões de Modelagem

A modelagem foi desenvolvida seguindo os princípios da normalização até a Terceira Forma Normal (3FN), eliminando redundâncias e minimizando anomalias de atualização.

Foram utilizadas tabelas associativas para representar os relacionamentos muitos-para-muitos:

- Livro_Autor
- Livro_Categoria

Além disso, foi criada a entidade Exemplar para representar cópias físicas dos livros, permitindo controlar disponibilidade e localização dentro da biblioteca.

---

## 5. Estrutura do Banco de Dados

O banco de dados é composto por 11 tabelas:

- Usuario
- Carteirinha
- Funcionario
- Livro
- Exemplar
- Autor
- Categoria
- Emprestimo
- Reserva
- Livro_Autor
- Livro_Categoria

---

## 6. Restrições de Integridade

Foram aplicadas as seguintes restrições:

### PRIMARY KEY

Presente em todas as tabelas para garantir unicidade dos registros.

### FOREIGN KEY

Utilizadas para garantir a integridade referencial entre as entidades.

### NOT NULL

Aplicada em atributos obrigatórios.

### UNIQUE

Utilizada em:

- CPF de usuários
- CPF de funcionários
- E-mails
- ISBN dos livros
- Número da carteirinha
- Código do exemplar

### CHECK

Aplicada para validação de:

- Status do usuário
- Estado de conservação do exemplar
- Disponibilidade do exemplar
- Status da reserva
- Valor da multa

### DEFAULT

Aplicada para:

- Data de cadastro
- Status do usuário
- Disponibilidade do exemplar
- Status da reserva
- Valor inicial da multa

---

## 7. Considerações Finais

O projeto permitiu aplicar conceitos fundamentais de bancos de dados relacionais, incluindo modelagem conceitual, implementação física, integridade referencial, normalização e elaboração de consultas SQL.

A solução desenvolvida atende aos requisitos propostos pela disciplina e representa de forma consistente o funcionamento de uma biblioteca tradicional.