class ImageModel {
  final String userId;
  final List<String> imageUrls;

  ImageModel({
    required this.userId,
    required this.imageUrls,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'imageUrls': imageUrls,
    };
  }

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      userId: map['userId'],
      imageUrls: List<String>.from(map['imageUrls'] ?? []),
    );
  }
}
