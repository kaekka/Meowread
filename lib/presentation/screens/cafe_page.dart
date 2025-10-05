import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:apktes1/app/data/models/product.dart';
import 'package:apktes1/app/data/providers/cart_provider.dart';
import 'package:apktes1/app/data/services/product_service.dart';
import 'package:apktes1/presentation/screens/product_detail_screen.dart';
import 'package:apktes1/presentation/screens/cart_screen.dart';

class CafePage extends StatefulWidget {
  const CafePage({super.key});

  @override
  State<CafePage> createState() => _CafePageState();
}

class _CafePageState extends State<CafePage> {
  final ProductService _productService = ProductService();
  late List<Product> _allProducts;
  late List<Product> _filteredProducts;

  String _selectedCategory = "Semua";
  final List<String> _categories = ["Semua", "Minuman", "Makanan", "Roti", "Es Krim"];

  @override
  void initState() {
    super.initState();
    _allProducts = _productService.getProducts();
    _filteredProducts = _allProducts;
  }

  void _filterProducts(String category) {
    setState(() {
      _selectedCategory = category;
      if (category == "Semua") {
        _filteredProducts = _allProducts;
      } else {
        final categoryEnum = ProductCategory.values.firstWhere(
          (e) => e.toString().split('.').last == category.toLowerCase().replaceAll(' ', ''),
        );
        _filteredProducts = _allProducts.where((p) => p.category == categoryEnum).toList();
      }
    });
  }

  Widget _categoryChip(String label, ThemeData theme) {
    final bool isSelected = _selectedCategory == label;
    return GestureDetector(
      onTap: () => _filterProducts(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? theme.primaryColor : theme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(22),
          boxShadow: isSelected
              ? [BoxShadow(color: theme.primaryColor.withOpacity(0.3), blurRadius: 5, offset: const Offset(0, 2))]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _productCard(Product product, ThemeData theme) {
    final currencyFormatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Card(
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Hero(
                tag: product.image,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: product.image.startsWith('http')
                      ? Image.network(product.image, fit: BoxFit.cover)
                      : Image.asset(product.image, fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    currencyFormatter.format(product.price),
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.primaryColor, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _promoCard(String title, String subtitle, String imagePath, ThemeData theme) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: theme.primaryColor.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(imagePath, width: 60, height: 60, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, color: theme.primaryColor)),
                const SizedBox(height: 4),
                Text(subtitle, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.8))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor, 
        elevation: 0,
        title: Text(
          "Meow-tisserie & Cafe",
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Badge(
                label: Text(cart.itemCount.toString()),
                isLabelVisible: cart.itemCount > 0,
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CartScreen()),
                    );
                  },
                  icon: Icon(Icons.shopping_bag_outlined, color: theme.colorScheme.onBackground),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: theme.primaryColor),
                hintText: "Cari menu...",
                filled: true,
                fillColor: theme.primaryColor.withOpacity(0.05),
                contentPadding: const EdgeInsets.all(0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              height: 45,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: _categories.length,
                itemBuilder: (context, index) => _categoryChip(_categories[index], theme),
              ),
            ),
          ),

          
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text("Promo Spesial Untukmu 🐱", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _promoCard("Paket Hemat", "1 Kopi + 1 Roti hanya Rp 35rb", "assets/cats/Cat.jpg", theme),
                _promoCard("Beli 2 Gratis 1", "Untuk semua varian es krim", "assets/cats/wlee.jpg", theme),
                _promoCard("Diskon Weekend", "Diskon 15% untuk semua makanan", "assets/cats/bobby.jpg", theme),
              ],
            ),
          ),

          
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
            child: Text("Menu Kami", style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          ),

          
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                return _productCard(_filteredProducts[index], theme);
              },
            ),
          ),
        ],
      ),
    );
  }
}
