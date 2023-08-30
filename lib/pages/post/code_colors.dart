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
        return const Color.fromARGB(255, 219, 132, 0);
      }
    }
    return const Color.fromARGB(255, 150, 207, 255);
  }

  Color dart(String w) {
    List<String> lightBlue = [
      'abstract',
      'assert',
      'deferred',
      'package',
      'part',
      'abstract',
      'boolean',
      'break',
      'byte',
      'case',
      'catch',
      'char',
      'class',
      'const',
      'continue',
      'default',
      'do',
      'double',
    ];
    List<String> lightGreen = [
      'case',
      'catch',
      'class',
      'enum',
      'export',
      'extends',
      'finally',
      'for',
      'if',
      'implements',
      'import',
      'in',
      'is',
      'library',
      'switch',
      'while',
      'with',
      'else',
      'enum',
      'extends',
      'final',
      'finally',
      'for',
      'if',
      'implements',
      'import',
      'instanceof',
      'int',
      'interface',
      'long',
      'break',
      'case',
      'catch',
      'class',
      'const',
      'continue',
      'debugger',
      'default',
      'delete',
      'do',
      'else',
      'export',
      'extends',
      'finally',
      'for',
      'function',
      'if',
      'import',
      'in',
      'instanceof',
      'new',
      'return',
      'switch',
      'this',
      'throw',
      'try',
      'typeof',
      'var',
      'void',
    ];
    List<String> goldenron = [
      'const',
      'final',
      'function',
      'get',
      'interface',
      'late',
      'new',
      'null',
      'operator',
      'override',
      'set',
      'static',
      'super',
      'this',
      'throw',
      'try',
      'typedef',
      'var',
      'void',
      'new',
      'package',
      'private',
      'protected',
      'public',
      'return',
      'static',
      'strictfp',
      'switch',
      'synchronized',
      'this',
      'throw',
      'throws',
      'transient',
      'try',
      'true',
      'false',
      'null',
      'assert',
      'abstract',
      'boolean',
      'byte',
      'char',
      'double',
      'enum',
      'final',
      'float',
      'goto',
      'implements',
      'int',
      'interface',
      'long',
      'native',
      'package',
      'private',
      'protected',
      'public',
      'short',
      'static',
      'super',
      'synchronized',
      'throws',
      'transient',
      'volatile',
      'let',
      'yield',
      'true',
      'false',
      'null',
      'undefined',
      'NaN',
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

    if (lightBlue.contains(w)) {
      return Colors.lightBlue;
    } else if (lightGreen.contains(w)) {
      return const Color.fromARGB(255, 121, 255, 190);
    } else if (goldenron.contains(w)) {
      return const Color.fromARGB(255, 250, 183, 0);
    } else if (yello.contains(w)) {
      return Colors.yellowAccent;
    } else {
      if (w.startsWith('//')) {
        return Colors.blueGrey;
      } else if (w.startsWith(RegExp(r'[A-Z]'))) {
        return Colors.green;
      } else if (w[0] == "'" || w[0] == '"') {
        return const Color.fromARGB(255, 219, 132, 0);
      }
    }
    return const Color.fromARGB(255, 150, 207, 255);
  }
}
