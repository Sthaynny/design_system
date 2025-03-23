import 'package:design_system/src/extensions/ds_date_time.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class DSDateFormField extends ShadDatePickerFormField {
  DSDateFormField({
    super.id,
    super.key,
    super.onSaved,
    super.label,
    super.error,
    super.description,

    /// {@macro DSCalendar.onChanged}
    super.onChanged,
    super.valueTransformer,
    super.onReset,
    super.enabled,
    super.autovalidateMode,
    super.restorationId,

    /// {@macro DSPopover.focusNode}
    super.focusNode,
    super.validator,
    super.initialValue,

    /// {@macro DSShadDatePicker.placeholder}
    super.placeholder,

    /// {@macro DSShadDatePicker.closeOnSelection}
    super.closeOnSelection,

    /// {@macro DSShadDatePicker.formatDateRange}
    String Function(DateTime)? formatDate,

    /// {@macro DSShadDatePicker.allowDeselection}
    super.allowDeselection,

    /// {@macro DSShadDatePicker.header}
    super.header,

    /// {@macro DSShadDatePicker.footer}
    super.footer,

    /// {@macro DSPopover.groupId}
    super.groupId,

    /// {@macro DSPopover.padding}
    super.popoverPadding,

    /// {@macro DSCalendar.multipleSelected}
    super.multipleSelected,

    /// {@macro DSCalendar.onMultipleChanged}
    super.onMultipleChanged,

    /// {@macro DSCalendar.showOutsideDays}
    super.showOutsideDays,

    /// {@macro DSCalendar.initialMonth}
    super.initialMonth,

    /// {@macro DSCalendar.formatMonthYear}
    super.formatMonthYear,

    /// {@macro DSCalendar.formatMonth}
    super.formatMonth,

    /// {@macro DSCalendar.formatYear}
    super.formatYear,

    /// {@macro DSCalendar.formatWeekday}
    super.formatWeekday,

    /// {@macro DSCalendar.showWeekNumbers}
    super.showWeekNumbers,

    /// {@macro DSCalendar.weekStartsOn}
    super.weekStartsOn,

    /// {@macro DSCalendar.fixedWeeks}
    super.fixedWeeks,

    /// {@macro DSCalendar.hideWeekdayNames}
    super.hideWeekdayNames,

    /// {@macro DSCalendar.numberOfMonths}
    super.numberOfMonths = 1,

    /// {@macro DSCalendar.fromMonth}
    super.fromMonth,

    /// {@macro DSCalendar.toMonth}
    super.toMonth,

    /// {@macro DSCalendar.onMonthChanged}
    super.onMonthChanged,

    /// {@macro DSCalendar.reverseMonths}
    super.reverseMonths = false,

    /// {@macro DSCalendar.min}
    super.min,

    /// {@macro DSCalendar.max}
    super.max,

    /// {@macro DSCalendar.selectableDayPredicate}
    super.selectableDayPredicate,

    /// {@macro DSCalendar.captionLayout}
    super.captionLayout,

    /// {@macro DSCalendar.hideNavigation}
    super.hideNavigation,

    /// {@macro DSCalendar.yearSelectorMinWidth}
    super.yearSelectorMinWidth,

    /// {@macro DSCalendar.monthSelectorMinWidth}
    super.monthSelectorMinWidth,

    /// {@macro DSCalendar.yearSelectorPadding}
    super.yearSelectorPadding,

    /// {@macro DSCalendar.monthSelectorPadding}
    super.monthSelectorPadding,

    /// {@macro DSCalendar.navigationButtonSize}
    super.navigationButtonSize,

    /// {@macro DSCalendar.navigationButtonIconSize}
    super.navigationButtonIconSize,

    /// {@macro DSCalendar.backNavigationButtonIconData}
    super.backNavigationButtonIconData,

    /// {@macro DSCalendar.forwardNavigationButtonIconData}
    super.forwardNavigationButtonIconData,

    /// {@macro DSCalendar.navigationButtonPadding}
    super.navigationButtonPadding,

    /// {@macro DSCalendar.navigationButtonDisabledOpacity}
    super.navigationButtonDisabledOpacity,

    /// {@macro DSCalendar.spacingBetweenMonths}
    super.spacingBetweenMonths,

    /// {@macro DSCalendar.runSpacingBetweenMonths}
    super.runSpacingBetweenMonths,

    /// {@macro DSCalendar.monthConstraints}
    super.monthConstraints,

    /// {@macro DSCalendar.headerHeight}
    super.calendarHeaderHeight,

    /// {@macro DSCalendar.headerPadding}
    super.calendarHeaderPadding,

    /// {@macro DSCalendar.captionLayoutGap}
    super.captionLayoutGap,

    /// {@macro DSCalendar.headerTextStyle}
    super.calendarHeaderTextStyle,

    /// {@macro DSCalendar.weekdaysPadding}
    super.weekdaysPadding,

    /// {@macro DSCalendar.weekdaysTextStyle}
    super.weekdaysTextStyle,

    /// {@macro DSCalendar.weekdaysTextAlign}
    super.weekdaysTextAlign,

    /// {@macro DSCalendar.weekNumbersHeaderText}
    super.weekNumbersHeaderText,

    /// {@macro DSCalendar.weekNumbersHeaderTextStyle}
    super.weekNumbersHeaderTextStyle,

    /// {@macro DSCalendar.weekNumbersTextStyle}
    super.weekNumbersTextStyle,

    /// {@macro DSCalendar.weekNumbersTextAlign}
    super.weekNumbersTextAlign,

    /// {@macro DSCalendar.dayButtonSize}
    super.dayButtonSize,

    /// {@macro DSCalendar.dayButtonOutsideMonthOpacity}
    super.dayButtonOutsideMonthOpacity,

    /// {@macro DSCalendar.dayButtonPadding}
    super.dayButtonPadding,

    /// {@macro DSCalendar.selectedDayButtonTextStyle}
    super.selectedDayButtonTextStyle,

    /// {@macro DSCalendar.dayButtonTextStyle}
    super.dayButtonTextStyle,

    /// {@macro DSCalendar.gridMainAxisSpacing}
    super.gridMainAxisSpacing,

    /// {@macro DSCalendar.gridCrossAxisSpacing}
    super.gridCrossAxisSpacing,

    /// {@macro DSCalendar.dayButtonOutsideMonthTextStyle}
    super.dayButtonOutsideMonthTextStyle,

    /// {@macro DSPopover.closeOnTapOutside}
    super.closeOnTapOutside = true,

    /// {@macro DSPopover.shadows}
    super.shadows,

    /// {@macro DSPopover.filter}
    super.filter,

    /// {@macro ShadMouseArea.groupId}
    super.areaGroupId,

    /// {@macro DSPopover.useSameGroupIdForChild}
    super.useSameGroupIdForChild = true,

    // ---
    // BUTTON
    // ---

    /// {@macro DSButton.onPressed}
    super.onPressed,

    /// {@macro DSButton.onLongPress}
    super.onLongPress,

    /// {@macro DSButton.icon}
    super.icon,

    /// {@macro DSShadDatePicker.iconData}
    super.iconData,

    /// {@macro DSButton.child}
    super.buttonChild,

    /// {@macro DSButton.cursor}
    super.cursor,

    /// {@macro DSButton.width}
    super.width,

    /// {@macro DSButton.height}
    super.height,

    /// {@macro DSButton.padding}
    super.buttonPadding,

    /// {@macro DSButton.backgroundColor}
    super.backgroundColor,

    /// {@macro DSButton.hoverBackgroundColor}
    super.hoverBackgroundColor,

    /// {@macro DSButton.foregroundColor}
    super.foregroundColor,

    /// {@macro DSButton.hoverForegroundColor}
    super.hoverForegroundColor,

    /// {@macro DSButton.autofocus}
    super.autofocus = false,

    /// {@macro DSButton.focusNode}
    super.buttonFocusNode,

    /// {@macro DSButton.pressedBackgroundColor}
    super.pressedBackgroundColor,

    /// {@macro DSButton.pressedForegroundColor}
    super.pressedForegroundColor,

    /// {@macro DSButton.shadows}
    super.buttonShadows,

    /// {@macro DSButton.gradient}
    super.gradient,

    /// {@macro DSButton.textDecoration}
    super.textDecoration,

    /// {@macro DSButton.hoverTextDecoration}
    super.hoverTextDecoration,

    /// {@macro DSButton.gap}
    super.gap,

    /// {@macro DSButton.mainAxisAlignment}
    super.mainAxisAlignment,

    /// {@macro DSButton.crossAxisAlignment}
    super.crossAxisAlignment,

    /// {@macro DSButton.hoverStrategies}
    super.hoverStrategies,

    /// {@macro DSButton.onHoverChange}
    super.onHoverChange,

    /// {@macro DSButton.onTapDown}
    super.onTapDown,

    /// {@macro DSButton.onTapUp}
    super.onTapUp,

    /// {@macro DSButton.onTapCancel}
    super.onTapCancel,

    /// {@macro DSButton.onSecondaryTapDown}
    super.onSecondaryTapDown,

    /// {@macro DSButton.onSecondaryTapUp}
    super.onSecondaryTapUp,

    /// {@macro DSButton.onSecondaryTapCancel}
    super.onSecondaryTapCancel,

    /// {@macro DSButton.onLongPressStart}
    super.onLongPressStart,

    /// {@macro DSButton.onLongPressCancel}
    super.onLongPressCancel,

    /// {@macro DSButton.onLongPressUp}
    super.onLongPressUp,

    /// {@macro DSButton.onLongPressDown}
    super.onLongPressDown,

    /// {@macro DSButton.onLongPressEnd}
    super.onLongPressEnd,

    /// {@macro DSButton.onDoubleTap}
    super.onDoubleTap,

    /// {@macro DSButton.onDoubleTapDown}
    super.onDoubleTapDown,

    /// {@macro DSButton.onDoubleTapCancel}
    super.onDoubleTapCancel,

    /// {@macro DSButton.longPressDuration}
    super.longPressDuration,

    /// {@macro DSButton.textDirection}
    super.textDirection,

    /// {@macro DSButton.onFocusChange}
    super.onFocusChange,

    /// {@macro DSButton.orderPolicy}
    super.orderPolicy,

    /// {@macro DSButton.expands}
    super.expands,
  }) : super(formatDate: formatDate ?? (date) => date.formatDateToPtBr);
}
