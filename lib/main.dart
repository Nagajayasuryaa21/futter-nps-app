import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kap_support_app/src/constants/constants.dart';
import 'package:kap_support_app/src/utils/CommonUtils.dart';
import 'package:kapture_nps/kapture_nps.dart';
// import 'package:nps_form_test_package/nps_form_test_package.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:lottie/lottie.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSwitched = true;
  bool _isStatusComplete = false;
  bool _isFormClosed = false;
  bool _isProgressComplete = false;
  int _ratingPoints = 0;
  WebResourceError? error = null;
  String? _response  = null;
  String _closeMessage = "";

  @override
  Widget build(BuildContext context) {
    final handleStatusComplete = (value){
      setState(() {
        _isStatusComplete=value;
      });
    };
    final handleFormClosed = (value){
      setState(() {
        _isFormClosed=value;
        if(_isFormClosed){
          Navigator.of(context).pop();
        }
      });
    };
    final handleSwitch = (value){
      setState(() {
        _isSwitched=value;
      });
    };
    final handleProgressComplete = (value){
      setState(() {
        _isProgressComplete=value;
      });
      print("PAGE LOADED CD $_isProgressComplete");
    };
    final handleResponse = (value){

      setState(() {
        if(value!=_response){
          _response=value;
          if(_response!=""){
            _showToast(context, _response.toString());
          }
        }
      });
      if(_response!=null && _response!=""){
      }
      print("RESVALUE $value");

    };
    final handleWebResourceError = (value){
      setState(() {
        error=value;
      });
    };
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Color.fromRGBO(17, 28, 67, 1),
      ),
      body:getHomePage(
          _isSwitched,
          _response,
          _isProgressComplete,
          handleSwitch,
          handleStatusComplete,
          handleFormClosed,
          handleProgressComplete,
          handleWebResourceError,
          handleResponse,
          context,
          _closeMessage
      ),
    );
  }
}


class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({Key? key}) : super(key: key);

  void _show(BuildContext context) {
    // showModalBottomSheet(
    //     elevation: 10,
    //     isScrollControlled: true,
    //     isDismissible: false,
    //     backgroundColor: Colors.white,
    //     context: ctx,
    //     builder: (ctx) => Container(
    //       padding: EdgeInsets.all(20.0),
    //       height: MediaQuery.of(ctx).size.height-100,
    //       color: Colors.transparent,
    //       alignment: Alignment.center,
    //       child: Column(
    //         children: [
    //           const Text('Breathe in... Breathe out...')
    //         ],
    //       ),
    //     ));
    showModalBottomSheet(
        context: context,
        builder: (context) {
          // using a scaffold helps to more easily position the FAB
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.maxFinite,
                ),
                Padding(
                  padding: EdgeInsets.all(30.0),
                  child: Text("Text in the sheet"),
                ),
              ],
            ),
            // translate the FAB up by 30
            floatingActionButton: Container(
              width: 150,
              padding: EdgeInsets.all(5),
              transform: Matrix4.translationValues(0.0, -80, 0.0),  // translate up by 30
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  // do stuff
                  print('doing stuff');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back,color: Colors.red,),
                  Padding(padding: EdgeInsets.all(5))
                  ,
                    Text("Go Back",style: TextStyle(color: Colors.red),)
                  ],
                ),
              ),
            ),
            // dock it to the center top (from which it is translated)
            floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
            child: const Text('Show The BottomSheet'),
            onPressed: () => _show(context),
          ),
        ),
      ),
    );
  }
}





class MyBottomSheetContent extends StatelessWidget {
  final bool isPageLoaded;
  final int buttonId;
  final ValueChanged<bool> onStatusComplete;
  final ValueChanged<bool> onFormClosed;
  final ValueChanged<bool> onProgressComplete;
  final ValueChanged<WebResourceError?> webResourceError;
  final ValueChanged<String?> onResponseMessage;
  final Function(bool) updateIsPageLoaded;
  final Future<Map<String, dynamic>> dataForWebView;
  final Future<String> dataForProgress;
  final ValueChanged<String> closeMessageHandler;




