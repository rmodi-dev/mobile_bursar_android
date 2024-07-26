class StudentsResponse {
  final String data;

  StudentsResponse({
    required this.data,
  });

  factory StudentsResponse.fromJson(Map<String, dynamic> json) {
    return StudentsResponse(
      data: json['data'],
    );
  }

  factory StudentsResponse.fromRawJson(Map<String, dynamic> json) {
    return StudentsResponse(
      data: json['data'],
    );
  }
}
