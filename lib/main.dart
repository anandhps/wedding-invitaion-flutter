import 'dart:io';
import 'package:wedding/repositories.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  var lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    textTheme: textTheme,
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  setPathUrlStrategy();
  runApp(
    // FlutterWebFrame(
    //   builder: (context) => GetMaterialApp(
    //     title: 'Enter invited guest data',
    //     theme: lightTheme,
    //     initialRoute: '/',
    //     getPages: getRoutes,
    //     initialBinding: MainBinding(),
    //   ),
    //   maximumSize: const Size(475, 1080),
    // ),
    GetMaterialApp(
      title: 'Wedding Invitation',
      theme: lightTheme,
      initialRoute: '/',
      getPages: getRoutes,
      initialBinding: MainBinding(),
    ),
  );
}
