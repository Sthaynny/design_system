import 'package:shadcn_ui/shadcn_ui.dart';

/// Op es de layout de caption para o widget [ShadCalendar].
enum DSCalendarCaptionLayout {
  /// Exibe o m s e ano como um r tulo. Valor padr o.
  label,

  /// Exibe um menu suspenso com m s e anos.
  dropdown,

  /// Exibe um menu suspenso somente com m s.
  dropdownMonths,

  /// Exibe um menu suspenso somente com anos.
  dropdownYears,
  ;

  const DSCalendarCaptionLayout();

  ShadCalendarCaptionLayout get mapToShadCalendarCaptionLayout =>
      switch (this) {
        DSCalendarCaptionLayout.label => ShadCalendarCaptionLayout.label,
        DSCalendarCaptionLayout.dropdown => ShadCalendarCaptionLayout.dropdown,
        DSCalendarCaptionLayout.dropdownMonths =>
          ShadCalendarCaptionLayout.dropdownMonths,
        DSCalendarCaptionLayout.dropdownYears =>
          ShadCalendarCaptionLayout.dropdownYears,
      };
}

