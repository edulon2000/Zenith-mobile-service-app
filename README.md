# zenith_app

Aplicativo móvel desenvolvido em Flutter para conectar clientes e prestadores de serviços residenciais. Os usuários podem buscar profissionais, solicitar atendimentos, acompanhar o status e enviar documentos para validação.

---

## 🚀 Tecnologias

- Flutter 3.x
- Dart
- Dio (HTTP)
- Provider (gerência de estado)
- Flutter Secure Storage
- Image Picker (upload de documentos)

---

## 📂 Estrutura do Projeto

- `screens/` – Telas do app (login, cadastro, home, atendimentos)
- `models/` – Modelos de dados (User, Servico, Atendimento)
- `services/` – Integração com APIs (Auth, Atendimentos, etc.)
- `widgets/` – Componentes reutilizáveis

---

## 📌 Funcionalidades

- Login e cadastro de usuários
- Envio e verificação de documentos
- Listagem de prestadores por categoria
- Solicitação e acompanhamento de atendimentos
- Edição e visualização de perfil

---

## ▶️ Como rodar

```bash
# Clonar o projeto
git clone https://github.com/seu-usuario/mobile-service-app

# Rodar o app
flutter pub get
flutter run
