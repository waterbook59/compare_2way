import 'package:compare_2way/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//ライセンスページ作成参照：https://zenn.dev/razokulover/articles/735ed893898d66

class MyLicensePage extends StatefulWidget {
  const MyLicensePage({Key? key}) : super(key: key);

  @override
  _MyLicensePageState createState() => _MyLicensePageState();
}

class _MyLicensePageState extends State<MyLicensePage> {

  List<List<String>> licenses = [];

  @override
  void initState() {
    super.initState();
    LicenseRegistry.licenses.listen((license) {
      // license.packagesとlicense.paragraphsの返り値がIterableなのでtoList()してる
      final packages = license.packages.toList();
      final paragraphs = license.paragraphs.toList();
      final packageName = packages.map((e) => e).join();
      final paragraphText = paragraphs.map((e) => e.text).join('\n');
      // この辺の状態更新とかは環境に合わせてお好みで
      licenses.add([packageName, paragraphText]);
      setState(() => licenses = licenses);
    });
  }

  @override
  void dispose() {
    // TODO: licenses dispose?
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        // actionsForegroundColor: Colors.white,
        backgroundColor: primaryColor,
        middle: const Text(
          'ライセンス',
          style: middleTextStyle,
        ),
      ),
      child: Scaffold(
        body: ListView.builder(
          itemCount: licenses.length,
          itemBuilder: (context, index) {
            final license = licenses[index];
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    license[0],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    license[1],
                    style: const TextStyle(fontSize: 12),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
