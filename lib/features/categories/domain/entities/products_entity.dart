import 'package:equatable/equatable.dart';

class CategoriesEntity extends Equatable {
  final String categoryName;
  final List<String> items;

  const CategoriesEntity({
    required this.categoryName,
    required this.items,
  });

  @override
  List<Object> get props => [categoryName, items];
}
