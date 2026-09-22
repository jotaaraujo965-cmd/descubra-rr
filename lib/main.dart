import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(DescubraRRApp(prefs: prefs));
}

class AppColors {
  static const green = Color(0xFF73C83C);
  static const lightGreen = Color(0xFFA5E65B);
  static const dark = Color(0xFF10251B);
  static const bg = Color(0xFFF6F8F5);
  static const gray = Color(0xFF6D786F);
  static const line = Color(0xFFE1E8E1);
}

class Municipality {
  final String name, subtitle;
  final double lat, lng;
  final int places;
  const Municipality(this.name, this.subtitle, this.lat, this.lng, this.places);
}

const municipalities = [
  Municipality('Boa Vista', 'Capital de Roraima', 2.8235, -60.6758, 6),
  Municipality('Pacaraima', 'Norte do estado', 4.4799, -61.1477, 4),
  Municipality('Amajari', 'Natureza e aventura', 3.6500, -61.4200, 3),
  Municipality('Caracaraí', 'Portal do sul', 1.8050, -61.1300, 3),
  Municipality('Bonfim', 'Fronteira e cultura', 3.3600, -59.8333, 3),
  Municipality('Uiramutã', 'Paisagens do extremo norte', 4.6039, -60.1817, 4),
  Municipality('Alto Alegre', 'Histórias e natureza', 2.9894, -61.3072, 3),
  Municipality('Mucajaí', 'Caminhos de Roraima', 2.4300, -60.9100, 3),
  Municipality('Normandia', 'Cultura e paisagens', 3.8800, -59.6200, 2),
  Municipality('Cantá', 'Perto da capital', 2.6100, -60.5950, 3),
  Municipality('Iracema', 'Verde e tranquila', 2.1833, -61.0433, 2),
  Municipality('Rorainópolis', 'Sul de Roraima', 0.9483, -60.4097, 3),
  Municipality('São Luiz', 'Pequena e acolhedora', 1.0100, -60.0400, 2),
  Municipality('São João da Baliza', 'Sul do estado', 0.9500, -59.9133, 2),
  Municipality('Caroebe', 'Natureza amazônica', 0.8833, -59.6950, 2),
];

class Discovery {
  final String title, category, description, curiosity, code;
  final IconData icon;
  final double lat, lng;
  bool unlocked;
  Discovery(this.title, this.category, this.description, this.curiosity, this.code,
      this.icon, this.lat, this.lng, {this.unlocked = false});
}

final discoveries = <Discovery>[
  Discovery('Praça Central', 'Cultura', 'Um ponto de encontro para conhecer o movimento da cidade.',
      'Observe como os espaços públicos contam parte da história local.', 'RR2026',
      Icons.account_balance, 2.8235, -60.6758),
  Discovery('Experiência Secreta', 'Turismo', 'Uma descoberta especial escondida no mapa.',
      'O código desta experiência é encontrado presencialmente.', 'BOAVISTA',
      Icons.auto_awesome, 2.8170, -60.6820),
  Discovery('Sabores de RR', 'Gastronomia', 'Uma experiência para descobrir sabores regionais.',
      'A gastronomia também é uma forma de explorar um território.', 'SABORES',
      Icons.restaurant, 2.8290, -60.6700),
  Discovery('Ponto Natural', 'Natureza', 'Um local para observar paisagens e biodiversidade.',
      'Roraima reúne diferentes paisagens em um único estado.', 'NATUREZA',
      Icons.forest, 2.8050, -60.6900),
  Discovery('Ponto Histórico', 'História', 'Uma parada para conhecer histórias da região.',
      'Procure os detalhes que normalmente passam despercebidos.', 'HISTORIA',
      Icons.history_edu, 2.8350, -60.6630),
  Discovery('Artesanato Local', 'Artesanato', 'Produtos e expressões que valorizam a cultura local.',
      'Valorizar o artesanato ajuda a manter saberes e tradições.', 'ARTESANATO',
      Icons.palette, 2.8150, -60.6650),
];

class DescubraRRApp extends StatelessWidget {
  final SharedPreferences prefs;
  const DescubraRRApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Descubra RR',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.bg,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.green),
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      home: SplashPage(prefs: prefs),
    );
  }
}

