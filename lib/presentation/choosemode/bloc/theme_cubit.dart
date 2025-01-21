import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);
  void updatetheme(ThemeMode thememode) => emit(thememode);
  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    final theme = json['theme'] as String?;
    if (theme == 'light') {
      return ThemeMode.light;
    } else if (theme == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    String theme;
    if (state == ThemeMode.light) {
      theme = 'light';
    } else if (state == ThemeMode.dark) {
      theme = 'dark';
    } else {
      theme = 'system';
    }
    return {'theme': theme};
  }
}
