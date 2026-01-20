import 'package:flutter/material.dart';

void main() {
  runApp(const GlowApp());
}

class GlowApp extends StatelessWidget {
  const GlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Glow App Dev',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.auto_awesome, size: 80, color: Colors.cyanAccent),
              SizedBox(height: 20),
              Text(
                'Glow App Inicializada',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text('Estructura Monorepo cargada correctamente'),
            ],
          ),
        ),
      ),
    );
  }
}
