import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class GotwoInformation extends StatefulWidget {
  const GotwoInformation({super.key});

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

  Uint8List? _image;
  void selectImage() async {
    List<int>? imageBytes = await pickImage(ImageSource.gallery);
    if (imageBytes != null) {
      setState(() {
        _image = Uint8List.fromList(imageBytes);
      });
    } else {
      debugPrint('No image selected');
    }
  }

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
        appBar: AppBar(
          backgroundColor: const Color(0xffffffff),
          title: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: _backButton(),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Information Personal",
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xff1a1c43),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: _page(),
      ),
    );
  }

  Widget _page() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 32,right: 32,top: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: _idcardBtn(),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: _licenseBtn(),
                  )
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: _carPictureBtn(),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: _carRegistrationBtn(),
                  )
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    child: _carACTBtn(),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: _inputField("Expiration date", expirationController),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _inputField(
                        "Car registration", carRegistrationController),
                  ),
                  const SizedBox(width: 5),
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
      ),
    );
  }

  Widget _backButton() {
    return GestureDetector(
      onTap: () {
        debugPrint("back");
      },
      child: const Icon(
        Icons.arrow_back_ios,
        size: 30,
        color: Color(0xff1a1c43),
      ),
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
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: _snackBarnotification(),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
      },
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
      height: 50,
      child: Column(
        children: [
          if (_image != null)
          const SizedBox(
            height: 0,
          ),
          ElevatedButton(
            onPressed: selectImage,
            style: ButtonStyle(
              backgroundColor: const WidgetStatePropertyAll(Colors.white),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: const BorderSide(
                    color: Color(0xff1a1c43),
                  ),
                ),
              ),
            ),
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
        ],
      ),
    );
  }

  Widget _licenseBtn() {
    return SizedBox(
      width: 100,
      height: 50,
      child: Column(
        children: [
          if (_image != null)
          const SizedBox(
            height: 0,
          ),
          ElevatedButton(
            onPressed: selectImage,
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
        ],
      ),
    );
  }

  Widget _carPictureBtn() {
    return SizedBox(
      width: 100,
      height: 50,
      child: Column(
        children: [
          if (_image != null)
          const SizedBox(
            height: 0,
          ),
          ElevatedButton(
            onPressed: selectImage,
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
        ],
      ),
    );
  }

  Widget _carRegistrationBtn() {
    return SizedBox(
      width: 100,
      height: 50,
      child: Column(
        children: [
          if (_image != null)
          const SizedBox(
            height: 0,
          ),
          ElevatedButton(
            onPressed: selectImage,
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
        ],
      ),
    );
  }

  Widget _carACTBtn() {
    return SizedBox(
      width: 100,
      height: 50,
      child: Column(
        children: [
          if (_image != null)
          const SizedBox(
            height: 0,
          ),
          ElevatedButton(
            onPressed: selectImage,
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
        ],
      ),
    );
  }

  Widget _snackBarnotification() {
    if (expirationController.text == "" &&
        carRegistrationController.text == "" &&
        carBrandController.text == "" &&
        namebankAccountController.text == "" &&
        accountNumberController.text == "") {
      return Container(
        padding: const EdgeInsets.all(8),
        height: 70,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.redAccent)),
        child: const Row(
          children: [
            SizedBox(
              width: 48,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Oh snap!",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xff1a1c43),
                    ),
                  ),
                  Text(
                    "Username or Password is Wrong",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff1a1c43),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Container();
  }
}

Future<List<int>?> pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  try {
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }
  } catch (e) {
    debugPrint('Error picking image: $e');
  }
  return null;
}
