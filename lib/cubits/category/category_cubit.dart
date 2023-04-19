import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/models/category.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  CategoryCubit({
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  })  : _firestore = firestore,
        _storage = storage,
        super(CategoryInitial());

  Future<void> getCategories() async {
    try {
      emit(CategoryLoading());

      final querySnapshot = await _firestore.collection('categories').get();

      final categories = querySnapshot.docs.map((doc) {
        return CategoryModel.fromJson(doc.data());
      }).toList();

      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
