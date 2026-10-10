import 'package:flutter/material.dart';

void main() {
  runApp(const LayoutShowcaseApp());
}

class LayoutShowcaseApp extends StatelessWidget {
  const LayoutShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exercício de Layouts Flutter',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2457C5),
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF153B83),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomeScreen(),
        '/cards': (_) => const CardsListScreen(),
        '/gallery': (_) => const GalleryScreen(),
        '/profile': (_) => const ProfileScreen(),
        '/dashboard': (_) => const DashboardScreen(),
        '/catalog': (_) => const CatalogScreen(),
        '/product': (_) => const ProductDetailsScreen(),
      },
    );
  }
}

const wireBlue = Color(0xFF8CB0E7);
const wireLightBlue = Color(0xFFDDE9FA);
const wireBorder = Color(0xFFB9CDEB);

class WireBlock extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color color;

  const WireBlock({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.child,
    this.margin,
    this.padding,
    this.color = wireBlue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius ?? BorderRadius.circular(5),
        border: Border.all(color: wireBorder),
      ),
      child: child,
    );
  }
}

class WireLine extends StatelessWidget {
  final double widthFactor;
  final double height;

  const WireLine({
    super.key,
    this.widthFactor = 1,
    this.height = 11,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: widthFactor,
      child: WireBlock(height: height, color: wireLightBlue),
    );
  }
}

class AppDrawer extends StatelessWidget {
  final String currentRoute;

  const AppDrawer({
    super.key,
    required this.currentRoute,
  });

  static const _items = <_DrawerItem>[
    _DrawerItem('/', 'Início', Icons.home_outlined),
    _DrawerItem('/cards', '1. Lista de Cards', Icons.view_agenda_outlined),
    _DrawerItem('/gallery', '2. Galeria Horizontal', Icons.view_carousel_outlined),
    _DrawerItem('/profile', '3. Perfil do Usuário', Icons.person_outline),
    _DrawerItem('/dashboard', '4. Dashboard Simples', Icons.dashboard_outlined),
    _DrawerItem('/catalog', '5. Catálogo de Itens', Icons.grid_view_outlined),
    _DrawerItem('/product', '6. Detalhes do Produto', Icons.inventory_2_outlined),
  ];

