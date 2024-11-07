import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gotwo_app/global_ip.dart';
import 'package:gotwo_app/gotwo_loginr.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class GotwoInformation extends StatefulWidget {
  final String username;
  final String email;
  final String phone;
  final String createPassword;
  final String confirmPassword;
  final String gender;
  final String? userCardImagePath;
  const GotwoInformation(
      {super.key,
      required this.username,
      required this.email,
      required this.phone,
      required this.createPassword,
      required this.confirmPassword,
      required this.gender,
      this.userCardImagePath});

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

  // Uint8List? _image;
  // void selectImage() async {
  //   List<int>? imageBytes = await pickImage(ImageSource.gallery);
  //   if (imageBytes != null) {
  //     setState(() {
  //       _image = Uint8List.fromList(imageBytes);
  //     });
  //   } else {
  //     debugPrint('No image selected');
  //   }
  // }

  // Future<List<int>?> pickImage(ImageSource source) async {
  //   final ImagePicker imagePicker = ImagePicker();
  //   try {
  //     XFile? file = await imagePicker.pickImage(source: source);
  //     if (file != null) {
  //       return await file.readAsBytes();
  //     }
  //   } catch (e) {
  //     debugPrint('Error picking image: $e');
  //   }
  //   return null;
  // }

//==========================================================================
  String? idCardImagePath;
  bool isImageSelected_idcardBtn = false;
  File? id_card_im_path;
  final picker = ImagePicker();
  Future id_getImageGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    setState(() {
      if (pickedFile != null) {
        id_card_im_path = File(pickedFile.path);
        idCardImagePath = pickedFile.path;
      } else {
        print("No Image Picked");
      }
    });
  }

//===============================================
  String? licenseCardImagePath;
  bool isImageSelected_license = false;
  File? license_card_im_path;
  Future license_getImageGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    setState(() {
      if (pickedFile != null) {
        license_card_im_path = File(pickedFile.path);
        licenseCardImagePath = pickedFile.path;
      } else {
        print("No Image Picked");
      }
    });
  }

//===============================================
  String? carpicCardImagePath;
  bool isImageSelected_carpic = false;
  File? carpic_card_im_path;
  Future carpic_getImageGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    setState(() {
      if (pickedFile != null) {
        carpic_card_im_path = File(pickedFile.path);
        carpicCardImagePath = pickedFile.path;
      } else {
        print("No Image Picked");
      }
    });
  }

//===============================================
  String? regCardImagePath;
  bool isImageSelected_Reg = false;
  File? reg_card_im_path;
  Future reg_getImageGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    setState(() {
      if (pickedFile != null) {
        reg_card_im_path = File(pickedFile.path);
        regCardImagePath = pickedFile.path;
      } else {
        print("No Image Picked");
      }
    });
  }

