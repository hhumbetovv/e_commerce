import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> setCatalog(Map<String, dynamic> catalogJson) async {
    try {
      await _firestore.collection('catalogs').doc(catalogJson['id']).set(catalogJson);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCatalog(String catalogId) async {
    try {
      await _firestore.collection('catalogs').doc(catalogId).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setCategory(Map<String, dynamic> categoryJson) async {
    try {
      await _firestore.collection('categories').doc(categoryJson['id']).set(categoryJson);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCategory(String categoryId) async {
    try {
      await _firestore.collection('categories').doc(categoryId).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setProduct(Map<String, dynamic> productJson) async {
    try {
      await _firestore.collection('products').doc(productJson['id']).set(productJson);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).delete();
    } catch (e) {
      rethrow;
    }
  }
}
