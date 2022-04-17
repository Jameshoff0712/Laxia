class Token {
  final String token;
  final String tokenType;
  final int expiresIn;
  const Token({
    required this.token,
    required this.tokenType,
    required this.expiresIn,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
        token: json['token'],
        tokenType: json['token_type'],
        expiresIn: json['expires_in']);
  }
}