class SplashPage extends StatefulWidget {
  final SharedPreferences prefs;
  const SplashPage({super.key, required this.prefs});
  @override State<SplashPage> createState() => _SplashPageState();
}
class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1900), () {
      if (mounted) Navigator.pushReplacement(context, _fade(LoginPage(prefs: widget.prefs)));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: 92, height: 92,
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [BoxShadow(color: AppColors.green.withOpacity(.3), blurRadius: 35, spreadRadius: 5)],
            ),
            child: const Icon(Icons.explore_rounded, color: AppColors.dark, size: 50),
          ).animate().scale(duration: 650.ms, curve: Curves.easeOutBack),
          const SizedBox(height: 22),
          Text('DESCUBRA RR', style: GoogleFonts.poppins(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: 2))
              .animate().fadeIn(delay: 250.ms).slideY(begin: .2),
          const SizedBox(height: 6),
          Text('Explore. Descubra. Desbloqueie.', style: TextStyle(color: AppColors.lightGreen, fontSize: 13))
              .animate().fadeIn(delay: 450.ms),
        ]),
      ),
    );
  }
}

Route _fade(Widget page) => PageRouteBuilder(
  pageBuilder: (_, __, ___) => page,
  transitionsBuilder: (_, a, __, child) => FadeTransition(opacity: a, child: child),
  transitionDuration: const Duration(milliseconds: 400),
);

class LoginPage extends StatefulWidget {
  final SharedPreferences prefs;
  const LoginPage({super.key, required this.prefs});
  @override State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  bool login = true;
  final email = TextEditingController();
  final password = TextEditingController();
  @override Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 440),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 35),
            Row(children: [
              Container(width: 48, height: 48, decoration: BoxDecoration(color: AppColors.green, borderRadius: BorderRadius.circular(15)),
                  child: const Icon(Icons.explore, color: AppColors.dark)),
              const SizedBox(width: 13),
              Text('Descubra RR', style: GoogleFonts.poppins(fontWeight: FontWeight.w800, fontSize: 23, color: AppColors.dark)),
            ]).animate().fadeIn().slideX(begin: -.15),
            const SizedBox(height: 48),
            Text(login ? 'Bem-vindo de volta.' : 'Comece sua jornada.',
                style: GoogleFonts.poppins(fontSize: 29, fontWeight: FontWeight.w800, color: AppColors.dark)),
            const SizedBox(height: 8),
            Text(login ? 'Entre para continuar suas descobertas.' : 'Crie sua conta e explore Roraima.',
                style: const TextStyle(color: AppColors.gray)),
            const SizedBox(height: 30),
            if (!login) _field('Nome', Icons.person_outline),
            if (!login) const SizedBox(height: 14),
            _field('E-mail', Icons.mail_outline),
            const SizedBox(height: 14),
            _field('Senha', Icons.lock_outline, obscure: true),
            if (!login) ...[
              const SizedBox(height: 14),
              _field('Confirmar senha', Icons.lock_reset_outlined, obscure: true),
            ],
            const SizedBox(height: 25),
            SizedBox(width: double.infinity, height: 55, child: FilledButton(
              style: FilledButton.styleFrom(backgroundColor: AppColors.dark, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17))),
              onPressed: () => Navigator.pushReplacement(context, _fade(HomePage(prefs: widget.prefs))),
              child: Text(login ? 'Entrar  →' : 'Criar conta  →', style: const TextStyle(fontWeight: FontWeight.w700)),
            )),
            const SizedBox(height: 20),
            Center(child: TextButton(
              onPressed: () => setState(() => login = !login),
              child: Text(login ? 'Ainda não tenho uma conta' : 'Já tenho uma conta', style: const TextStyle(color: AppColors.dark, fontWeight: FontWeight.w700)),
            )),
          ]))))),
    );
  }
  Widget _field(String label, IconData icon, {bool obscure = false}) => TextField(
    obscureText: obscure, controller: label.contains('E-mail') ? email : password,
    decoration: InputDecoration(
      labelText: label, prefixIcon: Icon(icon, color: AppColors.gray),
      filled: true, fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(17), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(17), borderSide: const BorderSide(color: AppColors.green, width: 1.5)),
    ),
  );
}

class HomePage extends StatefulWidget {
  final SharedPreferences prefs;
  const HomePage({super.key, required this.prefs});
  @override State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  int tab = 0;
  int get unlocked => discoveries.where((d) => d.unlocked).length;

