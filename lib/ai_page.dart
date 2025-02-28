import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AiPage extends StatefulWidget {
  const AiPage({super.key});

  @override
  State<AiPage> createState() => _AiPageState();
}

Future<void> gerarIA() async {
  final response = await Dio().get('https://dart.dev');
  print(response);
}
class _AiPageState extends State<AiPage> {
 TextEditingController controller = TextEditingController ();
 bool estaCarregando = false;
 String textoGerado = "";

 
 Future<void> gerarConteudo () async {
  setState(() {
    estaCarregando = true;
  });
  print(controller.text);
  String prompt = controller.text;
  String key ="AIzaSyBMmhg9XPjmyJNvVouAl0QHrUTvIZuWw4c";
  String url = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=$key";

  var data = {
  "contents": [{
    "parts":[
      {"text": prompt},
      ]
    }]
   };

    try{
      var resposta = await Dio().post(url, data: data);
   if(resposta.statusCode == 200);{
    print(resposta.data);
    setState(() {
      textoGerado = resposta.data['candidates'][0]['content']['parts'][0]['text'];
    });
   }
    }catch(erro){
      print(erro);
    } finally{
      setState(() {
    estaCarregando = false;
  });
    }

   
 }
 
  @override
  Widget build(BuildContext context) {
    double larguraDaTela =MediaQuery.of(context).size.width;
    double alturaDATela = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 16, 26, 44),
        title: Text("IA",
        style: TextStyle(color: Colors.white,
 ),
        ),
      ),
    
      body: Column(     
        children: [
          Container(
            child: Center(
              child: SizedBox(
                width: larguraDaTela * 0.65,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      label: Text("Comando"),
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder()
                    ),
                  ),
                ),
              ),
            ),
          ),

          ElevatedButton(onPressed: gerarConteudo, child: Text("Gerar",),
          ),

          Text(textoGerado),
          SizedBox(
            height: 27,
          ),
          Container(
            child: Column(
              children: [
                estaCarregando ?
                CircularProgressIndicator() :
                Text("Texto g")
              ],
            ),
            
          )
     
        ],
        

      ),
      bottomNavigationBar: Container(
        color:Color.fromARGB(255, 16, 26, 44),
        height:40,
      ),
    );
  }
}
//AIzaSyBMmhg9XPjmyJNvVouAl0QHrUTvIZuWw4c