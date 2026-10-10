# Atividade 2 — Brasa Delivery

Protótipo Flutter independente, com tema **Brasa**, catálogo e endereço fictícios, imagens locais e estado apenas em memória. **Não usa back-end, Firebase, APIs, banco de dados, autenticação ou pagamentos.**

## Estrutura
- `lib/main.dart`: entrada do aplicativo;
- `lib/screens/home_screen.dart`: Home, categorias, busca e carrinho;
- `lib/data/mock_data.dart`: oito produtos e seis categorias fictícios;
- `lib/theme/brasa_theme.dart`: identidade visual Material 3;
- `assets/images/*.png`: sete ilustrações locais de alimentos;
- `pubspec.yaml`: configuração das dependências e dos assets.

## Executar
Abra o terminal **nesta pasta** e rode:

```bash
flutter create .
flutter pub get
flutter run
```

O comando `flutter create .` gera os arquivos nativos que ainda não estejam no repositório. Certifique-se de manter o `pubspec.yaml` fornecido (ele declara `assets/images/`).

## Recursos demonstrativos
- Busca por produto, restaurante ou descrição.
- Filtro por categoria e botão para limpar filtros.
- Carrinho em memória com inclusão, remoção e subtotal.
- Navegação e endereço apenas ilustrativos.

Tudo é fictício, inclusive preços, avaliações e tempos de entrega. As imagens ilustrativas foram criadas para o protótipo. Os dados do carrinho são descartados ao reiniciar o aplicativo.