  @override void initState() { super.initState(); _load(); }
  void _load() {
    for (final d in discoveries) d.unlocked = widget.prefs.getBool('d_${d.title}') ?? false;
  }
  @override Widget build(BuildContext context) {
    final pages = [
      _home(),
      DiscoveriesPage(),
      ProfilePage(),
    ];
    return Scaffold(
      body: SafeArea(child: pages[tab]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (v) => setState(() => tab = v),
        backgroundColor: Colors.white,
        indicatorColor: AppColors.lightGreen.withOpacity(.35),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Início'),
          NavigationDestination(icon: Icon(Icons.auto_awesome_outlined), selectedIcon: Icon(Icons.auto_awesome), label: 'Descobertas'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }
  Widget _home() {
    final progress = unlocked / discoveries.length;
    return ListView(padding: const EdgeInsets.fromLTRB(20, 20, 20, 28), children: [
      Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Olá, explorador! 👋', style: TextStyle(color: AppColors.gray, fontSize: 14)),
          const SizedBox(height: 2),
          Text('Descubra RR', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.dark)),
        ])),
        Container(width: 45, height: 45, decoration: BoxDecoration(color: AppColors.dark, borderRadius: BorderRadius.circular(15)),
          child: const Icon(Icons.person, color: AppColors.lightGreen)),
      ]).animate().fadeIn().slideY(begin: -.1),
      const SizedBox(height: 24),
      Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [AppColors.dark, Color(0xFF1C3828)], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(27),
          boxShadow: [BoxShadow(color: AppColors.dark.withOpacity(.16), blurRadius: 24, offset: const Offset(0, 10))],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Expanded(child: Text('Sua jornada por Roraima', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700))),
            Text('$unlocked', style: GoogleFonts.poppins(color: AppColors.lightGreen, fontSize: 28, fontWeight: FontWeight.w800)),
          ]),
          const SizedBox(height: 6),
          Text('$unlocked de ${discoveries.length} descobertas desbloqueadas', style: const TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 18),
          ClipRRect(borderRadius: BorderRadius.circular(20), child: LinearProgressIndicator(
            value: progress, minHeight: 8, backgroundColor: Colors.white12, valueColor: const AlwaysStoppedAnimation(AppColors.green))),
          const SizedBox(height: 14),
          Text('${(progress * 100).round()}% da jornada concluída', style: const TextStyle(color: Colors.white60, fontSize: 12)),
        ]),
      ).animate().fadeIn(delay: 120.ms).slideY(begin: .12),
      const SizedBox(height: 30),
      Text('Comece a explorar', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.dark)),
      const SizedBox(height: 13),
      Row(children: [
        Expanded(child: _action(Icons.location_city, 'Municípios', 'Explore Roraima', () => Navigator.push(context, _fade(MunicipalitiesPage(prefs: widget.prefs))))),
        const SizedBox(width: 13),
        Expanded(child: _action(Icons.auto_awesome, 'Descobertas', 'Veja seus lugares', () => setState(() => tab = 1))),
      ]),
      const SizedBox(height: 30),
      Text('Categorias', style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.dark)),
      const SizedBox(height: 14),
      Wrap(spacing: 9, runSpacing: 9, children: [
        '🌿 Natureza','🏛️ História','🎭 Cultura','🍽️ Gastronomia','🛍️ Comércio','🎨 Artesanato','🎉 Eventos','📸 Turismo'
      ].map((x) => Chip(label: Text(x), backgroundColor: Colors.white, side: BorderSide.none, padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8))).toList()),
    ]);
  }
  Widget _action(IconData icon, String title, String sub, VoidCallback tap) => InkWell(
    borderRadius: BorderRadius.circular(22), onTap: tap,
    child: Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: 44, height: 44, decoration: BoxDecoration(color: AppColors.lightGreen.withOpacity(.35), borderRadius: BorderRadius.circular(14)), child: Icon(icon, color: AppColors.dark)),
        const SizedBox(height: 18), Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.dark)),
        const SizedBox(height: 4), Text(sub, style: const TextStyle(color: AppColors.gray, fontSize: 11)),
      ]),
    ),
  );
}