  void _goTo(BuildContext context, String route) {
    Navigator.of(context).pop();
    if (route == currentRoute) return;
    Navigator.of(context).pushReplacementNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              color: const Color(0xFFEAF1FF),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Color(0xFF2457C5),
                    child: Icon(Icons.flutter_dash, color: Colors.white),
                  ),
                  SizedBox(height: 14),
                  Text(
                    'Layouts Flutter',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF153B83),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text('Exercício — telas 1 a 6'),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: _items.map((item) {
                  final selected = item.route == currentRoute;
                  return ListTile(
                    selected: selected,
                    selectedTileColor: const Color(0xFFEAF1FF),
                    leading: Icon(item.icon),
                    title: Text(item.title),
                    onTap: () => _goTo(context, item.route),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem {
  final String route;
  final String title;
  final IconData icon;

  const _DrawerItem(this.route, this.title, this.icon);
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(currentRoute: '/'),
      appBar: AppBar(title: const Text('Exercício de Layouts')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
                side: const BorderSide(color: Color(0xFFD3DFF0)),
              ),
              child: const Padding(
                padding: EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.dashboard_customize_outlined,
                      size: 72,
                      color: Color(0xFF2457C5),
                    ),
                    SizedBox(height: 18),
                    Text(
                      'Layouts em Flutter',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF153B83),
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Abra o menu lateral pelo ícone no canto superior esquerdo e escolha uma das seis telas do exercício.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardsListScreen extends StatelessWidget {
  const CardsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(currentRoute: '/cards'),
      appBar: AppBar(title: const Text('1. Lista de Cards')),
      body: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 10),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(color: Color(0xFFD6E2F2)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  const WireBlock(width: 58, height: 58),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WireLine(widthFactor: 0.82, height: 13),
                        const SizedBox(height: 9),
                        WireLine(widthFactor: 0.55, height: 9),
                      ],
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
}

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(currentRoute: '/gallery'),
      appBar: AppBar(title: const Text('2. Galeria Horizontal')),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: WireBlock(width: 130, height: 15),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 115,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    6,
                    (index) => const WireBlock(
                      width: 105,
                      height: 105,
                      margin: EdgeInsets.only(right: 10),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 14),
            const WireBlock(height: 15),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                itemCount: 6,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.05,
                ),
                itemBuilder: (_, __) => const WireBlock(),
              ),
            ),
            const SizedBox(height: 12),
            const WireBlock(height: 20),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(currentRoute: '/profile'),
      appBar: AppBar(title: const Text('3. Perfil do Usuário')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  const WireBlock(
                    width: double.infinity,
                    height: 135,
                    borderRadius: BorderRadius.zero,
                  ),
                  Positioned(
                    top: 87,
                    child: CircleAvatar(
                      radius: 54,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 49,
                        backgroundColor: wireLightBlue,
                        child: Icon(
                          Icons.person,
                          size: 58,
                          color: wireBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 70),
              child: WireLine(widthFactor: 0.85, height: 13),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 95),
              child: WireLine(widthFactor: 0.72, height: 10),
            ),
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: List.generate(
                  3,
                  (index) => Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: index == 2 ? 0 : 10),
                      child: const WireBlock(height: 72),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: const [
                  WireBlock(height: 18),
                  SizedBox(height: 12),
                  WireBlock(height: 18),
                ],
              ),
            ),
            const SizedBox(height: 18),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: WireBlock(height: 165),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(currentRoute: '/dashboard'),
      appBar: AppBar(title: const Text('4. Dashboard Simples')),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            const WireBlock(height: 18),
            const SizedBox(height: 12),
            Row(
              children: List.generate(
                4,
                (index) => Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: index == 3 ? 0 : 9),
                    child: const WireBlock(height: 58),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(child: WireBlock()),
                  SizedBox(width: 12),
                  Expanded(child: WireBlock()),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const WireBlock(height: 22),
            const SizedBox(height: 14),
            const Expanded(
              flex: 4,
              child: WireBlock(),
            ),
          ],
        ),
      ),
    );
  }
}

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(currentRoute: '/catalog'),
      appBar: AppBar(title: const Text('5. Catálogo de Itens')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
            child: Row(
              children: const [
                Expanded(
                  child: WireBlock(
                    height: 44,
                    color: wireLightBlue,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Icon(Icons.search, color: Color(0xFF5677A7)),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                WireBlock(
                  width: 44,
                  height: 44,
                  child: Icon(Icons.tune, color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = (constraints.maxWidth - 48) / 3;
                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(14, 4, 14, 12),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      ...List.generate(
                        6,
                        (index) => SizedBox(
                          width: itemWidth,
                          child: const _CatalogItem(),
                        ),
                      ),
                      SizedBox(
                        width: itemWidth * 2 + 10,
                        child: const WireBlock(height: 80),
                      ),
                      SizedBox(
                        width: itemWidth,
                        child: const WireBlock(height: 80),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(14, 0, 14, 12),
            child: WireBlock(height: 22),
          ),
        ],
      ),
    );
  }
}

class _CatalogItem extends StatelessWidget {
  const _CatalogItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: wireBorder),
      ),
      child: const Column(
        children: [
          AspectRatio(aspectRatio: 1, child: WireBlock()),
          SizedBox(height: 6),
          WireLine(widthFactor: 0.8, height: 8),
          SizedBox(height: 5),
          WireLine(widthFactor: 0.55, height: 7),
        ],
      ),
    );
  }
}

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(currentRoute: '/product'),
      appBar: AppBar(title: const Text('6. Detalhes do Produto')),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(
              flex: 5,
              child: WireBlock(),
            ),
            const SizedBox(height: 12),
            Row(
              children: List.generate(4, (index) {
                final isSelected = selected == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => selected = index),
                    child: Container(
                      height: 58,
                      margin: EdgeInsets.only(right: index == 3 ? 0 : 9),
                      decoration: BoxDecoration(
                        color: wireBlue,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF2457C5)
                              : wireBorder,
                          width: isSelected ? 3 : 1,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 14),
            const WireLine(widthFactor: 0.62, height: 13),
            const SizedBox(height: 10),
            const WireLine(widthFactor: 0.40, height: 11),
            const SizedBox(height: 14),
            const Expanded(
              flex: 2,
              child: WireBlock(color: wireLightBlue),
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 48,
              child: FilledButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Ação do produto executada.')),
                  );
                },
                child: const Text('Botão'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
