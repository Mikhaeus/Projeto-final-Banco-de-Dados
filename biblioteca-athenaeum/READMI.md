# Biblioteca Clássica Athenaeum

## Integrantes

- Gustavo Caiuã Martins Mendes
- Maria Fernanda Bicalho Veloso

## Descrição

A Biblioteca Clássica Athenaeum é um sistema de gerenciamento de biblioteca desenvolvido como projeto final da disciplina de Banco de Dados do curso de Engenharia da Computação.

O sistema foi modelado e implementado utilizando exclusivamente SQL no SGBD MySQL/MariaDB, contemplando conceitos de modelagem conceitual, lógica e física, normalização, integridade referencial e consultas relacionais.

O banco de dados permite o gerenciamento de usuários, carteirinhas, funcionários, livros, autores, categorias, exemplares, empréstimos e reservas.

---

## Tecnologias Utilizadas

- MySQL / MariaDB
- XAMPP 8.2.12
- SQL
- phpMyAdmin

---

## Estrutura do Projeto

```text
biblioteca-athenaeum/
│
├── README.md
├── projeto.md
├── dicionario_dados.md
├── biblioteca_athenaeum.sql
├── consultas.sql
└── der.png
```

---

## Funcionalidades

- Cadastro de usuários
- Emissão de carteirinhas
- Cadastro de funcionários
- Controle de livros
- Controle de exemplares físicos
- Gerenciamento de autores
- Gerenciamento de categorias
- Registro de empréstimos
- Registro de reservas
- Consultas SQL para análise de dados

---

## Como Executar

### 1. Iniciar serviços

No XAMPP, iniciar:

- Apache
- MySQL

### 2. Abrir phpMyAdmin

```text
http://localhost/phpmyadmin
```

### 3. Importar banco

Executar o arquivo:

```text
biblioteca_athenaeum.sql
```

### 4. Executar consultas

Executar os comandos presentes em:

```text
consultas.sql
```

---

## Requisitos Atendidos

- Mais de 8 tabelas
- Relacionamento 1:1
- Relacionamentos 1:N
- Relacionamentos N:N
- Chaves primárias e estrangeiras
- Restrições de integridade
- Normalização até 3FN
- Mínimo de 15 registros por tabela
- Consultas simples e avançadas