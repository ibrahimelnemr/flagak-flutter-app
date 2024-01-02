import 'package:flutter/material.dart';
import 'package:frontend/views/admin_view.dart';
import 'views/register_view.dart';
import 'views/login_view.dart';
import 'views/main_view.dart';
import 'views/welcome_view.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
// await dotenv.load();
  runApp(StartApp());
}

class StartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => AppScaffold(child: WelcomeView()),
        '/register': (context) => AppScaffold(child: RegisterView()),
        '/login': (context) => AppScaffold(child: LoginView()),
        '/main': (context) => AppScaffold(child: MainView()),
        '/admin': (context) => AppScaffold(child: AdminView()),
      },
      theme: ThemeData(
        primaryColor: Colors.blue, 
        //accentColor: Colors.green, 
        fontFamily: 'Sans-serif',
        scaffoldBackgroundColor: Colors.grey[100], 
        appBarTheme: AppBarTheme(
          color: Colors.blue,
          elevation: 0, 
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ), 
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey[200], 
          selectedItemColor: Colors.black, 
          unselectedItemColor: Colors.black, 
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue, 
          textTheme: ButtonTextTheme.primary,
        ),
      ),
    );
  }
}

class AppScaffold extends StatefulWidget {
  final Widget child;

  const AppScaffold({Key? key, required this.child}) : super(key: key);

  @override
  _AppScaffoldState createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MyApp',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white
            ),
        ),
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          // navigate
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/welcome');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/register');
              break;
            case 2:
              Navigator.pushReplacementNamed(context, '/login');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/main');
              break;
            default:
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Welcome',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Register',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Main',
          ),
        ],
        backgroundColor: Colors.grey[200],
        // selectedItemColor: Colors.black, 
        // unselectedItemColor: Colors.black, 
        // // selectedIconTheme: IconThemeData(color: Colors.white),
        // selectedLabelStyle: TextStyle(color: Colors.black),
        // unselectedLabelStyle: TextStyle(color: Colors.black)

      ),
    );
  }
}