class MunicipalitiesPage extends StatelessWidget {
  final SharedPreferences prefs;
  const MunicipalitiesPage({super.key, required this.prefs});
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Municípios', style: TextStyle(fontWeight: FontWeight.w800)), backgroundColor: AppColors.bg),
      body: GridView.builder(
        padding: const EdgeInsets.all(18), itemCount: municipalities.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 1.05),
        itemBuilder: (_, i) {
          final m = municipalities[i];
          return InkWell(
            borderRadius: BorderRadius.circular(22),
            onTap: () => Navigator.push(context, _fade(MunicipalityMapPage(municipality: m, prefs: prefs))),
            child: Container(padding: const EdgeInsets.all(17), decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(22),
              border: Border.all(color: AppColors.line),
            ), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(width: 42, height: 42, decoration: BoxDecoration(color: AppColors.dark, borderRadius: BorderRadius.circular(14)),
                child: const Icon(Icons.location_on, color: AppColors.lightGreen)),
              const Spacer(),
              Text(m.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: AppColors.dark)),
              const SizedBox(height: 3),
              Text(m.subtitle, style: const TextStyle(fontSize: 10.5, color: AppColors.gray)),
              const SizedBox(height: 8),
              Text('${m.places} pontos', style: const TextStyle(fontSize: 10, color: AppColors.green, fontWeight: FontWeight.w700)),
            ]),
          ).animate(delay: (i * 35).ms).fadeIn().scale(begin: const Offset(.96, .96));
        },
      ),
    );
  }
}

class MunicipalityMapPage extends StatefulWidget {
  final Municipality municipality;
  final SharedPreferences prefs;
  const MunicipalityMapPage({super.key, required this.municipality, required this.prefs});
  @override State<MunicipalityMapPage> createState() => _MunicipalityMapPageState();
}
class _MunicipalityMapPageState extends State<MunicipalityMapPage> {
  final mapController = MapController();
  @override Widget build(BuildContext context) {
    final points = discoveries;
    return Scaffold(
      appBar: AppBar(
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.municipality.name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
          Text('${points.length} pontos de descoberta', style: const TextStyle(fontSize: 10, color: AppColors.gray)),
        ]),
        backgroundColor: AppColors.bg,
      ),
      body: Stack(children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(initialCenter: LatLng(widget.municipality.lat, widget.municipality.lng), initialZoom: 13.5),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'br.com.descubrarr.app',
            ),
            MarkerLayer(markers: points.map((d) => Marker(
              point: LatLng(d.lat, d.lng), width: 54, height: 54,
              child: GestureDetector(
                onTap: () => _openDiscovery(d),
                child: Container(
                  decoration: BoxDecoration(
                    color: d.unlocked ? AppColors.green : AppColors.dark,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(.18), blurRadius: 10)],
                  ),
                  child: Icon(d.unlocked ? Icons.location_on : Icons.lock, color: d.unlocked ? AppColors.dark : Colors.white, size: 24),
                ),
              ),
            )).toList()),
          ],
        ),
        Positioned(left: 18, right: 18, bottom: 18, child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(color: Colors.white.withOpacity(.95), borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 20)]),
          child: const Row(children: [
            Icon(Icons.touch_app, color: AppColors.green), SizedBox(width: 10),
            Expanded(child: Text('Toque em um marcador para descobrir o local.', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
          ]),
        )),
      ]),
    );
  }
  void _openDiscovery(Discovery d) {
    if (d.unlocked) {
      Navigator.push(context, _fade(DiscoveryDetailPage(d: d)));
    } else {
      showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
        builder: (_) => CodeSheet(d: d, prefs: widget.prefs, onUnlocked: () => setState(() {})));
    }
  }
}

