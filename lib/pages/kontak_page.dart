import 'package:flutter/material.dart';

class KontakPage extends StatelessWidget {
  final List<Map<String, String>> kontak = List.generate(15, (i) => {
        "nama": "Teman ${i + 1}",
        "telepon": "08123${i}56789"
      });

  KontakPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🌈 Gradasi latar belakang biru muda ke putih
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF87CEFA), // biru muda
              Color(0xFF00B4DB), // biru toska
              Colors.white,      // putih lembut
            ],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 15),
              const Text(
                "Daftar Kontak",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: kontak.length,
                  itemBuilder: (context, index) {
                    final contact = kontak[index];
                    return Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.white.withOpacity(0.9),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.lightBlueAccent,
                          radius: 25,
                          child: Text(
                            contact["nama"]![0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          contact["nama"]!,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        subtitle: Text(
                          contact["telepon"]!,
                          style: const TextStyle(color: Colors.black54),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.phone, color: Colors.blueAccent),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Memanggil ${contact["nama"]!}..."),
                                backgroundColor: Colors.blueAccent,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
