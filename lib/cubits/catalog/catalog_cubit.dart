import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/category.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';

part 'catalog_state.dart';

class CatalogCubit extends Cubit<CatalogState> {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  CatalogCubit({
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  })  : _firestore = firestore,
        _storage = storage,
        super(CatalogInitial());

  Future<void> getCatalogs() async {
    try {
      emit(CatalogLoading());

      final querySnapshot = await _firestore.collection('catalogs').get();

      final catalogs = querySnapshot.docs.map((doc) {
        return CategoryModel.fromJson(doc.data());
      }).toList();

      emit(CatalogLoaded(catalogs));
    } catch (e) {
      emit(CatalogError(e.toString()));
    }
  }
}
