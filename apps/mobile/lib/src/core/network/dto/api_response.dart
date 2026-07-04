class ApiResponse<T> {
  final T data;
  final int statusCode;

  const ApiResponse({
    required this.data,
    required this.statusCode,
  });
}
