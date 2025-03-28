import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

final _colorScheme = ShadColorScheme(
  background: DSColors.white,
  foreground: DSColors.primary.shade600,
  card: DSColors.primary,
  cardForeground: DSColors.error,
  popover: DSColors.gray.shade100,
  popoverForeground: DSColors.gray.shade300,
  primary: DSColors.primary,
  primaryForeground: DSColors.neutralMediumWave,
  secondary: DSColors.neutralMediumWave,
  secondaryForeground: DSColors.white,
  muted: DSColors.primary.shade600,
  mutedForeground: DSColors.primary.shade800,
  accent: DSColors.gray.shade200,
  accentForeground: DSColors.gray.shade100,
  destructive: DSColors.error,
  destructiveForeground: DSColors.neutralMediumWave,
  border: DSColors.primary.shade800,
  input: DSColors.primary.shade600,
  ring: DSColors.neutralMediumWave,
  selection: DSColors.primary.shade700,
);

class DSApp extends ShadApp {
  DSApp({
    super.key,
    super.navigatorKey,
    super.onGenerateRoute,
    super.onGenerateInitialRoutes,
    super.onUnknownRoute,
    super.onNavigationNotification,
    super.navigatorObservers = const <NavigatorObserver>[],
    super.initialRoute,
    super.home,
    super.routes = const <String, WidgetBuilder>{},
    super.builder,
    super.title = '',
    super.onGenerateTitle,
    super.locale,
    super.localizationsDelegates,
    super.localeListResolutionCallback,
    super.localeResolutionCallback,
    super.supportedLocales = const <Locale>[Locale('pt', 'pt-br')],
    super.showPerformanceOverlay = false,
    super.showSemanticsDebugger = false,
    super.debugShowCheckedModeBanner = false,
    super.shortcuts,
    super.actions,
    super.darkTheme,
    super.themeMode,
    Brightness? brightness,
    super.restorationScopeId,
    super.scrollBehavior = const ShadScrollBehavior(),
    super.pageRouteBuilder,
    super.themeCurve = Curves.linear,
    super.materialThemeBuilder,
  }) : super(
          color: DSColors.primary,
          theme: ShadThemeData(
            brightness: brightness ?? Brightness.light,
            colorScheme: _colorScheme,
          ),
        );

  /// Cria um [DSApp] que usa o [Router] em vez de um [Navigator].
  DSApp.router({
    super.key,
    super.darkTheme,
    super.themeMode,
    Brightness? brightness,
    super.routeInformationProvider,
    super.routeInformationParser,
    super.routerDelegate,
    super.backButtonDispatcher,
    super.routerConfig,
    super.builder,
    super.title = '',
    super.onGenerateTitle,
    super.onNavigationNotification,
    super.color,
    super.locale,
    super.localizationsDelegates,
    super.localeListResolutionCallback,
    super.localeResolutionCallback,
    super.supportedLocales = const <Locale>[Locale('pt', 'pt-br')],
    super.showPerformanceOverlay = false,
    super.showSemanticsDebugger = false,
    super.debugShowCheckedModeBanner = false,
    super.shortcuts,
    super.actions,
    super.restorationScopeId,
    super.scrollBehavior = const ShadScrollBehavior(),
    super.themeCurve = Curves.linear,
    super.materialThemeBuilder,
  }) : super.router(
          theme: ShadThemeData(
            brightness: brightness ?? Brightness.light,
            colorScheme: _colorScheme,
          ),
        );

  /// Cria um [MaterialApp] envolto por um [ShadTheme].
  DSApp.material({
    super.key,
    super.navigatorKey,
    super.onGenerateRoute,
    super.onGenerateInitialRoutes,
    super.onUnknownRoute,
    super.onNavigationNotification,
    super.navigatorObservers = const <NavigatorObserver>[],
    super.initialRoute,
    super.home,
    super.routes = const <String, WidgetBuilder>{},
    super.builder,
    super.title = '',
    super.onGenerateTitle,
    super.color,
    super.locale,
    super.localizationsDelegates,
    super.localeListResolutionCallback,
    super.localeResolutionCallback,
    super.supportedLocales = const <Locale>[Locale('pt', 'pt-br')],
    super.showPerformanceOverlay = false,
    super.showSemanticsDebugger = false,
    super.debugShowCheckedModeBanner = false,
    super.shortcuts,
    super.actions,
    super.themeMode,
    Brightness? brightness,
    super.restorationScopeId,
    super.scrollBehavior = const MaterialScrollBehavior(),
    super.pageRouteBuilder,
    super.themeCurve = Curves.linear,
    super.materialThemeBuilder,
  }) : super.material(
          theme: ShadThemeData(
            brightness: brightness ?? Brightness.light,
            colorScheme: _colorScheme,
          ),
        );

