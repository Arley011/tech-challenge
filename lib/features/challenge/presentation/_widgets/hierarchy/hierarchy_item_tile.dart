part of 'hierarchy_widget.dart';

class HierarchyItemTile extends StatelessWidget {
  const HierarchyItemTile({
    super.key,
    required this.itemNode,
    required this.onNodeSelectionToggle,
    required this.onNodeExpandedToggle,
  });

  final HierarchyNode itemNode;
  final NodeChangedCallback onNodeSelectionToggle;
  final NodeChangedCallback onNodeExpandedToggle;

  @override
  Widget build(BuildContext context) {
    if (itemNode is HierarchyCategoryNode) {
      return HierarchyCategoryTile(
        categoryNode: itemNode as HierarchyCategoryNode,
        onNodeSelectionToggle: onNodeSelectionToggle,
        onNodeExpandedToggle: onNodeExpandedToggle,
      );
    } else if (itemNode is HierarchyDataPoint) {
      return HierarchyDataPointTile(
        dataPointNode: itemNode as HierarchyDataPoint,
        onNodeSelectionToggle: onNodeSelectionToggle,
        onNodeExpandedToggle: onNodeExpandedToggle,
      );
    } else {
      return const Center(child: Text('Unknown node type'));
    }
  }
}
