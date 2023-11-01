import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
class PDFScreen extends StatefulWidget {
  final String? path;

  const PDFScreen({Key? key, this.path}) : super(key: key);

  @override
  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
  Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share,color: Colors.blue,),
            onPressed: () {

            },
          ),
        ],
        leading: IconButton(onPressed: (){
      Navigator.of(context).pop();
    },icon: Icon(Icons.arrow_back,color: Colors.black,)),
    backgroundColor: Colors.white,
    elevation: 0,
    title: Image.asset("images/logo-color.png",width: 250,height: 90,),
    ),


      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            onRender: (_pages) {
              setState(() {
                pages = _pages;
                isReady = true;
              });
            },
            onError: (error) {
              setState(() {
                errorMessage = error.toString();
              });
              print(error.toString());
            },
            onPageError: (page, error) {
              setState(() {
                errorMessage = '$page: ${error.toString()}';
              });
              print('$page: ${error.toString()}');
            },
            onViewCreated: (PDFViewController pdfViewController) {
              _controller.complete(pdfViewController);
            },
          ),
          errorMessage.isEmpty
              ? !isReady
              ? const Center(
            child: CircularProgressIndicator(),
          )
              : Container()
              : Center(
            child: Text(errorMessage),
          )
        ],
      ),
    );
  }
}