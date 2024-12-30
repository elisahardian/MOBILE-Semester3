import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final String productId;
  final String productName;
  final String productPrice;
  final String productImage;
  final String productDescription;

  ProductDetailPage({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productImage,
    required this.productDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                productImage,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, size: 100, color: Colors.red);
                },
              ),
              SizedBox(height: 20),
              Text(
                productName,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                productPrice,
                style: TextStyle(fontSize: 24, color: Colors.green),
              ),
              SizedBox(height: 20),
              Text(
                productDescription,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Logika untuk pembelian atau menambahkan produk ke keranjang
                  // Misalnya, Anda bisa memanggil fungsi seperti addToCart
                },
                child: Text('Checkout'),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 36)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
