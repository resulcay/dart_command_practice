import 'dart:convert';
import 'dart:io';

final class Compression {
  static void compress() {
    String data = 'Hello, World! \n' * 1000;

    List<int> original = utf8.encode(data);
    List<int> compressed = gzip.encode(original);
    List<int> decompressed = gzip.decode(compressed);

    print('Original: ${original.length} bytes');
    print('Compressed: ${compressed.length} bytes');
    print('Decompressed: ${decompressed.length} bytes');

    String decoded = utf8.decode(decompressed);
    assert(data == decoded);
  }
}
