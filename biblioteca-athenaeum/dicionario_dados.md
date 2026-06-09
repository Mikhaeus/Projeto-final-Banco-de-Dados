# Biblioteca Clássica Athenaeum

## Dicionário de Dados

### Tabela: Usuario

| Campo         | Tipo         | Restrições         | Descrição                              |
| ------------- | ------------ | ------------------ | -------------------------------------- |
| id_usuario    | INT          | PK, AUTO_INCREMENT | Identificador único do usuário         |
| nome          | VARCHAR(100) | NOT NULL           | Nome completo do usuário               |
| cpf           | VARCHAR(14)  | NOT NULL, UNIQUE   | CPF do usuário                         |
| email         | VARCHAR(100) | NOT NULL, UNIQUE   | E-mail do usuário                      |
| telefone      | VARCHAR(20)  | NOT NULL           | Telefone para contato                  |
| data_cadastro | DATE         | NOT NULL, DEFAULT  | Data de cadastro no sistema            |
| status        | VARCHAR(10)  | NOT NULL, DEFAULT  | Situação do usuário (ATIVO ou INATIVO) |

---

### Tabela: Carteirinha

| Campo          | Tipo        | Restrições         | Descrição                       |
| -------------- | ----------- | ------------------ | ------------------------------- |
| id_carteirinha | INT         | PK, AUTO_INCREMENT | Identificador da carteirinha    |
| numero         | VARCHAR(20) | NOT NULL, UNIQUE   | Número da carteirinha           |
| data_emissao   | DATE        | NOT NULL           | Data de emissão                 |
| id_usuario     | INT         | FK, UNIQUE         | Usuário associado à carteirinha |

---

### Tabela: Funcionario

| Campo          | Tipo         | Restrições         | Descrição                    |
| -------------- | ------------ | ------------------ | ---------------------------- |
| id_funcionario | INT          | PK, AUTO_INCREMENT | Identificador do funcionário |
| nome           | VARCHAR(100) | NOT NULL           | Nome do funcionário          |
| cpf            | VARCHAR(14)  | NOT NULL, UNIQUE   | CPF do funcionário           |
| cargo          | VARCHAR(50)  | NOT NULL           | Cargo exercido               |
| email          | VARCHAR(100) | UNIQUE             | E-mail institucional         |

---

### Tabela: Livro

| Campo          | Tipo         | Restrições         | Descrição              |
| -------------- | ------------ | ------------------ | ---------------------- |
| id_livro       | INT          | PK, AUTO_INCREMENT | Identificador do livro |
| titulo         | VARCHAR(200) | NOT NULL           | Título da obra         |
| isbn           | VARCHAR(20)  | NOT NULL, UNIQUE   | Código ISBN            |
| ano_publicacao | YEAR         | NOT NULL           | Ano de publicação      |

---

### Tabela: Exemplar

| Campo              | Tipo        | Restrições         | Descrição                         |
| ------------------ | ----------- | ------------------ | --------------------------------- |
| id_exemplar        | INT         | PK, AUTO_INCREMENT | Identificador do exemplar         |
| codigo_exemplar    | VARCHAR(20) | NOT NULL, UNIQUE   | Código patrimonial do exemplar    |
| estado_conservacao | VARCHAR(20) | NOT NULL           | Estado físico do exemplar         |
| disponibilidade    | VARCHAR(20) | NOT NULL, DEFAULT  | Situação do exemplar              |
| localizacao        | VARCHAR(50) | NOT NULL           | Local físico na biblioteca        |
| id_livro           | INT         | FK                 | Livro ao qual o exemplar pertence |

---

### Tabela: Autor

| Campo         | Tipo         | Restrições         | Descrição              |
| ------------- | ------------ | ------------------ | ---------------------- |
| id_autor      | INT          | PK, AUTO_INCREMENT | Identificador do autor |
| nome          | VARCHAR(100) | NOT NULL           | Nome do autor          |
| nacionalidade | VARCHAR(50)  | NOT NULL           | Nacionalidade do autor |

---

### Tabela: Categoria

| Campo        | Tipo         | Restrições         | Descrição                  |
| ------------ | ------------ | ------------------ | -------------------------- |
| id_categoria | INT          | PK, AUTO_INCREMENT | Identificador da categoria |
| nome         | VARCHAR(50)  | NOT NULL, UNIQUE   | Nome da categoria          |
| descricao    | VARCHAR(200) | -                  | Descrição da categoria     |

---

### Tabela: Emprestimo

| Campo           | Tipo         | Restrições         | Descrição                              |
| --------------- | ------------ | ------------------ | -------------------------------------- |
| id_emprestimo   | INT          | PK, AUTO_INCREMENT | Identificador do empréstimo            |
| data_emprestimo | DATE         | NOT NULL           | Data em que o empréstimo ocorreu       |
| data_prevista   | DATE         | NOT NULL           | Data prevista para devolução           |
| data_devolucao  | DATE         | NULL               | Data efetiva da devolução              |
| multa           | DECIMAL(8,2) | DEFAULT            | Valor da multa gerada                  |
| id_usuario      | INT          | FK                 | Usuário responsável pelo empréstimo    |
| id_funcionario  | INT          | FK                 | Funcionário que registrou o empréstimo |
| id_exemplar     | INT          | FK                 | Exemplar emprestado                    |

---

### Tabela: Reserva

| Campo        | Tipo        | Restrições         | Descrição                      |
| ------------ | ----------- | ------------------ | ------------------------------ |
| id_reserva   | INT         | PK, AUTO_INCREMENT | Identificador da reserva       |
| data_reserva | DATE        | NOT NULL           | Data da solicitação            |
| status       | VARCHAR(20) | DEFAULT            | Situação da reserva            |
| id_usuario   | INT         | FK                 | Usuário que realizou a reserva |
| id_livro     | INT         | FK                 | Livro reservado                |

---

### Tabela: Livro_Autor

| Campo    | Tipo | Restrições | Descrição         |
| -------- | ---- | ---------- | ----------------- |
| id_livro | INT  | PK, FK     | Livro relacionado |
| id_autor | INT  | PK, FK     | Autor relacionado |

**Finalidade:** implementar o relacionamento N:N entre Livro e Autor.

---

### Tabela: Livro_Categoria

| Campo        | Tipo | Restrições | Descrição             |
| ------------ | ---- | ---------- | --------------------- |
| id_livro     | INT  | PK, FK     | Livro relacionado     |
| id_categoria | INT  | PK, FK     | Categoria relacionada |

**Finalidade:** implementar o relacionamento N:N entre Livro e Categoria.

---

# Resumo dos Relacionamentos

## Relacionamento 1:1

* Usuario ↔ Carteirinha

## Relacionamentos 1:N

* Livro → Exemplar
* Usuario → Emprestimo
* Funcionario → Emprestimo
* Usuario → Reserva
* Livro → Reserva

## Relacionamentos N:N

* Livro ↔ Autor (Livro_Autor)
* Livro ↔ Categoria (Livro_Categoria)
