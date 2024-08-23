import 'package:flutter/material.dart';
import 'package:fudo_challenge/domain/usecase/is_user_authenticated.dart';
import 'package:fudo_challenge/presentation/login/view/login_page.dart';
import 'package:fudo_challenge/presentation/posts/view/posts_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp(isUserAuthenticatedUseCase: IsUserAuthenticatedUseCase()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.isUserAuthenticatedUseCase});

  final IsUserAuthenticatedUseCase isUserAuthenticatedUseCase;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fudo Challenge',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          // Specify custom colors for the dark theme.
          primary: Colors.black,
          surface: Colors.orange.shade600,
        ),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: isUserAuthenticatedUseCase(), 
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final isAuthenticated = snapshot.data!;
            return isAuthenticated 
              ? const PostsPage() 
              : const LoginPage();
          }
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
