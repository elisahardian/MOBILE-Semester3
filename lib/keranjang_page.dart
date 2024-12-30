import 'package:flutter/material.dart';

class KeranjangPage extends StatefulWidget {
  final List<Map<String, dynamic>> cart;
  final Function(Map<String, dynamic>) addToHistory;

  KeranjangPage({required this.cart, required this.addToHistory});

  @override
  _KeranjangPageState createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  // Fungsi untuk menghapus item dari keranjang
  void removeFromCart(int index) {
    setState(() {
      widget.cart.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item berhasil dihapus dari keranjang')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang Belanja'),
      ),
      body: widget.cart.isEmpty
          ? Center(child: Text('Keranjang Anda kosong'))
          : ListView.builder(
              itemCount: widget.cart.length,
              itemBuilder: (context, index) {
                final item = widget.cart[index];
                return ListTile(
                  leading: Image.network(
                    item['image'],
                    width: 50,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.error, color: Colors.red);
                    },
                  ),
                  title: Text(item['product']),
                  subtitle: Text('Harga: Rp ${item['price']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      removeFromCart(index); // Hapus item dari keranjang
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: widget.cart.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  // Tambahkan seluruh isi keranjang ke riwayat belanja
                  widget.cart.forEach((item) {
                    widget.addToHistory(
                        item); // Fungsi ini berasal dari Dashboard
                  });

                  // Kosongkan keranjang
                  setState(() {
                    widget.cart.clear();
                  });

                  // Tampilkan pesan berhasil
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Checkout berhasil! Semua item masuk ke Riwayat Belanja')),
                  );
                },
                child: Text('Checkout'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.green,
                ),
              ),
            ),
    );
  }
}
