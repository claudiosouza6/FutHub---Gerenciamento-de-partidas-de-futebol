# ⚽ FutHub - Sistema de Gerenciamento de Partidas de Futebol

O **FutHub** é um sistema de banco de dados relacional voltado para a organização e gestão completa de partidas de futebol amador, agendamento de locais, estatísticas individuais de jogadores e controle financeiro das partidas.

---

## 📐 Modelo Entidade-Relacionamento (EER)

A estrutura relacional foi modelada para garantir a integridade dos dados e o acompanhamento detalhado de cada partida:

![Diagrama EER](FutHub%20gerenciamento%20de%20partidas%20de%20futebol.png)

---

## 🛠️ Tecnologias Utilizadas

- **SGBD:** MySQL Server (v8.0)
- **Ferramenta de Modelagem:** MySQL Workbench
- **Linguagens:** SQL (DDL, DML, DQL)

---

## 📌 Funcionalidades Mapeadas

- **Gestão de Usuários e Jogadores:** Cadastro unificado de usuários e perfis de atletas (posição, nota média, apelido).
- **Agendamento de Partidas:** Registro de local, data/hora, tipo de solo (Society, Salão, Grama, etc.), organizador e limite de atletas.
- **Estatísticas de Jogo (`Joga_em`):** Controle de presença, gols, assistências e cartões por atleta e por partida.
- **Módulo Financeiro:** Acompanhamento de pagamentos por participante, métodos de pagamento (Pix, Crédito, Débito) e gateways.

---

## 🚀 Como Executar o Projeto

1. Certifique-se de ter o **MySQL Server (v8.0+)** e o **MySQL Workbench** instalados.
2. Clone este repositório:
   ```bash
   git clone [https://github.com/claudiosouza6/FutHub---Gerenciamento-de-partidas-de-futebol.git](https://github.com/claudiosouza6/FutHub---Gerenciamento-de-partidas-de-futebol.git)
3. Abra o arquivo `database/script_futhub.sql` no MySQL Workbench.
4. Execute o script completo (`Ctrl + Shift + Enter`) para criar a base de dados `FutHub gerenciamento de partidas de futebol`, gerar a estrutura de tabelas e popular com os dados iniciais.