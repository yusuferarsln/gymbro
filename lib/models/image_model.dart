// ignore_for_file: public_member_api_docs, sort_constructors_first

class ImageModel {
  String? move_img;
  ImageModel({
    required this.move_img,
  });

  factory ImageModel.fromJson(Map<String, dynamic> map) {
    return ImageModel(
      move_img: map['move_img'] ?? "https://via.placeholder.com/150",
    );
  }
}
