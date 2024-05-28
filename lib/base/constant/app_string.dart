// ignore_for_file: non_constant_identifier_names

const String _storageLink =
    'https://firebasestorage.googleapis.com/v0/b/cusufcan-etkinlik.appspot.com/o/';

class AppString {
  const AppString._privateConstructor();
  static const AppString _instance = AppString._privateConstructor();

  factory AppString() {
    return _instance;
  }

  final String MAPS_API_KEY = "AIzaSyAqOyshRw_8FGLmQiQZE8mQgoYopHGJ4V0";

  final String defaultPPUrl =
      '${_storageLink}default%2Fdef_pp.jpg?alt=media&token=3d3b9739-915d-4546-a4f0-684d3542cc62';
  final String defaultEventImageUrl =
      '${_storageLink}default%2Fno_image.jpg?alt=media&token=66e0c275-0155-4308-86c9-1452082337fd';
}

// sonra yapılacak
// enum ErrorMessages {
// }