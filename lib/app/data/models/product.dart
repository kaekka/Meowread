enum ProductCategory { minuman, makanan, roti, esKrim }

class Product {
  final String name;
  final double price; // <-- Diubah dari String menjadi double
  final String image;
  final ProductCategory category;
  final String description;

  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.category,
    required this.description,
  });
}
