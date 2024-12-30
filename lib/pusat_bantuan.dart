import 'package:flutter/material.dart';

class PusatBantuanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pusat Bantuan'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Judul atau Deskripsi Umum
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Selamat datang di Pusat Bantuan! Berikut adalah beberapa topik yang sering ditanyakan.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Pertanyaan Umum (FAQ)
            ListTile(
              title: Text(
                '1. Bagaimana cara melakukan pemesanan?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'Ikuti langkah-langkah untuk memesan produk di toko kami.'),
              onTap: () {
                _showDetail(context, 'Cara Melakukan Pemesanan');
              },
            ),
            ListTile(
              title: Text(
                '2. Apa yang harus dilakukan jika pesanan saya tidak sampai?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle:
                  Text('Langkah-langkah untuk mengatasi masalah pengiriman.'),
              onTap: () {
                _showDetail(context, 'Pesanan Tidak Sampai');
              },
            ),
            ListTile(
              title: Text(
                '3. Bagaimana cara menggunakan kupon diskon?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Petunjuk penggunaan kode kupon pada pembelian.'),
              onTap: () {
                _showDetail(context, 'Penggunaan Kupon Diskon');
              },
            ),
            ListTile(
              title: Text(
                '4. Bagaimana cara menghubungi customer service?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Informasi kontak untuk customer service.'),
              onTap: () {
                _showDetail(context, 'Menghubungi Customer Service');
              },
            ),

            // Space for more questions or help topics
            SizedBox(height: 20),

            // Button untuk pergi ke halaman kontak
            ElevatedButton(
              onPressed: () {
                _showContactInfo(context);
              },
              child: Text('Hubungi Kami'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show detail of the selected FAQ
  void _showDetail(BuildContext context, String topic) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(topic),
          content: Text(
              'Ini adalah detail mengenai topik "$topic". Anda dapat memberikan informasi lebih lanjut tentang masalah atau pertanyaan ini di sini.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  // Function to show contact information
  void _showContactInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hubungi Kami'),
          content: Text(
              'Jika Anda membutuhkan bantuan lebih lanjut, Anda dapat menghubungi customer service kami di:\n\nEmail: supportcustomer@tokotas.com\nNomor Telepon: 179-185-0001\nJam Operasional: Senin - Jumat, 09:00 - 16:00'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
}
