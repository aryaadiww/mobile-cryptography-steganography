class EnkripResult {
  final String encryptedMessage;
  final String imageUrl;
  final String shiftedAlphabet;
  final bool success;

  EnkripResult({
    required this.encryptedMessage,
    required this.imageUrl,
    required this.shiftedAlphabet,
    required this.success,
  });

  factory EnkripResult.fromJson(Map<String, dynamic> json) {
    return EnkripResult(
      encryptedMessage: json['encrypted_message'] ?? '',
      imageUrl: json['image_url'] ?? '',
      shiftedAlphabet: json['shifted_alphabet'] ?? '',
      success: json['success'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'encrypted_message': encryptedMessage,
      'image_url': imageUrl,
      'shifted_alphabet': shiftedAlphabet,
      'success': success,
    };
  }
}
