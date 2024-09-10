import 'dart:convert';
import 'dart:io';

final class PromptExecution {
  static void execute() {
    const String red = '\x1B[31m';
    const String green = '\x1B[32m';
    const String yellow = '\x1B[33m';
    const String orange = '\x1B[34m';

    print(
        'OS: ${Platform.operatingSystem} \nDart Version:  ${Platform.version}');
    print(Uri.decodeFull(Platform.script.path));

    Process.start('flutter', ['doctor', '-v'], runInShell: true)
        .then((Process process) async {
      print(orange + '-' * 100);

      print('${yellow}Process started by PID: ${process.pid}');
      print('${yellow}Waiting for process to kill...');

      await Future.delayed(Duration(seconds: 5));

      bool isKilled = process.kill();
      print('${red}Process killed: $isKilled');
      print(orange + '-' * 100);

      process.stdout.transform(utf8.decoder).listen((data) {
        print('${green}stdout: $data');
      });

      process.stderr.transform(utf8.decoder).listen((data) {
        print('${red}stderr: $data');
      });

      process.exitCode.then((exitCode) {
        print('${orange}Exit code: $exitCode');
      });
    });
  }
}
