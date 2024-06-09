import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../services/database_service.dart';
import '../services/media_service.dart';
import '../services/could_storage.dart';

class splashpages extends StatefulWidget {
  final VoidCallback onInitializationComplete;
  const splashpages({required Key key, required this.onInitializationComplete})
      : super(key: key);

  @override
  State<splashpages> createState() => _splashpagesState();
}

class _splashpagesState extends State<splashpages> {
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((_) {
      _setup().then(
        (_) => widget.onInitializationComplete(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My PFE Project",
      home: Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.only(top: 500),
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage(
                        "lib/asset/Capture d'écran 2024-05-30 234139.png"),
                    fit: BoxFit.none)),
          ),
        ),
      ),
    );
  }

  Future<void> _setup() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    _registerServices();
  }

  void _registerServices() {
    try {
      GetIt.instance.registerSingleton<DatabaseService>(DatabaseService());
      GetIt.instance.registerSingleton<mediaService>(mediaService());
      GetIt.instance
          .registerSingleton<CloudStorageService>(CloudStorageService());
    } catch (e) {
      print(e.toString());
    }
  }
}
