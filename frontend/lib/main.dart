import 'package:flutter/material.dart';
import 'package:frontend/helpers/not_logged_in_view.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/services/product.dart';
import 'package:frontend/views/admin_view.dart';
import 'package:frontend/views/create_product_view.dart';
import 'package:frontend/views/edit_product_view.dart';
import 'package:frontend/views/view_product_view.dart';
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
  var product;

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
        '/createproduct': (context) => AppScaffold(child: CreateProductView()),
        '/notloggedin': (context) => AppScaffold(child: NotLoggedInView()),
        //'/viewproduct': (context) => AppScaffold(child: EditProductView(product: product),),
        //'/editproduct': (context) => AppScaffold(child: ViewProductView(product: product),)
      },
      theme: ThemeData(
        iconTheme: IconThemeData(color: Colors.black),
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
  late Future<bool> isAdminFuture;
  late Future<bool> isLoggedInFuture;

  @override
  void initState() {
    super.initState();
    isAdminFuture = ApiService.isAdmin();
    isLoggedInFuture = ApiService.isLoggedIn();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Trendify',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                ),
              ),
              Icon(Icons.rocket_launch_outlined),
              SizedBox(width: 50)
            ],
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      // body: Center(child: _widgetOptions[_currentIndex]),
      body: widget.child,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Account Navigator - show if logged in
            FutureBuilder<bool>(
              future: isLoggedInFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox.shrink();
                } else if (snapshot.hasError || snapshot.data == false) {
                  return SizedBox.shrink();
                } else
                  return ListTile(
                    title: const Text('Account'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/account');
                    },
                  );
              },
            ),
            // Browse products Navigator - show if logged in
            FutureBuilder<bool>(
              future: isLoggedInFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox.shrink();
                } else if (snapshot.hasError || snapshot.data == false) {
                  return SizedBox.shrink();
                } else
                  return ListTile(
                    title: const Text('Browse Products'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/main');
                    },
                  );
              },
            ),
            // Admin interface Navigator - show if admin
            FutureBuilder<bool>(
              future: isAdminFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox.shrink();
                } else if (snapshot.hasError || snapshot.data == false) {
                  return SizedBox.shrink();
                } else
                  return ListTile(
                    title: const Text('Admin Interface'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/admin');
                    },
                  );
              },
            ),
            SizedBox(height: 16),
            // logout navigator - show if logged in
            FutureBuilder<bool>(
              future: isLoggedInFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox.shrink();
                } else if (snapshot.hasError || snapshot.data == false) {
                  return SizedBox.shrink();
                } else
                  return ListTile(
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _logout();
                      Navigator.pushNamed(context, '/login');
                    },
                  );
              },
            ),
            // login navigator - show if logged out
            FutureBuilder<bool>(
              future: isLoggedInFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox.shrink();
                } else if (snapshot.hasError) {
                  return SizedBox.shrink();
                } else if (snapshot.data == true) {
                  return SizedBox.shrink();
                } else
                  return ListTile(
                    title: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/login');
                    },
                  );
              },
            ),
          ],
        ),
      ),
    );
  }
}
