import 'package:deps/packages/freezed_annotation.dart';

part 'paginated.model.freezed.dart';
part 'paginated.model.g.dart';

void pageConverter(Map<dynamic, dynamic> json, dynamic _) => json['currentPage'] ?? json['page'];

@freezed
@JsonSerializable(genericArgumentFactories: true)
class PaginatedModel<T> with _$PaginatedModel<T> {
  const factory PaginatedModel({
    @JsonKey(readValue: pageConverter) required int currentPage,
    required int size,
    required int total,
    required List<T> items,
  }) = _PaginatedModel<T>;

  const PaginatedModel._();

  factory PaginatedModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return _$PaginatedModelFromJson<T>(json, fromJsonT);
  }

  factory PaginatedModel.empty() => PaginatedModel<T>(currentPage: 1, size: 100, total: 0, items: <T>[]);

  bool get isNotEmpty => this != PaginatedModel<T>.empty();
}
