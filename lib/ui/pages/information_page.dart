import 'package:flutter/material.dart';
import 'package:safe_place_app/ui/ui_constants.dart';

class InformationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double _paddingTop = MediaQuery.of(context).padding.top;
    double container = 120;

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Container(
          height: 60,
          padding: EdgeInsets.only(top: _paddingTop),
          margin: EdgeInsets.only(top: 10),
          child: Text(
            'Recomendações',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text(
              'Se possivel fique em casa, mas se precisar sair sempre siga os métodos de prevenção:',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: fontPrimaryColor),
            ),
            Divider(),
            Container(
              height: container,
              padding: EdgeInsets.all(10.0),
              color: Color.fromRGBO(224, 237, 254, 1),
              child: Row(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/useMascara.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Sempre utilize a máscara.',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              height: container,
              padding: EdgeInsets.all(10.0),
              color: Color.fromRGBO(129, 135, 213, 1),
              child: Row(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/alcoolGel.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Só entre nos estabelecimentos que disponibilize álcool gel na entrada, e sempre utilize.',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              height: container,
              padding: EdgeInsets.all(10.0),
              color: Color.fromRGBO(16, 137, 254, 1),
              child: Row(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/multidao.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Evite lugares que estejam muito cheios.',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              height: container,
              padding: EdgeInsets.all(10.0),
              color: Color.fromRGBO(255, 238, 228, 1),
              child: Row(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/pegarNecessario.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Procure tocar apenas nos produtos que vai levar.',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              height: container,
              padding: EdgeInsets.all(10.0),
              color: Color.fromRGBO(77, 212, 153, 1),
              child: Row(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/bocaNariz.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Evite tocar nos olhos, nariz e boca com as mãos não lavadas depois de tocar nos produtos.',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              height: container,
              padding: EdgeInsets.all(10.0),
              color: Color.fromRGBO(254, 147, 91, 1),
              child: Row(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/obejtosPessoais.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Não compartilhe objetos pessoais como copos, talheres e garrafas.',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              height: container,
              padding: EdgeInsets.all(10.0),
              color: Color.fromRGBO(74, 140, 201, 1),
              child: Row(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/desinfetarProdutos.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Procure higienizar e desinfetar as embalagens dos produtos comprados quando chegar em casa.',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
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
