import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/views/admin_view.dart';
import 'views/register_view.dart';
import 'views/login_view.dart';
import 'views/main_view.dart';
import 'views/welcome_view.dart';
import 'views/account_view.dart';

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
        '/welcome': (context) => WelcomeView(),
        '/register': (context) => AppScaffold(child: RegisterView()),
        '/login': (context) => AppScaffold(child: LoginView()),
        '/main': (context) => AppScaffold(child: MainView()),
        '/admin': (context) => AppScaffold(child: AdminView()),
        '/account': (context) => AppScaffold(child: AccountView()),
      },
      theme: ThemeData(
        primaryColor: Colors.black, 
        fontFamily: 'Sans-serif',
        scaffoldBackgroundColor: Colors.white, 
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0, 
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ), 
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.black, 
          textTheme: ButtonTextTheme.normal,
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
  late Future<bool> isAdminFuture;

  @override
  void initState() {
    super.initState();
    isAdminFuture = ApiService.isAdmin();
  }

  void _logout() async {
    try {
      await ApiService.logoutUser();
// Navigate to login screen after successful logout
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Logout successful!',
            style: TextStyle(color: Colors.green),
          ),
          duration: Duration(seconds: 2),
        ),
      );
      ApiService.onProductUpdate = null;
      Navigator.pushReplacementNamed(context, '/login');
    } catch (error) {
      print("Error logging out: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error logging out: $error',
            style: TextStyle(color: Colors.red),
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }


  void setIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyApp'),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      // body: Center(child: _widgetOptions[_currentIndex]),
      body: widget.child,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text('Account'),
              onTap: () {
                // _onItemTapped(0);
                Navigator.pop(context);
                Navigator.pushNamed(context, '/account');
              },
            ),
            ListTile(
              title: const Text('Browse Products'),
              onTap: () {
                // _onItemTapped(1);
                Navigator.pop(context);
                Navigator.pushNamed(context, '/main');
              },
            ),
            ListTile(
              title: const Text('Manage Your Store (Admin)'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/admin');
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                _logout();
                Navigator.pushNamed(context, '/login');
              },
            ),
          ]
        )
      ),
          );
  }
}