  /// Cria um [MaterialApp] envolto por um [ShadTheme] que usa o [Router] em vez de um [Navigator].
  DSApp.materialRouter({
    super.key,
    super.themeMode,
    super.routeInformationProvider,
    super.routeInformationParser,
    super.routerDelegate,
    super.backButtonDispatcher,
    super.routerConfig,
    super.builder,
    super.title = '',
    super.onGenerateTitle,
    super.onNavigationNotification,
    super.color,
    super.locale,
    super.localizationsDelegates,
    super.localeListResolutionCallback,
    super.localeResolutionCallback,
    super.supportedLocales = const <Locale>[Locale('pt', 'pt-br')],
    super.showPerformanceOverlay = false,
    super.showSemanticsDebugger = false,
    super.debugShowCheckedModeBanner = false,
    super.shortcuts,
    Brightness? brightness,
    super.actions,
    super.restorationScopeId,
    super.scrollBehavior = const MaterialScrollBehavior(),
    super.themeCurve = Curves.linear,
    super.materialThemeBuilder,
  }) : super.materialRouter(
          theme: ShadThemeData(
            brightness: brightness ?? Brightness.light,
            colorScheme: _colorScheme,
          ),
        );

  /// Cria um [CupertinoApp] envolto por um [ShadTheme].
  DSApp.cupertino({
    super.key,
    super.navigatorKey,
    super.onGenerateRoute,
    super.onGenerateInitialRoutes,
    super.onUnknownRoute,
    super.onNavigationNotification,
    super.navigatorObservers = const <NavigatorObserver>[],
    super.initialRoute,
    super.home,
    super.routes = const <String, WidgetBuilder>{},
    super.builder,
    super.title = '',
    super.onGenerateTitle,
    super.color,
    super.locale,
    super.localizationsDelegates,
    super.localeListResolutionCallback,
    super.localeResolutionCallback,
    super.supportedLocales = const <Locale>[Locale('pt', 'pt-br')],
    super.showPerformanceOverlay = false,
    super.showSemanticsDebugger = false,
    super.debugShowCheckedModeBanner = false,
    super.shortcuts,
    super.actions,
    super.darkTheme,
    super.themeMode,
    super.restorationScopeId,
    super.scrollBehavior,
    super.pageRouteBuilder,
    Brightness? brightness,
    super.themeCurve = Curves.linear,
    super.cupertinoThemeBuilder,
    super.materialThemeBuilder,
  }) : super.cupertino(
          theme: ShadThemeData(
            brightness: brightness ?? Brightness.light,
            colorScheme: _colorScheme,
          ),
        );

  /// Cria um [CupertinoApp] envolto por um [ShadTheme] que usa o [Router] em vez de um [Navigator].
  DSApp.cupertinoRouter({
    super.key,
    super.themeMode,
    super.routeInformationProvider,
    super.routeInformationParser,
    super.routerDelegate,
    super.backButtonDispatcher,
    super.routerConfig,
    super.builder,
    super.title = '',
    super.onGenerateTitle,
    super.onNavigationNotification,
    super.color,
    super.locale,
    super.localizationsDelegates,
    super.localeListResolutionCallback,
    super.localeResolutionCallback,
    super.supportedLocales = const <Locale>[Locale('pt', 'pt-br')],
    super.showPerformanceOverlay = false,
    super.showSemanticsDebugger = false,
    super.debugShowCheckedModeBanner = false,
    super.shortcuts,
    super.actions,
    super.restorationScopeId,
    super.scrollBehavior,
    super.themeCurve = Curves.linear,
    super.cupertinoThemeBuilder,
    Brightness? brightness,
    super.materialThemeBuilder,
  }) : super.cupertinoRouter(
          theme: ShadThemeData(
            brightness: brightness ?? Brightness.light,
            colorScheme: _colorScheme,
          ),
        );
}
