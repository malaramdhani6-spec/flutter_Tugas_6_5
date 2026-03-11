import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() => runApp(const ArcadeApp());

class ArcadeApp extends StatelessWidget {
  const ArcadeApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D0D1A), 
        useMaterial3: true,
      ),
      builder: (context, child) {
        return MobileFrame(child: child!);
      },
      home: const GetStartedPage(),
    );
  }
}

class MobileFrame extends StatelessWidget {
  final Widget child;
  const MobileFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D1A), 
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 450), 
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A2E),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 30,
                spreadRadius: 5,
              )
            ],
          ),
          child: ClipRect(child: child),
        ),
      ),
    );
  }
}

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  bool _isAnimated = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => _isAnimated = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
          ),
        ),
        child: AnimatedScale(
          scale: _isAnimated ? 1.0 : 0.8,
          duration: const Duration(seconds: 1),
          curve: Curves.elasticOut,
          child: AnimatedOpacity(
            opacity: _isAnimated ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 800),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withAlpha(100), 
                        blurRadius: 50,
                        spreadRadius: 5,
                      )
                    ],
                  ),
                  child: const Icon(Icons.rocket_launch_rounded, size: 100, color: Colors.cyanAccent),
                ),
                const SizedBox(height: 40),
                const Text(
                  "ARCADE HUB",
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4,
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "Petualangan Seru Dimulai Di Sini",
                  style: TextStyle(color: Colors.cyanAccent, fontSize: 16, letterSpacing: 1.2),
                ),
                const SizedBox(height: 60),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MainWrapper()),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      gradient: const LinearGradient(colors: [Colors.cyanAccent, Colors.blueAccent]),
                      boxShadow: [
                        BoxShadow(color: Colors.blueAccent.withAlpha(150), blurRadius: 20, offset: const Offset(0, 5))
                      ],
                    ),
                    child: const Text(
                      "GAS MAIN!",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});
  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;
  final List<Widget> _pages = [const HomePage(), const SearchPage(), const SettingPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF16213E),
        selectedItemColor: Colors.cyanAccent,
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.settings_rounded), label: "Settings"),
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> allGames = [
      {"name": "GUESS NO", "icon": Icons.casino, "color": Colors.orange, "page": const GuessNumberGame()},
      {"name": "MEMORY", "icon": Icons.psychology, "color": Colors.pinkAccent, "page": const MemoryMatchGame()},
      {"name": "MATH QUICK", "icon": Icons.calculate, "color": Colors.green, "page": const MathQuizGame()},
      {"name": "COLOR TAP", "icon": Icons.palette, "color": Colors.blue, "page": const ColorTapGame()},
      {"name": "CLICK RACE", "icon": Icons.touch_app, "color": Colors.purple, "page": const ClickerGame()},
      {"name": "REACTION", "icon": Icons.bolt, "color": Colors.yellowAccent, "page": const ReactionGame()},
      {"name": "WHACK IT", "icon": Icons.gavel_rounded, "color": Colors.brown, "page": const WhackAMoleGame()},
      {"name": "SNAKE", "icon": Icons.vibration_rounded, "color": Colors.lightGreenAccent, "page": const SnakeGame()},
      {"name": "ROLL DICE", "icon": Icons.filter_6_rounded, "color": Colors.white, "page": const DiceGame()},
    ];

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LIBRARY", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(15),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, 
          childAspectRatio: 0.55, 
          crossAxisSpacing: 12,
          mainAxisSpacing: 20,
        ),
        itemCount: allGames.length,
        itemBuilder: (ctx, i) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => allGames[i]['page']),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: allGames[i]['color'].withAlpha(100), width: 1.5),
                    ),
                    child: Center(
                      child: Icon(
                        allGames[i]['icon'],
                        color: allGames[i]['color'],
                        size: 80,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  allGames[i]['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class GuessNumberGame extends StatefulWidget {
  const GuessNumberGame({super.key});
  @override
  State<GuessNumberGame> createState() => _GuessNumberGameState();
}
class _GuessNumberGameState extends State<GuessNumberGame> {
  int target = Random().nextInt(20) + 1;
  String msg = "Tebak 1-20";
  final _c = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Guess Number")),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(msg, style: const TextStyle(fontSize: 24, color: Colors.cyanAccent)),
        Padding(padding: const EdgeInsets.all(30), child: TextField(controller: _c, keyboardType: TextInputType.number, textAlign: TextAlign.center, style: const TextStyle(fontSize: 30))),
        ElevatedButton(onPressed: () {
          int? v = int.tryParse(_c.text);
          if (v == null) return;
          setState(() {
            if (v < target) {
            msg = "Terlalu Kecil!";
            } else if (v > target) {
            msg = "Terlalu Besar!";
            }else {
            msg = "MENANG! 🎉";
            }
          });
          _c.clear();
        }, child: const Text("CEK")),
      ]),
    );
  }
}

