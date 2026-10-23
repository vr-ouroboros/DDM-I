import 'package:flutter/foundation.dart';

import 'mock_data.dart';

/// Carrinho local compartilhado entre Home e Busca.
/// Não persiste dados e não acessa rede nem serviços externos.
class CarrinhoDemo extends ChangeNotifier {
  CarrinhoDemo._();

  static final CarrinhoDemo instancia = CarrinhoDemo._();

  final Map<String, int> _itens = {};

  int quantidadeDo(String produtoId) => _itens[produtoId] ?? 0;

  int get quantidade => _itens.values.fold<int>(
        0,
        (total, n) => total + n,
      );

  double get subtotal => CatalogoFicticio.produtos.fold<double>(
        0,
        (total, produto) => total + produto.preco * quantidadeDo(produto.id),
      );

  void adicionar(Produto produto) {
    _itens[produto.id] = quantidadeDo(produto.id) + 1;
    notifyListeners();
  }

  void remover(Produto produto) {
    final atual = quantidadeDo(produto.id);
    if (atual <= 0) return;
    if (atual == 1) {
      _itens.remove(produto.id);
    } else {
      _itens[produto.id] = atual - 1;
    }
    notifyListeners();
  }
}