class CodeSheet extends StatefulWidget {
  final Discovery d;
  final SharedPreferences prefs;
  final VoidCallback onUnlocked;
  const CodeSheet({super.key, required this.d, required this.prefs, required this.onUnlocked});
  @override State<CodeSheet> createState() => _CodeSheetState();
}
class _CodeSheetState extends State<CodeSheet> {
  final controller = TextEditingController();
  String? error;
  bool success = false;
  @override Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(padding: const EdgeInsets.fromLTRB(24, 12, 24, 30), decoration: const BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 42, height: 5, decoration: BoxDecoration(color: AppColors.line, borderRadius: BorderRadius.circular(10))),
          const SizedBox(height: 25),
          Container(width: 64, height: 64, decoration: BoxDecoration(color: AppColors.dark, borderRadius: BorderRadius.circular(20)),
            child: Icon(success ? Icons.check : Icons.lock, color: AppColors.lightGreen, size: 30)),
          const SizedBox(height: 17),
          Text(success ? 'Descoberta desbloqueada!' : 'Descoberta bloqueada', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.dark)),
          const SizedBox(height: 7),
          Text(success ? 'Agora esse lugar faz parte da sua jornada.' : 'Encontre o código desse local e desbloqueie a experiência.', textAlign: TextAlign.center, style: const TextStyle(color: AppColors.gray)),
          if (!success) ...[
            const SizedBox(height: 20),
            TextField(controller: controller, textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(labelText: 'Digite o código', prefixIcon: const Icon(Icons.key),
                errorText: error, filled: true, fillColor: AppColors.bg,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(17), borderSide: BorderSide.none))),
            const SizedBox(height: 15),
            SizedBox(width: double.infinity, height: 52, child: FilledButton(
              style: FilledButton.styleFrom(backgroundColor: AppColors.dark, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              onPressed: _unlock, child: const Text('Desbloquear  ✨', style: TextStyle(fontWeight: FontWeight.w700)))),
          ] else ...[
            const SizedBox(height: 18),
            SizedBox(width: double.infinity, height: 52, child: FilledButton(
              style: FilledButton.styleFrom(backgroundColor: AppColors.green, foregroundColor: AppColors.dark, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
              onPressed: () { Navigator.pop(context); Navigator.push(context, _fade(DiscoveryDetailPage(d: widget.d))); },
              child: const Text('Ver descoberta →', style: TextStyle(fontWeight: FontWeight.w800)))),
          ],
        ]).animate().fadeIn(duration: 250.ms).slideY(begin: .08),
      ),
    );
  }
  void _unlock() {
    if (controller.text.trim().toUpperCase() == widget.d.code) {
      setState(() { success = true; widget.d.unlocked = true; });
      widget.prefs.setBool('d_${widget.d.title}', true);
      widget.onUnlocked();
    } else {
      setState(() => error = 'Código inválido. Tente novamente.');
    }
  }
}

class DiscoveryDetailPage extends StatelessWidget {
  final Discovery d;
  const DiscoveryDetailPage({super.key, required this.d});
  @override Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 280, pinned: true, backgroundColor: AppColors.dark,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(d.title, style: const TextStyle(fontWeight: FontWeight.w800)),
            background: Container(
              decoration: const BoxDecoration(gradient: LinearGradient(colors: [AppColors.dark, Color(0xFF315D3D)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              child: Center(child: Icon(d.icon, color: AppColors.lightGreen, size: 92).animate().scale(duration: 700.ms, curve: Curves.easeOutBack)),
            ),
          ),
        ),
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(22), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Chip(label: Text(d.category), backgroundColor: AppColors.lightGreen.withOpacity(.35), side: BorderSide.none),
          const SizedBox(height: 18),
          Text('Sobre', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.dark)),
          const SizedBox(height: 8), Text(d.description, style: const TextStyle(height: 1.6, color: AppColors.gray)),
          const SizedBox(height: 26),
          _info(Icons.lightbulb_outline, 'Curiosidade', d.curiosity),
          const SizedBox(height: 14),
          _info(Icons.location_on_outlined, 'Localização', 'Roraima • ponto de descoberta'),
          const SizedBox(height: 14),
          _info(Icons.verified_outlined, 'Status', 'Descoberta desbloqueada'),
        ]).animate().fadeIn(delay: 150.ms).slideY(begin: .08))),
      ]),
    );
  }
  Widget _info(IconData icon, String title, String text) => Container(
    padding: const EdgeInsets.all(17), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(width: 42, height: 42, decoration: BoxDecoration(color: AppColors.lightGreen.withOpacity(.3), borderRadius: BorderRadius.circular(13)), child: Icon(icon, color: AppColors.dark)),
      const SizedBox(width: 13),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.dark)),
        const SizedBox(height: 3), Text(text, style: const TextStyle(fontSize: 12, color: AppColors.gray, height: 1.4)),
      ])),
    ]),
  );
}