class MemoryMatchGame extends StatefulWidget {
  const MemoryMatchGame({super.key});
  @override
  State<MemoryMatchGame> createState() => _MemoryMatchGameState();
}
class _MemoryMatchGameState extends State<MemoryMatchGame> {
  List<Color> colors = [Colors.red, Colors.blue, Colors.green, Colors.yellow];
  int? targetIdx;
  bool isMemorizing = true;

  @override
  void initState() {
    super.initState();
    startNewRound();
  }

  void startNewRound() {
    setState(() {
      isMemorizing = true;
      targetIdx = Random().nextInt(4);
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) { setState(() => isMemorizing = false); }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Memory Match")),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(isMemorizing ? "INGAT WARNA INI!" : "MANA WARNANYA?", style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          isMemorizing 
            ? Container(width: 100, height: 100, decoration: BoxDecoration(color: colors[targetIdx!], borderRadius: BorderRadius.circular(10)))
            : Wrap(spacing: 20, runSpacing: 20, children: List.generate(4, (i) => GestureDetector(
                onTap: () {
                  if (i == targetIdx) { startNewRound(); }
                },
                child: Container(width: 80, height: 80, decoration: BoxDecoration(color: colors[i], borderRadius: BorderRadius.circular(10))),
              ))),
        ]),
      ),
    );
  }
}

class MathQuizGame extends StatefulWidget {
  const MathQuizGame({super.key});
  @override
  State<MathQuizGame> createState() => _MathQuizGameState();
}
class _MathQuizGameState extends State<MathQuizGame> {
  int a = Random().nextInt(10), b = Random().nextInt(10), score = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Math Quick")),
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("Skor: $score", style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 20),
        Text("$a + $b = ?", style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
        const SizedBox(height: 40),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ElevatedButton(onPressed: () => check(a + b), child: Text("${a + b}")),
          ElevatedButton(onPressed: () => check(a + b + 2), child: Text("${a + b + 2}")),
        ]),
      ])),
    );
  }
  void check(int ans) {
    if (ans == a + b) score++;
    setState(() { a = Random().nextInt(10); b = Random().nextInt(10); });
  }
}

class ColorTapGame extends StatefulWidget {
  const ColorTapGame({super.key});
  @override
  State<ColorTapGame> createState() => _ColorTapGameState();
}
class _ColorTapGameState extends State<ColorTapGame> {
  int targetIdx = Random().nextInt(4);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Color Tap")),
      body: GridView.builder(
        padding: const EdgeInsets.all(40),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
        itemCount: 4,
        itemBuilder: (ctx, i) => GestureDetector(
          onTap: () { if(i == targetIdx) setState(() => targetIdx = Random().nextInt(4)); },
          child: Container(color: i == targetIdx ? Colors.cyanAccent : Colors.cyan.withAlpha(51)),
        ),
      ),
    );
  }
}

class ClickerGame extends StatefulWidget {
  const ClickerGame({super.key});
  @override
  State<ClickerGame> createState() => _ClickerGameState();
}
class _ClickerGameState extends State<ClickerGame> {
  int clicks = 0;
  bool active = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Clicker Race")),
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("$clicks", style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(shape: const CircleBorder(), padding: const EdgeInsets.all(50)),
          onPressed: () => setState(() => clicks++),
          child: const Text("TAP!"),
        ),
        const SizedBox(height: 20),
        TextButton(onPressed: () => setState(() => clicks = 0), child: const Text("Reset"))
      ])),
    );
  }
}

class ReactionGame extends StatefulWidget {
  const ReactionGame({super.key});
  @override
  State<ReactionGame> createState() => _ReactionGameState();
}
class _ReactionGameState extends State<ReactionGame> {
  String status = "TEKAN START";
  Color bgColor = const Color(0xFF1A1A2E);
  Stopwatch watch = Stopwatch();
  bool waiting = false;

  void start() {
    setState(() { status = "TUNGGU HIJAU..."; bgColor = Colors.red; waiting = true; });
    Timer(Duration(seconds: Random().nextInt(3) + 2), () {
      if (mounted && waiting) {
        setState(() { bgColor = Colors.green; status = "TAP SEKARANG!"; });
        watch.start();
      }
    });
  }

