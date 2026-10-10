import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/brasa_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final busca = TextEditingController();
  final Map<String, int> carrinho = {};
  String? categoria;
  String consulta = '';

  @override
  void dispose() {
    busca.dispose();
    super.dispose();
  }

  int get quantidade => carrinho.values.fold(0, (a, b) => a + b);
  double get subtotal => CatalogoFicticio.produtos.fold(
      0.0, (soma, p) => soma + p.preco * (carrinho[p.id] ?? 0));

  List<Produto> get produtos => CatalogoFicticio.produtos.where((p) {
        final t = consulta.trim().toLowerCase();
        return (categoria == null || categoria == p.categoriaId) &&
            (t.isEmpty ||
                p.nome.toLowerCase().contains(t) ||
                p.restaurante.toLowerCase().contains(t) ||
                p.descricao.toLowerCase().contains(t));
      }).toList();

  void mensagem(String texto) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texto)));
  }

  void limpar() {
    busca.clear();
    setState(() {
      consulta = '';
      categoria = null;
    });
  }

  void adicionar(Produto p) {
    setState(() => carrinho[p.id] = (carrinho[p.id] ?? 0) + 1);
    mensagem('Produto adicionado ao carrinho fictício.');
  }

  void abrirCarrinho() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (modalContext) => StatefulBuilder(
        builder: (modalContext, atualizar) {
          final itens = CatalogoFicticio.produtos
              .where((p) => (carrinho[p.id] ?? 0) > 0).toList();
          return SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 5, 20, 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Seu carrinho', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                  const Text('Apenas demonstração: não há pedidos reais.',
                      style: TextStyle(color: BrasaCores.secundario)),
                  const SizedBox(height: 12),
                  if (itens.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(22),
                      child: Center(child: Text('Seu carrinho está vazio.')),
                    ),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height * .4),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: itens.length,
                      itemBuilder: (_, i) {
                        final p = itens[i];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Image.asset(p.imagem, width: 48, height: 48, fit: BoxFit.cover),
                          title: Text(p.nome),
                          subtitle: Text('${carrinho[p.id]} × ${precoEmReais(p.preco)}'),
                          trailing: IconButton(
                            tooltip: 'Remover uma unidade',
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () {
                              setState(() {
                                final n = carrinho[p.id] ?? 0;
                                if (n <= 1) {
                                  carrinho.remove(p.id);
                                } else {
                                  carrinho[p.id] = n - 1;
                                }
                              });
                              atualizar(() {});
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    const Text('Subtotal fictício'),
                    Text(precoEmReais(subtotal), style: const TextStyle(fontWeight: FontWeight.bold)),
                  ]),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => Navigator.pop(modalContext),
                      child: const Text('Continuar explorando'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget titulo(String titulo) => Row(children: [
        Expanded(child: Text(titulo, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800))),
        TextButton(onPressed: limpar, child: const Text('Ver todos')),
      ]);

  Widget categoriaItem(Categoria c) {
    final ativa = categoria == c.id;
    return InkWell(
      onTap: () => setState(() => categoria = ativa ? null : c.id),
      child: SizedBox(
        width: 80,
        child: Column(children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: ativa ? BrasaCores.vermelho : BrasaCores.borda, width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(c.imagem, height: 66, width: 66, fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 5),
          Text(c.nome, maxLines: 1, overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 11, fontWeight: ativa ? FontWeight.bold : FontWeight.normal)),
        ]),
      ),
    );
  }

  Widget produtoItem(Produto p) => Card(
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: Row(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(p.imagem, width: 100, height: 125, fit: BoxFit.cover),
            ),
            const SizedBox(width: 10),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.restaurante, maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11, color: BrasaCores.secundario)),
                const SizedBox(height: 3),
                Text(p.nome, maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(p.descricao, maxLines: 2, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 11)),
                const SizedBox(height: 5),
                Text('⭐ ${p.avaliacao.toStringAsFixed(1)} • ${p.tempoEntrega}',
                    style: const TextStyle(fontSize: 10, color: BrasaCores.secundario)),
                const SizedBox(height: 8),
                Row(children: [
                  Expanded(child: Text(precoEmReais(p.preco),
                      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold,
                          color: BrasaCores.vermelhoEscuro))),
                  SizedBox(
                    height: 34,
                    child: FilledButton(
                      onPressed: () => adicionar(p),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 9),
                      ),
                      child: const Text('Adicionar', style: TextStyle(fontSize: 10)),
                    ),
                  ),
                ]),
              ],
            )),
          ]),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final filtrados = produtos;
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Expanded(
            child: CustomScrollView(slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          height: 40, width: 40,
                          decoration: BoxDecoration(color: BrasaCores.vermelho,
                              borderRadius: BorderRadius.circular(12)),
                          child: const Icon(Icons.local_fire_department, color: Colors.white),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('brasa.', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
                            Text('O sabor chama. A gente entrega.',
                                style: TextStyle(fontSize: 10, color: BrasaCores.secundario)),
                          ],
                        )),
                        Badge(
                          isLabelVisible: quantidade > 0,
                          label: Text('\${quantidade}'),
                          child: IconButton(
                            icon: const Icon(Icons.shopping_bag_outlined),
                            tooltip: 'Carrinho',
                            onPressed: abrirCarrinho,
                          ),
                        ),
                      ]),
                      const SizedBox(height: 17),
                      Row(children: [
                        const Icon(Icons.location_on_outlined, color: BrasaCores.vermelho),
                        const SizedBox(width: 5),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          const Text('ENTREGAR EM', style: TextStyle(fontSize: 9)),
                          Text(CatalogoFicticio.endereco, maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                        ])),
                        TextButton(onPressed: () => mensagem('Endereço fictício.'),
                            child: const Text('Alterar')),
                      ]),
                      const SizedBox(height: 24),
                      const Text('Olá, que bom te ver!',
                          style: TextStyle(color: BrasaCores.secundario)),
                      const SizedBox(height: 6),
                      const Text('O que você deseja\npedir hoje?',
                          style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 18),
                      TextField(
                        controller: busca,
                        onChanged: (t) => setState(() => consulta = t),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Buscar pratos ou restaurantes',
                        ),
                      ),
                      const SizedBox(height: 18),
                      Container(
                        decoration: BoxDecoration(
                          color: BrasaCores.rosa,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(children: [
                          Expanded(child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('OFERTA DO DIA',
                                    style: TextStyle(color: BrasaCores.vermelhoEscuro,
                                        fontSize: 10, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 7),
                                const Text('Sabor que\nacende a fome!',
                                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900)),
                                const SizedBox(height: 10),
                                FilledButton(
                                  onPressed: () {
                                    busca.clear();
                                    setState(() {
                                      consulta = '';
                                      categoria = 'lanches';
                                    });
                                  },
                                  child: const Text('Ver ofertas'),
                                ),
                              ],
                            ),
                          )),
                          ClipRRect(
                            borderRadius: const BorderRadius.horizontal(right: Radius.circular(18)),
                            child: Image.asset('assets/images/burger.png',
                                height: 174, width: 119, fit: BoxFit.cover),
                          ),
                        ]),
                      ),
                      const SizedBox(height: 18),
                      titulo('Categorias'),
                      const SizedBox(height: 7),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 110, child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  itemCount: CatalogoFicticio.categorias.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (_, i) => categoriaItem(CatalogoFicticio.categorias[i]),
                )),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                sliver: SliverToBoxAdapter(child: titulo('Produtos em destaque')),
              ),
              if (filtrados.isEmpty)
                SliverToBoxAdapter(child: Center(child: Column(children: [
                  const Text('Nenhum produto encontrado.'),
                  TextButton(onPressed: limpar, child: const Text('Limpar filtros')),
                ])))
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 24),
                  sliver: SliverList.builder(
                    itemCount: filtrados.length,
                    itemBuilder: (_, i) => produtoItem(filtrados[i]),
                  ),
                ),
            ]),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              nav(Icons.home_rounded, 'Início', () {}),
              nav(Icons.search, 'Buscar', () => mensagem('Use a busca acima.')),
              nav(Icons.receipt_long_outlined, 'Pedidos',
                  () => mensagem('Pedidos indisponíveis na demonstração.')),
              nav(Icons.person_outline, 'Perfil',
                  () => mensagem('Perfil em desenvolvimento.')),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget nav(IconData icon, String nome, VoidCallback onTap) => InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(icon, color: nome == 'Início' ? BrasaCores.vermelho : BrasaCores.secundario),
            Text(nome, style: const TextStyle(fontSize: 10)),
          ]),
        ),
      );
}
