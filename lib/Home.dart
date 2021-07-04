import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _preco = "0";

  void _recuperarPreco() async {
    String url = "https://blockchain.info/ticker";

    http.Response response = await http.get(url);

    Map<String, dynamic> retorno = json.decode(response.body);
    String moeda = retorno["BRL"] ["buy"].toString();

    setState(() {
      _preco = moeda;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/bitcoin.png"),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Text(
                "R\$ $_preco",
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: RaisedButton(
                color: Colors.orange,
                textColor: Colors.white,
                padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                child: Text(
                  "Atualizar",
                  style: TextStyle(
                    fontSize: 20
                  ),
                ),
                onPressed: _recuperarPreco,
              ),
            )
          ],
        ),
      )
    );
  }
}
