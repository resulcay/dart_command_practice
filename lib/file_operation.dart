import 'dart:io';

final class FileOperation {
  static Future<void> writeToFile() async {
    String now = DateTime.now().toString();
    now = now.substring(0, now.length - 7);
    String message = "$now \nGood morning, Dart!";
    String path = '${Directory.current.path}/files/test.txt';
    File file = File(path);
    print('File created at: $path');
    Future<RandomAccessFile> fileToWrite = file.open(mode: FileMode.write);
    fileToWrite.then((RandomAccessFile raf) {
      print('Writing to file...');
      raf
          .writeString(message)
          .then((_) => print('File written to successfully'))
          .catchError((e) => print('Error Occured: $e'))
          .whenComplete(() => raf.close());
    });
  }

  static Future<void> readFromFile() async {
    String path = '${Directory.current.path}/files/test.txt';
    File file = File(path);
    print('Reading file from: $path');
    file
        .readAsString()
        .then((String contents) => print('File content: $contents'))
        .catchError((e) => print('Error occured while reading: $e'))
        .whenComplete(() => print('File read successfully'));
  }
}
