import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: PageView(
          children: [
            Screen1(),
            Screen2(),
            Screen3(),
            Screen4(),
            Screen5(),
          ],
        ),
        theme: ThemeData(
          textTheme: GoogleFonts.bungeeSpiceTextTheme(),
        ),
        debugShowCheckedModeBanner: false);
  }
}

class Screen1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('from LETO'),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Text(
              'COOLGRAM',
              textDirection: TextDirection.ltr,
              style: TextStyle(fontSize: 30.0),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text('swipe right to register ->',
                  textDirection: TextDirection.ltr),
            ),
          ),
        ],
      ),
    );
  }
}

class Screen2 extends StatefulWidget {
  @override
  _Screen2State createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  final _formKey = GlobalKey<FormState>();
  String _status = 'busy';
  String _status1 = 'busy';

  void _buyCrypto() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final message = 'success';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  void _sellCrypto() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final message = 'well please register';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'registration',
          style: GoogleFonts.bungeeSpice(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                onSaved: (value) => _status = value!,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'login',
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                onSaved: (value) => _status1 = value!,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'password',
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _buyCrypto,
                    child: Text('register'),
                  ),
                  ElevatedButton(
                    onPressed: _sellCrypto,
                    child: Text('exit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Screen3 extends StatefulWidget {
  @override
  _Screen3State createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  List<String> columnList = [];
  List<String> listViewList = [];
  List<String> listViewSeparatedList = [];
  var currentItem = "";
  int activeListType = 1;

  void addItemToList(String item, int listType) {
    setState(() {
      if (listType == 0)
        columnList.add(item);
      else if (listType == 1)
        listViewList.add(item);
      else if (listType == 2) listViewSeparatedList.add(item);
    });
  }

  void removeCrypt(int index) {
    setState(() {
      columnList.removeAt(index);
    });
  }

  void removeStock(int index) {
    setState(() {
      listViewList.removeAt(index);
    });
  }

  void removeMet(int index) {
    setState(() {
      listViewSeparatedList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('What to buy?'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text('Cryptocurrency', //Column List
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Column(
              children: List.generate(columnList.length, (index) {
                return ListTile(
                  tileColor: Colors.green.shade100,
                  title: Text(columnList[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      removeCrypt(index);
                    },
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            Text('Stock', // ListView
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              itemCount: listViewList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  tileColor: Colors.green.shade200,
                  title: Text(listViewList[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      removeStock(index);
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            Text('Precious metals', // ListView.separated
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            ListView.separated(
              shrinkWrap: true,
              itemCount: listViewSeparatedList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  tileColor: Colors.green.shade300,
                  title: Text(listViewSeparatedList[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      removeMet(index);
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.white,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Add assets'),
                content: TextField(
                  onChanged: (value) {
                    currentItem = value;
                  },
                ),
                actions: [
                  TextButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text('Add'),
                    onPressed: () {
                      addItemToList(currentItem, activeListType);
                      Navigator.of(context).pop();
                      currentItem = '';
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activeListType,
        onTap: (int index) {
          setState(() {
            // _selectedIndex = index;
            activeListType = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: 'Cryptocurrency',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Stock',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_numbered),
            label: 'Precious metals',
          ),
        ],
      ),
    );
  }
}

class Screen4 extends StatefulWidget {
  @override
  _Screen4State createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  who() {
    if (Platform.isIOS) return IosPage();
    if (Platform.isWindows) return WinPage();
    if (kIsWeb) return WebPage();
    if (Platform.isAndroid) return AndroidPage();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: who(),
    );
  }
}

class IosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'IOS page',
          style: GoogleFonts.bungeeSpice(),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.apple,
            size: 500,
            color: Colors.black,
          ),
        ],
      )),
    );
  }
}

class WebPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Web page',
          style: GoogleFonts.bungeeSpice(),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.web,
            size: 500,
            color: Colors.black,
          ),
        ],
      )),
    );
  }
}

class AndroidPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Android page',
            style: GoogleFonts.bungeeSpice(),
          ),
          backgroundColor: Colors.white,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.android,
              size: 500,
              color: Colors.black,
            ),
          ],
        )));
  }
}

class WinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Desktop page',
          style: GoogleFonts.bungeeSpice(),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.desktop_windows,
            size: 500,
            color: Colors.black,
          ),
        ],
      )),
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => First(),
    ),
    GoRoute(path: "/dog", builder: (context, state) => Dog()),
    GoRoute(path: "/cat", builder: (context, state) => Cat())
  ],
);

class Screen5 extends StatefulWidget {
  @override
  _Screen5State createState() => _Screen5State();
}

class _Screen5State extends State<Screen5> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Практика 6',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First page'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () => context.go("/dog"),
              style: ElevatedButton.styleFrom(fixedSize: const Size(150, 50)),
              child: Text("Dog")),
          ElevatedButton(
              onPressed: () => context.go("/cat"),
              style: ElevatedButton.styleFrom(fixedSize: const Size(150, 50)),
              child: Text("Cat")),
          ElevatedButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Frog())),
              style: ElevatedButton.styleFrom(fixedSize: const Size(150, 50)),
              child: Text("Frog")),
          ElevatedButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Cow())),
              style: ElevatedButton.styleFrom(fixedSize: const Size(150, 50)),
              child: Text("Cow")),
        ],
      )),
    );
  }
}

class Dog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dog'),
        backgroundColor: Colors.brown,
      ),
      body: Center(
          child: Column(
        children: [
          const Text(
              "Соба́ка — домашнее животное, одно из наиболее популярных животных-компаньонов. Домашняя собака была описана как самостоятельный биологический вид Canis familiaris Линнеем в 1758 году; в настоящее время данное научное название признаётся организациями, такими как Американское общество маммалогов."),
          ElevatedButton(
              onPressed: () => context.go("/"),
              child: Text("Back to first page")),
          const SizedBox(
            height: 20,
          ),
        ],
      )),
    );
  }
}

class Cat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat'),
        backgroundColor: Colors.brown,
      ),
      body: Center(
          child: Column(
        children: [
          const Text(
              "Ко́шка — домашнее животное, одно из наиболее популярных «животных-компаньонов». С точки зрения научной систематики, домашняя кошка — млекопитающее семейства кошачьих отряда хищных. Одни исследователи рассматривают домашнюю кошку как подвид дикой кошки, другие — как отдельный биологический вид"),
          ElevatedButton(
              onPressed: () => context.go("/"),
              child: Text("Back to first page")),
          const SizedBox(
            height: 20,
          ),
        ],
      )),
    );
  }
}

class Frog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Frog'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
          child: Column(
        children: [
          const Text(
              "Лягу́шки — общеупотребительное название группы животных из отряда бесхвостых земноводных. В широком смысле термин «лягушка» относится ко всем представителям отряда бесхвостых, обладающим увеличенными задними конечностями, которые позволяют им прыгать."),
          TextButton(
            child: const Text('Go back'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      )),
    );
  }
}

class Cow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cow'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
          child: Column(
        children: [
          const Text(
              "Коро́ва — отелившаяся самка крупного рогатого скота, то есть домашнего быка. Прежде чем стать коровой, самка быка является тёлкой, после оплодотворения до первых родов она называется нетелью. Коровы используются для получения потомства, а также молочной и мясной продукции."),
          TextButton(
            child: const Text('Go back'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      )),
    );
  }
}
