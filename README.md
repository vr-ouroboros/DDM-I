# DDM-I — Desenvolvimento Mobile

Este repositório reúne **atividades independentes** da disciplina de Desenvolvimento Mobile. Cada atividade tem sua própria pasta, seu próprio `lib/main.dart` e, quando necessário, seu próprio `pubspec.yaml`.

| Atividade | Pasta | Descrição |
| --- | --- | --- |
| 1 | [atividade_01_layouts](atividade_01_layouts/) | Exercício anterior de layouts Flutter (seis telas, navegação por drawer). |
| 2 | [atividade_02_brasa_delivery](atividade_02_brasa_delivery/) | Protótipo Brasa Delivery com identidade visual, imagens locais e dados fictícios. |

## Como executar

Tenha o [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado e execute os comandos **dentro da pasta da atividade desejada**.

### Atividade 1
```bash
cd atividade_01_layouts
flutter create .
flutter pub get
flutter run
```

### Atividade 2 — Brasa Delivery
```bash
cd atividade_02_brasa_delivery
flutter create .
flutter pub get
flutter run
```

O comando `flutter create .` gera as pastas nativas ausentes (`android/`, `ios/`, etc.) sem exigir que elas sejam versionadas nesta entrega.

> O Brasa é apenas um protótipo local: sem back-end, APIs, banco de dados ou pagamentos. As imagens estão em `atividade_02_brasa_delivery/assets/images/`, e os dados fictícios em `lib/data/mock_data.dart` **dentro da pasta do Brasa**.
