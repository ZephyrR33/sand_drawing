import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Запрещаем альбомную ориентацию (только портрет)
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sand Drawing',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 94, 83, 112),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Sand Drawing'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Данные для карусели
  final List<String> images = [
    'assets/main.png',
    'assets/back.png',
    'assets/future.png',
  ];
  final List<String> titles = [
    'Manuka',
    'Abundance',
    'Sacred Geometry',
  ];

  // Индекс активного элемента карусели
  int _carouselIndex = 0;

  // Индекс нижнего меню
  int _navIndex = 0;

  // Значения слайдеров
  double speedValue = 0.5;
  double brightnessValue = 0.7;

  // Цвет нижнего меню
  final Color _bottomNavColor = const Color.fromRGBO(100, 100, 100, 1);

  // Для переключения кнопки Light (картинки)
  bool _isLightOn = false;

  @override
  Widget build(BuildContext context) {
    // Процент (для примера)
    final double percentage = ((_carouselIndex + 1) / images.length) * 100;

    return Scaffold(
      // Без appBar
      appBar: null,

      body: Stack(
        children: [
          ///
          /// Вогнутый фон вверху
          ///
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipPath(
              clipper: InvertedHalfCircleClipper(),
              child: Container(
                height: 250,
                color: const Color.fromRGBO(41, 41, 41, 1),
              ),
            ),
          ),

          ///
          /// Лого (по центру сверху)
          ///
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Center(
              child: ClipOval(
                child: Image.asset(
                  'assets/logo.png',
                  width: 200,
                  height: 200,
                ),
              ),
            ),
          ),

          ///
          /// Кнопка On/Off (слева вверху)
          ///
          Positioned(
            top: 60,
            left: 40,
            child: InkWell(
              onTap: () {},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/on_off.png',
                  width: 40,
                  height: 40,
                ),
              ),
            ),
          ),

          ///
          /// Основной контент с прокруткой
          ///
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ///
                  /// Карусель
                  ///
                  CarouselSlider(
                    items: images.asMap().entries.map((entry) {
                      final index = entry.key;
                      final image = entry.value;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: Stack(
                          children: [
                            // Картинка
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // Лайк только на активном элементе
                            if (index == _carouselIndex)
                              Positioned(
                                top: 8,
                                right: 8,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    // Действие при нажатии лайка
                                  },
                                ),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 200, // Высота карусели
                      viewportFraction: 0.625, // Показываем 1.6 элемента
                      enableInfiniteScroll: true,
                      autoPlay: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _carouselIndex = index;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  ///
                  /// Проценты + Название
                  ///
                  Text(
                    '${percentage.toInt()}%',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    titles[_carouselIndex],
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 20),

                  ///
                  /// Кнопки плеера + подписи под ними
                  ///
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Play
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.play_arrow),
                            color: Colors.white,
                            iconSize: 30,
                            onPressed: () {},
                          ),
                          const Text(
                            'Play',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      // Stop
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.stop),
                            color: Colors.white,
                            iconSize: 30,
                            onPressed: () {},
                          ),
                          const Text(
                            'Stop',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      // Repeat
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.loop),
                            color: Colors.white,
                            iconSize: 30,
                            onPressed: () {},
                          ),
                          const Text(
                            'Repeat',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),

                      // Shuffle
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.shuffle),
                            color: Colors.white,
                            iconSize: 30,
                            onPressed: () {},
                          ),
                          const Text(
                            'Shuffle',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  ///
                  /// Слайдер Speed
                  ///
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Speed',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Slider(
                            min: 0,
                            max: 1,
                            value: speedValue,
                            activeColor: Colors.greenAccent,
                            inactiveColor: Colors.white24,
                            onChanged: (v) {
                              setState(() {
                                speedValue = v;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  ///
                  /// Слайдер Brightness + Кнопка Light (картинка)
                  /// Кнопка Light у правого края, не укорачивает слайдер
                  ///
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    child: Stack(
                      children: [
                        // 1) надпись + слайдер (слева)
                        Positioned(
                          left: 40,
                          top: 0,
                          bottom: 0,
                          right: 80,
                          child: Row(
                            children: [
                              const Text(
                                'Brightness',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Slider(
                                  min: 0,
                                  max: 1,
                                  value: brightnessValue,
                                  activeColor: Colors.greenAccent,
                                  inactiveColor: Colors.white24,
                                  onChanged: (v) {
                                    setState(() {
                                      brightnessValue = v;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),

                        // 2) Кнопка Light (две картинки на выбор)
                        Positioned(
                          right: 0,
                          top: 10,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isLightOn = !_isLightOn;
                              });
                            },
                            child: Image.asset(
                              _isLightOn
                                  ? 'assets/light-on.png'
                                  : 'assets/light-off.png',
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),

      ///
      /// Нижняя панель
      ///
      bottomNavigationBar: Container(
        height: 70,
        color: _bottomNavColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              icon: Icons.play_circle_fill,
              label: 'Player',
              index: 0,
            ),
            _buildNavItem(
              icon: Icons.view_module,
              label: 'Playlist',
              index: 1,
            ),
            _buildNavItem(
              icon: Icons.filter_vintage,
              label: 'Patterns',
              index: 2,
            ),
            _buildNavItem(
              icon: Icons.settings,
              label: 'Settings',
              index: 3,
            ),
          ],
        ),
      ),

      backgroundColor: const Color.fromRGBO(34, 35, 34, 1),
    );
  }

  ///
  /// Элемент нижнего меню
  ///
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isSelected = (index == _navIndex);
    return GestureDetector(
      onTap: () {
        setState(() {
          _navIndex = index;
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.greenAccent : Colors.white,
            size: 30,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.greenAccent : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

///
/// Клиппер для вогнутого полукруга (вверху)
///
class InvertedHalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.4);
    path.quadraticBezierTo(
      size.width / 2,
      size.height * 0.9 + 20,
      size.width,
      size.height * 0.4,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
