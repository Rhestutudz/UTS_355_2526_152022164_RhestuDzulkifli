import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({super.key});

  @override
  _KalkulatorPageState createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  String userInput = '';
  String result = '0';

  final List<String> buttons = [
    'AC', '⌫', '%', '÷',
    '7', '8', '9', '×',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '0', '.', '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🌈 Gradasi latar belakang biru muda ke putih
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF87CEFA), // biru muda
              Color(0xFF00B4DB), // biru toska
              Colors.white, // putih lembut
            ],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Kalkulator',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 15),

              // 📟 Display input dan hasil
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                alignment: Alignment.centerRight,
                child: Text(
                  userInput,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 28,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                alignment: Alignment.centerRight,
                child: Text(
                  result,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Divider(color: Colors.white38),

              // 🔢 Grid tombol kalkulator
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      final button = buttons[index];
                      final isOperator = (button == '÷' ||
                          button == '×' ||
                          button == '-' ||
                          button == '+' ||
                          button == '=' ||
                          button == '%');

                      return ElevatedButton(
                        onPressed: () => _handleButtonPress(button),
                        style: ElevatedButton.styleFrom(
                          elevation: 3,
                          backgroundColor: _getButtonColor(button, isOperator),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(10),
                        ),
                        child: Text(
                          button,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: _getTextColor(button, isOperator),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getButtonColor(String button, bool isOperator) {
    if (button == 'AC') return Colors.redAccent;
    if (button == '⌫') return Colors.orangeAccent;
    if (isOperator) return Colors.blueAccent;
    return Colors.white;
  }

  Color _getTextColor(String button, bool isOperator) {
    if (button == 'AC' || button == '⌫' || isOperator) return Colors.white;
    return Colors.black87;
  }

  // Fungsi ketika tombol ditekan
  void _handleButtonPress(String button) {
    setState(() {
      if (button == 'AC') {
        userInput = '';
        result = '0';
      } else if (button == '⌫') {
        userInput = userInput.isNotEmpty
            ? userInput.substring(0, userInput.length - 1)
            : '';
      } else if (button == '=') {
        _calculateResult();
      } else {
        userInput += button;
      }
    });
  }

  // 🔢 Hitung hasil kalkulasi
  void _calculateResult() {
    String expression = userInput;
    expression = expression.replaceAll('×', '*');
    expression = expression.replaceAll('÷', '/');

    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      setState(() {
        result = eval.toString();
      });
    } catch (e) {
      setState(() {
        result = 'Error';
      });
    }
  }
}
