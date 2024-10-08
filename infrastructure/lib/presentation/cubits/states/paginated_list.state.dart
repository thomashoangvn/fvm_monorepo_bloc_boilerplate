// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

part of '../paginated_list.cubit.dart';

/// Defines the various states of the [PaginatedListCubit] using Freezed.
@freezed
class PaginatedListState<T> with _$PaginatedListState<T> {
  /// Represents the state when data fetching fails with a [Failure].
  const factory PaginatedListState.failed(Failure failure) =
      PaginatedListStateFailed<T>;

  /// Represents the initial state before any data has been loaded.
  const factory PaginatedListState.initial() = PaginatedListStateInitial<T>;

  /// Represents the state when data has been successfully loaded.
  const factory PaginatedListState.loaded(PaginatedModel<T> data) =
      PaginatedListStateLoaded<T>;

  /// Represents the loading state while data is being fetched.
  const factory PaginatedListState.loading() = PaginatedListStateLoading<T>;

  /// Represents the state when the list is being refreshed.
  const factory PaginatedListState.refresh() = PaginatedListStateRefresh<T>;
}
