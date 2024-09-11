import 'dart:convert';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:path/path.dart' as path;

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

  static void compareAlgorithm() {
    String data = 'Hello, World! \n' * 1000;

    int zlibCodec = _encoder(zlib, data);
    int gzibCodec = _encoder(gzip, data);

    print('zlib: $zlibCodec');
    print('gzip: $gzibCodec');
  }

  static int _encoder(var codec, String data) {
    List<int> original = utf8.encode(data);
    List<int> compressed = codec.encode(original);
    List<int> decompressed = codec.decode(compressed);

    print('Original (${codec.runtimeType}): ${original.length} bytes');
    print('Compressed (${codec.runtimeType}):  ${compressed.length} bytes');
    print('Decompressed (${codec.runtimeType}): ${decompressed.length} bytes');

    String decoded = utf8.decode(decompressed);
    assert(data == decoded);

    return compressed.length;
  }

  static void zipAndUnzip() {
    List<String> files = [];
    Directory.current.listSync().forEach((FileSystemEntity element) {
      if (element is File) {
        files.add(element.path);
      }
    });

    String zipFile = './files/test.zip';
    _zipCreator(files, zipFile);
    unzip(zipFile, './files/unzipped');
  }

  static void _zipCreator(List<String> files, String fileName) {
    Archive archive = Archive();
    for (var element in files) {
      File file = File(element);
      ArchiveFile archiveFile = ArchiveFile(
        path.basename(element),
        file.lengthSync(),
        file.readAsBytesSync(),
      );
      archive.addFile(archiveFile);
    }

    ZipEncoder encoder = ZipEncoder();
    File file = File(fileName);
    file.writeAsBytesSync(encoder.encode(archive) as List<int>);

    print('Zip file created at: ${file.path}');
  }

  static void unzip(String zip, String path) {
    File file = File(zip);
    Archive archive = ZipDecoder().decodeBytes(file.readAsBytesSync());

    for (var file in archive) {
      File newFile = File('$path/${file.name}');
      newFile.createSync(recursive: true);
      newFile.writeAsBytesSync(file.content);
    }

    print('Zip file extracted at: $path');
  }
}
