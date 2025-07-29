import 'package:flutter/material.dart';
import 'kalkulator.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  // Store registered users (in a real app, you'd want to use secure storage)
  static final Map<String, String> registeredUsers = {'admin': 'admin'};

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Animation controller untuk text animation
  late AnimationController _textAnimationController;
  late Animation<double> _textAnimation;

  // Animation controller untuk eye blink
  late AnimationController _eyeBlinkController;
  late Animation<double> _eyeBlinkAnimation;

  // Variables untuk text animation
  bool _showXiText = false;
  String _currentText = "こんにちは!";

  // Variable untuk show/hide password
  bool _isPasswordVisible = false;

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

    // Setup eye blink animation controller
    _eyeBlinkController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _eyeBlinkAnimation = Tween<double>(begin: 1.0, end: 0.1).animate(
      CurvedAnimation(parent: _eyeBlinkController, curve: Curves.easeInOut),
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
      _currentText = _showXiText ? "Kalkulator Sederhana" : "こんにちは!";
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

  void _togglePasswordVisibility() async {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });

    // Animate eye blink
    await _eyeBlinkController.forward();
    await _eyeBlinkController.reverse();
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
    _eyeBlinkController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Important: memungkinkan resize ketika keyboard muncul
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
          child: SingleChildScrollView(
            // Wrap dengan SingleChildScrollView
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight:
                    MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom -
                    40, // 40 untuk padding
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(flex: 1, child: SizedBox()),
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
                    const SizedBox(height: 30), // Dikurangi dari 40
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
                                fontSize: 28, // Dikurangi dari 32
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
                    const SizedBox(height: 40), // Dikurangi dari 50
                    // Username Field
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha((0.1 * 255).toInt()),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
                          hintText: "Username",
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 158, 158, 158),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(20),
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
                            color: Colors.black.withAlpha((0.1 * 255).toInt()),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.blue,
                          ),
                          suffixIcon: AnimatedBuilder(
                            animation: _eyeBlinkAnimation,
                            builder: (context, child) {
                              return IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Color.fromARGB(
                                    (255 * _eyeBlinkAnimation.value).toInt(),
                                    33,
                                    150,
                                    243,
                                  ), // same as Colors.blue
                                ),
                                onPressed: _togglePasswordVisibility,
                              );
                            },
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 158, 158, 158),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30), // Dikurangi dari 40
                    // Login Button
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          final String username = _usernameController.text;
                          final String password = _passwordController.text;

                          if (LoginPage.registeredUsers.containsKey(username) &&
                              LoginPage.registeredUsers[username] == password) {
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
                    const SizedBox(height: 20),
                    // Register Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "having no account yet? ",
                          style: TextStyle(color: Colors.white70),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "click here!",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Expanded(flex: 1, child: SizedBox()),
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
