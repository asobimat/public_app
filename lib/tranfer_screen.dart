import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({Key? key}) : super(key: key);

  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class MyClip extends CustomClipper<Rect> {
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0, 100, 100);
  }

  bool shouldReclip(oldClipper) {
    return false;
  }
}

class _TransferScreenState extends State<TransferScreen> {
  bool isVisible = true;
  String? selectedOption = 'Value1';
  List<String> selectItems = ['Value1', 'Value2', 'Value3'];
  TextEditingController textBoxController = TextEditingController();
  bool radioButtonValue = false;
  bool radioButtonValue1 = false;
  DateTime selectedDate = DateTime.now();
  int currentIndex = 1;
  bool isLoading = false;
  List<String> pickerItems = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  String selectedValue = 'Item 1';
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  final Widget goodJob = const Text('Good job!');
  bool? isChecked1 = false;
  bool? isChecked2 = false;
  bool? isChecked3 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer Screen'),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.plus_one),
        onPressed: () => _counter.value += 1,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('ValueListenableBuilder:'),
          ValueListenableBuilder<int>(
            builder: (BuildContext context, int value, Widget? child) {
              // This builder will only get called when the _counter
              // is updated.
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('$value'),
                  child!,
                ],
              );
            },
            valueListenable: _counter,
            // The child parameter is most helpful if the child is
            // expensive to build and does not depend on the value from
            // the notifier.
            child: goodJob,
          ),
          const Text('ClipOval:'),
          ClipOval(
            child: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRFU7U2h0umyF0P6E_yhTX45sGgPEQAbGaJ4g&usqp=CAU',
                fit: BoxFit.fill),
            clipper: MyClip(),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 20),
                minimumSize: Size.fromHeight(50),
              ),
              onPressed: () {
                setState (() {
                  isVisible = !isVisible;
                });
              },
              child: Text("Show/Hide")
          ),
          for (int i = 0; i < 20; i++)
            Visibility(
                visible: isVisible,
                child: Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text('Item $i'),
                subtitle: Text('Subtitle $i'),
                onTap: () {
                  // Handle item tap
                },
              ),
            ),
            ),
          // Text Box
          TextFormField(
            controller: textBoxController,
            decoration: const InputDecoration(labelText: 'Enter Text'),
          ),
          const SizedBox(height: 16.0),

          // Radio Buttons
          const Text('Choose an option:'),
          Row(
            children: [
              Radio(
                value: true,
                groupValue: radioButtonValue,
                onChanged: (value) {
                  setState(() {
                    radioButtonValue = value as bool;
                    // if (value) {
                    //   _startLoading();
                    // } else {
                    //   _stopLoading();
                    // }
                  });
                },
              ),
              const Text('Option 1'),
              Radio(
                value: false,
                groupValue: radioButtonValue,
                onChanged: (value) {
                  setState(() {
                    radioButtonValue = value as bool;
                    // if (value) {
                    //   _startLoading();
                    // } else {
                    //   _stopLoading();
                    // }
                  });
                },
              ),
              const Text('Option 2'),
            ],
          ),
          const SizedBox(height: 16.0),

          // Check box
          const Text('Checkbox:'),
          Row(
            children: [
              Checkbox(
                tristate: true,
                value: isChecked1,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked1 = value;
                  });
                },
              ),
              const Text('Option 1'),
              Checkbox(
                isError: true,
                tristate: true,
                value: isChecked2,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked2 = value;
                  });
                },
              ),
              const Text('Option 2'),
              Checkbox(
                isError: true,
                tristate: true,
                value: isChecked3,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked3 = value;
                  });
                },
              ),
              const Text('Option 3'),
            ],
          ),
          const SizedBox(height: 16.0),

          // Date Picker
          const Text('Select a date:'),
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: const Text('Pick Date'),
          ),
          Text('Selected Date: ${selectedDate.toLocal()}'),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              _launchURL('https://www.google.com');
            },
            child: const Text('Open Link'),
          ),
            IconButton(
              icon: const Icon(Icons.volume_up),
              tooltip: 'Increase volume by 10',
              onPressed: () {
                setState(() {
                });
              },
            ),
          const Text('Rich text:'),
          RichText(
            text: TextSpan(
              text: 'Hello ',
              style: DefaultTextStyle.of(context).style,
              children: const <TextSpan>[
                TextSpan(text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: ' world!'),
              ],
            ),
          ),
          // TextButton
          const Text('Text button:'),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {},
            child: const Text('Enabled'),
          ),
          // Dropdown (Select) Option
          const Text('Select an option:'),
          DropdownButton<String>(
            value: selectedOption,
            onChanged: (String? newValue) {
              setState(() {
                selectedOption = newValue;
              });
            },
            items: selectItems
                .map((option) => DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            ))
                .toList(),
          ),
          const SizedBox(height: 16.0),

          // Cupertino Switch
          const SizedBox(height: 16.0),
          const Text('Cupertino Switch:'),
          CupertinoSwitch(
            value: radioButtonValue1,
            onChanged: (value) {
              setState(() {
                radioButtonValue1 = value;
                if (value) {
                  _startLoading();
                } else {
                  _stopLoading();
                }
              });
            },
          ),
          // CircularProgressIndicator
          if (isLoading)
            TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0, end: 2400),
              duration: const Duration(milliseconds: 2400),
              builder: (context, value, child) {
                // Lấy màu từ ColorTween
                final color = ColorTween(
                  begin: Colors.blue,
                  end: Colors.red,
                ).lerp(value / 1500);

                return Transform.rotate(
                  angle: value * 0.01,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color,
                    ),
                    child: child,
                  ),
                );
              },
              child: const Center(
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              ),
            ),

          // Cupertino Picker
          const SizedBox(height: 16.0),
          const Text('Cupertino Picker:'),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext builder) {
                  return SizedBox(
                    height: 200.0,
                    child: CupertinoPicker(
                      itemExtent: 32.0,
                      onSelectedItemChanged: (int index) {
                        setState(() {
                          selectedValue = pickerItems[index];
                        });
                      },
                      children: List<Widget>.generate(pickerItems.length,
                            (index) {
                          return Center(
                            child: Text(
                              pickerItems[index],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                selectedValue,
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
          ),

          // InkWell
          const SizedBox(height: 16.0),
          InkWell(
            onTap: () {
              Fluttertoast.showToast(
                  msg: "This is Center Short Toast",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Text(
                'Tap Tap Tap',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
          ),

          // Multiple Items for Scrolling
          for (int i = 0; i < 5; i++)
            Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text('Item $i'),
                subtitle: Text('Subtitle $i'),
                onTap: () {
                  // Handle item tap
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          _handleTabSelection(index);
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.lock),
          label: 'Login',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.swap_horiz_sharp),
          label: 'Transfer',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.read_more),
          label: 'RenderView',
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _handleTabSelection(int index) {
    setState(() {
      currentIndex = index;
    });


    switch (index) {
      case 0:
        Navigator.pop(context);
        break;
      case 1:

        break;
      case 2:
        Navigator.pushNamed(context, '/renderView');
        break;
    }
  }

  // void _showToast(String message) {
  //   Fluttertoast.showToast(
  //     msg: message,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.BOTTOM,
  //     backgroundColor: Colors.black,
  //     textColor: Colors.white,
  //     fontSize: 16.0,
  //   );
  // }

  Future<void> _launchURL(String url) async {
    var uri = Uri.parse(url);
    print('uri : $uri');
    if (!await launchUrl(uri)) {
      throw 'Could not launch';
    }
  }

  void _startLoading() {
    setState(() {
      isLoading = true;
    });
  }

  void _stopLoading() {
    setState(() {
      isLoading = false;
    });
  }
}
