import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => SignUpScreen(),
      '/login': (context) => LoginScreen(),
      '/home': (context) => HomeScreen(),
    },
  ));
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final Dio _dio = Dio();

  Future<void> _createAccount() async {
    try {
      final response = await _dio.post(
        'http://localhost:3000/api/utilisateurs/inscription',
        data: {
          'nom': _usernameController.text,
          'email': _emailController.text,
          'motDePasse': _passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        print('Compte créé');
        Navigator.pushNamed(context, '/login');
      } else {
        print('Erreur lors de la création du compte: ${response.statusCode}');
      }
    } catch (error) {
      print('Erreur lors de la création du compte: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Créer un compte'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Nom d\'utilisateur'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _createAccount,
              child: Text('Créer un compte'),
            ),
            SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text('Déjà inscrit ? Se connecter'),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final Dio _dio = Dio();

  Future<void> _login() async {
      try {
        final response = await _dio.post(
          'http://localhost:3000/api/utilisateurs/connexion',
          data: {
            'email': _emailController.text,
            'motDePasse': _passwordController.text,
          },
        );

        if (response.statusCode == 200) {
          print('Connexion réussie');
          Navigator.pushNamed(context, '/home');
        } else {
          print('Erreur lors de la connexion: ${response.statusCode}');
        }
      } catch (error) {
        print('Erreur lors de la connexion: $error');
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connexion'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'E-mail'),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _login,
              child: Text('Se connecter'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('Toujours pas inscrit? créer ton compte.'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page d\'accueil'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Bienvenue sur la page d\'accueil !'),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                _showDeleteAccountDialog(context);
              },
              child: Text('Supprimer mon compte'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text('Se déconnecter'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    String username = '';
    String password = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Supprimer mon compte'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  username = value;
                },
                decoration: InputDecoration(labelText: 'Nom d\'utilisateur'),
              ),
              TextField(
                onChanged: (value) {
                  password = value;
                },
                obscureText: true,
                decoration: InputDecoration(labelText: 'Mot de passe'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _deleteAccount(context, username, password);
              },
              child: Text('Supprimer le compte'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Annuler'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteAccount(BuildContext context, String username, String password) async {
    if (username.isNotEmpty && password.isNotEmpty) {
      try {
        final dio = Dio();
        final response = await dio.delete(
          'http://localhost:3000/api/utilisateurs/suppression',
          data: {
            'nom': username,
            'motDePasse': password,
          },
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Compte supprimé avec succès')));
          Navigator.pushNamed(context, '/login');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur lors de la suppression du compte')));
        }
      } catch (error) {
        print('Erreur lors de la suppression du compte: $error');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur lors de la suppression du compte')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veuillez entrer un nom d\'utilisateur et un mot de passe')));
    }
  }
}
