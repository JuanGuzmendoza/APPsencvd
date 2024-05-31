import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:open_file/open_file.dart';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Create PDF',
      home: PdfScreen(),
    );
  }
}

class PdfScreen extends StatefulWidget {
  @override
  _PdfScreenState createState() => _PdfScreenState();
}

class _PdfScreenState extends State<PdfScreen> {
  String pdfFile = '';

  Future<void> createPdfFile(String Nombre) async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text('Nombre' + Nombre, style: pw.TextStyle(fontSize: 20)),
        );
      },
    ));

    final bytes = await pdf.save();

    final directory = await getApplicationSupportDirectory();
    final file = File('${directory.path}/output.pdf');
    await file.writeAsBytes(bytes);

    setState(() {
      pdfFile = file.path;
    });
  }

  void savePdfFile() {
    OpenFile.open(pdfFile);
  }
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Color colorform =Color.fromARGB(221, 255, 255, 255);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Container(
            color: Color.fromARGB(179, 204, 204, 204),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[

                        Container(
                          width: MediaQuery.of(context).size.width,
                          height:MediaQuery.of(context).size.height*33/100,
                          color: Colors.green,
                          child: Column(
                         children: [
                          SizedBox(
                            width: 200,
                            height:200,
                            child: Padding(
                              padding:  EdgeInsets.only(top: 30.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                          Text("JUAN GUZMAN",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 29),),
                          Text("Tecnico en Sistemas",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),)
                         ],
                          ),
                        ),
                        // Add your list items here
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                                labelText: 'Nombre',
                                prefixIcon: Icon(Icons.person,color: Colors.green,),
                                filled: true,
                                fillColor: colorform,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ),
                          Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                                labelText: 'Nombre',
                                prefixIcon: Icon(Icons.person,color: Colors.green,),
                                filled: true,
                                fillColor: colorform,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ),   Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _nameController,
                            decoration: InputDecoration(
                                labelText: 'Nombre',
                                prefixIcon: Icon(Icons.person,color: Colors.green,),
                                filled: true,
                                fillColor: colorform,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                )),
                          ),
                        ),
                        //...
                      ],
                    ),
                  ),
                ),
            
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.green,
          onPressed: () async {
            await createPdfFile(_nameController.text);
            savePdfFile();
          },
             label:Text('Crear CVD',style: TextStyle(fontWeight: FontWeight.w900,color: Colors.white),),
                icon: const Icon(Icons.note_add,color: Colors.white,),
        
        ));
  }
}
