import 'package:flutter/material.dart';
import 'injection_container.dart' as di;
import 'presentation/cubit/romantic_cubit.dart';
import 'presentation/pages/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  // Uygulama başlamadan önce bağımlılıkları kaydet.
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // GetIt kayıtlarını burada çalıştır.

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider, Cubit'i Widget ağacına enjekte eder.
    return BlocProvider(
      // Cubit'i GetIt aracılığıyla alıyoruz.
      create: (context) {
        final cubit = di.sl<RomanticCubit>();
        Future.microtask(() => cubit.loadInitialStep());
        return cubit;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Güzelime',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          scaffoldBackgroundColor: Colors.pink[50],
          // ...
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
        home: const MainScreen(),
      ),
    );
  }
}
