import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicacion de Adivina el numero',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(titleDif: 'Adivina el numero', min: 0, max: 0, intents: 0,),
    );
  }
}

class Dificultad {
  String nombreDif;
  Dificultad(this.nombreDif);
  int numMin = 1;
  int numMax = 1;

  int intentos = 1;
}

class DifFacil extends Dificultad{
  DifFacil () : super("Facil");

  @override
  int get numMin => 1;
  @override
  int get numMax => 10;
  @override
  int get intentos => 5;
}

class DifMedio extends Dificultad{
  DifMedio () : super("Medio");

  @override
  int get numMin => 1;
  @override
  int get numMax => 20;
  @override
  int get intentos => 8;
}

class DifAvanzdo extends Dificultad{
  DifAvanzdo () : super("Avanzado");

  @override
  int get numMin => 1;
  @override
  int get numMax => 100;
  @override
  int get intentos => 15;
}

class DifExtremo extends Dificultad{
  DifExtremo () : super("Extremo");

  @override
  int get numMin => 1;
  @override
  int get numMax => 1000;
  @override
  int get intentos => 25;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.titleDif, required this.min, required this.max, required this.intents});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String titleDif;
  final int min;
  final int max;
  final int intents;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/*class CambiaTexto extends StatefulWidget {
  @override
  State<CambiaTexto> createState() => _MyHomePageState();
}*/

class _MyHomePageState extends State<MyHomePage> {
  int selectDif = 0;
  String nombredificultad = 'Ninguna';
  int numerominimo = 0;
  int numeromaximo = 0;
  int intentosposibles = 0;

  int intentoshechos = 0;
  int numeroescondido = 0;

  void _incrementCounter() {
    setState(() {
      selectDif++;
      if(selectDif == 1){
        nombredificultad = DifFacil().nombreDif;
        numerominimo = DifFacil().numMin;
        numeromaximo = DifFacil().numMax;
        intentosposibles = DifFacil().intentos;
      }
      if(selectDif == 2){
        nombredificultad = DifMedio().nombreDif;
        numerominimo = DifMedio().numMin;
        numeromaximo = DifMedio().numMax;
        intentosposibles = DifMedio().intentos;
      }
      if(selectDif == 3){
        nombredificultad = DifAvanzdo().nombreDif;
        numerominimo = DifAvanzdo().numMin;
        numeromaximo = DifAvanzdo().numMax;
        intentosposibles = DifAvanzdo().intentos;
      }
      if(selectDif == 4){
        nombredificultad = DifExtremo().nombreDif;
        numerominimo = DifExtremo().numMin;
        numeromaximo = DifExtremo().numMax;
        intentosposibles = DifExtremo().intentos;
      }
    });
  }

  void HacerIntento(){
    
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.titleDif),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(nombredificultad),
            Text(numerominimo.toString()),
            Text(numeromaximo.toString()),
            Text(intentosposibles.toString()),
            Text(
              '$selectDif',
              style: 
              Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Incrementado',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
