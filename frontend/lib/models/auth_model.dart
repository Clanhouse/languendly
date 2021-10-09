import 'package:equatable/equatable.dart';

class Auth extends Equatable {
  final String access;
  final String refresh;

  Auth({required this.access, required this.refresh});

  @override
  List<Object?> get props => [access, refresh];

  Map<String, dynamic> toMap() {
    return {
      'access': this.access,
      'refresh': this.refresh,
    };
  }

  factory Auth.fromMap(Map<String, dynamic> map) {
    return Auth(
      access: map['access'] as String,
      refresh: map['refresh'] as String,
    );
  }

  Auth copyWith({
    String? access,
    String? refresh,
  }) {
    return Auth(
      access: access ?? this.access,
      refresh: refresh ?? this.refresh,
    );
  }
}
