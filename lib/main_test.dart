import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrollbar test',
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Scrollbar test'),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 700),
                        child: Scrollbar(
                          thumbVisibility: true,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: ListView(
                              clipBehavior: Clip.none,
                              children: List.generate(
                                20,
                                (index) => const SizedBox(
                                  height: 50,
                                  child: Card(
                                    child: Text('Test'),
                                  ),
                                ),
                              ).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  color: Colors.blueGrey,
                  height: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
