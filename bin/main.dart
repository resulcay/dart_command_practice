import 'package:dart_command_practice/prompt_execution.dart';
import 'package:dart_command_practice/file_operation.dart';
import 'package:dart_command_practice/compression.dart';

void main(List<String> arguments) async {
  PromptExecution.execute();
  FileOperation.writeToFile();
  FileOperation.readFromFile();
  Compression.compress();
  Compression.compareAlgorithm();
  Compression.zipAndUnzip();
}
