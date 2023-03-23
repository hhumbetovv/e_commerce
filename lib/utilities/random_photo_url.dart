import 'dart:math';

String randomPhotoUrl() {
  return "https://picsum.photos/1024?random=${1 + Random().nextInt((100 + 1) - 1)}";
}
