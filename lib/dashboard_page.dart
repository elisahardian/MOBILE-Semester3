import 'package:flutter/material.dart';
import 'dart:convert'; // Untuk parsing JSON
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // Impor intl untuk memformat angka
import 'package:latlogin/pusat_bantuan.dart';
import 'package:latlogin/riwayat_pembelian.dart';
import 'package:latlogin/setting_page.dart';
// import 'package:latlogin/setting_page.dart';
import 'login.dart'; // Impor halaman login
import 'package:latlogin/productdetailpage.dart';
//import 'package:latlogin/riwayat_pembelian.dart';
//import 'productdetailpage.dart'; // Impor halaman ProductDetailPage\
import 'keranjang_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List products = [];
  bool isLoading = true; // Menyimpan status loading
  String errorMessage = ''; // Menyimpan pesan error jika ada

  List<Map<String, dynamic>> cart = []; //tambahkan property keranjang
  List<Map<String, dynamic>> history = []; //tambahkan property history
  //tambahkan property detail barang

  //fungsi untuk menmabakna produk kekeranjang
  void addToCart(Map<String, dynamic> product) {
    setState(() {
      cart.add(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content:
              Text('${product['product']} telah ditambahkan ke keranjang')),
    );
  }

  //fungsi untuk menmabakna produk ke riwayat belanja
  void addToHistory(Map<String, dynamic> product) {
    setState(() {
      history.add(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              '${product['product']} telah ditambahkan ke Riwayat Belanja')),
    );
  }

  // Fungsi untuk mengambil data produk dari API
  Future<void> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse(
            //'http://192.168.114.198/flutter/get_products.php'), // Ganti dengan URL API Anda
            'http://localhost/apk_latihanproduk/get_products.php'),
      );

      if (response.statusCode == 200) {
        setState(() {
          products = json.decode(response.body);
          isLoading =
              false; // Set loading ke false setelah data berhasil diambil
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Set loading ke false jika terjadi error
        errorMessage = e.toString(); // Simpan pesan error
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProducts(); // Panggil fungsi untuk mengambil data saat widget diinisialisasi
  }

  // Fungsi untuk memformat harga
  String formatCurrency(String price) {
    final formatter = NumberFormat.currency(locale: 'id', symbol: 'Rp ');
    return formatter.format(int.parse(price));
  }

  //@override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard Produk'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigasi ke halaman keranjang dengan data keranjang
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KeranjangPage(
                    cart: cart,
                    addToHistory: addToHistory,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Navigasi ke halaman login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: FutureBuilder<SharedPreferences>(
          future: SharedPreferences
              .getInstance(), // Mendapatkan instance SharedPreferences
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator()); // Menunggu data
            } else if (snapshot.hasData) {
              // Ambil data dari SharedPreferences
              SharedPreferences prefs = snapshot.data!;
              String userName = prefs.getString('userName') ?? 'Nama Pengguna';
              String userEmail =
                  prefs.getString('userEmail') ?? 'email@domain.com';

              return ListView(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(userName), // Menampilkan nama pengguna
                    accountEmail: Text(userEmail), // Menampilkan email pengguna
                    currentAccountPicture: CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://via.placeholder.com/150'),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.history),
                    title: Text('Riwayat Belanja'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RiwayatPage(history: history),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: Text('Keranjang Belanja'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KeranjangPage(
                              cart: cart, addToHistory: addToHistory),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: Icon(Icons.question_answer),
                    title: Text('Pusat Bantuan (FAQ)'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PusatBantuanPage(),
                        ),
                      );
                    },
                  ),

                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Setting'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingPage(),
                        ),
                      );
                    },
                  ),
                  // Daftar menu lain
                ],
              );
            } else {
              return Center(child: Text("Error loading user data"));
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat Berbelanja',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : errorMessage.isNotEmpty
                      ? Center(child: Text(errorMessage))
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10),
                                      ),
                                      child: Image.network(
                                        product['image'],
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(
                                            Icons.error,
                                            size: 100,
                                            color: Colors.red,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product['product'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          formatCurrency(product['price']),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        ElevatedButton(
                                          onPressed: () {
                                            // Tambahkan produk ke keranjang
                                            addToCart(product);
                                          },
                                          child: Text('Masukkan keranjang'),
                                          style: ElevatedButton.styleFrom(
                                            minimumSize:
                                                Size(double.infinity, 36),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            // Menavigasi ke halaman ProductDetailPage dan mengirimkan data produk
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailPage(
                                                  productName:
                                                      product['product'] ??
                                                          'Unknown Product',
                                                  productPrice: formatCurrency(
                                                      product['price'] ?? '0'),
                                                  productImage:
                                                      product['image'] ?? '',
                                                  productDescription:
                                                      product['description'] ??
                                                          'No description',
                                                  productId:
                                                      product['idproduct'] ??
                                                          '0',
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text('Lihat Detail'),
                                          style: ElevatedButton.styleFrom(
                                            minimumSize:
                                                Size(double.infinity, 36),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
