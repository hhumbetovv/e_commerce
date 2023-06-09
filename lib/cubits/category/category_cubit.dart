import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../models/category.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final FirebaseFirestore _firestore;

  CategoryCubit({
    required FirebaseFirestore firestore,
    required FirebaseStorage storage,
  })  : _firestore = firestore,
        super(CategoryInitial());

  Future<void> getCategories() async {
    try {
      emit(CategoryLoading());

      final querySnapshot = await _firestore.collection('categories').get();

      final List<CategoryModel> categories = querySnapshot.docs.map((doc) {
        return CategoryModel.fromJson(doc.data());
      }).toList();

      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
