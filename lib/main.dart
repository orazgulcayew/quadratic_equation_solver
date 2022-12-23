import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const QuadraticEqSolverApp());
}

class QuadraticEqSolverApp extends StatefulWidget {
  const QuadraticEqSolverApp({super.key});

  @override
  State<QuadraticEqSolverApp> createState() => _QuadraticEqSolverAppState();
}

class _QuadraticEqSolverAppState extends State<QuadraticEqSolverApp> {
  bool isDark = false;
  bool hasError = false;

  double a = 0,
      b = 0,
      c = 0,
      discr = 0,
      root1 = 0,
      root2 = 0,
      res = 0,
      real = 0,
      imag = 0;

  final formKey = GlobalKey<FormState>();
  TextEditingController t1 = TextEditingController(text: '');
  TextEditingController t2 = TextEditingController(text: '');
  TextEditingController t3 = TextEditingController(text: '');

  String aText = "a";
  String bText = "+b";
  String cText = "+c";

  doGeneralQuadraticFormula() {
    try {
      setState(() {
        hasError = false;
        a = double.parse(t1.text);
        b = double.parse(t2.text);
        c = double.parse(t3.text);
        discr = b * b - 4 * a * c;
        real = -b / (2 * a);
        imag = sqrt(-discr) / (2 * a);

        if (discr > 0) {
          root1 = ((-1 * b) + sqrt(discr)) / (2 * a);
          root2 = ((-1 * b) - sqrt(discr)) / (2 * a);
        } else {
          root1 = real;
          root2 = imag;
        }
      });
    } catch (e) {
      setState(() {
        hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.indigo,
          brightness: isDark ? Brightness.dark : Brightness.light),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Text(
                'Kwadrat deňleme',
              ),
              const Spacer(),
              IconButton(
                  icon: Icon(
                    isDark
                        ? CupertinoIcons.moon_fill
                        : CupertinoIcons.sun_max_fill,
                    color:
                        isDark ? Colors.white.withOpacity(0.8) : Colors.amber,
                  ),
                  onPressed: () {
                    setState(() {
                      isDark = !isDark;
                    });
                  }),
            ],
          ),
        ),
        body: SingleChildScrollView(
          key: formKey,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            '${aText}x²${bText}x$cText = 0',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Deňlemäniň kökleri:',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'x₁ = $root1',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          'x₂ = $root2',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(height: 32),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'a:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Flexible(
                    child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'x²-kofissienti'),
                      controller: t1,
                      onChanged: (value) {
                        setState(() {
                          aText = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'b:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Flexible(
                    child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'x-kofissienti'),
                      controller: t2,
                      onChanged: (value) {
                        setState(() {
                          bText = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'c:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Flexible(
                    child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Hemişelik ululyk'),
                      controller: t3,
                      onChanged: (value) {
                        setState(() {
                          cText = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Visibility(
                visible: hasError,
                child: const Text(
                  "Girizilen deňleme nädogry!",
                  style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 247, 63, 63),
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  onPressed: () {
                    if (t1.text.isNotEmpty &&
                        t2.text.isNotEmpty &&
                        t3.text.isNotEmpty) {
                      doGeneralQuadraticFormula();
                    } else {
                      setState(() {
                        hasError = true;
                      });
                    }
                  },
                  color: Colors.indigo,
                  child: const Text('Deňlemäni çöz'),
                ),
              ),
              const Divider(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
