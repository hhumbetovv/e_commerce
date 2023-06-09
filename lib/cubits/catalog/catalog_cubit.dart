import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../models/category.dart';

part 'catalog_state.dart';

class CatalogCubit extends Cubit<CatalogState> {
  final FirebaseFirestore _firestore;

  CatalogCubit({
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  })  : _firestore = firestore,
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