//===============================================
  String? atcCardImagePath;
  bool isImageSelected_Atc = false;
  File? atc_card_im_path;
  Future atc_getImageGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    setState(() {
      if (pickedFile != null) {
        atc_card_im_path = File(pickedFile.path);
        atcCardImagePath = pickedFile.path;
      } else {
        print("No Image Picked");
      }
    });
  }

  //===============================================
  Uri url = Uri.parse('http://${Global.ip_8080}/gotwo/rider_Register.php');
  Future<void> insert_Register(
    String imgProfile,
    String name,
    String email,
    String tel,
    String gender,
    String password,
    String imgIdCard,
    String imgDriverLicense,
    String imgCarPicture,
    String imgCarRegistration,
    String imgAct,
    String expirationDate,
    String carRegistration,
    String carBrand,
    String bank,
    String nameAccount,
    String numberBank,
    String statusRider,
    String reason,
  ) async {
    try {
      var response = await http.post(
        url,
        body: {
          "img_profile": imgProfile,
          "name": name,
          "email": email,
          "tel": tel,
          "gender": gender,
          "password": password,
          "img_id_card": imgIdCard,
          "img_driver_license": imgDriverLicense,
          "img_car_picture": imgCarPicture,
          "img_car_registration": imgCarRegistration,
          "img_act": imgAct,
          "expiration_date": expirationDate,
          "car_rigistration": carRegistration,
          "car_brand": carBrand,
          "bank": bank,
          "name_account": nameAccount,
          "number_bank": numberBank,
          "status_rider": statusRider,
          "reason": reason,
        },
      );

      if (response.statusCode == 200) {
        // Check for success message from PHP
        var jsonResponse = json.decode(response.body);
        print("Insert success: $jsonResponse");
      } else {
        print("Failed to insert: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
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
                      padding: EdgeInsets.only(left: 15),
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
        padding: const EdgeInsets.only(left: 32, right: 32, top: 15),
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
      borderSide: const BorderSide(color: Color(0xff1a1c43)),
    );

    return SizedBox(
      height: 40,
      width: 100,
      child: TextField(
        style: const TextStyle(color: Color(0xff1a1c43), fontSize: 12),
        controller: controller,
        textAlign: TextAlign.center, // จัดตัวหนังสือให้ตรงกลางในแนวนอน
        textAlignVertical:
            TextAlignVertical.center, // จัดตัวหนังสือให้ตรงกลางในแนวตั้ง
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color(0xff1a1c43)),
          enabledBorder: border,
          focusedBorder: border,
          contentPadding: const EdgeInsets.symmetric(
              vertical: 10), // ปรับ Padding ให้อยู่ตรงกลาง
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
        String statusRider0 = "0";
        String reasonNo = "no";
        debugPrint("imgProfile: ${widget.userCardImagePath}");
        debugPrint("Username: ${widget.username}");
        debugPrint("Email: ${widget.email}");
        debugPrint("Phone: ${widget.phone}");
        debugPrint("Gender: ${widget.gender}");
        debugPrint("password : ${widget.createPassword}");
        debugPrint("imgIdCard : $idCardImagePath");
        debugPrint("imgDriverLicense : $licenseCardImagePath");
        debugPrint("imgCarPicture : $carpicCardImagePath");
        debugPrint("imgCarRegistration : $regCardImagePath");
        debugPrint("imgAct : $atcCardImagePath");
        debugPrint("expirationDate : ${expirationController.text}");
        debugPrint("carRegistration : ${carRegistrationController.text}");
        debugPrint("carBrand : ${carBrandController.text}");
        debugPrint("bank : ${dropdownValue.toString()}");
        debugPrint("nameAccount : ${namebankAccountController.text}");
        debugPrint("numberBank : ${accountNumberController.text}");
        debugPrint("statusRider : $statusRider0");
        debugPrint("reason : ${widget.confirmPassword}");

        insert_Register(
            widget.userCardImagePath.toString(),
            widget.username,
            widget.email,
            widget.phone,
            widget.gender,
            widget.createPassword,
            idCardImagePath.toString(),
            licenseCardImagePath.toString(),
            carpicCardImagePath.toString(),
            regCardImagePath.toString(),
            atcCardImagePath.toString(),
            expirationController.text,
            carRegistrationController.text,
            carBrandController.text,
            dropdownValue.toString(),
            namebankAccountController.text,
            accountNumberController.text,
            statusRider0,
            reasonNo);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Loginpage(),
          ),
          (Route<dynamic> route) => false,
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
          ElevatedButton(
            onPressed: () {
              print(id_card_im_path);
              id_getImageGallery().then((_) {
                if (id_card_im_path != null) {
                  setState(() {
                    isImageSelected_idcardBtn =
                        true; // เปลี่ยนสถานะเมื่อเลือกรูปภาพสำเร็จ
                  });

                  // แสดงไดอะล็อกพร้อมรูปภาพที่อัปโหลด
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          "Id card",
                          style: TextStyle(
                            color: Color(0xff1a1c43),
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            id_card_im_path != null
                                ? Image.file(
                                    id_card_im_path!) // แสดงรูปภาพที่อัปโหลด
                                : const Text("No image selected"),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              print(id_card_im_path);
                            },
                            child: const Text(
                              "Close",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              });
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                Colors.white,
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(
                    color: isImageSelected_idcardBtn
                        ? Colors.green.shade200
                        : const Color(0xff1a1c43),
                  ),
                ),
              ),
            ),
            child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(
                      Icons.co_present,
                      color: isImageSelected_idcardBtn
                          ? Colors.green.shade200
                          : const Color(0xff1a1c43),
                      size: 20.0,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Id Card",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: isImageSelected_idcardBtn
                            ? Colors.green.shade200
                            : const Color(0xff1a1c43),
                      ),
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
          ElevatedButton(
            onPressed: () {
              print(license_card_im_path);
              license_getImageGallery().then((_) {
                if (license_card_im_path != null) {
                  setState(() {
                    isImageSelected_license =
                        true; // เปลี่ยนสถานะเมื่อเลือกรูปภาพสำเร็จ
                  });

                  // แสดงไดอะล็อกพร้อมรูปภาพที่อัปโหลด
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          "license",
                          style: TextStyle(
                            color: Color(0xff1a1c43),
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            license_card_im_path != null
                                ? Image.file(
                                    license_card_im_path!) // แสดงรูปภาพที่อัปโหลด
                                : const Text("No image selected"),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              print(license_card_im_path);
                            },
                            child: const Text(
                              "Close",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              });
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                Colors.white,
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(
                    color: isImageSelected_license
                        ? Colors.green.shade200
                        : const Color(0xff1a1c43),
                  ),
                ),
              ),
            ),
            child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(
                      Icons.call_to_action,
                      color: isImageSelected_license
                          ? Colors.green.shade200
                          : const Color(0xff1a1c43),
                      size: 20.0,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Ilicense",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: isImageSelected_license
                            ? Colors.green.shade200
                            : const Color(0xff1a1c43),
                      ),
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
          ElevatedButton(
            onPressed: () {
              print(carpic_card_im_path);
              carpic_getImageGallery().then((_) {
                if (carpic_card_im_path != null) {
                  setState(() {
                    isImageSelected_carpic =
                        true; // เปลี่ยนสถานะเมื่อเลือกรูปภาพสำเร็จ
                  });

                  // แสดงไดอะล็อกพร้อมรูปภาพที่อัปโหลด
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          "carpicture",
                          style: TextStyle(
                            color: Color(0xff1a1c43),
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            carpic_card_im_path != null
                                ? Image.file(
                                    carpic_card_im_path!) // แสดงรูปภาพที่อัปโหลด
                                : const Text("No image selected"),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              print(carpic_card_im_path);
                            },
                            child: const Text(
                              "Close",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              });
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                Colors.white,
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(
                    color: isImageSelected_carpic
                        ? Colors.green.shade200
                        : const Color(0xff1a1c43),
                  ),
                ),
              ),
            ),
            child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(
                      Icons.moped,
                      color: isImageSelected_carpic
                          ? Colors.green.shade200
                          : const Color(0xff1a1c43),
                      size: 20.0,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "carpicture",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: isImageSelected_carpic
                            ? Colors.green.shade200
                            : const Color(0xff1a1c43),
                      ),
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
          ElevatedButton(
            onPressed: () {
              print(reg_card_im_path);
              reg_getImageGallery().then((_) {
                if (reg_card_im_path != null) {
                  setState(() {
                    isImageSelected_Reg =
                        true; // เปลี่ยนสถานะเมื่อเลือกรูปภาพสำเร็จ
                  });

                  // แสดงไดอะล็อกพร้อมรูปภาพที่อัปโหลด
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          "CarRegistration",
                          style: TextStyle(
                            color: Color(0xff1a1c43),
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            reg_card_im_path != null
                                ? Image.file(
                                    reg_card_im_path!) // แสดงรูปภาพที่อัปโหลด
                                : const Text("No image selected"),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              print(reg_card_im_path);
                            },
                            child: const Text(
                              "Close",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              });
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                Colors.white,
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(
                    color: isImageSelected_Reg
                        ? Colors.green.shade200
                        : const Color(0xff1a1c43),
                  ),
                ),
              ),
            ),
            child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(
                      Icons.garage,
                      color: isImageSelected_Reg
                          ? Colors.green.shade200
                          : const Color(0xff1a1c43),
                      size: 20.0,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Reg",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: isImageSelected_Reg
                            ? Colors.green.shade200
                            : const Color(0xff1a1c43),
                      ),
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
          ElevatedButton(
            onPressed: () {
              print(atc_card_im_path);
              atc_getImageGallery().then((_) {
                if (atc_card_im_path != null) {
                  setState(() {
                    isImageSelected_Atc =
                        true; // เปลี่ยนสถานะเมื่อเลือกรูปภาพสำเร็จ
                  });

                  // แสดงไดอะล็อกพร้อมรูปภาพที่อัปโหลด
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                          "carACT",
                          style: TextStyle(
                            color: Color(0xff1a1c43),
                          ),
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            atc_card_im_path != null
                                ? Image.file(
                                    atc_card_im_path!) // แสดงรูปภาพที่อัปโหลด
                                : const Text("No image selected"),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              print(atc_card_im_path);
                            },
                            child: const Text(
                              "Close",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              });
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                Colors.white,
              ),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(
                    color: isImageSelected_Atc
                        ? Colors.green.shade200
                        : const Color(0xff1a1c43),
                  ),
                ),
              ),
            ),
            child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(
                      Icons.insert_drive_file_outlined,
                      color: isImageSelected_Atc
                          ? Colors.green.shade200
                          : const Color(0xff1a1c43),
                      size: 20.0,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "carACT",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: isImageSelected_Atc
                            ? Colors.green.shade200
                            : const Color(0xff1a1c43),
                      ),
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
