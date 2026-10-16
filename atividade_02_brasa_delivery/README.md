# Atividade 2 — Brasa Delivery

Protótipo Flutter independente com tema **Brasa**, catálogo fictício, ilustrações locais e estado apenas em memória. **Não usa backend, Firebase, APIs, banco de dados, autenticação real ou pagamentos.**

## Estrutura
- `lib/main.dart`: inicialização e rotas (`/login` e `/home`);
- `lib/screens/login_screen.dart`: tela de login personalizada, baseada no esboço;
- `lib/screens/home_screen.dart`: home, categorias, busca e carrinho;
- `lib/data/mock_data.dart`: oito produtos fictícios e seis categorias;
- `lib/theme/brasa_theme.dart`: identidade visual Material 3;
- `assets/images/*.png`: sete ilustrações locais de alimentos;
- `pubspec.yaml`: dependências e declaração dos assets.

## Executar
Abra o terminal nesta pasta:

```bash
flutter create .
flutter pub get
flutter run
```

O `flutter create .` gera os arquivos nativos ausentes. Mantenha o `pubspec.yaml` desta atividade, que registra `assets/images/`.

## Tela de login
A rota inicial é `/login`. A tela tem marca Brasa, imagem local, campos de e-mail e senha, validação **apenas local**, botão de mostrar/ocultar senha e ações demonstrativas para **Entrar**, **Google**, **Esqueci minha senha** e **Criar conta**.

**Importante:** o botão **Entrar** não autentica e não transmite nem salva credenciais; apenas valida os campos e exibe um aviso. Google, recuperação e cadastro exibem mensagens sobre a ausência de integração. **Explorar como visitante** abre a Home sem login. Na Home, o botão **Perfil** leva à tela de login.

## Home
- Busca por produto, restaurante ou descrição.
- Filtro por categoria.
- Carrinho em memória com inclusão, remoção e subtotal.
- Endereço e navegação fictícios.

Todos os nomes, preços, avaliações e prazos de entrega são inventados. O carrinho é perdido ao reiniciar o aplicativo.