  MyBottomSheetContent({
    required this.isPageLoaded,
    required this.onStatusComplete,
    required this.onFormClosed,
    required this.onProgressComplete,
    required this.webResourceError,
    required this.onResponseMessage,
    required this.updateIsPageLoaded,
    required this.dataForWebView,
    required this.dataForProgress,
    required this.buttonId,
    required this.closeMessageHandler,
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        color: Color.fromRGBO(0, 0, 0, 0.001),
        child: GestureDetector(
          onTap: () {},
          child: DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.2,
            builder: (_, controller) {
              return Container(
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(25.0),
                    topRight: const Radius.circular(25.0),
                  ),
                ),
                child: ListView(
                  // controller: controller,
                  padding: EdgeInsets.zero,
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          // mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height-200,
                              child: Container(
                                color: Colors.transparent,
                                child: FutureBuilder(
                                  future: dataForWebView,
                                  builder: (context,
                                      AsyncSnapshot<Map<String, dynamic>> snapshot) {
                                    print("SCREEN");
                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return loadProgress();
                                    } else if (snapshot.hasError) {
                                      _showToast(context, "Unable to fetch data please try again");
                                      print("ERROR: ${snapshot.error}");
                                    }
                                    if (snapshot.hasData) {
                                      final formCode = snapshot.data!['url'] as String?;
                                      print('Form Link: $formCode');
                                      print('Form Link: ${snapshot.data!}');
                                      const newWebPage = "https://democrm.kapturecrm.com/nui_develop/survey_form/generic/KtV1709892";
                                      if (formCode != null && formCode.isNotEmpty) {
                                        return WebViewPackage(
                                          url: newWebPage,
                                          isStatusComplete: onStatusComplete,
                                          isFormClosed: onFormClosed,
                                          webResourceError: webResourceError,
                                          responseMessage: onResponseMessage,
                                          pageFinished: onProgressComplete,
                                          configId: buttonId,
                                          closeMessageHandler: closeMessageHandler,
                                        );
                                        // return ;
                                      } else {
                                        _showToast(context, 'URL not found please try again');
                                      }
                                    }
                                    return loadProgress();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          onVerticalDragDown: (drag){
            print("Drag Down ${drag.localPosition}");
            print("Drag Down ${drag.globalPosition.direction}");
          },
        ),
      ),
    );
  }
}


Widget loadProgress(){
  return Container(
      alignment: Alignment.topCenter,
      color: Colors.white,
      child:Column(
        children: [
          Padding(padding: EdgeInsets.all(20),child: Text("Please wait...",textAlign: TextAlign.center,),),
          Lottie.asset("assets/lottieAnimation.json"),
        ],
      ),
  );
}

Widget getHomePage(
    bool isSwitched,
    String? response,
    bool isPageLoaded,
    ValueChanged<bool> onSwitchChanged,
    ValueChanged<bool> onStatusComplete,
    ValueChanged<bool> onFormClosed,
    ValueChanged<bool> onProgressComplete,
    ValueChanged<WebResourceError?> webResourceError,
    ValueChanged<String?> onResponseMessage,
    BuildContext context,
    String closeMessage
    ) {
  if(response!=null){
  }
  if(!isSwitched){
    return returnSecondPage(
        isSwitched,
        onSwitchChanged,
        onStatusComplete,
        onProgressComplete,
        webResourceError,
        onResponseMessage,
        context
    );
  }
  else{
    return HomeScreenGridSTF(
        isSwitched: isSwitched,
        isPageLoaded: isPageLoaded,
        onSwitchChanged: onSwitchChanged,
        onStatusComplete: onStatusComplete,
        onFormClosed: onFormClosed,
        onResponseMessage: onResponseMessage,
        onProgressComplete: onProgressComplete,
        webResourceError:webResourceError,
        closeMessage: closeMessage,
    );
  }
}

class HomeScreenGridSTF extends StatefulWidget {
  final bool isSwitched;
  final bool isPageLoaded;
  final ValueChanged<bool> onSwitchChanged;
  final ValueChanged<bool> onStatusComplete;
  final ValueChanged<bool> onFormClosed;
  final ValueChanged<bool> onProgressComplete;
  final ValueChanged<WebResourceError?> webResourceError;
  final ValueChanged<String?> onResponseMessage;
  final String closeMessage;
  const HomeScreenGridSTF({
    super.key,
    required this.isSwitched,
    required this.isPageLoaded,
    required this.onSwitchChanged,
    required this.onStatusComplete,
    required this.onProgressComplete,
    required this.webResourceError,
    required this.onResponseMessage,
    required this.closeMessage,
    required this.onFormClosed
  });

  @override
  State<HomeScreenGridSTF> createState() => _HomeScreenGridSTFState();
}

class _HomeScreenGridSTFState extends State<HomeScreenGridSTF> {
  bool _isPageLoaded = false;
  late Future<Map<String, dynamic>> _dataForWebView ;
  late Future<String> _dataForProgress ;
  late String closeMessage;
  @override
  void initState() {
    super.initState();
    closeMessage = widget.closeMessage;
  }
  //
  // Future<String> _fetchDataForProgress() async {
  //   // Simulate some asynchronous operation
  //   await (){if(widget.isPageLoaded){return "Loading completed";}}; // Simulating delay
  //    // Return initial value after delay
  // }
  //
  // @override
  // void didUpdateWidget(covariant HomeScreenGridSTF oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (oldWidget.isPageLoaded != widget.isPageLoaded && widget.isPageLoaded) {
  //     _dataForProgress = Future.value("true");
  //   }
  // }


  void _onCloseMessage(String value) {
    setState(() {
      closeMessage = value;
      print("closeMessage ${closeMessage}");
    });
  }
  @override
  Widget build(BuildContext context) {
    _isPageLoaded = widget.isPageLoaded;
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          title: Row(
            children: [
              Image.asset("assets/kaptureLogo.png"),
              Text('Kapture CX',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          backgroundColor: Color.fromRGBO(17, 28, 67, 1),
        ),
        backgroundColor: Color.fromRGBO(220,220,220, 1),
        body:Center(
          child: GridView.builder(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: Constants.choices.length,
            itemBuilder: (BuildContext context, int index) {
              print("PAGE 463 ${widget.isPageLoaded}");
              return
                GestureDetector(
                  onTap: () {
                    print("Tap $index");
                    // if(index == 4){
                      _dataForWebView =
                      _fetchDataForWebView(widget.onFormClosed, context);
                      _dataForProgress = Future<String>.value("");
                      // _dataForProgress = Future.delayed(Duration.zero,()=>"null");
                      _showBottomSheet(
                          context,
                          widget.onStatusComplete,
                          widget.onFormClosed,
                          widget.isPageLoaded,
                          _dataForWebView,
                          _dataForProgress,
                          index+1,
                          _onCloseMessage
                        // widget.isPageLoaded,
                        // widget.onStatusComplete,
                        // widget.onProgressComplete,
                        // widget.webResourceError,
                        // widget.onResponseMessage,
                      );
                    // }else{
                    //   widget.onSwitchChanged(false);
                    // }
                  },
                  child: Container(
                    child: Card(
                      color: Color.fromRGBO(255, 255, 255, 1),
                      elevation: 2,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Constants.choices[index].icon,
                              size: 50,
                              //17, 28, 67, 1
                              //194, 5, 21, 1.0
                              color: Color.fromRGBO(17, 28, 67, 1),
                            ),
                            SizedBox(height: 10,),
                            Text(Constants.choices[index].title, style: TextStyle(fontSize: 20,color: Color.fromRGBO(17, 28, 67, 1)),textAlign: TextAlign.center,),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
            },
          ),
        )
    );
  }
  void _showBottomSheet(
      BuildContext context,
      ValueChanged<bool> onStatusComplete,
      ValueChanged<bool> onFormClosed,
      bool isPageLoaded,
      Future<Map<String, dynamic>> _dataForWebView,
      Future<String> _dataForProgress,
      int buttonId, void Function(String value) onCloseMessage
      // Function(bool) updateIsPageLoaded,
      ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context,StateSetter setstate){
            print("STATE ${widget.isPageLoaded}");
            return MyBottomSheetContent(
              isPageLoaded: isPageLoaded,
              onStatusComplete: widget.onStatusComplete,
              onFormClosed: widget.onFormClosed,
              onProgressComplete: widget.onProgressComplete,
              webResourceError: widget.webResourceError,
              onResponseMessage: widget.onResponseMessage,
              updateIsPageLoaded: widget.onFormClosed,
              dataForWebView: _dataForWebView,
              dataForProgress: _dataForProgress,
              buttonId: buttonId,
              closeMessageHandler: onCloseMessage,
            );
          },
        );
      },
    ).whenComplete(() {
      _showToast(context, closeMessage);
      widget.onFormClosed(false);
      widget.onProgressComplete(false);
      widget.webResourceError(null);
      widget.onResponseMessage("");
    });
  }



}


Widget returnSecondPage(bool isSwitched,
    ValueChanged<bool> onSwitchChanged,
    ValueChanged<bool> onStatusComplete,
    ValueChanged<bool> onProgressComplete,
    ValueChanged<WebResourceError> webResourceError,
    ValueChanged<String> onResponseMessage,
    BuildContext context ){
  return Container(
    color: Colors.white,
    child: FutureBuilder(
      future: _fetchDataForWebView(onSwitchChanged,context),
      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        print("SCREEN");
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if(snapshot.hasData){
          final formCode = snapshot.data!['url'] as String?;
          // final formCode = null;
          print('Form Link: $formCode');
          print('Form Link: ${snapshot.data!}');
          if (formCode != null && formCode.isNotEmpty) {
            // If URL is present, return WebViewPackage with the URL
            print("NEXT PAGE ");
            return Scaffold(
                appBar: AppBar(
                  title: Text("WebView"),
                  leading: BackButton(
                    color: Colors.white,
                    onPressed: (){
                      onSwitchChanged(false);
                    },
                  ),
                ),
                body: WebViewPackage(
                  url:formCode,
                  isStatusComplete: onStatusComplete,
                  isFormClosed: onSwitchChanged,
                  webResourceError: webResourceError,
                  pageFinished: onProgressComplete,
                  responseMessage: onResponseMessage,
                  configId: 1, closeMessageHandler: (String value) {  },
                )
            );
          } else {
            // If URL is not present, return WebViewPackage with other parameters
            _showToast(context, 'URL not found please try again');
            Future.microtask(() {
              onSwitchChanged(true);
            });
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    ),
  );
}

Future<Map<String, dynamic>> _fetchDataForWebView(
    ValueChanged<bool> onSwitchChanged ,
    BuildContext context ) async {
  try {
    final response = await http.post(
      Uri.parse(Constants.baseUrl),
      headers: {
        'Content-Type': 'application/json', // Set the content type
      },
      body: jsonEncode({
        'eventType': 'Aditya Birala 1',
        'customerId': 10,
      }),
    );
    if (response.statusCode == 201) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData;
    } else {
      onSwitchChanged(true);
      _showToast(context, 'Unable to fetch data please try again');
      throw Exception('Failed to fetch data');
    }
  } catch (e) {
    onSwitchChanged(true);
    _showToast(context, 'Unable to fetch data please try again');
    throw Exception('Failed to fetch data: $e');
  }
}

void _showToast(BuildContext context,String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
