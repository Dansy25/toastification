import 'package:flutter/material.dart';
import 'package:toastification/src/core/style_parameter_builder.dart';

/// Using this enum you can define the behavior of the toast close button
enum CloseButtonShowType {
  /// [always] - show the close button always
  always._('Always'),

  /// [onHover] - show the close button only when the mouse is hovering the toast
  onHover._('On Hover'),

  /// [none] - do not show the close button
  none._('None');

  const CloseButtonShowType._(this.title);

  final String title;

  @override
  String toString() => title;

  String toValueString() => 'CloseButtonShowType.$name';
}

/// Creates the built-in toastification content - title, description, progress bar
///
/// This widget is used by the built-in toastification widgets
class BuiltInContent extends StatelessWidget {
  const BuiltInContent({
    super.key,
    required this.styleParameters,
    this.title,
    this.description,
    this.progressBarValue,
    this.progressBarWidget,
  });

  final StyleParameters styleParameters;

  final Widget? title;
  final Widget? description;

  final double? progressBarValue;
  final Widget? progressBarWidget;

  @override
  Widget build(BuildContext context) {
    Widget content = DefaultTextStyle.merge(
      style: styleParameters.defaultStyle.titleTextStyle(context)?.copyWith(
            color: styleParameters.foregroundColor,
          ),
      child: title ?? const SizedBox(),
    );

    final showColumn =
        description != null || styleParameters.showProgressBar == true;
    if (!showColumn) {
      return content;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        content,
        if (description != null) ...[
          const SizedBox(height: 6),
          DefaultTextStyle.merge(
            style: styleParameters.defaultStyle
                .descriptionTextStyle(context)
                ?.copyWith(
                  color: styleParameters.foregroundColor,
                ),
            child: description!,
          ),
        ],
        if (styleParameters.showProgressBar) ...[
          const SizedBox(height: 10),
          ProgressIndicatorTheme(
            data: styleParameters.progressIndicatorTheme,
            child: progressBarWidget ??
                LinearProgressIndicator(value: progressBarValue),
          ),
        ],
      ],
    );
  }
}
