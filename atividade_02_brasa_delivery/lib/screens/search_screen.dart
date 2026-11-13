import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../data/cart_state.dart';
import '../theme/brasa_theme.dart';

enum FiltroBusca { todos, proximos, entregaRapida, melhorAvaliacao }

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _busca = TextEditingController();
  final _pagina = PageController(viewportFraction: .88);
  final _carrinho = CarrinhoDemo.instancia;
  String _texto = '';
  FiltroBusca _filtro = FiltroBusca.todos;
  int _destaque = 0;

  static const _destaques = [0, 1, 3];

  @override
  void initState() {
    super.initState();
    _carrinho.addListener(_atualizar);
  }

  void _atualizar() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _busca.dispose();
    _pagina.dispose();
    _carrinho.removeListener(_atualizar);
    super.dispose();
  }

  int _menorTempo(Produto p) =>
      int.tryParse(RegExp(r'\d+').firstMatch(p.tempoEntrega)?.group(0) ?? '') ?? 99;

  List<Produto> get _resultados {
    final texto = _texto.trim().toLowerCase();
    final categorias = {
      for (final c in CatalogoFicticio.categorias) c.id: c.nome.toLowerCase(),
    };
    final encontrados = CatalogoFicticio.produtos.where((p) {
      final nomeCategoria = categorias[p.categoriaId] ?? '';
      final corresponde = texto.isEmpty ||
          p.nome.toLowerCase().contains(texto) ||
          p.restaurante.toLowerCase().contains(texto) ||
          p.descricao.toLowerCase().contains(texto) ||
          nomeCategoria.contains(texto);
      if (!corresponde) return false;
      switch (_filtro) {
        case FiltroBusca.todos:
          return true;
        case FiltroBusca.proximos:
          // Lista fictícia: não utiliza GPS ou localização real.
          return const ['Brasa Burger', 'Café Aurora', 'Doce Momento']
              .contains(p.restaurante);
        case FiltroBusca.entregaRapida:
          return _menorTempo(p) <= 20;
        case FiltroBusca.melhorAvaliacao:
          return p.avaliacao >= 4.8;
      }
    }).toList();
    if (_filtro == FiltroBusca.melhorAvaliacao) {
      encontrados.sort((a, b) => b.avaliacao.compareTo(a.avaliacao));
    } else if (_filtro == FiltroBusca.entregaRapida) {
      encontrados.sort((a, b) => _menorTempo(a).compareTo(_menorTempo(b)));
    }
    return encontrados;
  }

  void _aviso(String mensagem) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensagem)));
  }

  void _adicionar(Produto produto) {
    _carrinho.adicionar(produto);
    _aviso('${produto.nome} adicionado ao carrinho de demonstração.');
  }

  Widget _chip(String nome, FiltroBusca filtro) {
    final selecionado = _filtro == filtro;
    return ChoiceChip(
      label: Text(nome),
      selected: selecionado,
      onSelected: (_) => setState(() => _filtro = filtro),
      showCheckmark: false,
      backgroundColor: Colors.white,
      selectedColor: BrasaCores.vermelho,
      labelStyle: TextStyle(
        color: selecionado ? Colors.white : BrasaCores.texto,
        fontSize: 12,
        fontWeight: selecionado ? FontWeight.w700 : FontWeight.w500,
      ),
      side: BorderSide(
        color: selecionado ? BrasaCores.vermelho : BrasaCores.borda,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _produto(Produto p) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(9),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: BrasaCores.borda),
      borderRadius: BorderRadius.circular(17),
    ),
    child: Row(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(p.imagem, width: 96, height: 113, fit: BoxFit.cover),
      ),
      const SizedBox(width: 10),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(p.restaurante, maxLines: 1, overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 11, color: BrasaCores.secundario)),
        const SizedBox(height: 4),
        Text(p.nome, maxLines: 1, overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
        const SizedBox(height: 5),
        Text('★ ${p.avaliacao.toStringAsFixed(1)} · ${p.tempoEntrega}',
          style: const TextStyle(fontSize: 10, color: BrasaCores.secundario)),
        const SizedBox(height: 13),
        Row(children: [
          Expanded(child: Text(precoEmReais(p.preco),
            style: const TextStyle(color: BrasaCores.vermelhoEscuro,
              fontSize: 13, fontWeight: FontWeight.w800))),
          SizedBox(height: 34, child: FilledButton(
            onPressed: () => _adicionar(p),
            style: FilledButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 10)),
            child: const Text('Adicionar', style: TextStyle(fontSize: 11)),
          )),
        ]),
      ])),
    ]),
  );

  Widget _carrossel() => Column(children: [
    SizedBox(
      height: 142,
      child: PageView.builder(
        controller: _pagina,
        itemCount: _destaques.length,
        onPageChanged: (i) => setState(() => _destaque = i),
        itemBuilder: (context, i) {
          final p = CatalogoFicticio.produtos[_destaques[i]];
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              decoration: BoxDecoration(
                color: i.isEven ? BrasaCores.rosa : const Color(0xFFFFE8D0),
                borderRadius: BorderRadius.circular(18),
              ),
              clipBehavior: Clip.antiAlias,
              child: Row(children: [
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(13),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('ESCOLHA DA BRASA', style: TextStyle(
                      color: BrasaCores.vermelhoEscuro, fontSize: 10, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    Text(p.nome, maxLines: 2, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                    const Spacer(),
                    Text(precoEmReais(p.preco), style: const TextStyle(
                      fontWeight: FontWeight.w800, color: BrasaCores.vermelhoEscuro)),
                  ]),
                )),
                Image.asset(p.imagem, width: 118, height: 142, fit: BoxFit.cover),
              ]),
            ),
          );
        },
      ),
    ),
    const SizedBox(height: 9),
    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      for (var i = 0; i < _destaques.length; i++)
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: i == _destaque ? 19 : 7, height: 7,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: i == _destaque ? BrasaCores.vermelho : BrasaCores.borda,
          ),
        ),
    ]),
  ]);

  Widget _navegacao() => Container(
    padding: const EdgeInsets.only(top: 9, bottom: 9),
    decoration: const BoxDecoration(
      color: Colors.white,
      border: Border(top: BorderSide(color: BrasaCores.borda)),
    ),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      _nav(Icons.home_outlined, 'Início', false, () => Navigator.of(context).pushReplacementNamed('/home')),
      _nav(Icons.search_rounded, 'Buscar', true, () {}),
      _nav(Icons.receipt_long_outlined, 'Pedidos', false,
          () => Navigator.of(context).pushReplacementNamed('/orders')),
      _nav(Icons.person_outline, 'Perfil', false, () => Navigator.of(context).pushNamed('/login')),
    ]),
  );

  Widget _nav(IconData icon, String nome, bool ativo, VoidCallback acao) => InkWell(
    onTap: acao,
    borderRadius: BorderRadius.circular(12),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, color: ativo ? BrasaCores.vermelho : BrasaCores.secundario, size: 25),
        const SizedBox(height: 3),
        Text(nome, style: TextStyle(fontSize: 10,
          fontWeight: ativo ? FontWeight.bold : FontWeight.normal,
          color: ativo ? BrasaCores.vermelho : BrasaCores.secundario)),
      ]),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final resultados = _resultados;
    return Scaffold(
      body: SafeArea(child: Column(children: [
        Expanded(child: ListView(padding: const EdgeInsets.fromLTRB(19, 19, 19, 18), children: [
          Row(children: [
            Container(
              height: 32, width: 32,
              decoration: BoxDecoration(color: BrasaCores.vermelho,
                borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.local_fire_department, color: Colors.white, size: 22),
            ),
            const SizedBox(width: 8),
            const Text('brasa.', style: TextStyle(
              fontSize: 21, fontWeight: FontWeight.w900, color: BrasaCores.vermelhoEscuro)),
            const Spacer(),
            if (_carrinho.quantidade > 0)
              Text('${_carrinho.quantidade} no carrinho',
                style: const TextStyle(fontSize: 11, color: BrasaCores.secundario)),
          ]),
          const SizedBox(height: 22),
          const Text('EXPLORAR', style: TextStyle(
            fontSize: 10, fontWeight: FontWeight.w800,
            color: BrasaCores.vermelhoEscuro, letterSpacing: 2)),
          const SizedBox(height: 5),
          const Text('Buscar', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900)),
          const SizedBox(height: 19),
          TextField(
            controller: _busca,
            onChanged: (valor) => setState(() => _texto = valor),
            decoration: InputDecoration(
              hintText: 'Produto, categoria ou restaurante',
              hintStyle: const TextStyle(fontSize: 12),
              prefixIcon: const Icon(Icons.search, color: BrasaCores.vermelho),
              suffixIcon: _texto.isEmpty ? null : IconButton(
                tooltip: 'Limpar busca',
                icon: const Icon(Icons.close),
                onPressed: () { _busca.clear(); setState(() => _texto = ''); },
              ),
            ),
          ),
          const SizedBox(height: 18),
          const Text('Filtros', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
          const SizedBox(height: 7),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [
              _chip('Todos', FiltroBusca.todos),
              const SizedBox(width: 7),
              _chip('Próximos', FiltroBusca.proximos),
              const SizedBox(width: 7),
              _chip('Entrega rápida', FiltroBusca.entregaRapida),
              const SizedBox(width: 7),
              _chip('Melhor avaliação', FiltroBusca.melhorAvaliacao),
            ]),
          ),
          const SizedBox(height: 19),
          Row(children: [
            const Expanded(child: Text('Destaques da Brasa',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800))),
            const Text('Deslize para ver', style: TextStyle(
              color: BrasaCores.secundario, fontSize: 10)),
          ]),
          const SizedBox(height: 11),
          _carrossel(),
          const SizedBox(height: 19),
          Row(children: [
            const Expanded(child: Text('Resultados',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800))),
            Text('${resultados.length} itens',
              style: const TextStyle(color: BrasaCores.secundario, fontSize: 11)),
          ]),
          const SizedBox(height: 12),
          if (resultados.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Column(children: [
                const Icon(Icons.search_off_rounded, size: 44, color: BrasaCores.secundario),
                const SizedBox(height: 8),
                const Text('Nenhum produto encontrado.'),
                TextButton(
                  onPressed: () { _busca.clear(); setState(() { _texto = ''; _filtro = FiltroBusca.todos; }); },
                  child: const Text('Limpar filtros'),
                ),
              ]),
            ),
          for (final produto in resultados) _produto(produto),
          const Text('Proximidade e tempo de entrega são demonstrativos.',
            textAlign: TextAlign.center,
            style: TextStyle(color: BrasaCores.secundario, fontSize: 10)),
        ])),
        _navegacao(),
      ])),
    );
  }
}
