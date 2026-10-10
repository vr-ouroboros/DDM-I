/// Dados estáticos fictícios: nenhum backend é acessado.
class Categoria {
  final String id;
  final String nome;
  final String imagem;
  const Categoria({required this.id, required this.nome, required this.imagem});
}

class Produto {
  final String id, nome, restaurante, categoriaId, imagem, descricao, tempoEntrega;
  final double preco, avaliacao;
  const Produto({
    required this.id,
    required this.nome,
    required this.restaurante,
    required this.categoriaId,
    required this.imagem,
    required this.descricao,
    required this.preco,
    required this.avaliacao,
    required this.tempoEntrega,
  });
}

String precoEmReais(double valor) =>
    'R\$ ' + valor.toStringAsFixed(2).replaceAll('.', ',');

abstract final class CatalogoFicticio {
  static const endereco = 'Rua das Palmeiras, 120';

  static const categorias = <Categoria>[
    Categoria(id: 'lanches', nome: 'Lanches', imagem: 'assets/images/burger.png'),
    Categoria(id: 'pizzas', nome: 'Pizzas', imagem: 'assets/images/pizza.png'),
    Categoria(id: 'acompanhamentos', nome: 'Porções', imagem: 'assets/images/batata.png'),
    Categoria(id: 'bebidas', nome: 'Bebidas', imagem: 'assets/images/bebida.png'),
    Categoria(id: 'doces', nome: 'Doces', imagem: 'assets/images/brownie.png'),
    Categoria(id: 'massas', nome: 'Massas', imagem: 'assets/images/massa.png'),
  ];

  static const produtos = <Produto>[
    Produto(id: 'burger-brasa', nome: 'Smash da Brasa', restaurante: 'Brasa Burger',
      categoriaId: 'lanches', imagem: 'assets/images/burger.png',
      descricao: 'Pão brioche, carne smash, queijo e molho da casa.',
      preco: 29.90, avaliacao: 4.8, tempoEntrega: '25–35 min'),
    Produto(id: 'pizza-pepperoni', nome: 'Pizza Pepperoni', restaurante: 'Forno da Vila',
      categoriaId: 'pizzas', imagem: 'assets/images/pizza.png',
      descricao: 'Mussarela, pepperoni e massa de fermentação lenta.',
      preco: 49.90, avaliacao: 4.9, tempoEntrega: '35–45 min'),
    Produto(id: 'batata-rustica', nome: 'Batata Crocante', restaurante: 'Brasa Burger',
      categoriaId: 'acompanhamentos', imagem: 'assets/images/batata.png',
      descricao: 'Batatas sequinhas com páprica e maionese especial.',
      preco: 18.90, avaliacao: 4.7, tempoEntrega: '20–30 min'),
    Produto(id: 'brownie-quente', nome: 'Brownie Quentinho', restaurante: 'Doce Momento',
      categoriaId: 'doces', imagem: 'assets/images/brownie.png',
      descricao: 'Brownie de chocolate com cobertura cremosa.',
      preco: 19.50, avaliacao: 4.9, tempoEntrega: '20–35 min'),
    Produto(id: 'cha-gelado', nome: 'Chá Gelado da Casa', restaurante: 'Refresca Aí',
      categoriaId: 'bebidas', imagem: 'assets/images/bebida.png',
      descricao: 'Chá gelado artesanal com toque cítrico, 400 ml.',
      preco: 12.90, avaliacao: 4.6, tempoEntrega: '15–25 min'),
    Produto(id: 'penne', nome: 'Penne ao Sugo', restaurante: 'Cantina da Vila',
      categoriaId: 'massas', imagem: 'assets/images/massa.png',
      descricao: 'Penne com molho de tomate, manjericão e parmesão.',
      preco: 36.90, avaliacao: 4.8, tempoEntrega: '30–40 min'),
    Produto(id: 'burger-duplo', nome: 'Duplo Queijo', restaurante: 'Brasa Burger',
      categoriaId: 'lanches', imagem: 'assets/images/burger.png',
      descricao: 'Dois hambúrgueres smash com queijo extra.',
      preco: 37.90, avaliacao: 4.9, tempoEntrega: '25–35 min'),
    Produto(id: 'espresso', nome: 'Espresso Cremoso', restaurante: 'Café Aurora',
      categoriaId: 'bebidas', imagem: 'assets/images/cafe.png',
      descricao: 'Café espresso da casa, preparado na hora.',
      preco: 8.50, avaliacao: 4.7, tempoEntrega: '15–25 min'),
  ];
}