  void tap() {
    if (bgColor == Colors.green) {
      watch.stop();
      setState(() { status = "Waktu kamu: ${watch.elapsedMilliseconds}ms"; bgColor = const Color(0xFF1A1A2E); waiting = false; });
      watch.reset();
    } else if (waiting) {
      setState(() { status = "TERLALU CEPAT!"; bgColor = const Color(0xFF1A1A2E); waiting = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: waiting ? tap : start,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(title: const Text("Reaction Test"), backgroundColor: Colors.transparent),
        body: Center(child: Text(status, textAlign: TextAlign.center, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
      ),
    );
  }
}

class WhackAMoleGame extends StatefulWidget {
  const WhackAMoleGame({super.key});
  @override State<WhackAMoleGame> createState() => _WhackAMoleGameState();
}
class _WhackAMoleGameState extends State<WhackAMoleGame> {
  int moleIdx = Random().nextInt(9); int score = 0;
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Score: $score")),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: 9,
        itemBuilder: (ctx, i) => GestureDetector(
          onTap: () { if (i == moleIdx) setState(() { score++; moleIdx = Random().nextInt(9); }); },
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: Colors.white10, shape: BoxShape.circle),
            child: i == moleIdx ? const Icon(Icons.face, size: 40, color: Colors.brown) : null,
          ),
        ),
      ),
    );
  }
}

class SnakeGame extends StatefulWidget {
  const SnakeGame({super.key});
  @override State<SnakeGame> createState() => _SnakeGameState();
}
class _SnakeGameState extends State<SnakeGame> {
  int snake = 45; int food = Random().nextInt(100); int score = 0;
  void move(int dir) {
    setState(() {
      snake += dir;
      if (snake < 0) snake += 100; if (snake >= 100) snake -= 100;
      if (snake == food) { score++; food = Random().nextInt(100); }
    });
  }
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Score: $score")),
      body: Column(children: [
        Expanded(child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 10),
          itemCount: 100,
          itemBuilder: (ctx, i) => Container(margin: const EdgeInsets.all(1), color: i == snake ? Colors.green : (i == food ? Colors.red : Colors.white10)),
        )),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => move(-1)),
          Column(children: [IconButton(icon: const Icon(Icons.arrow_upward), onPressed: () => move(-10)), IconButton(icon: const Icon(Icons.arrow_downward), onPressed: () => move(10))]),
          IconButton(icon: const Icon(Icons.arrow_forward), onPressed: () => move(1)),
        ]),
        const SizedBox(height: 20),
      ]),
    );
  }
}

class DiceGame extends StatefulWidget {
  const DiceGame({super.key});
  @override State<DiceGame> createState() => _DiceGameState();
}
class _DiceGameState extends State<DiceGame> {
  int dice = 1;
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dice Roller")),
      body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.filter_frames, size: 100, color: Colors.white24),
        Text("$dice", style: const TextStyle(fontSize: 120, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
        const SizedBox(height: 40),
        ElevatedButton(onPressed: () => setState(() => dice = Random().nextInt(6) + 1), child: const Text("ROLL DICE", style: TextStyle(fontSize: 20))),
      ])),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> _foundGames = [];
  @override
  void initState() {
    _foundGames = allGames;
    super.initState();
  }

  void _runFilter(String keyword) {
    setState(() {
      _foundGames = allGames.where((game) => game["name"].toLowerCase().contains(keyword.toLowerCase())).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CARI GAME")),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              onChanged: _runFilter,
              decoration: InputDecoration(
                labelText: 'Ketik nama game...',
                filled: true,
                fillColor: Colors.white10,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                suffixIcon: const Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _foundGames.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundGames.length,
                      itemBuilder: (ctx, i) => ListTile(
                        leading: Icon(_foundGames[i]['icon'], color: _foundGames[i]['color']),
                        title: Text(_foundGames[i]['name']),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => _foundGames[i]['page'])),
                      ),
                    )
                  : const Center(child: Text("Game tidak ditemukan")),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String userName = "Gamer Pro";
  String userEmail = "gamerpro@email.com";
  String userAlamat = "Jakarta, Indonesia";
  String userPhone = "08123456789";

  void _editProfile(String title, String currentValue, Function(String) onSave) {
    TextEditingController controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit $title"),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: "Masukkan $title baru"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
          ElevatedButton(
            onPressed: () {
              setState(() {
                onSave(controller.text);
              });
              Navigator.pop(context);
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SETTINGS & PROFILE", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.cyanAccent,
                child: Icon(Icons.person, size: 60, color: Colors.black),
              ),
            ),
            const SizedBox(height: 30),

            _buildProfileItem("Nama", userName, Icons.person_outline, (val) => userName = val),
            _buildProfileItem("Email", userEmail, Icons.email_outlined, (val) => userEmail = val),
            _buildProfileItem("Alamat", userAlamat, Icons.map_outlined, (val) => userAlamat = val),
            _buildProfileItem("No. HP", userPhone, Icons.phone_android_outlined, (val) => userPhone = val),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const GetStartedPage()),
                  (r) => false,
                ),
                icon: const Icon(Icons.logout),
                label: const Text("LOGOUT", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(String label, String value, IconData icon, Function(String) onSave) {
    return Card(
      color: Colors.white.withAlpha(10),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.cyanAccent),
        title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
        trailing: IconButton(
          icon: const Icon(Icons.edit, size: 20, color: Colors.cyanAccent),
          onPressed: () => _editProfile(label, value, onSave),
        ),
      ),
    );
  }
}