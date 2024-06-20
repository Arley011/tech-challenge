import 'package:hymate_test/core/beans/optional.dart';
import 'package:hymate_test/features/challenge/data/models/hierarchy/hierarchy_node_model.dart';
import 'package:hymate_test/features/challenge/domain/hierarchy/hierarchy_category_node.dart';


class HierarchyCategoryNodeModel extends HierarchyNodeModel {
  const HierarchyCategoryNodeModel({
    required super.id,
    required this.label,
    required this.parentId,
    this.children = const [],
  });

  final String? label;
  final String? parentId;
  final List<HierarchyNodeModel> children;

  HierarchyCategoryNodeModel copyWith({
    String? label,
    List<HierarchyNodeModel>? children,
    Optional<String?>? parentId,
  }) {
    return HierarchyCategoryNodeModel(
      id: id,
      label: label ?? this.label,
      parentId: Optional.resolve(parentId, this.parentId),
      children: children ?? this.children,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        label,
        children,
        parentId,
      ];

  @override
  HierarchyCategoryNode toEntity() {
    return HierarchyCategoryNode(
      id: id,
      label: label!,
      parentId: parentId,
      children: children.map((e) => e.toEntity()).toList(),
    );
  }
}
