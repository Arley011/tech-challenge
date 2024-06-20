part of 'hierarchy_widget.dart';

class HierarchyDataPointTile extends StatelessWidget {
  const HierarchyDataPointTile({
    super.key,
    required this.dataPointNode,
    required this.onNodeSelectionToggle,
    required this.onNodeExpandedToggle,
  });

  final HierarchyDataPoint dataPointNode;
  final NodeChangedCallback onNodeSelectionToggle;
  final NodeChangedCallback onNodeExpandedToggle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      onTap: () => onNodeSelectionToggle(dataPointNode),
      title: Container(
        padding: const EdgeInsets.only(
          left: 20,
          top: 8,
          bottom: 8,
        ),
        child: Row(
          children: [
            CupertinoCheckbox(
              value: dataPointNode.isSelected,
              onChanged: (_) => onNodeSelectionToggle(dataPointNode),
              shape: const CircleBorder(),
              activeColor: dataPointNode.color,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                dataPointNode.label,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
