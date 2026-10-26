import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'screens/main/main_screen.dart';
import 'services/services.dart';
import 'utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.accent,
        ),
        useMaterial3: true,
      ),
      initialRoute: RouteNames.splash,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case RouteNames.splash:
            return MaterialPageRoute(builder: (_) => const SplashScreen());
          
          case RouteNames.login:
            return MaterialPageRoute(builder: (_) => const LoginScreen());
          
          case RouteNames.register:
            return MaterialPageRoute(builder: (_) => const RegisterScreen());
          
          case RouteNames.main:
            return MaterialPageRoute(
              builder: (_) => FutureBuilder<int?>(
                future: SessionService().getUserId(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  }
                  
                  if (snapshot.hasData && snapshot.data != null) {
                    return MainScreen(userId: snapshot.data!);
                  }
                  
                  // If no userId, redirect to login
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pushReplacementNamed(RouteNames.login);
                  });
                  
                  return const Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            );
          
          default:
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                appBar: AppBar(title: const Text('Error')),
                body: const Center(child: Text('Page not found')),
              ),
            );
        }
      },
    );
  }
}
