// lib/screens/explore_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/weather_service.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _weather = "Loading...";
  String _locationStatus = "Mencari lokasi...";

  final List<Map<String, dynamic>> _bookstores = [
    {"name": "Gramedia Matraman", "address": "Jl. Matraman Raya No.46", "lat": -6.2029751, "lng": 106.8562622},
    {"name": "Kinokuniya Plaza Senayan", "address": "Plaza Senayan Lt. 3", "lat": -6.225385248116257, "lng": 106.79913896381676},
    {"name": "Periplus Citywalk Sudirman", "address": "Citywalk Sudirman Lt. GF", "lat": -6.22428, "lng": 106.80983},
    {"name": "Aksara Kemang", "address": "Jl. Kemang Raya No.8B", "lat": -6.256123819358625, "lng": 106.81465113030791},
    {"name": "Post Bookshop Pasar Santa", "address": "Pasar Santa Lt. Atas", "lat": -6.239609961830192, "lng": 106.81212249345934},
  ];

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  Future<void> _checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    _getWeatherData();
  }

  Future<void> _getWeatherData() async {
    try {
      final weatherService = Provider.of<WeatherService>(context, listen: false);
      Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      final result = await weatherService.fetchWeather(pos.latitude, pos.longitude);
      if (mounted) {
        setState(() {
          _weather = result;
          _locationStatus = "Lokasi Berhasil Terdeteksi";
        });
      }
    } catch (e) {
      if (mounted) setState(() => _weather = "GPS Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    // KUNCI DARK MODE: Gunakan Theme.of(context)
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Card Cuaca yang Dinamis
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark 
                      ? [Colors.blue[900]!, Colors.black] 
                      : [Colors.blue[700]!, Colors.blue[400]!],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(_weather, style: const TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
                  Text(_locationStatus, style: const TextStyle(color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Daftar Toko Buku
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _bookstores.length,
              itemBuilder: (context, index) {
                final store = _bookstores[index];
                return Card(
                  // Card akan otomatis berubah warna jika useMaterial3: true di main.dart
                  child: ListTile(
                    leading: const Icon(Icons.map, color: Colors.blue),
                    title: Text(store['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(store['address']),
                    trailing: IconButton(
                      icon: const Icon(Icons.directions_car),
                      onPressed: () async {
                        final url = Uri.parse("https://www.google.com/maps/search/?api=1&query=${store['lat']},${store['lng']}");
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.externalApplication);
                        }
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}