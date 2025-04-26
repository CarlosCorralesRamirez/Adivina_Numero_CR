import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:math';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
      ),
      home: const MyHomePage(titleDif: 'Adivina el numero'),
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

class DifFacil extends Dificultad {
  DifFacil() : super("Facil");

  @override
  int get numMin => 1;
  @override
  int get numMax => 10;
  @override
  int get intentos => 5;
}

class DifMedio extends Dificultad {
  DifMedio() : super("Medio");

  @override
  int get numMin => 1;
  @override
  int get numMax => 20;
  @override
  int get intentos => 8;
}

class DifAvanzdo extends Dificultad {
  DifAvanzdo() : super("Avanzado");

  @override
  int get numMin => 1;
  @override
  int get numMax => 100;
  @override
  int get intentos => 15;
}

class DifExtremo extends Dificultad {
  DifExtremo() : super("Extremo");

  @override
  int get numMin => 1;
  @override
  int get numMax => 1000;
  @override
  int get intentos => 25;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.titleDif});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String titleDif;

  //final List<String> historial = [];

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectDif = 1;
  String nombredificultad = DifFacil().nombreDif;
  int numerominimo = DifFacil().numMin;
  int numeromaximo = DifFacil().numMax;
  int intentosposibles = DifFacil().intentos;

  int intentoshechos = 0;

  int numeroescondido = 0;

  int numerousuario = 0;

  String resultadoinput = "Ingrese un numero valido";

  String textHint = "Numbers";
  String textLabel = "Numbers";
  Color hintColor = Colors.grey;
  Color labelColor = Colors.grey;
  Color resultadoColor = Colors.red;

  late TextEditingController textController;
  String textoInput = '';
  List<String> menorhistorial = [];
  List<String> mayorhistorial = [];
  List<String> historial = [];

  double sliderValue = 1;

  String advertencia = "";

  List<Widget> numerosHistorial = [];

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    generarNumeroEscondido();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void seleccionarDificultad(double valorslider) {
    setState(() {
      sliderValue = valorslider;
      selectDif = valorslider.toInt();
      if (selectDif == 1) {
        nombredificultad = DifFacil().nombreDif;
        numerominimo = DifFacil().numMin;
        numeromaximo = DifFacil().numMax;
        intentosposibles = DifFacil().intentos;
      }
      if (selectDif == 2) {
        nombredificultad = DifMedio().nombreDif;
        numerominimo = DifMedio().numMin;
        numeromaximo = DifMedio().numMax;
        intentosposibles = DifMedio().intentos;
      }
      if (selectDif == 3) {
        nombredificultad = DifAvanzdo().nombreDif;
        numerominimo = DifAvanzdo().numMin;
        numeromaximo = DifAvanzdo().numMax;
        intentosposibles = DifAvanzdo().intentos;
      }
      if (selectDif == 4) {
        nombredificultad = DifExtremo().nombreDif;
        numerominimo = DifExtremo().numMin;
        numeromaximo = DifExtremo().numMax;
        intentosposibles = DifExtremo().intentos;
      }
    });

    generarNumeroEscondido();
    limpiarTodo();
  }

  void generarNumeroEscondido() {
    setState(() {
      Random numAdivina = Random();
      numeroescondido =
          numerominimo + numAdivina.nextInt(numeromaximo - numerominimo + 1);
    });
  }

  void hacerIntento(String input) {
    int numAux = int.tryParse(input) ?? 0;
    String resultado = "";

    if (numAux > numeromaximo || numAux < numerominimo) {
      setState(() {
        advertencia =
            "Debe ingresar un numero entre $numerominimo y $numeromaximo";
      });
    } else {
      setState(() {
        advertencia = "";
      });

      if (intentosposibles > 1) {
        if (numAux != 0) {
          setState(() {
            numerousuario = numAux;
            intentosposibles--;
            intentoshechos++;
          });

          if (numerousuario > numeroescondido) {
            resultado = "El numero es mayor al numero escondido";
            setState(() {
              mayorhistorial.add(numerousuario.toString());
            });
          } else if (numerousuario < numeroescondido) {
            resultado = "El numero es menor al numero escondido";
            setState(() {
              menorhistorial.add(numerousuario.toString());
            });
          } else {
            resultado = "El numero es igual al numero escondido FELICIDADES";
            setState(() {
              resultadoColor = Colors.green;
              historial.add(numerousuario.toString());
            });
            agregaResultados();
            reiniciarJuego();
            //limpiarTodo();
            //historial.add(numAux.toString());
          }
        } else {
          resultado = "Debe ingresar un numero valido";
        }
      } else if (intentosposibles > 0) {
        if (numAux != 0) {
          setState(() {
            numerousuario = numAux;
          });
          if (numerousuario == numeroescondido) {
            setState(() {
              resultadoColor = Colors.green;
              historial.add(numerousuario.toString());

              intentosposibles--;
              intentoshechos++;

              agregaResultados();
              reiniciarJuego();
            });
          } else {
            setState(() {
              resultadoColor = Colors.red;
              historial.add(numerousuario.toString());

              intentosposibles--;
              intentoshechos++;

              agregaResultados();
              reiniciarJuego();
            });
          }
        }

        /*setState(() {
          historial.add(numerousuario.toString());
        });*/
      } else {
        resultado = "No quedan intentos";
      }
    }

    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      numerousuario = numAux;
      resultadoinput = resultado;
      textHint = "Numbers";
      hintColor = Colors.grey;
      textLabel = "Numbers";
      labelColor = Colors.grey;
    });

    textController.clear();
  }

  void fieldSeleccionado() {
    setState(() {
      textHint = "###";
      //hintColor = Colors.white;
      textLabel = "Numbers";
      labelColor = Colors.blue;
    });
  }

  void fieldDeseleccionado(PointerDownEvent e) {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() {
      textHint = "Numbers";
      hintColor = Colors.grey;
      textLabel = "Numbers";
      labelColor = Colors.grey;
    });
  }

  void limpiarTodo() {
    textController.clear();
    menorhistorial.clear();
    mayorhistorial.clear();
    intentoshechos = 0;
    advertencia = "";
  }

  void reiniciarJuego() {
    seleccionarDificultad(sliderValue);
  }

  List<Widget> menorHistorial() {
    return new List<Widget>.generate(menorhistorial.length, (int index) {
      return Text(
        menorhistorial[index].toString(),
        style: TextStyle(color: Colors.white),
      );
    });
  }

  List<Widget> mayorHistorial() {
    return new List<Widget>.generate(mayorhistorial.length, (int index) {
      return Text(
        mayorhistorial[index].toString(),
        style: TextStyle(color: Colors.white),
      );
    });
  }

  List<Widget> agregaHistorial() {
    return new List<Widget>.generate(historial.length, (int index) {
      return Text(
        historial[index].toString(),
        style: TextStyle(color: resultadoColor),
      );
    });
  }

  void agregaResultados() {
    setState(() {
      numerosHistorial.add(
        Text(numerousuario.toString(), style: TextStyle(color: resultadoColor)),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    //generarNumeroEscondido();
    return Scaffold(
      backgroundColor: Colors.grey[850],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[800],
        title: Text(widget.titleDif, style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              //Boton presionado
            },
          ),
        ],
      ),
      body: Center(
        //Columna principal
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //Fila de TextField
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: 200.0,
                  child: TextField(
                    controller: textController,
                    onTap: fieldSeleccionado,
                    onTapOutside: fieldDeseleccionado,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      hintText: textHint,
                      hintStyle: TextStyle(color: hintColor),
                      labelText: textLabel,
                      labelStyle: TextStyle(color: labelColor),
                    ),
                    onSubmitted: (String value) {
                      hacerIntento(value);
                    },
                  ),
                ),
                Column(
                  children: <Widget>[
                    Text("Intentos", style: TextStyle(color: Colors.white)),
                    Text(
                      intentosposibles.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                //Box de historial mayor
                SizedBox(
                  width: 100.0,
                  height: 200,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Mayor que",
                            style: TextStyle(color: Colors.white),
                          ),
                          Column(children: mayorHistorial()),
                        ],
                      ),
                    ),
                  ),
                  //child:
                ),

                //Box de historial menor
                SizedBox(
                  width: 100.0,
                  height: 200,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Menor que",
                            style: TextStyle(color: Colors.white),
                          ),
                          Column(children: menorHistorial()),
                        ],
                      ),
                    ),
                  ),
                  //child:
                ),

                //Box de historial
                SizedBox(
                  width: 100.0,
                  height: 200,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Historial",
                            style: TextStyle(color: Colors.white),
                          ),
                          Column(children: numerosHistorial),
                        ],
                      ),
                    ),
                  ),
                  //child:
                ),
              ],
            ),
            Text(nombredificultad, style: TextStyle(color: Colors.white)),

            //Text("Numero minimo ${numerominimo.toString()}", style: TextStyle(color: Colors.white),),
            //Text("Numero maximo ${numeromaximo.toString()}", style: TextStyle(color: Colors.white),),

            //Text("Intentos Hechos ${intentoshechos.toString()}", style: TextStyle(color: Colors.white),),
            //Text("Numero a encontrar ${numeroescondido.toString()}",style: TextStyle(color: Colors.white),),
            //Text("Numero del usuario ${numerousuario.toString()}",style: TextStyle(color: Colors.white),),
            //Text(resultadoinput, style: TextStyle(color: Colors.white),),
            /*Container(
              child: Row(
                children: <Widget>[
                  Column(
                    children: [
                      mayorhistorial.isEmpty
                      ?const Center(
                        child: Text('mayor historial', style: TextStyle(color: Colors.white),),
                      )
                      : Column(
                        children: mayorHistorial(),
                      )
                    ],
                  ),

                  Column(
                    children: [
                      menorhistorial.isEmpty
                      ?const Center(
                        child: Text('menor historial', style: TextStyle(color: Colors.white),),
                      )
                      : Column(
                        children: menorHistorial(),
                      )
                    ],
                  ),

                  Column(
                    children: [
                      historial.isEmpty
                      ?const Center(
                        child: Text('historial', style: TextStyle(color: Colors.white),),
                      )
                      : Column(
                        children: agregaHistorial(),
                      )
                    ],
                  ),
                ],
              ),
            ),*/
            Slider(
              value: sliderValue,
              min: 1,
              max: 4,
              divisions: 3,
              label: nombredificultad,
              activeColor: Colors.blue,
              onChanged: (double slider) {
                seleccionarDificultad(slider);
              },
            ),

            Text(advertencia, style: TextStyle(color: Colors.red)),

            SizedBox(height: 200),
            /*Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: _incrementCounter,
                  tooltip: 'Incrementado',
                  child: const Icon(Icons.add),
                ),
                FloatingActionButton(
                  onPressed: generarNumeroEscondido,
                  tooltip: 'Generando numero random',
                  child: const Icon(Icons.charging_station),
                ),
                /*FloatingActionButton(
                  onPressed: hacerIntento,
                  tooltip: 'Intento Realizado',
                  child: const Icon(Icons.check),
                ),*/
              ],
            ),*/
          ],
        ),
      ),
    );
  }
}
