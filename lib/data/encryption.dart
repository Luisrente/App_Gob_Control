import 'package:encrypt/encrypt.dart';

const _key = '1234567';

class EncryptionService {
  String encryptData(String carnet) {
    final key = Key.fromLength(32);
    final iv = IV.fromLength(8);
    final encrypter = Encrypter(Salsa20(key));
    final encrypted = encrypter.encrypt(carnet, iv: iv);
    return encrypted.base64;
  }

  descrypData(String encrypted) {
    final key = Key.fromLength(32);
    final iv = IV.fromLength(8);
    try {
      final encrypter = Encrypter(Salsa20(key));
      final String decrypted =
          encrypter.decrypt(Encrypted.from64(encrypted), iv: iv);
      return decrypted;
    } catch (e) {
      return null;
    }
  }
}
