import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hymate_test/features/challenge/domain/hierarchy/hierarchy.dart';

part 'hierarchy_category_tile.dart';

part 'hierarchy_data_point_tile.dart';

part 'hierarchy_item_tile.dart';

typedef NodeChangedCallback = void Function(HierarchyNode node);

class HierarchyWidget extends StatelessWidget {
  const HierarchyWidget({
    super.key,
    HierarchyRoot? hierarchyRoot,
    required this.onNodeSelectionToggle,
    required this.onNodeExpandedToggle,
  }) : hierarchyRoot = hierarchyRoot ?? const HierarchyRoot();

  final HierarchyRoot hierarchyRoot;
  final NodeChangedCallback onNodeSelectionToggle;
  final NodeChangedCallback onNodeExpandedToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: theme.primaryColor.withOpacity(0.2),
      ),
      child: ListView(
        children: [
          ...hierarchyRoot.children.map(
            (child) => HierarchyItemTile(
              key: Key(child.id),
              itemNode: child,
              onNodeSelectionToggle: onNodeSelectionToggle,
              onNodeExpandedToggle: onNodeExpandedToggle,
            ),
          ),
        ],
      ),
    );
  }
}
