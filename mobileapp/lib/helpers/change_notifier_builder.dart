import 'package:flutter/widgets.dart';

/// A builder widget that rebuilds when a [ChangeNotifier] notifies its listeners.
/// This is a key component in implementing the MVVM (Model-View-ViewModel) pattern
/// where ViewModels extend [ChangeNotifier] and notify their listeners when their state changes.
///
/// Usage:
/// ```dart
/// ChangeNotifierBuilder(
///   notifier: viewModel,
///   builder: (context) => Text(viewModel.someField),
/// )
/// ```
///
/// The widget will automatically subscribe to the notifier's changes and rebuild
/// only the necessary parts of the UI when [notifier.notifyListeners()] is called.
class ChangeNotifierBuilder extends StatefulWidget {
  final ChangeNotifier notifier;
  final Widget Function(BuildContext context) builder;

  const ChangeNotifierBuilder({
    super.key,
    required this.notifier,
    required this.builder,
  });

  @override
  _ChangeNotifierBuilderState createState() => _ChangeNotifierBuilderState();
}

class _ChangeNotifierBuilderState extends State<ChangeNotifierBuilder> {
  late ChangeNotifier oldObject;

  @override
  void initState() {
    super.initState();
    widget.notifier.addListener(_listener);
    oldObject = widget.notifier;
  }

  @override
  void didUpdateWidget(covariant ChangeNotifierBuilder oldWidget) {
    oldWidget.notifier.removeListener(_listener);
    widget.notifier.addListener(_listener);
    super.didUpdateWidget(oldWidget);
  }

  void _listener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.notifier.removeListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}

/// A builder widget that rebuilds when multiple [ChangeNotifier]s notify their listeners.
/// This is useful when a view depends on multiple ViewModels or different parts of the
/// application state.
///
/// Usage:
/// ```dart
/// MultiChangeNotifierBuilder(
///   notifiers: [viewModel1, viewModel2],
///   builder: (context) => Text('${viewModel1.field} ${viewModel2.field}'),
/// )
/// ```
class MultiChangeNotifierBuilder extends StatefulWidget {
  final List<ChangeNotifier> notifiers;
  final Widget Function(BuildContext context) builder;

  const MultiChangeNotifierBuilder(
      {super.key, required this.notifiers, required this.builder});

  @override
  _MultiChangeNotifierBuilderState createState() =>
      _MultiChangeNotifierBuilderState();
}

class _MultiChangeNotifierBuilderState
    extends State<MultiChangeNotifierBuilder> {
  @override
  void initState() {
    super.initState();
    for (var notifier in widget.notifiers) {
      notifier.addListener(_listener);
    }
  }

  void _listener() {
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    for (var notifier in widget.notifiers) {
      notifier.removeListener(_listener);
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context);
  }
}
