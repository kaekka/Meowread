import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:apktes1/app/data/providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final theme = Theme.of(context);
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Keranjang Saya"),
        actions: [
          if (cartProvider.items.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: () {
                cartProvider.clearCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Keranjang telah dikosongkan.")),
                );
              },
            ),
        ],
      ),
      body: cartProvider.items.isEmpty
          ? Center(
              child: Text(
                "Keranjang Anda masih kosong. 🐱",
                style: TextStyle(fontSize: 16, color: theme.hintColor),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 120), // Add padding for bottom sheet
              itemCount: cartProvider.items.length,
              itemBuilder: (context, index) {
                final cartItem = cartProvider.items[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: cartItem.product.image.startsWith('http')
                              ? Image.network(cartItem.product.image, width: 70, height: 70, fit: BoxFit.cover)
                              : Image.asset(cartItem.product.image, width: 70, height: 70, fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(cartItem.product.name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(
                                currencyFormatter.format(cartItem.product.price),
                                style: theme.textTheme.bodyMedium?.copyWith(color: theme.primaryColor, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        // Quantity Changer
                        Row(
                          children: [
                            IconButton(icon: const Icon(Icons.remove), onPressed: () => cartProvider.decrementItem(cartItem), iconSize: 20),
                            Text(cartItem.quantity.toString(), style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                            IconButton(icon: const Icon(Icons.add), onPressed: () => cartProvider.incrementItem(cartItem), iconSize: 20),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomSheet: cartProvider.items.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.cardColor,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))],
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Harga:", style: theme.textTheme.titleMedium),
                      Text(
                        currencyFormatter.format(cartProvider.totalPrice),
                        style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: theme.primaryColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      // TODO: Implement checkout logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Fitur checkout belum diimplementasikan.")),
                      );
                    },
                    child: const Text(
                      "Pesan Sekarang",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
