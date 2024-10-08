// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/freezed_annotation.dart';
import 'package:infrastructure/analytics/failure/failure.dart';
import 'package:infrastructure/presentation/models/paginated.model.dart';

part 'paginated_list.cubit.freezed.dart';
part 'states/paginated_list.state.dart';

/// An abstract class that defines the behavior of paginated list cubits.
/// It must be extended by a concrete class to implement data fetching.
abstract class PaginatedListCubit<T> implements Cubit<PaginatedListState<T>> {
  /// Fetches a paginated list of items with a specified limit and page.
  ///
  /// [limit] - The number of items to fetch (default is 20).
  /// [page] - The page from where to start fetching (default is 0).
  Future<void> fetch({int limit = 20, int page = 0});
}
