class ApiResponse<T> {
  T? data;
  String? message;
  bool success;

  ApiResponse.success(this.data) : success = true, message = null;

  ApiResponse.error(this.message) : success = false, data = null;

  @override
  String toString() {
    if (success) {
      return 'ApiResponse: Success { data: $data }';
    } else {
      return 'ApiResponse: Error { message: $message }';
    }
  }
}
