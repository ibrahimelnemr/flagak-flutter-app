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
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white, 
          selectedItemColor: Colors.black, 
          unselectedItemColor: Colors.black, 
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.black, 
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
  late Future<bool> isAdminFuture;

  @override
  void initState() {
    super.initState();
    isAdminFuture = ApiService.isAdmin();
  }

  static List<Widget> _widgetOptions = <Widget>[
    AppScaffold(child: RegisterView()),
    AppScaffold(child: RegisterView()),
    AppScaffold(child: RegisterView()),
    AppScaffold(child: RegisterView()),
  ];


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


  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    //Widget targetWidget = MainView();
    // switch (index) {
    //   case 0:
    //   Navigator.pushReplacementNamed(context, '/account');
    //   break;
    //   case 1: 
    //   Navigator.pushReplacementNamed(context, '/main');
    //   break;
    //   case 2: 
    //   Navigator.pushReplacementNamed(context, '/admin');
    //   break;
    //   case 3: 
    //   _logout();
    //   break;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyApp'),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(child: _widgetOptions[_currentIndex]),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text('Account'),
              selected: _currentIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Browse Products'),
              selected: _currentIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Manage Your Store (Admin)'),
              selected: _currentIndex == 2,
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Logout'),
              selected: _currentIndex == 3,
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
              },
            ),
          ]
        )
      ),
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
        backgroundColor: Colors.white,
        // selectedItemColor: Colors.black, 
        // unselectedItemColor: Colors.black, 
        // // selectedIconTheme: IconThemeData(color: Colors.white),
        // selectedLabelStyle: TextStyle(color: Colors.black),
        // unselectedLabelStyle: TextStyle(color: Colors.black)

      ),
    );
  }
}
