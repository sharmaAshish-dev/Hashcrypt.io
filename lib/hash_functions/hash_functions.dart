import 'dart:convert';
import 'package:hashlib/hashlib.dart' as hash;

enum HashType {
  md5,
  sha1,
  sha256,
  sha384,
  sha512,
  sha3_256,
  sha3_384,
  sha3_512,
}

extension HashTypeName on HashType {
  String get name {
    switch (this) {
      case HashType.md5:
        return "MD5";
      case HashType.sha1:
        return "SHA-1";
      case HashType.sha256:
        return "SHA-256";
      case HashType.sha384:
        return "SHA-384";
      case HashType.sha512:
        return "SHA-512";
      case HashType.sha3_256:
        return "SHA3-256";
      case HashType.sha3_384:
        return "SHA3-384";
      case HashType.sha3_512:
        return "SHA3-512";
      default:
        return "MD5";
    }
  }
}

class HashFunctions {
  static String md5(String text) {
    return "${hash.md5.string(text)}";
  }

  static String sha1(String text) {
    return hash.sha1.convert(utf8.encode(text)).toString();
  }

  static String sha256(String text) {
    return hash.sha256.convert(utf8.encode(text)).toString();
  }

  static String sha384(String text) {
    return hash.sha384.convert(utf8.encode(text)).toString();
  }

  static String sha512(String text) {
    return hash.sha512.convert(utf8.encode(text)).toString();
  }

  static String sha3_256(String text) {
    return hash.sha3_256.convert(utf8.encode(text)).toString();
  }

  static String sha3_384(String text) {
    return hash.sha3_384.convert(utf8.encode(text)).toString();
  }

  static String sha3_512(String text) {
    return hash.sha3_512.convert(utf8.encode(text)).toString();
  }

}
