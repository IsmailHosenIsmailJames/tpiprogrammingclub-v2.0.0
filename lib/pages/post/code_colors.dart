import 'package:flutter/material.dart';

class CodeColors {
  Color python(String w) {
    List<String> blue = [
      'f',
      'False',
      'None',
      'True',
      'and',
      'class',
      'in',
      'is',
      'lambda',
      'nonlocal',
      'not',
      'or',
    ];
    List<String> purple = [
      'pass',
      'raise',
      'def',
      'continue',
      'del',
      'elif',
      'else',
      'except',
      'finally',
      'for',
      'from',
      'global',
      'return',
      'try',
      'while',
      'with',
      'yield',
      'if',
      'import',
      'as',
      'assert',
      'async',
      'await',
      'break',
    ];

    List<String> green = [
      'u',
      'r',
      'bool',
      'int',
      'float',
      'complex',
      'str',
      'bytes',
      'bytearray',
      'list',
      'tuple',
      'set',
      'frozenset',
      'dict',
    ];
    List<String> yello = [
      '(',
      ')',
      '{',
      '}',
      '[',
      ']',
      '<',
      '>',
    ];

    if (blue.contains(w)) {
      return Colors.lightBlue;
    } else if (purple.contains(w)) {
      return Colors.purpleAccent;
    } else if (green.contains(w)) {
      return Colors.lightGreen;
    } else if (yello.contains(w)) {
      return Colors.yellow;
    } else {
      if (w[0] == "#") {
        return Colors.green;
      } else if (w[0] == "'" || w[0] == '"') {
        return const Color.fromARGB(255, 255, 154, 2);
      }
    }
    return const Color.fromARGB(255, 150, 207, 255);
  }
}
