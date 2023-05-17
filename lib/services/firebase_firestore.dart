import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addCatalog(Map<String, dynamic> catalogJson) async {
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

  Future<void> addCategory(Map<String, dynamic> categoryJson) async {
    try {
      await _firestore.collection('categories').add(categoryJson);
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

  Future<void> addProduct(Map<String, dynamic> productJson) async {
    try {
      await _firestore.collection('products').add(productJson);
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
