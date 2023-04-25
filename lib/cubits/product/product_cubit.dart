import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../models/product.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  ProductCubit({
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  })  : _firestore = firestore,
        _storage = storage,
        super(ProductInitial());

  Future<void> getProducts() async {
    try {
      emit(ProductLoading());

      final querySnapshot = await _firestore.collection('products').get();

      final products = querySnapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data());
      }).toList();

      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
