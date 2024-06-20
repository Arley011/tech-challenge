part of 'hierarchy_widget.dart';

class HierarchyCategoryTile extends StatelessWidget {
  const HierarchyCategoryTile({
    super.key,
    required this.categoryNode,
    required this.onNodeSelectionToggle,
    required this.onNodeExpandedToggle,
  });

  final HierarchyCategoryNode categoryNode;
  final NodeChangedCallback onNodeSelectionToggle;
  final NodeChangedCallback onNodeExpandedToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ExpansionTile(
      childrenPadding: const EdgeInsets.only(left: 20),
      title: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        child: Row(
          children: [
            CupertinoCheckbox(
              value: categoryNode.isSelected,
              onChanged: (_) => onNodeSelectionToggle(categoryNode),
              shape: const CircleBorder(),
              activeColor: categoryNode.color,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                categoryNode.label,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      children: [
        ...categoryNode.children.map(
          (child) => HierarchyItemTile(
            itemNode: child,
            onNodeSelectionToggle: onNodeSelectionToggle,
            onNodeExpandedToggle: onNodeExpandedToggle,
          ),
        ),
      ],
    );
  }
}
