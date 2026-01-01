import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  // Sekarang menerima parameter lat dan lon
  Future<String> fetchWeather(double lat, double lon) async {
    try {
      final url = Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current_weather=true');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final temp = data['current_weather']['temperature'];
        return "$temp°C";
      } else {
        return "Gagal memuat cuaca";
      }
    } catch (e) {
      return "Offline";
    }
  }
}