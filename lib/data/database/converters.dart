import 'dart:convert';

import 'package:drift/drift.dart';

/// Stores a `List<String>` (e.g. photo paths) as a JSON array text column
/// (Blueprint Section 3.2 — "JSON array of relative paths").
class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();

  @override
  List<String> fromSql(String fromDb) {
    if (fromDb.isEmpty) return const [];
    final decoded = jsonDecode(fromDb) as List<dynamic>;
    return decoded.cast<String>();
  }

  @override
  String toSql(List<String> value) => jsonEncode(value);
}

/// Stores a `List<int>` (reminder offsets) as a JSON array text column.
class IntListConverter extends TypeConverter<List<int>, String> {
  const IntListConverter();

  @override
  List<int> fromSql(String fromDb) {
    if (fromDb.isEmpty) return const [];
    final decoded = jsonDecode(fromDb) as List<dynamic>;
    return decoded.cast<int>();
  }

  @override
  String toSql(List<int> value) => jsonEncode(value);
}
