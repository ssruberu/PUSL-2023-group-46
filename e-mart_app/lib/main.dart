import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sample_app/firebase_options.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BasePage(),
    );
  }
}

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const ProductPage(),
    const CartPage(),
    const Profile(),
    // Add more pages here
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    final User? user = AuthClass().currentUser;

    // Navigate to another page if user email is empty
    switch (index) {
      case 3:
        if (user!.email!.isEmpty) {
          // Navigate to a different page (Page2 in this example)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Profile()),
          );
          break;
        } else {
          // Navigate to AccountScreen if user email is not empty
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AccountScreen()),
          );
        }
      // Add more cases for additional pages if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'E - Mart App',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber[800],
      ),
      body: SingleChildScrollView(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          )

          // Add more BottomNavigationBarItems for other pages
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.black87,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final Color backcolor;

  ProductCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.backcolor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Card(
        color: backcolor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SizedBox(
          width: 310.0,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        title,
                        style:
                            const TextStyle(fontSize: 14.0, color: Colors.grey),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        description,
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(253, 245, 135, 62),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Browse',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(1),
                child: Image.asset(
                  imagePath,
                  width: 150,
                  height: 200,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ItemsCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final String price;
  final String documentId;

  ItemsCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.documentId,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 255, 254, 249),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15.0)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                width: double.infinity,
                height: 100,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '\$$price',
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              documentId as String,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  final user = FirebaseAuth.instance.currentUser;

                  if (user == null) {
                    // Navigate to login page if user is not logged in
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChooseScreen(),
                      ),
                    );
                  } else {
                    // Update the document in the "carts" collection to add the new field
                    FirebaseFirestore.instance
                        .collection("carts")
                        .doc(user.email)
                        .update({
                      documentId:
                          double.parse(price), // Convert price to double
                    }).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Field added to Cart'),
                        ),
                      );
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error Occurred'),
                        ),
                      );
                      FirebaseFirestore.instance
                          .collection("carts")
                          .doc(user.email)
                          .set({
                        documentId: double.parse(price),
                      }).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Field added to Cart'),
                          ),
                        );
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Error Occurred'),
                          ),
                        );
                      });
                    });
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.favorite_border_outlined),
                onPressed: () {
                  final user = FirebaseAuth.instance.currentUser;

                  if (user == null) {
                    // Navigate to login page if user is not logged in
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChooseScreen(),
                      ),
                    );
                  } else {
                    // Update the document in the "carts" collection to add the new field
                    FirebaseFirestore.instance
                        .collection("wishlist")
                        .doc(user.email)
                        .update({
                      documentId: double.parse(price),
                    }).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Field added to Cart'),
                        ),
                      );
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error Occurred'),
                        ),
                      );
                      FirebaseFirestore.instance
                          .collection("wishlist")
                          .doc(user.email)
                          .set({
                        documentId: double.parse(price),
                      }).then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Field added to Cart'),
                          ),
                        );
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Error Occurred'),
                          ),
                        );
                      });
                    });
                  }
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Welcome to E - Mart App !',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 220.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              List<String> imagePaths = [
                "assets/food.png",
                "assets/dress.png",
                "assets/Industrial.png",
              ];
              List<String> titles = [
                'Explore Foods',
                'Explore Dress',
                'Explore Climber Items',
              ];
              List<String> descriptions = [
                'Freshly Taken From the Bakery',
                'New Dress Design Comming',
                'Climber Isometric Composition',
              ];
              List<Color> backcolors = [
                const Color(0xFFFFF0D0),
                const Color(0xFFE7E7E7),
                const Color(0xFFC8E4F7),
              ];
              return ProductCard(
                title: titles[index],
                description: descriptions[index],
                imagePath: imagePaths[index],
                backcolor: backcolors[index],
              );
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Let"s shopping !',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(18.0),
          child: Text(
            '  Home & Lifestyle',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('items').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Something went wrong'),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                childAspectRatio: 0.53,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var item = snapshot.data!.docs[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ItemsCard(
                    title: item['title'],
                    description: item['description'],
                    imagePath: item['imagePath'],
                    price: item['price'],
                    documentId: item.id,
                  ),
                );
              },
            );
          },
        ),
        const Padding(
          padding: EdgeInsets.all(18.0),
          child: Text(
            '  Dress Design',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('dress').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Something went wrong'),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                childAspectRatio: 0.54,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var item = snapshot.data!.docs[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ItemsCard(
                    title: item['title'],
                    description: item['description'],
                    imagePath: item['imagePath'],
                    price: item['price'],
                    documentId: item.id,
                  ),
                );
              },
            );
          },
        ),
        const Padding(
          padding: EdgeInsets.all(18.0),
          child: Text(
            '  Climbers Isometric',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('climber').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Something went wrong'),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                childAspectRatio: 0.54,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var item = snapshot.data!.docs[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ItemsCard(
                    title: item['title'],
                    description: item['description'],
                    imagePath: item['imagePath'],
                    price: item['price'],
                    documentId: item.id,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.thumb_up),
              onPressed: () {
                // Handle like button press
              },
            ),
            IconButton(
              icon: const Icon(Icons.local_offer),
              onPressed: () {
                // Handle coupon button press
              },
            ),
            IconButton(
              icon: const Icon(Icons.today),
              onPressed: () {
                // Handle list button press
              },
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text(
            'Find you Favourite !',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            '  Home & Lifestyle',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('items').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Something went wrong'),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var item = snapshot.data!.docs[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ItemsCard(
                    title: item['title'],
                    description: item['description'],
                    imagePath: item['imagePath'],
                    price: item['price'],
                    documentId: item.id,
                  ),
                );
              },
            );
          },
        ),
        const Padding(
          padding: EdgeInsets.all(0.0),
          child: Text(
            '  Dress Design !',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('dress').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Something went wrong'),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var item = snapshot.data!.docs[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ItemsCard(
                    title: item['title'],
                    description: item['description'],
                    imagePath: item['imagePath'],
                    price: item['price'],
                    documentId: item.id,
                  ),
                );
              },
            );
          },
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            '  Climbers Isometric !',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('climber').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Something went wrong'),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var item = snapshot.data!.docs[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ItemsCard(
                    title: item['title'],
                    description: item['description'],
                    imagePath: item['imagePath'],
                    price: item['price'],
                    documentId: item.id,
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthClass().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const AccountScreen();
        } else {
          return const LoginAndRegisterScreen();
        }
      },
    );
  }
}

