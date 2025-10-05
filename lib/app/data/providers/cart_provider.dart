import 'package:flutter/material.dart';
import 'package:apktes1/app/data/models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  // Jumlah item unik di keranjang
  int get itemCount => _items.length;

  // Total harga semua item di keranjang
  double get totalPrice {
    double total = 0.0;
    for (var item in _items) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  // Menambahkan produk ke keranjang
  void addItem(Product product) {
    // Cek apakah produk sudah ada di keranjang
    for (var item in _items) {
      if (item.product.name == product.name) {
        item.quantity++;
        notifyListeners();
        return;
      }
    }
    // Jika belum ada, tambahkan sebagai item baru
    _items.add(CartItem(product: product));
    notifyListeners();
  }

  // Menghapus produk dari keranjang
  void removeItem(CartItem cartItem) {
    _items.remove(cartItem);
    notifyListeners();
  }

  // Menambah kuantitas item
  void incrementItem(CartItem cartItem) {
    cartItem.quantity++;
    notifyListeners();
  }

  // Mengurangi kuantitas item
  void decrementItem(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
    } else {
      // Jika kuantitas jadi 0, hapus item dari keranjang
      _items.remove(cartItem);
    }
    notifyListeners();
  }

  // Menghapus semua item dari keranjang
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
