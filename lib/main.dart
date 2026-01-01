import 'package:book_journey/providers/theme_provider.dart';
import 'package:book_journey/screens/login_screen.dart';
import 'package:book_journey/screens/home_screen.dart';
import 'package:book_journey/services/auth_service.dart';
import 'package:book_journey/services/database_helper.dart';
import 'package:book_journey/services/weather_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        // Dependency Injection: Service didaftarkan di sini
        Provider(create: (_) => AuthService()),
        Provider(create: (_) => DatabaseHelper.instance),
        Provider(create: (_) => WeatherService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    // Mengambil AuthService lewat Provider
    final authService = Provider.of<AuthService>(context, listen: false);

    return MaterialApp(
      title: 'Book Journey',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
      },
      home: FutureBuilder<bool>(
        future: authService.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          return snapshot.data == true ? const HomeScreen() : const LoginScreen();
        },
      ),
    );
  }
}