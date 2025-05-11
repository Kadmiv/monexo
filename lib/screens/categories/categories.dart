import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:monexo/generated/l10n.dart';
import 'package:monexo/models/models.dart';
import 'package:monexo/screens/categories/categories_event.dart';
import 'package:monexo/screens/categories/categories_state.dart';
import 'package:monexo/screens/categories/dialogs/add_category.dart';
import 'package:monexo/shared/utils.dart';

import 'categories_bloc.dart';

/// Сторінка для відображення списку категорій типу доходів або витрат
///
/// На даній сторінці відображається список категорій типу доходів або витрат
/// Можна додавати нову категорію
final class CategoriesScreen extends StatefulWidget {
  static const String routeName = '/categories';

  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final bloc = CategoriesBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc..add(LoadCategories()),
      /// Використання DefaultTabController для відображення вкладок на сторінці
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            elevation: 0,
            title: Text(S.of(context).categories),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            bottom: TabBar(
              indicatorColor: Theme.of(context).colorScheme.primary,
              tabs: <Widget>[
                Tab(
                  child: Text(S.of(context).revenue),
                ),
                Tab(
                  child: Text(S.of(context).costs),
                ),
              ],
            ),
          ),
          body: Builder(
            builder: (context) => BlocBuilder<CategoriesBloc, CategoriesState>(
              builder: (context, state) {
                if (state is CategoriesLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is CategoriesError) {
                  return Center(child: Text(state.message));
                }

                if (state is CategoriesLoaded) {
                  /// Відображення відображення категорій типу доходів або витрат
                  return TabBarView(
                    children: <Widget>[
                      GridView.count(
                        crossAxisCount: 4,
                        children: <Widget>[
                          ..._buildCategories(
                            context,
                            state.categories
                                .where((x) => x.type == CategoryType.income),
                          ),
                          _buildAddButton(context, CategoryType.income),
                        ],
                      ),
                      GridView.count(
                        crossAxisCount: 4,
                        children: <Widget>[
                          ..._buildCategories(
                            context,
                            state.categories
                                .where((x) => x.type == CategoryType.expense),
                          ),
                          _buildAddButton(context, CategoryType.expense),
                        ],
                      ),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }

  /// Відображення кнопки додавання нової категорії
  Widget _buildAddButton(
    BuildContext context,
    CategoryType type,
  ) {

    return InkWell(
      onTap: () async {
        final result = await showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => AddCategoryDialog(type),
        );

        if (result is List<CategoryModel>) {
          if (result.isNotEmpty) {
            bloc.add(CreateCategory(result.first));
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            width: 0.5,
            color: Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.add,
              size: 32,
            ),
            const SizedBox(height: 10),
            Text(
              S.of(context).addANewOne,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  /// Відображення списку категорій типу доходів або витрат
  List<Widget> _buildCategories(
    BuildContext context,
    Iterable<CategoryModel> categories,
  ) {
    return categories
        .map((category) => InkWell(
              child: Container(
                key: Key(category.id),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.5,
                    color: Colors.grey.withOpacity(0.15),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 32,
                      child: Image.asset(
                        'assets/categories/${category.icon}.png',
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      transformCategoryToKey(category),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ))
        .toList();
  }
}
