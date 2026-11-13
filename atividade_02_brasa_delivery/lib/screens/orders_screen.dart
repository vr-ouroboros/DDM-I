import 'package:flutter/material.dart';

import '../theme/brasa_theme.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<PedidoCliente> _emAndamento = const [
    PedidoCliente(
      id: '#0001',
      restaurante: 'Brasa Burger',
      status: 'Em preparo',
      previsao: '00:20',
      total: 62.80,
      imagem: 'assets/images/burger.png',
      itens: [
        ItemPedido(nome: '2x Smash da Brasa'),
        ItemPedido(nome: '1x Batata Crocante'),
      ],
    ),
    PedidoCliente(
      id: '#0002',
      restaurante: 'Forno da Vila',
      status: 'Saiu para entrega',
      previsao: '00:12',
      total: 54.90,
      imagem: 'assets/images/pizza.png',
      itens: [
        ItemPedido(nome: '1x Pizza Pepperoni'),
        ItemPedido(nome: '1x Chá Gelado da Casa'),
      ],
    ),
    PedidoCliente(
      id: '#0003',
      restaurante: 'Café Aurora',
      status: 'Recebido',
      previsao: '00:18',
      total: 21.40,
      imagem: 'assets/images/cafe.png',
      itens: [
        ItemPedido(nome: '1x Espresso Cremoso'),
        ItemPedido(nome: '1x Brownie Quentinho'),
      ],
    ),
  ];

  final List<PedidoCliente> _anteriores = const [
    PedidoCliente(
      id: '#0004',
      restaurante: 'Cantina da Vila',
      status: 'Entregue',
      previsao: 'Finalizado',
      total: 36.90,
      imagem: 'assets/images/massa.png',
      itens: [
        ItemPedido(nome: '1x Penne ao Sugo'),
      ],
    ),
    PedidoCliente(
      id: '#0005',
      restaurante: 'Doce Momento',
      status: 'Entregue',
      previsao: 'Finalizado',
      total: 19.50,
      imagem: 'assets/images/brownie.png',
      itens: [
        ItemPedido(nome: '1x Brownie Quentinho'),
      ],
    ),
    PedidoCliente(
      id: '#0006',
      restaurante: 'Brasa Burger',
      status: 'Entregue',
      previsao: 'Finalizado',
      total: 48.80,
      imagem: 'assets/images/batata.png',
      itens: [
        ItemPedido(nome: '1x Duplo Queijo'),
        ItemPedido(nome: '1x Batata Crocante'),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _mostrarAviso(String mensagem) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(mensagem)));
  }

  String _precoEmReais(double valor) =>
      'R\$ ${valor.toStringAsFixed(2).replaceAll('.', ',')}';

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'em preparo':
        return const Color(0xFFF5BE67);
      case 'saiu para entrega':
        return const Color(0xFF6DAE6C);
      case 'recebido':
        return const Color(0xFF8E6BD3);
      case 'entregue':
        return const Color(0xFF5E9B8A);
      default:
        return BrasaCores.borda;
    }
  }

  Widget _marcaTopo() {
    return Row(
      children: [
        Container(
          height: 36,
          width: 36,
          decoration: BoxDecoration(
            color: BrasaCores.vermelho,
            borderRadius: BorderRadius.circular(11),
          ),
          child: const Icon(
            Icons.local_fire_department_rounded,
            color: Colors.white,
            size: 22,
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          'brasa.',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w900,
            color: BrasaCores.vermelhoEscuro,
          ),
        ),
      ],
    );
  }

  Widget _abas() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF2ECE8),
        borderRadius: BorderRadius.circular(14),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        indicatorPadding: const EdgeInsets.all(5),
        dividerColor: Colors.transparent,
        labelColor: BrasaCores.texto,
        unselectedLabelColor: BrasaCores.secundario,
        labelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
        tabs: const [
          Tab(text: 'Em andamento'),
          Tab(text: 'Anteriores'),
        ],
      ),
    );
  }

  Widget _statusChip(String status) {
    final cor = _statusColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: cor.withOpacity(.16),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: cor is MaterialColor ? cor.shade700 : cor,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _cardPedido(PedidoCliente pedido, {required bool andamento}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: BrasaCores.borda),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Pedido ${pedido.id}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: BrasaCores.secundario,
                  ),
                ),
              ),
              _statusChip(pedido.status),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(
                Icons.storefront_outlined,
                size: 18,
                color: BrasaCores.vermelho,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  pedido.restaurante,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: BrasaCores.texto,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: BrasaCores.borda),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  pedido.imagem,
                  width: 72,
                  height: 72,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: pedido.itens
                      .map(
                        (item) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.restaurant_menu,
                                size: 14,
                                color: BrasaCores.vermelhoEscuro,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  item.nome,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: BrasaCores.secundario,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(color: BrasaCores.borda),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  andamento ? 'Previsão: ${pedido.previsao}' : pedido.previsao,
                  style: const TextStyle(
                    fontSize: 12,
                    color: BrasaCores.secundario,
                  ),
                ),
              ),
              Text(
                _precoEmReais(pedido.total),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: BrasaCores.vermelhoEscuro,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: OutlinedButton.icon(
              onPressed: () => _mostrarAviso(
                andamento
                    ? 'Acompanhamento indisponível neste protótipo.'
                    : 'Detalhes do pedido indisponíveis neste protótipo.',
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: BrasaCores.texto,
                side: const BorderSide(color: BrasaCores.texto),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: Icon(
                andamento
                    ? Icons.delivery_dining_outlined
                    : Icons.receipt_long_outlined,
                size: 18,
              ),
              label: Text(
                andamento ? 'Acompanhar pedido' : 'Ver detalhes',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listaPedidos(List<PedidoCliente> pedidos, {required bool andamento}) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 14, bottom: 20),
      itemCount: pedidos.length,
      itemBuilder: (context, index) {
        return _cardPedido(pedidos[index], andamento: andamento);
      },
    );
  }

  Widget _bottomNavigation() {
    return Container(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: BrasaCores.borda)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(
            icon: Icons.home_outlined,
            label: 'Início',
            ativo: false,
            onTap: () => Navigator.of(context).pushReplacementNamed('/home'),
          ),
          _navItem(
            icon: Icons.search_rounded,
            label: 'Buscar',
            ativo: false,
            onTap: () => Navigator.of(context).pushReplacementNamed('/search'),
          ),
          _navItem(
            icon: Icons.receipt_long_rounded,
            label: 'Pedidos',
            ativo: true,
            onTap: () {},
          ),
          _navItem(
            icon: Icons.person_outline,
            label: 'Perfil',
            ativo: false,
            onTap: () => Navigator.of(context).pushNamed('/login'),
          ),
        ],
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required String label,
    required bool ativo,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 25,
              color: ativo ? BrasaCores.vermelho : BrasaCores.secundario,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: ativo ? FontWeight.bold : FontWeight.normal,
                color: ativo ? BrasaCores.vermelho : BrasaCores.secundario,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _marcaTopo(),
                    const SizedBox(height: 22),
                    const Text(
                      'ACOMPANHAMENTO',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.8,
                        color: BrasaCores.vermelhoEscuro,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Meus pedidos',
                      style: TextStyle(
                        fontSize: 31,
                        fontWeight: FontWeight.w900,
                        color: BrasaCores.texto,
                      ),
                    ),
                    const SizedBox(height: 18),
                    _abas(),
                    const SizedBox(height: 2),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _listaPedidos(_emAndamento, andamento: true),
                          _listaPedidos(_anteriores, andamento: false),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _bottomNavigation(),
          ],
        ),
      ),
    );
  }
}

class PedidoCliente {
  final String id;
  final String restaurante;
  final String status;
  final String previsao;
  final double total;
  final String imagem;
  final List<ItemPedido> itens;

  const PedidoCliente({
    required this.id,
    required this.restaurante,
    required this.status,
    required this.previsao,
    required this.total,
    required this.imagem,
    required this.itens,
  });
}

class ItemPedido {
  final String nome;

  const ItemPedido({
    required this.nome,
  });
}