class LoginAndRegisterScreen extends StatefulWidget {
  const LoginAndRegisterScreen({Key? key}) : super(key: key);

  @override
  State<LoginAndRegisterScreen> createState() => _LoginAndRegisterScreenState();
}

class _LoginAndRegisterScreenState extends State<LoginAndRegisterScreen> {
  bool loginScreenVisible = true;
  bool _obscureText = true; // Define _obscureText at the class level
  bool showLoading = false;
  String email = '';
  String password = '';

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(loginScreenVisible ? 'Login' : 'Signup'),
        backgroundColor: const Color.fromARGB(253, 245, 135, 62),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 200),
        child: Column(
          children: [
            inputField('email', const Color.fromARGB(252, 247, 133, 57)),
            inputField('password', const Color.fromARGB(252, 247, 133, 57)),
            !loginScreenVisible ? const SizedBox() : forgotPassword(),
            loginRegisterButton(),
            toggleIconButton(),
          ],
        ),
      ),
    );
  }

  Widget inputField(String fieldType, Color borderColor) {
    bool isPasswordField = fieldType == 'password';

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              style: const TextStyle(fontSize: 16.0),
              obscureText: isPasswordField ? _obscureText : false,
              onChanged: (value) {
                setState(() {
                  if (isPasswordField) {
                    password = value;
                  } else {
                    email = value;
                  }
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                ),
                hintText:
                    isPasswordField ? 'Enter password...' : 'Enter email...',
                suffixIcon: isPasswordField
                    ? InkWell(
                        onTap: _toggle,
                        child: Icon(
                          _obscureText
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.eyeSlash,
                          size: 15.0,
                          color: Colors.black,
                        ),
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Forgot password ///
  Widget forgotPassword() {
    return const Align(
      alignment: Alignment.centerRight,
      child: Text(
        'Forgot password?',
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
      ),
    );
  }

  /// Login and Register Button
  Widget loginRegisterButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 31, bottom: 21),
      child: MaterialButton(
          onPressed: email.isEmpty || password.isEmpty
              ? null
              : () async {
                  setState(() {});
                  showLoading = true;
                  if (loginScreenVisible) {
                    try {
                      print('get it now');
                      await AuthClass().signIn(email, password);
                      print('get it');
                    } on FirebaseAuthException {
                      if (AuthClass().currentUser == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Invalid email or password')));
                      }
                    }
                    setState(() {
                      showLoading = false;
                    });
                  }
                  if (!loginScreenVisible) {
                    try {
                      await AuthClass().register(email, password);
                    } on FirebaseAuthException {
                      var res = await AuthClass()
                          .auth
                          .fetchSignInMethodsForEmail(email);
                      if (res.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('User already exists')));
                      }
                    }
                    setState(() {
                      showLoading = false;
                    });
                  }
                },
          padding: const EdgeInsets.symmetric(vertical: 13),
          minWidth: double.infinity,
          color: const Color.fromARGB(252, 247, 133, 57),
          disabledColor: Colors.grey.shade300,
          textColor: Colors.white,
          child: showLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(loginScreenVisible ? 'Login' : 'Register')),
    );
  }

  /// custom toggle button ///
  Widget toggleIconButton() {
    return InkWell(
      onTap: () {
        setState(() {
          loginScreenVisible = !loginScreenVisible;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        height: 50,
        width: 100,
        decoration: BoxDecoration(
            color: const Color.fromARGB(252, 255, 197, 159),
            borderRadius: BorderRadius.circular(100)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            loginScreenVisible
                ? toggleButtonText()
                : const Expanded(
                    child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ),
            !loginScreenVisible
                ? toggleButtonText()
                : const Expanded(
                    child: Center(
                      child: Text(
                        'Signup',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget toggleButtonText() {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: Color.fromARGB(253, 245, 135, 62)),
        child: Text(
          loginScreenVisible ? 'Login' : 'Signup',
          style: const TextStyle(color: Colors.white, fontSize: 11),
        ),
      ),
    );
  }
}

// home screen ///
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});
  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final User? user = AuthClass().currentUser;

  @override
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(253, 245, 135, 62),
        centerTitle: true,
        title: const Text('Account Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BasePage()),
            ); // Navigate back when the button is pressed
          },
        ),
        actions: [
          MaterialButton(
            onPressed: () async {
              await AuthClass().signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BasePage()),
              );
            },
            child:
                const Text('Sign Out', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(11),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 3,
                      spreadRadius: 1,
                      offset: const Offset(3, 3),
                      color: Colors.grey.shade200)
                ]),
            child: Column(
              children: [
                Text(
                  user!.email!.isEmpty ? 'No data' : user.email.toString(),
                ),
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Whish List',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ),
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('wishlist')
                      .doc(user.email)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Something went wrong'),
                        ),
                      );
                      return const Text('Error');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    var cartData =
                        snapshot.data!.data() as Map<String, dynamic>?;

                    if (cartData == null || cartData.isEmpty) {
                      return const Text('No items in cart');
                    }

                    return FutureBuilder<String>(
                      future: checkDocumentExists('items'),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> documentExistsSnapshot) {
                        if (documentExistsSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (documentExistsSnapshot.hasError) {
                          return const Text(
                              'Error checking document existence');
                        }

                        String documentExists =
                            documentExistsSnapshot.data ?? '';

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cartData.keys.length,
                          itemBuilder: (BuildContext context, int index) {
                            String key = cartData.keys.elementAt(index);

                            return FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection(documentExists)
                                  .doc(key)
                                  .get(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot1) {
                                if (snapshot1.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                if (snapshot1.hasError) {
                                  return const Text('Something went wrong');
                                }

                                if (!snapshot1.hasData ||
                                    !snapshot1.data!.exists) {
                                  return const Text(
                                    'Document not found',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  );
                                }

                                var documentData = snapshot1.data!.data()
                                    as Map<String, dynamic>;

                                return Container(
                                  margin: const EdgeInsets.all(5.0),
                                  child: Card(
                                    color: const Color.fromARGB(
                                        255, 252, 246, 239),
                                    child: ListTile(
                                      title: Text(
                                        '${documentData['title']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: Image.asset(
                                              '${documentData['imagePath']}',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Text(
                                              '${documentData['description']}'),
                                          Text('\$${documentData['price']}',
                                              style: const TextStyle(
                                                  color: Colors.red)),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () async {
                                          await FirebaseFirestore.instance
                                              .collection('wishlist')
                                              .doc(user.email)
                                              .update(
                                                  {key: FieldValue.delete()});
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('wishlist')
                      .doc(user.email)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Something went wrong'),
                        ),
                      );
                      return const Text('Error');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    var cartData =
                        snapshot.data!.data() as Map<String, dynamic>?;

                    if (cartData == null || cartData.isEmpty) {
                      return const Text('No items in cart');
                    }

                    return FutureBuilder<String>(
                      future: checkDocumentExists('dress'),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> documentExistsSnapshot) {
                        if (documentExistsSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (documentExistsSnapshot.hasError) {
                          return const Text(
                              'Error checking document existence');
                        }

                        String documentExists =
                            documentExistsSnapshot.data ?? '';

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cartData.keys.length,
                          itemBuilder: (BuildContext context, int index) {
                            String key = cartData.keys.elementAt(index);

                            return FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection(documentExists)
                                  .doc(key)
                                  .get(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot1) {
                                if (snapshot1.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                if (snapshot1.hasError) {
                                  return const Text('Something went wrong');
                                }

                                if (!snapshot1.hasData ||
                                    !snapshot1.data!.exists) {
                                  return const Text(
                                    'Document not found',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  );
                                }

                                var documentData = snapshot1.data!.data()
                                    as Map<String, dynamic>;

                                return Container(
                                  margin: const EdgeInsets.all(5.0),
                                  child: Card(
                                    color: const Color.fromARGB(
                                        255, 252, 246, 239),
                                    child: ListTile(
                                      title: Text(
                                        '${documentData['title']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: Image.asset(
                                              '${documentData['imagePath']}',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Text(
                                              '${documentData['description']}'),
                                          Text('\$${documentData['price']}',
                                              style: const TextStyle(
                                                  color: Colors.red)),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () async {
                                          await FirebaseFirestore.instance
                                              .collection('wishlist')
                                              .doc(user.email)
                                              .update(
                                                  {key: FieldValue.delete()});
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('wishlist')
                      .doc(user.email)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Something went wrong'),
                        ),
                      );
                      return const Text('Error');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    var cartData =
                        snapshot.data!.data() as Map<String, dynamic>?;

                    if (cartData == null || cartData.isEmpty) {
                      return const Text('No items in cart');
                    }

                    return FutureBuilder<String>(
                      future: checkDocumentExists('climber'),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> documentExistsSnapshot) {
                        if (documentExistsSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (documentExistsSnapshot.hasError) {
                          return const Text(
                              'Error checking document existence');
                        }

                        String documentExists =
                            documentExistsSnapshot.data ?? '';

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cartData.keys.length,
                          itemBuilder: (BuildContext context, int index) {
                            String key = cartData.keys.elementAt(index);

                            return FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection(documentExists)
                                  .doc(key)
                                  .get(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot1) {
                                if (snapshot1.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }

                                if (snapshot1.hasError) {
                                  return const Text('Something went wrong');
                                }

                                if (!snapshot1.hasData ||
                                    !snapshot1.data!.exists) {
                                  return const Text(
                                    'Document not found',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  );
                                }

                                var documentData = snapshot1.data!.data()
                                    as Map<String, dynamic>;

                                return Container(
                                  margin: const EdgeInsets.all(5.0),
                                  child: Card(
                                    color: const Color.fromARGB(
                                        255, 252, 246, 239),
                                    child: ListTile(
                                      title: Text(
                                        '${documentData['title']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: Image.asset(
                                              '${documentData['imagePath']}',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Text(
                                              '${documentData['description']}'),
                                          Text('\$${documentData['price']}',
                                              style: const TextStyle(
                                                  color: Colors.red)),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () async {
                                          await FirebaseFirestore.instance
                                              .collection('wishlist')
                                              .doc(user.email)
                                              .update(
                                                  {key: FieldValue.delete()});
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                // Add additional widgets here
                // For example:
                // Text('Some other information'),
                // ElevatedButton(
                //   onPressed: () {},
                //   child: Text('Button'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Firebase Operations ///
class AuthClass {
  final FirebaseAuth auth = FirebaseAuth.instance;
  User? get currentUser => auth.currentUser;
  Stream<User?> get authStateChanges => auth.authStateChanges();

  Future<void> signIn(email, password) async {
    await auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> register(email, password) async {
    await auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key); // Added key parameter

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Cart',
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
        ),
        if (user != null)
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('carts')
                .doc(user.email)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Something went wrong'),
                  ),
                );
                return const Text('Error');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              var cartData = snapshot.data!.data() as Map<String, dynamic>?;

              if (cartData == null || cartData.isEmpty) {
                return const Text('No items in cart');
              }

              double totalSum = 0.0;

              for (var value in cartData.values) {
                if (value is num) {
                  totalSum += value;
                }
              }

              // Display the total sum
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Total: \$${totalSum.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: const EdgeInsets.all(
                              10.0), // Adjust the margin as needed
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .green, // Change the background color as needed
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Adjust the border radius as needed
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CheckoutPage(totalSum: totalSum),
                                ),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(
                                  10.0), // Adjust the padding as needed
                              child: Text(
                                'Go to Checkout',
                                style: TextStyle(
                                  fontSize:
                                      18.0, // Change the font size as needed
                                  fontWeight: FontWeight
                                      .bold, // Change the font weight as needed
                                  color: Colors
                                      .white, // Change the text color as needed
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder<String>(
                    future: checkDocumentExists('items'),
                    builder: (BuildContext context,
                        AsyncSnapshot<String> documentExistsSnapshot) {
                      if (documentExistsSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (documentExistsSnapshot.hasError) {
                        return const Text('Error checking document existence');
                      }

                      String documentExists = documentExistsSnapshot.data ?? '';

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cartData.keys.length,
                        itemBuilder: (BuildContext context, int index) {
                          String key = cartData.keys.elementAt(index);

                          return FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection(documentExists)
                                .doc(key)
                                .get(),
                            builder: (BuildContext context,
                                AsyncSnapshot<DocumentSnapshot> snapshot1) {
                              if (snapshot1.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              if (snapshot1.hasError) {
                                return const Text('Something went wrong');
                              }

                              if (!snapshot1.hasData ||
                                  !snapshot1.data!.exists) {
                                return const Text(
                                  'Document not found',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                );
                              }

                              var documentData = snapshot1.data!.data()
                                  as Map<String, dynamic>;

                              return Container(
                                margin: const EdgeInsets.all(10.0),
                                child: Card(
                                  color:
                                      const Color.fromARGB(255, 252, 246, 239),
                                  child: ListTile(
                                    title: Text(
                                      '${documentData['title']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 50,
                                          width: 50,
                                          child: Image.asset(
                                            '${documentData['imagePath']}',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Text('${documentData['description']}'),
                                        Text('\$${documentData['price']}',
                                            style: const TextStyle(
                                                color: Colors.red)),
                                      ],
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection('carts')
                                            .doc(user.email)
                                            .update({key: FieldValue.delete()});
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            },
          ),

        StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('carts')
              .doc(user?.email)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Something went wrong'),
                ),
              );
              return const Text('Error');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            var cartData = snapshot.data!.data() as Map<String, dynamic>?;

            if (cartData == null || cartData.isEmpty) {
              return const Text('No items in cart');
            }

            return FutureBuilder<String>(
              future: checkDocumentExists('dress'),
              builder: (BuildContext context,
                  AsyncSnapshot<String> documentExistsSnapshot) {
                if (documentExistsSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (documentExistsSnapshot.hasError) {
                  return const Text('Error checking document existence');
                }

                String documentExists = documentExistsSnapshot.data ?? '';

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cartData.keys.length,
                  itemBuilder: (BuildContext context, int index) {
                    String key = cartData.keys.elementAt(index);

                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection(documentExists)
                          .doc(key)
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot1) {
                        if (snapshot1.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (snapshot1.hasError) {
                          return const Text('Something went wrong');
                        }

                        if (!snapshot1.hasData || !snapshot1.data!.exists) {
                          return const Text(
                            'Document not found',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          );
                        }

                        var documentData =
                            snapshot1.data!.data() as Map<String, dynamic>;

                        return Container(
                          margin: const EdgeInsets.all(10.0),
                          child: Card(
                            color: const Color.fromARGB(255, 252, 246, 239),
                            child: ListTile(
                              title: Text(
                                '${documentData['title']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Image.asset(
                                      '${documentData['imagePath']}',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Text('${documentData['description']}'),
                                  Text('\$${documentData['price']}',
                                      style:
                                          const TextStyle(color: Colors.red)),
                                ],
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('carts')
                                      .doc(user?.email)
                                      .update({key: FieldValue.delete()});
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),

        // Define total outside of the widget tree

        StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('carts')
              .doc(user?.email)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Something went wrong'),
                ),
              );
              return const Text('Error');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            var cartData = snapshot.data!.data() as Map<String, dynamic>?;

            if (cartData == null || cartData.isEmpty) {
              return const Text('No items in cart');
            }

            return FutureBuilder<String>(
              future: checkDocumentExists('climber'),
              builder: (BuildContext context,
                  AsyncSnapshot<String> documentExistsSnapshot) {
                if (documentExistsSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (documentExistsSnapshot.hasError) {
                  return const Text('Error checking document existence');
                }

                String documentExists = documentExistsSnapshot.data ?? '';

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: cartData.keys.length,
                  itemBuilder: (BuildContext context, int index) {
                    String key = cartData.keys.elementAt(index);

                    return FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection(documentExists)
                          .doc(key)
                          .get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot1) {
                        if (snapshot1.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        if (snapshot1.hasError) {
                          return const Text('Something went wrong');
                        }

                        if (!snapshot1.hasData || !snapshot1.data!.exists) {
                          return const Text(
                            'Document not found',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          );
                        }

                        var documentData =
                            snapshot1.data!.data() as Map<String, dynamic>;

                        return Container(
                          margin: const EdgeInsets.all(10.0),
                          child: Card(
                            color: const Color.fromARGB(255, 252, 246, 239),
                            child: ListTile(
                              title: Text(
                                '${documentData['title']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Image.asset(
                                      '${documentData['imagePath']}',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Text('${documentData['description']}'),
                                  Text('\$${documentData['price']}',
                                      style:
                                          const TextStyle(color: Colors.red)),
                                ],
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('carts')
                                      .doc(user?.email)
                                      .update({key: FieldValue.delete()});
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}

Future<String> checkDocumentExists(String collectionName) async {
  // Just returning a collection name as an example
  return collectionName;
}

class Profile extends StatelessWidget {
  const Profile({Key? key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(
              'https://static.vecteezy.com/system/resources/previews/002/437/945/large_2x/illustration-of-a-login-account-free-vector.jpg', // Replace with your image URL
              fit: BoxFit.fill, // Adjust image fit as needed
              height: 200, // Adjust image height as needed
              width: double.infinity, // Take full width
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Profile Page',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please Log in for Cart Checkout and Items buy or check your Internet connections',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChooseScreen()),
                      ); // Add your onPressed code here!
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.amber[800], // Change button color here
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white), // Change text color here
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckoutPage extends StatelessWidget {
  final double totalSum;
  final String url =
      'https://www.paypal.com/signin'; // replace with your website link

  const CheckoutPage({Key? key, required this.totalSum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total: \$${totalSum.toStringAsFixed(2)}',
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0), // Add some spacing
            ElevatedButton(
              onPressed: () => launch(url), // This will open the website link
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green, // This is the text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // border radius
                ),
              ),
              child: const Text('Pay Now'),
            ),
          ],
        ),
      ),
    );
  }
}
