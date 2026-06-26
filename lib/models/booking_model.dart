class BookingModel {
  final String id;
  final String userId;
  final String serviceId;
  final String serviceName;
  final String category;
  final String image;
  final String issueImagePath;
  final int createdAt;

  BookingModel({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.serviceName,
    required this.category,
    required this.image,
    required this.issueImagePath,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'category': category,
      'image': image,
      'issueImagePath': issueImagePath,
      'createdAt': createdAt,
    };
  }

  factory BookingModel.fromMap(Map<dynamic, dynamic> map) {
    return BookingModel(
      id: map['id']?.toString() ?? '',
      userId: map['userId']?.toString() ?? '',
      serviceId: map['serviceId']?.toString() ?? '',
      serviceName: map['serviceName']?.toString() ?? '',
      category: map['category']?.toString() ?? '',
      image: map['image']?.toString() ?? '',
      issueImagePath: map['issueImagePath']?.toString() ?? '',
      createdAt: int.tryParse(map['createdAt']?.toString() ?? '0') ?? 0,
    );
  }
}
