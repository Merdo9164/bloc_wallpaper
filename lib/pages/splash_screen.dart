import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //  Logo veya İkon
            Icon(Icons.connecting_airports, size: 100, color: Colors.white),
            const SizedBox(height: 20),

            //  Uygulama Adı
            const Text(
              "Wallpaper App",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 40),

            //  Yükleniyor İkonu
            const CircularProgressIndicator(color: Colors.white),
            const SizedBox(height: 10),

            const Text(
              "Yükleniyor...",
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
