import 'package:flutter/material.dart';
import 'package:food_example/widgets/nomormeja.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Daftar item dalam keranjang
  List<Map<String, dynamic>> cartItems = [];
  int selectedTableNumber = 0; // Nomor meja yang dipilih

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Text('Keranjang kosong'),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  title: Text(item['name']),
                  subtitle: Text('Harga: ${item['price']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () {
                      removeItem(index);
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: cartItems.isEmpty
          ? null
          : BottomAppBar(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: ${calculateTotal()}',
                      style: TextStyle(fontSize: 18),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Implement logic untuk checkout
                        // Misalnya, pindah ke layar pembayaran
                        // dan sertakan nomor meja yang dipilih
                        navigateToPaymentScreen(selectedTableNumber);
                      },
                      child: Text('Checkout'),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Tampilkan dialog atau navigasi ke halaman pilih nomor meja
          navigateToTableSelection();
        },
        child: Icon(Icons.table_chart),
      ),
    );
  }

  // Fungsi untuk menambahkan item ke keranjang
  void addItem(String name, double price) {
    setState(() {
      cartItems.add({'name': name, 'price': price});
    });
  }

  // Fungsi untuk menghapus item dari keranjang
  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  // Fungsi untuk menghitung total harga keranjang
  double calculateTotal() {
    double total = 0;
    for (var item in cartItems) {
      total += item['price'];
    }
    return total;
  }

  // Fungsi untuk menavigasi ke halaman pilih nomor meja
  void navigateToTableSelection() async {
    final selectedTable = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NomorMejaPage()),
    );
    if (selectedTable != null) {
      setState(() {
        selectedTableNumber = selectedTable;
      });
    }
  }

  // Fungsi untuk menavigasi ke halaman pembayaran
  void navigateToPaymentScreen(int tableNumber) {
    // Implementasi logika untuk membawa nomor meja ke halaman pembayaran
    // Misalnya, dengan menggunakan Navigator.push
    // dan mengirimkan argumen nomor meja
  }
}
