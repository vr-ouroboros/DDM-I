# Atividade 2 — Brasa Delivery

Protótipo Flutter independente com a identidade visual **Brasa**. Todo o conteúdo é local: **sem backend, APIs, autenticação real, banco de dados ou pagamentos**.

## Organização
- `lib/main.dart` — inicialização e rotas (`/login`, `/home` e `/search`);
- `lib/screens/login_screen.dart` — login demonstrativo;
- `lib/screens/home_screen.dart` — Home e catálogo;
- `lib/screens/search_screen.dart` — Busca, filtros, carrossel e resultados;
- `lib/data/mock_data.dart` — oito produtos e seis categorias fictícios;
- `lib/data/cart_state.dart` — carrinho compartilhado em memória;
- `lib/theme/brasa_theme.dart` — tema Material 3;
- `assets/images/` — sete ilustrações PNG locais.

## Executar
No terminal, entre na pasta `atividade_02_brasa_delivery`:

```bash
flutter create .
flutter pub get
flutter run
```

O `flutter create .` gera pastas nativas ausentes; preserve o `pubspec.yaml`, que declara os assets.

## Telas

**Login:** validação visual/local de e-mail e senha; ações de login, Google, recuperação e cadastro apenas demonstrativas. O link **Explorar como visitante** leva à Home sem autenticação.

**Home:** exibição do catálogo com dados locais, categorias, busca e carrinho em memória. A aba **Buscar** abre a tela de busca.

**Busca:** pesquisa instantânea por nome, categoria, descrição ou restaurante; chips **Todos**, **Próximos**, **Entrega rápida** e **Melhor avaliação**; contagem de resultados; imagens locais dos produtos; cards com preço, avaliação e tempo fictícios; botão **Adicionar** e **carrossel horizontal** (PageView) com três produtos em destaque.

Os filtros são **simulados**: "Próximos" usa uma lista de restaurantes fictícios pré-selecionados, sem GPS; "Entrega rápida" usa o limite fictício de 20 minutos; "Melhor avaliação" seleciona notas a partir de 4,8. O carrinho é compartilhado entre Home e Busca na memória do processo, mas não é persistido.

Nenhuma ação aciona serviços externos. Dados, preços, avaliações e entregas são inteiramente fictícios.
