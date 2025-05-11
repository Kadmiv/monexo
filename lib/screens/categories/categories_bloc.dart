import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monexo/screens/categories/categories_event.dart';
import 'package:monexo/screens/categories/categories_state.dart';
import 'package:monexo/services/category_provider.dart';
import 'package:monexo/services/account_provider.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial()) {
    on<LoadCategories>(_onLoadCategories);
    on<CreateCategory>(_onCreateCategory);
  }

  final AccountProvider _accountService = AccountProvider();
  final CategoryProvider _categoryProvider = CategoryProvider();

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<CategoriesState> emit,
  ) async {
    try {
      emit(CategoriesLoading());
      final account = await _accountService.getAccount();
      final categories = await _categoryProvider.getCategories(account.id);
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  Future<void> _onCreateCategory(
    CreateCategory event,
    Emitter<CategoriesState> emit,
  ) async {
    try {
      emit(CategoriesLoading());
      await _categoryProvider.add(event.category);
      final account = await _accountService.getAccount();
      final categories = await _categoryProvider.getCategories(account.id);
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }
}
