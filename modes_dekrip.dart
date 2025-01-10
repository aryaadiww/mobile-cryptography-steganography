class DekripResult {
  final String decryptedMessage;
  final String encryptedMessage;
  final int shiftKey;
  final bool success;

  DekripResult({
    required this.decryptedMessage,
    required this.encryptedMessage,
    required this.shiftKey,
    required this.success,
  });

  factory DekripResult.fromJson(Map<String, dynamic> json) {
    return DekripResult(
      decryptedMessage: json['decrypted_message'] ?? 'No Data!',
      encryptedMessage: json['encrypted_message'] ?? 'No Data!',
      shiftKey: json['shift_key'] ?? 'No Data!',
      success: json['success'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'decryptedMessage': decryptedMessage,
      'encryptedMessage': encryptedMessage,
      'shiftKey': shiftKey,
      'success': success,
    };
  }
}
