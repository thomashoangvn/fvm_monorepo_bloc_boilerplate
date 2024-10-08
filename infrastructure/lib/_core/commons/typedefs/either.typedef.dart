// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

import 'package:deps/packages/fpdart.dart';
import 'package:infrastructure/analytics/failure/failure.dart';

/// Type alias for an asynchronous operation that returns an `Either` type with
/// a `Failure` on the left side (indicating an error) or a value of type `T`
/// on the right side (indicating success).
///
/// This is commonly used in operations that perform asynchronous tasks such as
/// network requests or database queries.
///
/// Example usage:
/// ```dart
/// AsyncEither<MyData> fetchData() {
///   // Implementation here
/// }
/// ```
typedef AsyncEither<T> = Future<Either<Failure, T>>;

/// Type alias for a synchronous operation that returns an `Either` type with
/// a `Failure` on the left side (indicating an error) or a value of type `T`
/// on the right side (indicating success).
///
/// This is useful for operations that do not involve asynchronous tasks but
/// can still fail and need to return a result or an error.
///
/// Example usage:
/// ```dart
/// SyncEither<int> validateData() {
///   // Implementation here
/// }
/// ```
typedef SyncEither<T> = Either<Failure, T>;
