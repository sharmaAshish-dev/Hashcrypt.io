import 'hash_functions.dart';

extension Hashes on String {
  String encode(HashType type) {
    switch(type){
      case HashType.md5:
        return HashFunctions.md5(this);
      case HashType.sha1:
        return HashFunctions.sha1(this);
      case HashType.sha256:
        return HashFunctions.sha256(this);
      case HashType.sha384:
        return HashFunctions.sha384(this);
      case HashType.sha512:
        return HashFunctions.sha512(this);
      case HashType.sha3_256:
        return HashFunctions.sha3_256(this);
      case HashType.sha3_384:
        return HashFunctions.sha3_384(this);
      case HashType.sha3_512:
        return HashFunctions.sha3_512(this);
    }
  }
}