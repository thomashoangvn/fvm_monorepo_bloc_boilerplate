// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

// ignore_for_file: no-equal-arguments, avoid-non-null-assertion

import 'dart:async';

import 'package:deps/packages/flutter_bloc.dart';
import 'package:deps/packages/infinite_scroll_pagination.dart';
import 'package:flutter/material.dart';
import 'package:infrastructure/_core/commons/extensions/context.ext.dart';
import 'package:infrastructure/_core/commons/extensions/double.ext.dart';
import 'package:infrastructure/analytics/failure/failure.dart';
import 'package:infrastructure/presentation/cubits/paginated_list.cubit.dart';
import 'package:infrastructure/presentation/models/paginated.model.dart';
import 'package:infrastructure/presentation/super_class.dart';

typedef OnLocalFilter<T> = bool Function(T item)?;
typedef OnNextPage<T> = void Function(PaginatedListCubit<T> bloc, int page);
typedef ItemBuilder<T> = Widget Function(
    BuildContext context, int index, T? item);

class PaginatedList<T, C extends PaginatedListCubit<T>> extends StatefulWidget {
  const PaginatedList({
    required this.itemBuilder,
    this.onNextPage,
    this.bloc,
    super.key,
    this.page = 1,
    this.limit = 20,
    this.onLocalFilter,
  });

  final C? bloc;
  final ItemBuilder<T> itemBuilder;
  final int limit;
  final int page;
  final OnLocalFilter<T> onLocalFilter;
  final OnNextPage<T>? onNextPage;

  @override
  State<PaginatedList<T, C>> createState() => _PaginatedListState<T, C>();
}

class _PaginatedListState<T, C extends PaginatedListCubit<T>>
    extends State<PaginatedList<T, C>> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<C, PaginatedListState<T>>(
      listener: _handleListener,
      bloc: _bloc,
      child: PagedListView<int, T>(
        padding: ($.context.mqPadding.bottom + $.paddings.md).bottom,
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<T>(
          itemBuilder: (BuildContext ctx, T item, int index) {
            return widget.itemBuilder(ctx, index, item);
          },
          firstPageProgressIndicatorBuilder: (_) {
            return SizedBox.shrink(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext ctx, int index) {
                  return widget.itemBuilder(ctx, -1, null);
                },
                itemCount: 20,
              ),
            );
          },
          newPageProgressIndicatorBuilder: (BuildContext ctx) {
            return widget.itemBuilder(ctx, -1, null);
          },
          noItemsFoundIndicatorBuilder: (_) => const Placeholder(),
          animateTransitions: true,
        ),
      ),
    );
  }

  late final C _bloc = widget.bloc ?? $.get<C>();
  late final PagingController<int, T> _pagingController =
      PagingController<int, T>(
    firstPageKey: widget.page,
  );

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener(_onPageRequest);
  }

  void _onPageRequest(int page) {
    if (widget.onNextPage != null) {
      widget.onNextPage?.call(_bloc, page);
    }

    unawaited(_bloc.fetch(limit: widget.limit, page: page));
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  void _handleListener(BuildContext _, PaginatedListState<T> state) {
    switch (state) {
      case PaginatedListStateRefresh<T>():
        _pagingController.refresh();

      case PaginatedListStateFailed<T>(:final Failure failure):
        _pagingController.error = failure.message;

      case PaginatedListStateLoaded<T>(:final PaginatedModel<T> data):
        final List<T> newItems = widget.onLocalFilter == null
            ? data.items
            : data.items
                .where((T item) => !widget.onLocalFilter!(item))
                .toList();
        final bool isLastPage = newItems.length < widget.limit;

        if (isLastPage) {
          _pagingController.appendLastPage(newItems);
        } else {
          final int nextPageKey = (_pagingController.nextPageKey ?? 0) + 1;
          _pagingController.appendPage(newItems, nextPageKey);
        }
    }
  }
}
