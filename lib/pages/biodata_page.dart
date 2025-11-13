import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BiodataPage extends StatefulWidget {
  const BiodataPage({super.key});

  @override
  State<BiodataPage> createState() => _BiodataPageState();
}

class _BiodataPageState extends State<BiodataPage> {
  // Data biodata yang bisa di-edit
  String nama = 'Rhestu Dzulkifli';
  String nim = '152022164';
  String prodi = 'Teknik Informatika';
  String semester = '7';
  String ttl = 'Garut, 27 Januari 2004';
  String hobi = 'Bermain Game dan Analisis Data';

  // Controller untuk form edit
  late TextEditingController _namaC;
  late TextEditingController _nimC;
  late TextEditingController _prodiC;
  late TextEditingController _semesterC;
  late TextEditingController _ttlC;
  late TextEditingController _hobiC;

  @override
  void initState() {
    super.initState();
    _namaC = TextEditingController(text: nama);
    _nimC = TextEditingController(text: nim);
    _prodiC = TextEditingController(text: prodi);
    _semesterC = TextEditingController(text: semester);
    _ttlC = TextEditingController(text: ttl);
    _hobiC = TextEditingController(text: hobi);
  }

  @override
  void dispose() {
    _namaC.dispose();
    _nimC.dispose();
    _prodiC.dispose();
    _semesterC.dispose();
    _ttlC.dispose();
    _hobiC.dispose();
    super.dispose();
  }

  // 🔧 bottom sheet untuk edit biodata
  void _showEditBiodata() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            top: 16,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Edit Biodata',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _namaC,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                TextField(
                  controller: _nimC,
                  decoration: const InputDecoration(
                    labelText: 'NIM',
                    prefixIcon: Icon(Icons.credit_card),
                  ),
                ),
                TextField(
                  controller: _prodiC,
                  decoration: const InputDecoration(
                    labelText: 'Program Studi',
                    prefixIcon: Icon(Icons.school),
                  ),
                ),
                TextField(
                  controller: _semesterC,
                  decoration: const InputDecoration(
                    labelText: 'Semester',
                    prefixIcon: Icon(Icons.menu_book),
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _ttlC,
                  decoration: const InputDecoration(
                    labelText: 'Tempat, Tanggal Lahir',
                    prefixIcon: Icon(Icons.cake),
                  ),
                ),
                TextField(
                  controller: _hobiC,
                  decoration: const InputDecoration(
                    labelText: 'Hobi',
                    prefixIcon: Icon(Icons.videogame_asset),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        nama = _namaC.text;
                        nim = _nimC.text;
                        prodi = _prodiC.text;
                        semester = _semesterC.text;
                        ttl = _ttlC.text;
                        hobi = _hobiC.text;
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Biodata berhasil diperbarui')),
                      );
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Simpan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00B4DB),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            // 🌈 Background gradient penuh
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF00B4DB),
                    Color(0xFF0083B0),
                    Color(0xFFFFFFFF),
                  ],
                  stops: [0.0, 0.65, 1.0],
                ),
              ),
            ),

            // 🌊 Gelombang lembut
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: 180,
                  color: Colors.white.withOpacity(0.15),
                ),
              ),
            ),

            // 📱 Konten utama
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text(
                      '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Biodata Saya',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 25),

                    // 👤 Foto Profil
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage: AssetImage('assets/PP.jpg'),
                      ),
                    ),
                    const SizedBox(height: 15),

                    // 🧾 Nama dan Deskripsi
                    Text(
                      nama,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Mahasiswa Informatika - ITENAS Bandung',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 25),

                    // 📋 Card Biodata
                    Container(
                      padding: const EdgeInsets.all(18),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255)
                            .withOpacity(0.95),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InfoRow(
                              icon: Icons.person,
                              label: 'Nama Lengkap',
                              value: nama),
                          InfoRow(
                              icon: Icons.credit_card,
                              label: 'NIM',
                              value: nim),
                          InfoRow(
                              icon: Icons.school,
                              label: 'Program Studi',
                              value: prodi),
                          InfoRow(
                              icon: Icons.menu_book,
                              label: 'Semester',
                              value: semester),
                          InfoRow(
                              icon: Icons.cake,
                              label: 'Tempat, Tanggal Lahir',
                              value: ttl),
                          InfoRow(
                              icon: Icons.videogame_asset,
                              label: 'Hobi',
                              value: hobi),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),

        // ✏️ Tombol edit (ikon pensil) di kanan bawah
        floatingActionButton: FloatingActionButton(
          onPressed: _showEditBiodata,
          backgroundColor: const Color(0xFF00B4DB),
          child: const Icon(Icons.edit, color: Colors.white),
        ),
      ),
    );
  }
}

// 🧩 Widget Info Row
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.lightBlueAccent),
          const SizedBox(width: 12),
          Expanded(
            flex: 3,
            child: Text(
              "$label:",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              value,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}

// 🌊 Custom clipper untuk efek gelombang
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40);
    final firstControlPoint = Offset(size.width / 4, size.height);
    final firstEndPoint = Offset(size.width / 2, size.height - 40);
    final secondControlPoint = Offset(3 * size.width / 4, size.height - 80);
    final secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
