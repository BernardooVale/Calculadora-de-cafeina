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
  String _informacao = "", _dadosPessoa = "";
  double resultadoConsumo = 0;
  int _tipoCafe = 0;

  void _reiniciaDados(){

    mlControle.text = "";
    _informacao = "";
    _formKey = GlobalKey<FormState>();

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

          _informacao = "Amanda?";

        } else {

          _informacao = "Saudável";
        }
      } else if(_dadosPessoa == "Crianças e Adolescentes"){

        if(resultadoConsumo > 100){

          _informacao = "Amanda?";

        } else {

          _informacao = "Saudável";
        }
      } else if(_dadosPessoa == "Adultos"){

        if(resultadoConsumo > 400){

          _informacao = "Amanda?";

        } else {

          _informacao = "Saudável";
        }
      } else if(_dadosPessoa == "Sensíveis a cafeína"){

        if(resultadoConsumo > 200){

          _informacao = "Amanda?";

        } else {

          _informacao = "Saudável";
        }
      } else if(_dadosPessoa == "") {

        _informacao = "Selecione sua condição";

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cafeteria do Épico"),
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
                    labels: const ["Coado", "Expresso"],
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
                items: const [
                  DropdownMenuItem(value: "", child: Text("Selecionar")),
                  DropdownMenuItem(value: "Gestantes e lactantes", child: Text("Gestantes e lactantes")),
                  DropdownMenuItem(value: "Crianças e Adolescentes", child: Text("Crianças e Adolescentes")),
                  DropdownMenuItem(value: "Adultos", child: Text("Adultos")),
                  DropdownMenuItem(value: "Sensíveis a cafeína", child: Text("Sensíveis a cafeína")),
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
                  decoration: const InputDecoration(
                    labelText: "Consumo (ml)",
                    labelStyle: TextStyle(color:  Colors.white70),
                  ),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 25.0),
                  controller: mlControle,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Insira o consumo";
                    } else if(double.parse(value) < 1){
                      return "consumo muito baixo";
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
                    backgroundColor: const Color.fromRGBO(20, 125, 30, 100),
                    fixedSize: const Size(250, 50),
                  ),
                  child: const Text("Resultado", style: TextStyle(color: Colors.white, fontSize: 25.0),
                  ),
                ),
              ),
              Text(_informacao, style: const TextStyle(color: Colors.white70, fontSize: 25.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
