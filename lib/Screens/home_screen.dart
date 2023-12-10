import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _currencies = ["USD", "BDT", "AUD"];
  var _currentSelectedItems = "BDT";
  var displayResult = "";
  var _formKey = GlobalKey<FormState>();

  TextEditingController principalController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController termController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade900,
        title: const Text(
          "Interest Calculator",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            Center(
                child: Image.asset(
              "assets/interest.png",
              fit: BoxFit.cover,
            )),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: principalController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "please Enter The Principal Amount";
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "Principal Amount",
                  hintText: "Enter a Principal amount e.g 15000",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: rateController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "please Enter The Interest Amount";
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "Rate Of Interest",
                  hintText: "Enter in percentage e.g 15",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: termController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "please Enter The Term Amount";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: "Term",
                        hintText: "Term in Years e.g 10",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    child: DropdownButton(
                      items: _currencies.map(
                        (value) {
                          return DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                      onChanged: (newSelectedItem) {
                        setState(() {
                          _currentSelectedItems = newSelectedItem!;
                        });
                      },
                      value: _currentSelectedItems,
                      isExpanded: true,
                      isDense: true,
                      underline: const SizedBox.shrink(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_formKey.currentState!.validate()) {
                        displayResult = calculateInterest();
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(100, 50),
                  ),
                  child: const Text("Calculate",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  width: 15,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      resultFields();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    backgroundColor: Colors.orange[800],
                    foregroundColor: Colors.white,
                    minimumSize: const Size(100, 50),
                  ),
                  child: const Text(
                    "Reset",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
                child: Text(
              displayResult,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            )),
          ],
        ),
      ),
    );
  }

  String calculateInterest() {
    double principal = double.parse(principalController.text);
    double rate = double.parse(rateController.text);
    double term = double.parse(termController.text);

    double totalPayable = principal + (principal + rate + term) / 100;
    String result =
        "After $term years, Your Investment will be worth of $totalPayable $_currentSelectedItems";
    return result;
  }

  void resultFields() {
    principalController.text = "";
    rateController.text = "";
    termController.text = "";
    _currentSelectedItems = "BDT";
    displayResult = "";
  }
}
