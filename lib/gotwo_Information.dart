import 'package:flutter/material.dart';

class GotwoInformation extends StatefulWidget {
  @override
  State<GotwoInformation> createState() => _GotwoInformationState();
}

class _GotwoInformationState extends State<GotwoInformation> {
  TextEditingController expirationController = TextEditingController();
  TextEditingController carRegistrationController = TextEditingController();
  TextEditingController carBrandController = TextEditingController();
  TextEditingController namebankAccountController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();

  static const List<String> list = <String>[
    'Bank Select',
    'Bank 1',
    'Bank 2',
  ];
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          Colors.white,
          Colors.white,
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _page(),
      ),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _aText(),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _idcardBtn(),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _licenseBtn(),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _carPictureBtn(),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child:
                      _carRegistrationBtn(),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _carACTBtn(),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _inputField("Expiration date", expirationController),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _inputField("Car registration", carRegistrationController),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _inputField("Car brand", carBrandController),
                )
              ],
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Color(0xff1a1c43),
              height: 2,
              thickness: 1,
              indent: 10,
              endIndent: 1,
            ),
            const SizedBox(height: 10),
            _bText(),
            const SizedBox(height: 10),
            _dropdown(),
            const SizedBox(height: 10),
            _inputField2("Bank account name", namebankAccountController),
            const SizedBox(height: 10),
            _inputField2("Enter account number", accountNumberController),
            const SizedBox(height: 5),
            _nextBtn(),
          ],
        ),
      ),
    );
  }

  Widget _aText() {
    return const Text(
      "Information Personal",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 26, color: Color(0xff1a1c43), fontWeight: FontWeight.bold),
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {isPassword = false}) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xff1a1c43)));

    return SizedBox(
      height: 40,
      width: 100,
      child: TextField(
        style: const TextStyle(color: Color(0xff1a1c43), fontSize: 12),
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xff1a1c43)),
          enabledBorder: border,
          focusedBorder: border,
        ),
        obscureText: isPassword,
      ),
    );
  }

  Widget _inputField2(String hintText, TextEditingController controller,
      {isPassword = false}) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xff1a1c43)));

    return SizedBox(
      child: TextField(
        style: const TextStyle(
          color: Color(0xff1a1c43),
        ),
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xff1a1c43)),
          enabledBorder: border,
          focusedBorder: border,
        ),
        obscureText: isPassword,
      ),
    );
  }

  Widget _bText() {
    return const Text(
      "Bank Account",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 26, color: Color(0xff1a1c43), fontWeight: FontWeight.bold),
    );
  }

  Widget _dropdown() {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xff1a1c43)));

    return DropdownButtonFormField<String>(
      hint: const Text('Gender'),
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder: border,
      ),
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(
        color: Color(0xff1a1c43),
        fontWeight: FontWeight.bold,
      ),
      borderRadius: BorderRadius.circular(18),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _nextBtn() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(120, 24),
        foregroundColor: Colors.blue,
        backgroundColor: const Color(0xff1a1c43),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 2),
      ),
      child: const SizedBox(
          width: double.infinity,
          child: Text(
            "Next",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.white),
          )),
    );
  }

  Widget _idcardBtn() {
    return SizedBox(
      width: 100,
      height: 40,
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(Colors.white),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: Color(0xff1a1c43))))),
        child: const SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  Icons.co_present,
                  color: Color(0xff1a1c43),
                  size: 20.0,
                ),
                SizedBox(width: 5),
                Text(
                  "ID Card",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Color(0xff1a1c43)),
                ),
              ],
            )),
      ),
    );
  }

  Widget _licenseBtn() {
    return SizedBox(
      width: 100,
      height: 40,
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(Colors.white),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: Color(0xff1a1c43))))),
        child: const SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  Icons.call_to_action,
                  color: Color(0xff1a1c43),
                  size: 20.0,
                ),
                SizedBox(width: 5),
                Text(
                  "license",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Color(0xff1a1c43)),
                ),
              ],
            )),
      ),
    );
  }

  Widget _carPictureBtn() {
    return SizedBox(
      width: 100,
      height: 40,
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(Colors.white),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: Color(0xff1a1c43))))),
        child: const SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  Icons.moped,
                  color: Color(0xff1a1c43),
                  size: 20.0,
                ),
                SizedBox(width: 5),
                Text(
                  "Car Picture",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10, color: Color(0xff1a1c43)),
                ),
              ],
            )),
      ),
    );
  }

  Widget _carRegistrationBtn() {
    return SizedBox(
      width: 100,
      height: 40,
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(Colors.white),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: Color(0xff1a1c43))))),
        child: const SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  Icons.garage,
                  color: Color(0xff1a1c43),
                  size: 20.0,
                ),
                SizedBox(width: 5),
                Text(
                  "Registration",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10, color: Color(0xff1a1c43)),
                ),
              ],
            )),
      ),
    );
  }

  Widget _carACTBtn() {
    return SizedBox(
      width: 100,
      height: 40,
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(Colors.white),
            shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: Color(0xff1a1c43))))),
        child: const SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  Icons.insert_drive_file_outlined,
                  color: Color(0xff1a1c43),
                  size: 20.0,
                ),
                SizedBox(width: 5),
                Text(
                  "ACT",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10, color: Color(0xff1a1c43)),
                ),
              ],
            )),
      ),
    );
  }
}
