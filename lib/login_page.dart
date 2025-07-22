import 'package:flutter/material.dart';
import 'kalkulator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Animation controller untuk text animation
  late AnimationController _textAnimationController;
  late Animation<double> _textAnimation;

  // Variables untuk text animation
  bool _showXiText = false;
  String _currentText = "Install Arch Kids!";

  @override
  void initState() {
    super.initState();

    // Setup animation controller (lebih smooth dan lambat)
    _textAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1050), // lebih lambat
      vsync: this,
    );

    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textAnimationController,
        curve: Curves.easeInOutCubic, // curve lebih smooth
      ),
    );

    // Start the looping animation
    _startTextAnimation();
  }

  void _startTextAnimation() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _animateText();
      }
    });
  }

  void _animateText() async {
    if (!mounted) return;

    // Animate out current text
    await _textAnimationController.forward();

    if (!mounted) return;

    // Change text and style
    setState(() {
      _showXiText = !_showXiText;
      _currentText = _showXiText
          ? "Kalkulator Sederhana"
          : "Install Arch Kids!";
    });

    // Animate in new text
    await _textAnimationController.reverse();

    // Continue looping
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _animateText();
      }
    });
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _textAnimationController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
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
            colors: [Color(0xFF42A5F5), Color(0xFF1565C0)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 1),
                // Logo
                Container(
                  width: 120,
                  height: 120,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/archlogo.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      // Fallback jika image tidak ditemukan
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.computer,
                          size: 60,
                          color: Colors.blue,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Animated Text (fixed)
                AnimatedBuilder(
                  animation: _textAnimation,
                  builder: (context, child) {
                    return AnimatedOpacity(
                      opacity: 1.0 - _textAnimation.value,
                      duration: const Duration(
                        milliseconds: 700,
                      ), // lebih lambat
                      curve: Curves.easeInOutCubic,
                      child: AnimatedScale(
                        scale: 1.0 - (_textAnimation.value * 0.1),
                        duration: const Duration(
                          milliseconds: 700,
                        ), // lebih lambat
                        curve: Curves.easeInOutCubic,
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(
                            milliseconds: 700,
                          ), // lebih lambat
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: _showXiText
                                ? FontWeight.w300
                                : FontWeight.bold,
                            letterSpacing: _showXiText ? 2.0 : 0.0,
                          ),
                          child: Text(
                            _currentText,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                const Text(
                  "Please sign in to continue",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 50),
                // Username Field
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person, color: Colors.blue),
                      hintText: "Username",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(20),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Password Field
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.blue),
                      hintText: "Password",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(20),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Login Button
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      final String username = _usernameController.text;
                      final String password = _passwordController.text;

                      if (username == 'admin' && password == 'admin') {
                        // Navigasi ke KalkulatorPage setelah login sukses
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const KalkulatorPage(),
                          ),
                        );
                      } else {
                        _showSnackBar('Login gagal.', Colors.red);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
