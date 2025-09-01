import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io' show Platform;

/// デスクトッププラットフォーム向けのデータベース初期化
void initializeDatabaseFactory() {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    // デスクトッププラットフォーム用のFFI初期化
    databaseFactory = databaseFactoryFfi;
    sqfliteFfiInit();
  }
}
