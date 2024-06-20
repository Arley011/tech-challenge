import 'dart:developer';
import 'dart:ui';

import 'package:hymate_test/core/utils/color_utils.dart';
import 'package:hymate_test/features/challenge/domain/domain.dart';
import 'package:hymate_test/features/challenge/domain/hierarchy/hierarchy.dart';

class HierarchyRoot extends HierarchyNode {
  const HierarchyRoot({
    this.children = const [],
  }) : super(id: 'root');

  final List<HierarchyNode> children;

  List<HierarchyCategoryNode> get categories {
    final List<HierarchyCategoryNode> list = [];

    void getCategoriesRecursively(HierarchyNode node) {
      if (node is HierarchyCategoryNode) {
        list.add(node);
        for (final child in node.children) {
          getCategoriesRecursively(child);
        }
      }
    }

    for (final child in children) {
      getCategoriesRecursively(child);
    }

    return list;
  }

  List<HierarchyNode> getSelectedNodes({
    HierarchyNode? node,
  }) {
    final List<HierarchyNode> list = [];

    void getSelectedNodesRecursively(HierarchyNode node) {
      if (node.isSelected) {
        list.add(node);
      }
      if (node is HierarchyCategoryNode) {
        for (final child in node.children) {
          getSelectedNodesRecursively(child);
        }
      }
    }

    if (node is HierarchyCategoryNode) {
      getSelectedNodesRecursively(node);
      return list;
    } else {
      for (final child in children) {
        getSelectedNodesRecursively(child);
      }
    }

    return list;
  }

  HierarchyRoot updateNode(HierarchyNode node) {
    return _updateNodeRecursively(this, node) as HierarchyRoot;
  }

  HierarchyRoot generateColors() {
    final colors = ColorUtils.generateLinearColors(categories.length);
    return _setColorsRecursively(this, colors.toList()) as HierarchyRoot;
  }

  HierarchyNode _updateNodeRecursively(
    HierarchyNode currentNode,
    HierarchyNode node,
  ) {
    if (currentNode.id == node.id) {
      return node;
    }

    if (currentNode is HierarchyRoot) {
      final updatedChildren = currentNode.children.map(
        (child) => _updateNodeRecursively(child, node),
      );

      return currentNode.copyWith(
        children: updatedChildren.toList(),
      );
    } else if (currentNode is HierarchyCategoryNode) {
      final updatedChildren = currentNode.children.map(
        (child) => _updateNodeRecursively(child, node),
      );

      return currentNode.copyWith(
        children: updatedChildren.toList(),
      );
    }

    return currentNode;
  }

  HierarchyNode _setColorsRecursively(HierarchyNode node, List<Color> colors) {
    if (node is HierarchyRoot) {
      final updatedChildren = node.children.map(
        (child) => _setColorsRecursively(child, colors),
      );

      return node.copyWith(
        children: updatedChildren.toList(),
      );
    } else if (node is HierarchyCategoryNode) {
      final baseColor = colors.removeLast();
      final children = node.children;
      if (children.isNotEmpty && children.first is HierarchyDataPoint) {
        final colorShades = ColorUtils.generateShadesOfColor(
          baseColor,
          children.length,
        ).toList();
        return node.copyWith(
          children: children
              .map(
                (child) => (child as HierarchyDataPoint).copyWith(
                  color: colorShades.removeLast(),
                ),
              )
              .toList(),
          color: baseColor,
        );
      }
      final updatedChildren = node.children.map(
        (child) => _setColorsRecursively(child, colors),
      );

      return node.copyWith(
        color: baseColor,
        children: updatedChildren.toList(),
      );
    }

    return node;
  }

  void printTree() {
    log('Hierarchy:\n');
    for (final child in children) {
      _printNode(child, 0);
    }
  }

  void _printNode(HierarchyNode node, int depth) {
    final indent = '  ->' * depth;
    log(
      '$indent Node(${node is HierarchyCategoryNode ? '${node.label} - ' : 'dataPoint -'} '
      '${node.id}; color = ${node.color.value})',
    );
    if (node is HierarchyCategoryNode) {
      for (final child in node.children) {
        _printNode(child, depth + 1);
      }
    }
  }

  @override
  HierarchyRoot copyWith({
    bool? isSelected,
    List<HierarchyNode>? children,
  }) {
    return HierarchyRoot(
      children: children ?? this.children,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        children,
      ];
}