class DiscoveriesPage extends StatelessWidget {
  DiscoveriesPage({super.key});
  final cats = const ['Todas','Natureza','História','Cultura','Gastronomia','Artesanato'];
  @override Widget build(BuildContext context) {
    final list = discoveries.where((d) => d.unlocked).toList();
    return ListView(padding: const EdgeInsets.fromLTRB(20, 20, 20, 30), children: [
      Text('Minhas descobertas', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.dark)),
      const SizedBox(height: 5),
      Text('${list.length} lugares fazem parte da sua jornada.', style: const TextStyle(color: AppColors.gray)),
      const SizedBox(height: 22),
      Wrap(spacing: 8, runSpacing: 8, children: cats.map((c) => Chip(label: Text(c), backgroundColor: Colors.white, side: BorderSide.none)).toList()),
      const SizedBox(height: 18),
      if (list.isEmpty) _empty(context) else ...list.asMap().entries.map((e) => _card(context, e.value, e.key)),
    ]);
  }
  Widget _empty(BuildContext context) => Container(
    padding: const EdgeInsets.all(35), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(26)),
    child: Column(children: [
      const Icon(Icons.explore_outlined, size: 55, color: AppColors.green),
      const SizedBox(height: 15),
      const Text('Sua coleção está começando.', style: TextStyle(fontWeight: FontWeight.w800, color: AppColors.dark, fontSize: 16)),
      const SizedBox(height: 7),
      const Text('Explore um município e desbloqueie seu primeiro ponto.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.gray, fontSize: 12)),
    ]),
  );
  Widget _card(BuildContext context, Discovery d, int i) => InkWell(
    onTap: () => Navigator.push(context, _fade(DiscoveryDetailPage(d: d))), borderRadius: BorderRadius.circular(22),
    child: Container(margin: const EdgeInsets.only(bottom: 12), padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22)),
      child: Row(children: [
        Container(width: 58, height: 58, decoration: BoxDecoration(color: AppColors.dark, borderRadius: BorderRadius.circular(17)), child: Icon(d.icon, color: AppColors.lightGreen, size: 28)),
        const SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(d.title, style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.dark)),
          const SizedBox(height: 3), Text(d.category, style: const TextStyle(color: AppColors.gray, fontSize: 11)),
        ])),
        const Icon(Icons.chevron_right, color: AppColors.gray),
      ]),
    ),
  ).animate(delay: (i * 70).ms).fadeIn().slideX(begin: .06);
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override Widget build(BuildContext context) {
    final count = discoveries.where((d) => d.unlocked).length;
    return ListView(padding: const EdgeInsets.all(20), children: [
      Text('Perfil', style: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.dark)),
      const SizedBox(height: 20),
      Container(padding: const EdgeInsets.all(22), decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.dark, Color(0xFF274B34)]), borderRadius: BorderRadius.circular(28)),
        child: Row(children: [
          Container(width: 68, height: 68, decoration: BoxDecoration(color: AppColors.green, borderRadius: BorderRadius.circular(22)),
            child: const Icon(Icons.explore, color: AppColors.dark, size: 34)),
          const SizedBox(width: 15),
          const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Explorador RR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 19)),
            SizedBox(height: 4), Text('Colecionando experiências', style: TextStyle(color: Colors.white70, fontSize: 11)),
          ]),
        ]),
      ),
      const SizedBox(height: 22),
      Row(children: [
        _stat('$count', 'Descobertas'), _stat('1', 'Município'), _stat('${(count / discoveries.length * 100).round()}%', 'Progresso'),
      ]),
      const SizedBox(height: 28),
      _section(Icons.emoji_events_outlined, 'Sua jornada', 'Cada código desbloqueado aumenta sua coleção de experiências.'),
      const SizedBox(height: 12),
      _section(Icons.settings_outlined, 'Preferências', 'Configure notificações e privacidade do aplicativo.'),
    ]);
  }
  Widget _stat(String value, String label) => Expanded(child: Container(margin: const EdgeInsets.only(right: 8), padding: const EdgeInsets.symmetric(vertical: 20),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)), child: Column(children: [
      Text(value, style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.dark)),
      const SizedBox(height: 3), Text(label, style: const TextStyle(fontSize: 10, color: AppColors.gray)),
    ])));
  Widget _section(IconData icon, String title, String sub) => Container(padding: const EdgeInsets.all(17), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
    child: Row(children: [
      Icon(icon, color: AppColors.green, size: 29), const SizedBox(width: 14), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: AppColors.dark)),
        const SizedBox(height: 3), Text(sub, style: const TextStyle(fontSize: 11, color: AppColors.gray)),
      ])),
    ]));
}
