import 'package:hymate_test/features/challenge/data/models/hierarchy/hierarchy_node_model.dart';
import 'package:hymate_test/features/challenge/domain/hierarchy/hierarchy_data_point.dart';

class HierarchyDataPointModel extends HierarchyNodeModel {
  final String categoryId;
  final String label;

  const HierarchyDataPointModel({
    required super.id,
    required this.categoryId,
    required this.label,
  }) : super();

  HierarchyDataPointModel copyWith({
    bool? isSelected,
    String? label,
    String? categoryId,
  }) {
    return HierarchyDataPointModel(
      id: id,
      categoryId: categoryId ?? this.categoryId,
      label: label ?? this.label,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        label,
        categoryId,
      ];

  @override
  HierarchyDataPoint toEntity() {
    return HierarchyDataPoint(
      id: id,
      categoryId: categoryId,
      label: label,
    );
  }
}
