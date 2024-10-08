// Copyright 2024 Thomas Hoang
//
// This source code is licensed under the MIT License found in the
// LICENSE file.
//

/// A type alias for a function that takes a `Map<String, dynamic>` (typically JSON)
/// and returns an instance of a model of type `I`.
///
/// This is commonly used in deserialization, where a model object is constructed
/// from a JSON representation.
///
/// Example usage:
/// ```dart
/// ModelFromJson<MyModel> fromJson = (json) => MyModel.fromJson(json);
/// ```
///
/// In this example, `MyModel.fromJson` would be a factory constructor or a
/// static method that takes a `Map<String, dynamic>` and returns a `MyModel` instance.
typedef ModelFromJson<I> = I Function(Map<String, dynamic> json);
