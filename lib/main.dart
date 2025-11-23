// lib/main.dart (versi final dengan Provider)
import 'package:book_journey/providers/theme_provider.dart';
import 'package:book_journey/screens/login_screen.dart';
import 'package:book_journey/screens/home_screen.dart';
import 'package:book_journey/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final authService = AuthService();

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
      home: FutureBuilder(
        future: authService.isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          bool? loggedIn = snapshot.data;
          return loggedIn == true ? const HomeScreen() : const LoginScreen();
        },
      ),
    );
  }
}