import 'package:design_system/design_system.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

extension ShadDateTimeRangeExt on ShadDateTimeRange {
  String get formatDateRangeToPtBr =>
      '${start?.formatDateToPtBr}${end != null ? ' - ${end?.formatDateToPtBr}' : ''}';
}
