class Cat {
  final String _name;
  final String _age;
  final String _mood;
  final String _image;
  final String _description;
  final List<String> _extraPhotos;

  Cat(
    this._name,
    this._age,
    this._mood,
    this._image,
    this._description,
    this._extraPhotos,
  );

  // Getter → enkapsulasi
  String get name => _name;
  String get age => _age;
  String get mood => _mood;
  String get image => _image;
  String get description => _description;
  List<String> get extraPhotos => _extraPhotos;

  // Default kategori → dioverride oleh subclass
  String get category => "Kucing Umum";
}

// Subclass sesuai kategori (inheritance + polymorphism)
class CampusCat extends Cat {
  CampusCat(
    String name,
    String age,
    String mood,
    String image,
    String description,
    List<String> extraPhotos,
  ) : super(name, age, mood, image, description, extraPhotos);

  @override
  String get category => "Kucing Kampus";
}

class LocalCat extends Cat {
  LocalCat(
    String name,
    String age,
    String mood,
    String image,
    String description,
    List<String> extraPhotos,
  ) : super(name, age, mood, image, description, extraPhotos);

  @override
  String get category => "Kucing Lokal";
}

class OtherCat extends Cat {
  OtherCat(
    String name,
    String age,
    String mood,
    String image,
    String description,
    List<String> extraPhotos,
  ) : super(name, age, mood, image, description, extraPhotos);

  @override
  String get category => "Kucing Kucingan";
}
