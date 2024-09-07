class ApiResponse<T> {
  final int statusCode;
  final T data;
  final String message;
  final bool success;

  ApiResponse({
    required this.statusCode,
    required this.data,
    required this.message,
    required this.success,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) {
    return ApiResponse<T>(
      statusCode: json['statusCode'],
      data: fromJsonT(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'statusCode': statusCode,
      'data': toJsonT(data),
      'message': message,
      'success': success,
    };
  }
}
