class ResponseEntity<T> {
  int? code;
  String? message;
  T? data;

  ResponseEntity({this.code, this.message, this.data});

  @override
  String toString() {
    return 'ResponseEntity{code: $code, message: $message, data: $data}';
  }
}
