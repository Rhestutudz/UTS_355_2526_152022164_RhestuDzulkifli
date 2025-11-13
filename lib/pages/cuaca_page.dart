import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class CuacaPage extends StatefulWidget {
  const CuacaPage({super.key});

  @override
  State<CuacaPage> createState() => _CuacaPageState();
}

class _CuacaPageState extends State<CuacaPage> {
  String kondisi = "";
  String suhu = "";
  String lokasi = "Bandung, Jawa Barat";
  String animasi = "assets/cuaca/Weather-sunny.json";
  Color warnaLatar = Colors.lightBlue[50]!;

  @override
  void initState() {
    super.initState();
    _aturCuacaBerdasarkanWaktu();
  }

  void _aturCuacaBerdasarkanWaktu() {
    final now = DateTime.now();
    int jam = now.hour;

    if (jam >= 5 && jam < 11) {
      // Pagi
      setState(() {
        kondisi = "Cerah Pagi 🌅";
        suhu = "24°C";
        animasi = "assets/cuaca/morning.json";
        warnaLatar = Colors.lightBlue.shade100;
      });
    } else if (jam >= 11 && jam < 16) {
      // Siang
      setState(() {
        kondisi = "Cerah Terik ☀️";
        suhu = "30°C";
        animasi = "assets/cuaca/Weather-sunny.json";
        warnaLatar = Colors.blue.shade200;
      });
    } else if (jam >= 16 && jam < 18) {
      // Sore
      setState(() {
        kondisi = "Berawan Sore 🌤️";
        suhu = "26°C";
        animasi = "assets/cuaca/cloudy.json";
        warnaLatar = Colors.orange.shade100;
      });
    } else {
      // Malam
      setState(() {
        kondisi = "Langit Malam 🌙";
        suhu = "22°C";
        animasi = "assets/cuaca/night.json";
        warnaLatar = Colors.indigo.shade200;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warnaLatar,
      appBar: AppBar(
        title: const Text('Cuaca Hari Ini'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 144, 209, 249),
        elevation: 4,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Animasi Cuaca
              Lottie.asset(animasi, height: 200),

              const SizedBox(height: 10),

              // Suhu
              Text(
                suhu,
                style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                kondisi,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 20),

              // Lokasi
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.location_on, color: Colors.redAccent),
                  Text(
                    lokasi,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Informasi tambahan
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: const [
                    WeatherInfo(
                      icon: Icons.air,
                      label: "Kecepatan Angin",
                      value: "12 km/h",
                    ),
                    WeatherInfo(
                      icon: Icons.opacity,
                      label: "Kelembapan",
                      value: "68%",
                    ),
                    WeatherInfo(
                      icon: Icons.thermostat,
                      label: "Tekanan Udara",
                      value: "1015 hPa",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Prakiraan Singkat
              Card(
                color: Colors.white,
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        "Prakiraan Hari Ini",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _deskripsiPrakiraan(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk deskripsi sesuai waktu
  String _deskripsiPrakiraan() {
    final hour = DateTime.now().hour;
    if (hour >= 5 && hour < 11) {
      return "Pagi hari ini cerah dan sejuk. Cocok untuk olahraga ringan di luar ruangan!";
    } else if (hour >= 11 && hour < 16) {
      return "Cuaca siang ini cukup panas, pastikan kamu minum air putih yang cukup ya 💧.";
    } else if (hour >= 16 && hour < 18) {
      return "Sore hari ini berawan ringan, suasana nyaman untuk bersantai sambil minum kopi ☕.";
    } else {
      return "Malam ini langit cerah dengan suhu dingin. Waktunya istirahat dan recharge energi 😴.";
    }
  }
}

// Widget info tambahan
class WeatherInfo extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const WeatherInfo({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(width: 12),
          Text(
            "$label: ",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
