import 'package:flutter/material.dart';

class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({super.key});

  @override
  State<KalkulatorPage> createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  final TextEditingController _angka1Controller = TextEditingController();
  final TextEditingController _angka2Controller = TextEditingController();
  String _selectedOperator = '+';
  String _hasil = '-';

  void _hitung() {
    double? angka1 = double.tryParse(_angka1Controller.text);
    double? angka2 = double.tryParse(_angka2Controller.text);
    if (angka1 == null || angka2 == null) {
      setState(() {
        _hasil = '-';
      });
      return;
    }
    double result;
    switch (_selectedOperator) {
      case '+':
        result = angka1 + angka2;
        break;
      case '-':
        result = angka1 - angka2;
        break;
      case '×':
        result = angka1 * angka2;
        break;
      case '÷':
        if (angka2 == 0) {
          setState(() {
            _hasil = '-';
          });
          return;
        }
        result = angka1 / angka2;
        break;
      default:
        result = 0;
    }

    String formattedResult = result % 1 == 0
        ? result.toInt().toString()
        : result.toStringAsFixed(2);
    setState(() {
      _hasil = formattedResult;
    });
  }

  @override
  void dispose() {
    _angka1Controller.dispose();
    _angka2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[400]!, Colors.blue[800]!],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Expanded(
                      child: Text(
                        "Kalkulator",
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
                const SizedBox(height: 40),
                _buildTextField(
                  controller: _angka1Controller,
                  label: 'Angka 1',
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _angka2Controller,
                  label: 'Angka 2',
                ),
                const SizedBox(height: 30),
                _buildOperatorButtons(),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Hasil: $_hasil',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return Container(
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
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(20),
          prefixIcon: const Icon(Icons.numbers, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _buildOperatorButtons() {
    final operators = ['+', '-', '×', '÷'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: operators.map((operator) {
        return ElevatedButton(
          onPressed: () {
            setState(() => _selectedOperator = operator);
            _hitung();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: _selectedOperator == operator
                ? Colors.white
                : Colors.blue[100],
            foregroundColor: Colors.blue[800],
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Text(operator, style: const TextStyle(fontSize: 24)),
        );
      }).toList(),
    );
  }
}
