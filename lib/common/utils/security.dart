import 'dart:convert';
import 'package:crypto/crypto.dart';

/// SHA256
String duSHA256(String input) {
  String salt = 'EIpWsyfiy@R@X#qn17!StJNdZK1fFF8iV6ffN!goZkqt#JxO'; // 加盐
  var bytes = utf8.encode(input + salt);
  var digest = sha256.convert(bytes);

  return digest.toString();
}

int getStringLength(String? text) {
  String punctuation = '.,!?;:"\'()[]{}<>，。！？；：“”‘’（）【】{}《》';
  String cleanedText =
      (text ?? "").replaceAll(RegExp('[$punctuation\\p{Script=Han}]'), '');
  return cleanedText.length;
}

int countLengthWithoutPunctuation(String input) {
  String punctuation = '.,!?;:"\'()[]{}<>，。！？；：“”‘’（）【】{}《》';
  int count = 0;

  for (int i = 0; i < input.length; i++) {
    if (!punctuation.contains(input[i])) {
      count++;
    }
  }

  return count;
}
