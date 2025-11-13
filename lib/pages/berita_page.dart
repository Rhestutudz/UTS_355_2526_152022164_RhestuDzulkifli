import 'package:flutter/material.dart';

class BeritaPage extends StatelessWidget {
  const BeritaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 🌈 Gradasi warna biru muda - putih
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: const [
                SizedBox(height: 10),
                Text(
                  "Berita Terkini",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 20),
                NewsCard(
                  title: "Penyaluran Bantuan Untuk Pekerja Informal",
                  subtitle:
                      "Membantu masyarakat dengan program bantuan gizi yang lebih sehat.",
                  imagePath: "assets/berita/axisxmeliora.jpg",
                  color: Color(0xFFFFCDD2), // pink muda
                ),
                NewsCard(
                  title: "Kisah Inspiratif Minggu Ini",
                  subtitle:
                      "Dari Perahu Ini Bangkit Cita-Cita yang Tertangguh di Tengah Badai.",
                  imagePath: "assets/berita/berdendangberdanska.jpg",
                  color: Color(0xFFFFAB91), // oranye lembut
                ),
                NewsCard(
                  title: "Senang Rasanya Kalau Caca Punya Sepeda Baru",
                  subtitle:
                      "Bantuan kecil yang membawa kebahagiaan besar bagi anak-anak.",
                  imagePath: "assets/berita/fanstasticfest.jpg",
                  color: Color(0xFFF8BBD0), // merah muda pastel
                ),
                NewsCard(
                  title: "Sahabat Unggulan Untuk Membantu Pak John",
                  subtitle:
                      "Program sosial terbaru dari PLN Icon Plus yang berfokus pada masyarakat desa.",
                  imagePath: "assets/berita/smilemotion.jpg",
                  color: Color(0xFFB3E5FC), // biru muda
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewsCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final Color color;

  const NewsCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.color,
  });

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();

    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeIn,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget.color.withOpacity(0.9),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📸 Gambar berita
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                widget.imagePath,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 14),

            // 📰 Teks berita
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Baca selengkapnya tentang: ${widget.title}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.blueAccent,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                    ),
                    child: const Text("Baca Selengkapnya"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
