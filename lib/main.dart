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
  int selectDif = 0;
  String nombredificultad = DifFacil().nombreDif;
  int numerominimo = DifFacil().numMin;
  int numeromaximo = DifFacil().numMax;
  int intentosposibles = DifFacil().intentos;

  int intentoshechos = 0;

  int numeroescondido = 0;

  int numerousuario = 0;

  String resultadoinput = "Ingrese un numero";

  late TextEditingController textController;
  String textoInput = '';
  List<String> menorhistorial = [];
  List<String> mayorhistorial = [];
  List<String> historial = [];

  @override
  void initState(){
    super.initState();
    textController = TextEditingController();
  }

    @override
  void dispose(){
    textController.dispose();
    super.dispose();
  }

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

  void generarNumeroEscondido(){
    setState(() {
      Random numAdivina = Random();
      numeroescondido = numerominimo + numAdivina.nextInt(numeromaximo - numerominimo + 1);
    });
  }

  void hacerIntento(String input){
    int numAux = int.tryParse(input)??0;
    String resultado = "";

    if(intentosposibles > 0){
      if(numAux != 0){
        setState(() {
            numerousuario = numAux;
          });

        if(numerousuario > numeroescondido){
          resultado = "El numero es mayor al numero escondido";
          setState(() {
            mayorhistorial.add(numerousuario.toString());
          });

        }else if(numerousuario < numeroescondido){
          resultado = "El numero es menor al numero escondido";
          setState(() {
            menorhistorial.add(numerousuario.toString());
          });

        }else{
          resultado = "El numero es igual al numero escondido FELICIDADES";
          setState(() {
            historial.add(numerousuario.toString());
          });
          //historial.add(numAux.toString());
        }

        setState(() {
          intentosposibles--;
          intentoshechos++;
        });

      }else{
        resultado = "Debe ingresar un numero valido";
      }
    }else{
      resultado = "No quedan intentos";

      /*setState(() {
        historial.add(numerousuario.toString());
      });*/
    }

    setState(() {
      numerousuario = numAux;
      resultadoinput = resultado;
    });
    
  }

  /*void registraInput(String input){
    //int numAux = int.parse(input);
    //int numAux = int.tryParse(input)??0;
    /*if(numAux != null){
      setState(() {
        numerousuario = int.parse(input);
      });
    }*/
    setState(() {
      numerousuario = int.tryParse(input)??0;
    });
  }*/

  List<Widget> menorHistorial(){
    return new List<Widget>.generate(menorhistorial.length, (int index) {
      return Text(menorhistorial[index].toString());
    });
  }

  List<Widget> mayorHistorial(){
    return new List<Widget>.generate(mayorhistorial.length, (int index) {
      return Text(mayorhistorial[index].toString());
    });
  }

  List<Widget> agregaHistorial(){
    return new List<Widget>.generate(historial.length, (int index) {
      return Text(historial[index].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        //backgroundColor: Colors.grey,
        title: Text(widget.titleDif),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*Text(
              '$selectDif',
              style: 
              Theme.of(context).textTheme.headlineMedium,
            ),*/
            TextField(
              controller: textController,
              keyboardType: TextInputType.number,
              onSubmitted: (String value){
                hacerIntento(value);
              },
            ),
            
            Text("$nombredificultad ${selectDif.toString()}"),
            Text("Numero minimo ${numerominimo.toString()}"),
            Text("Numero maximo ${numeromaximo.toString()}"),
            Text("Intentos posibles ${intentosposibles.toString()}"),
            Text("Intentos Hechos ${intentoshechos.toString()}"),
            Text("Numero a encontrar ${numeroescondido.toString()}"),
            Text("Numero del usuario ${numerousuario.toString()}"),
            Text(resultadoinput),
            Container(
              child: Row(
                children: <Widget>[
                  Column(
                    children: [
                      mayorhistorial.isEmpty
                      ?const Center(
                        child: Text('Juega para ver tu historial'),
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
                        child: Text('Juega para ver tu historial'),
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
                        child: Text('Juega para ver tu historial'),
                      )
                      : Column(
                        children: agregaHistorial(),
                      )
                    ],
                  ),
                ],
              ),
            ),
            /*Container(
              child: Column(
                children: [
                  historial.isEmpty
                  ?const Center(
                    child: Text('Juega para ver tu historial'),
                  )
                  : Column(
                    children: agregaHistorial(),
                  )
                ],
              ),
            ),*/
            /*Column(
              children: agregaHistorial(),
            ),*/

            /*Container(
              child: Column(
                children: [
                  historial.isEmpty
                  ?const Center(
                    child: Text('Juega para ver tu historial'),
                  )
                  :ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Text('hola mundo 1');
                    }
                  ),
                  
                  /*Expanded(
                    child: ListView.builder(
                      itemCount: historial.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return Text(historial[index]);
                      }
                      ),
                    ),*/
                  
                ],
              ),
              /*child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Text('hola mundo 1');
                }
              ),*/
            ),*/
            
            /*ListView.builder(
              itemCount: historial.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    children: [
                      Text('$historial[index]')
                    ],
                  ),
                );
              }
              ),*/
            //Text('${historial[index]}'),

            /*Container(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index){
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        child: Text(historial[index]),
                      ),
                    ],
                  );
                }, 
                separatorBuilder: (context, index){
                  return SizedBox(width: 20);
                }, 
                itemCount: 3)
            ),*/
            /*ListView.builder(
              itemCount: historial.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Text(historial[index]),
                  );
              }
            ),*/
            Row(
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
            ),
          ],
        ),
      ),
    );
  }
}
