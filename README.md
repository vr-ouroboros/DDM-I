# DDM-I — Brasa Delivery

Repositório de atividades de Desenvolvimento Mobile.

## Entrega atual: Brasa Delivery (Flutter)

Protótipo de delivery com visual **Brasa**, catálogo e endereço fictícios, imagens locais e estado em memória. **Sem backend, APIs, banco de dados, geolocalização ou pagamentos.**

### Organização
- `lib/main.dart`: entrada do aplicativo e aplicação do tema;
- `lib/screens/home_screen.dart`: tela inicial, categorias, busca e carrinho em memória;
- `lib/data/mock_data.dart`: oito produtos fictícios e seis categorias;
- `lib/theme/brasa_theme.dart`: paleta de cores e tema Material 3;
- `assets/images/*.png`: sete imagens ilustrativas locais;
- `lib/legacy_layouts.dart`: cópia preservada da atividade de layouts anterior.

### Rodar
Caso o projeto ainda não tenha as pastas nativas geradas pelo Flutter, execute na raiz:

```bash
flutter create .
flutter pub get
flutter run
```

Os assets estão declarados em `pubspec.yaml`. O aplicativo não envia requisições de rede. Carrinho e filtros são perdidos ao reiniciar.

### Interações de demonstração
Busca por nome, restaurante ou descrição; filtro por categoria; banner de ofertas; adicionar/remover itens e calcular subtotal fictício. Pedidos, conta e endereço são apenas elementos de interface.

Os dados, preços, avaliações e tempos de entrega são inventados. Imagens de alimentos são ilustrações produzidas para o protótipo.
