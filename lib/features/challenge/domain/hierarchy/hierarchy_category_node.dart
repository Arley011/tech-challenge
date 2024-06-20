import 'dart:ui';

import 'package:hymate_test/features/challenge/domain/hierarchy/hierarchy_data_point.dart';
import 'package:hymate_test/features/challenge/domain/hierarchy/hierarchy_node.dart';

class HierarchyCategoryNode extends HierarchyNode {
  const HierarchyCategoryNode({
    required super.id,
    required this.label,
    required this.parentId,
    super.color,
    this.children = const [],
    this.isExpanded = false,
    super.isSelected,
  });

  final String label;
  final String? parentId;
  final bool isExpanded;
  final List<HierarchyNode> children;

  List<HierarchyDataPoint> get dataPoints {
    final List<HierarchyDataPoint> list = [];

    void getDataPointsRecursively(HierarchyNode node) {
      if (node is HierarchyDataPoint) {
        list.add(node);
      } else if (node is HierarchyCategoryNode) {
        for (final child in node.children) {
          getDataPointsRecursively(child);
        }
      }
    }

    for (final child in children) {
      getDataPointsRecursively(child);
    }

    return list;
  }

  @override
  HierarchyCategoryNode copyWith({
    bool? isSelected,
    String? label,
    String? parentId,
    List<HierarchyNode>? children,
    bool? isExpanded,
    Color? color,
  }) {
    return HierarchyCategoryNode(
      id: id,
      label: label ?? this.label,
      children: children ?? this.children,
      parentId: parentId ?? this.parentId,
      isExpanded: isExpanded ?? this.isExpanded,
      isSelected: isSelected ?? this.isSelected,
      color: color ?? this.color,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        parentId,
        label,
        children,
        isExpanded,
      ];
}
