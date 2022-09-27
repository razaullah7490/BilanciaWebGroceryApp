import 'package:equatable/equatable.dart';

class CustomError extends Equatable {
  final String error;
  const CustomError({
    required this.error,
  });

  @override
  List<Object> get props => [error];

  @override
  String toString() => error;
}
