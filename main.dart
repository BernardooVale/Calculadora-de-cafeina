import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toggle_switch/toggle_switch.dart';

//main feito por Bernardo Vale dos Santos Bento

void main() {
  runApp(const MaterialApp(
    home: paginaPrincipal(),
  ));
}

class paginaPrincipal extends StatefulWidget {
  const paginaPrincipal({Key? key}) : super(key: key);

  @override
  State<paginaPrincipal> createState() => _paginaPrincipalState();
}

class _paginaPrincipalState extends State<paginaPrincipal> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController mlControle = TextEditingController();
  String _informacao = "", _dadosPessoa = "", titulo = "Cafeteria do Épico", tipoCafe1 = "Coado", tipoCafe2 = "Expresso",
  dropdown1 = "Selecionar", dropdown2 = "Gestantes e lactantes", dropdown3 = "Crianças e Adolescentes", dropdown4 = "Adultos",
      dropdown5 = "Sensíveis a cafeína", consumo = "Consumo", semConsumo = "Insira seu consumo", diagnosticoBom = "Saudável",
      diagnosticoRuim = "Beba menos café", semCondicao = "Insira sua condição";
  double resultadoConsumo = 0;
  int _tipoCafe = 0, _lingua = 0;

  void _reiniciaDados(){

    setState(() {

      mlControle.text = "";
      _informacao = "";
      _formKey = GlobalKey<FormState>();
      _lingua = 0;

    });
  }

  void mudaLingua(){

    if(_lingua == 0){

      setState(() {

        titulo = "Cafeteria do Épico";
        tipoCafe1 = "Coado";
        tipoCafe2 = "Expresso";
        dropdown1 = "Selecionar";
        dropdown2 = "Gestantes e lactantes";
        dropdown3 = "Crianças e adolescentes";
        dropdown4 = "Adultos";
        dropdown5 = "Sensíveis a cafeína";
        consumo = " Consumo(ml)";
        semConsumo = "Insira seu consumo";
        diagnosticoBom = "Saudável";
        diagnosticoRuim = "Beba menos café";
        semCondicao = "Insira sua condição";

      });
    } else if(_lingua == 1){

      setState(() {

        titulo = "Epico's cafe";
        tipoCafe1 = "Brewed coffee";
        tipoCafe2 = "Espresso";
        dropdown1 = "Select";
        dropdown2 = "Pregnant and lactating women";
        dropdown3 = "Children and teenagers";
        dropdown4 = "Adults";
        dropdown5 = "Caffeine sensitive";
        consumo = " Consumption(ml)";
        semConsumo = "Insert your consume";
        diagnosticoBom = "Healthy";
        diagnosticoRuim = "Drink less coffee";
        semCondicao = "Insert your condition";

      });
    }
  }

  void _calculo(){

    setState(() {
      double consumo = double.parse(mlControle.text);
      if(_tipoCafe == 0){

        resultadoConsumo = consumo * 0.68;

      } else if(_tipoCafe == 1){

        resultadoConsumo = consumo * 2;
      }

      if(_dadosPessoa == "Gestantes e lactantes"){

        if(resultadoConsumo > 200){

          _informacao = diagnosticoRuim;

        } else {

          _informacao = diagnosticoBom;
        }
      } else if(_dadosPessoa == "Crianças e Adolescentes"){

        if(resultadoConsumo > 100){

          _informacao = diagnosticoRuim;

        } else {

          _informacao = diagnosticoBom;
        }
      } else if(_dadosPessoa == "Adultos"){

        if(resultadoConsumo > 400){

          _informacao = diagnosticoRuim;

        } else {

          _informacao = diagnosticoBom;
        }
      } else if(_dadosPessoa == "Sensíveis a cafeína"){

        if(resultadoConsumo > 200){

          _informacao = diagnosticoRuim;

        } else {

          _informacao = diagnosticoBom;
        }
      } else if(_dadosPessoa == "") {

        _informacao = semCondicao;

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(20, 125, 30, 100),
        actions: <Widget>[
          IconButton(onPressed: _reiniciaDados,
              icon: const Icon(Icons.refresh)),
        ],
      ),
      backgroundColor: Colors.black38,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10.0, 25.0, 10.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Icon(Icons.coffee_maker_rounded, size: 120.0, color: Color.fromRGBO(20, 125, 30, 100)),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 25),
                child: Center(
                  child: ToggleSwitch(
                    minWidth: 140.0,
                    initialLabelIndex: 0,
                    cornerRadius: 20.0,
                    inactiveBgColor: Colors.grey,
                    totalSwitches: 2,
                    labels: [tipoCafe1, tipoCafe2],
                    icons: const [Icons.coffee_outlined, Icons.coffee_outlined],
                    activeBgColors: const [[Color.fromRGBO(20, 125, 30, 100)],[Color.fromRGBO(20, 125, 30, 100)]],
                    onToggle: (tipoCafe) {
                      _tipoCafe = tipoCafe!;
                    },
                  ),
                ),
              ),
              DropdownButton(
                icon: const Icon(Icons.coffee_rounded),
                style: const TextStyle(color: Colors.white70),
                isExpanded: true,
                dropdownColor: const Color.fromRGBO(64, 64, 64, 100),
                items:[
                  DropdownMenuItem(value: "", child: Text(dropdown1)),
                  DropdownMenuItem(value: "Gestantes e lactantes", child: Text(dropdown2)),
                  DropdownMenuItem(value: "Crianças e Adolescentes", child: Text(dropdown3)),
                  DropdownMenuItem(value: "Adultos", child: Text(dropdown4)),
                  DropdownMenuItem(value: "Sensíveis a cafeína", child: Text(dropdown5)),
                ],
                value: _dadosPessoa,
                onChanged: (String? value) {

                  if(value is String){

                    setState(() {
                      _dadosPessoa = value;
                    });
                  }
                },
              ),
              TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    labelText: consumo,
                    labelStyle: const TextStyle(color:  Colors.white70),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 25.0),
                  controller: mlControle,
                  validator: (value){
                    if(value!.isEmpty){
                      return semConsumo;
                    }
                  }
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                child: ElevatedButton(
                  onPressed:(){
                    if(_formKey.currentState!.validate()) {
                      _calculo();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(20, 125, 30, 100),
                    fixedSize: const Size(250, 50),
                  ),
                  child: const Icon(Icons.play_arrow_rounded, size: 40, color: Colors.white),
                ),
              ),
              Text(_informacao, style: const TextStyle(color: Colors.white70, fontSize: 25.0),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 170, 0, 0),
                child: Center(
                  child: ToggleSwitch(
                    minWidth: 90,
                    initialLabelIndex: 0,
                    cornerRadius: 20.0,
                    inactiveBgColor: Colors.grey,
                    totalSwitches: 2,
                    labels: const ["Português", "English"],
                    activeBgColors: const [[Color.fromRGBO(20, 125, 30, 100)],[Color.fromRGBO(150, 8, 8, 100)]],
                    onToggle: (lingua) {
                      _lingua = lingua!;
                      mudaLingua();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
