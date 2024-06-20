import 'dart:ui';

import 'package:hymate_test/features/challenge/domain/hierarchy/hierarchy_node.dart';

class HierarchyDataPoint extends HierarchyNode {
  final String categoryId;
  final String label;

  const HierarchyDataPoint({
    required super.id,
    required this.categoryId,
    required this.label,
    super.color,
    super.isSelected,
  }) : super();

  @override
  HierarchyNode copyWith({
    bool? isSelected,
    String? categoryId,
    String? label,
    Color? color,
  }) {
    return HierarchyDataPoint(
      id: id,
      categoryId: categoryId ?? this.categoryId,
      label: label ?? this.label,
      isSelected: isSelected ?? this.isSelected,
      color: color ?? this.color,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        label,
        categoryId,
      ];
}
