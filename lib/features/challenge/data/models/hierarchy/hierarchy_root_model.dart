import 'dart:developer';

import 'package:hymate_test/features/challenge/data/models/hierarchy/hierarchy_category_node_model.dart';
import 'package:hymate_test/features/challenge/data/models/hierarchy/hierarchy_node_model.dart';
import 'package:hymate_test/features/challenge/domain/hierarchy/hierarchy_root.dart';

class HierarchyRootModel extends HierarchyNodeModel {
  const HierarchyRootModel({
    this.children = const [],
  }) : super(id: 'root');

  final List<HierarchyNodeModel> children;

  HierarchyRootModel addNode(HierarchyNodeModel node, String? parentId) {
    try {
      return _addNodeRecursively(
        this,
        node,
        parentId,
      ) as HierarchyRootModel;
    } catch (e, st) {
      log('Cannot add node: $node\n$e\n$st');
    }
    return this;
  }

  HierarchyNodeModel _addNodeRecursively(
    HierarchyNodeModel currentNode,
    HierarchyNodeModel nodeToAdd,
    String? parentId,
  ) {
    if (parentId == null && currentNode is HierarchyRootModel) {
      return currentNode.copyWith(
        children: [
          ...currentNode.children,
          nodeToAdd,
        ],
      );
    }
    if (currentNode.id == parentId) {
      return (currentNode as HierarchyCategoryNodeModel).copyWith(
        children: [
          ...currentNode.children,
          nodeToAdd,
        ],
      );
    }

    if (currentNode is HierarchyCategoryNodeModel ) {
      final matchingChildId = currentNode.children.indexWhere(
        (element) => element.id == parentId,
      );
      if (!matchingChildId.isNegative) {
        return currentNode.copyWith(
          children: currentNode.children.map((e) {
            if (e.id == parentId) {
              return _addNodeRecursively(e, nodeToAdd, parentId);
            }
            return e;
          }).toList(),
        );
      }
      return currentNode.copyWith(
        children: currentNode.children.map((element) {
          return _addNodeRecursively(element, nodeToAdd, parentId);
        }).toList(),
      );
    } else if (currentNode is HierarchyRootModel) {
      return currentNode.copyWith(
        children: currentNode.children.map((element) {
          return _addNodeRecursively(element, nodeToAdd, parentId);
        }).toList(),
      );
    }

    return currentNode;
  }

  HierarchyRootModel copyWith({
    bool? isSelected,
    List<HierarchyNodeModel>? children,
  }) {
    return HierarchyRootModel(
      children: children ?? this.children,
    );
  }

  @override
  HierarchyRoot toEntity() {
    return HierarchyRoot(
      children: children.map((e) => e.toEntity()).toList(),
    );
  }
}
