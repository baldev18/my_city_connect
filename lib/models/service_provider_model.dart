class ServiceProviderModel {
  final String id;
  final String name;
  final String category;
  final String image;
  final double rating;
  final String phone;
  final String website;
  final String address;
  final String description;

  ServiceProviderModel({
    required this.id,
    required this.name,
    required this.category,
    required this.image,
    required this.rating,
    required this.phone,
    required this.website,
    required this.address,
    required this.description,
  });

  factory ServiceProviderModel.fromJson(Map<String, dynamic> json) {
    return ServiceProviderModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Unknown Service',
      category: json['category']?.toString() ?? 'Service',
      image: json['image']?.toString() ?? '',
      rating: double.tryParse(json['rating']?.toString() ?? '0') ?? 0,
      phone: json['phone']?.toString() ?? '',
      website: json['website']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'image': image,
      'rating': rating,
      'phone': phone,
      'website': website,
      'address': address,
      'description': description,
    };
  }
}
