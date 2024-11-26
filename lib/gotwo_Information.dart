import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gotwo_app/global_ip.dart';
import 'package:gotwo_app/gotwo_loginr.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

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

  // เพิ่มสถานะปุ่ม
  bool isNextBtnEnabled = false;

  // ฟังก์ชันตรวจสอบข้อมูล
  void validateFields() {
    setState(() {
      isNextBtnEnabled = expirationController.text.isNotEmpty &&
          carRegistrationController.text.isNotEmpty &&
          carBrandController.text.isNotEmpty &&
          namebankAccountController.text.isNotEmpty &&
          accountNumberController.text.isNotEmpty &&
          _idImageUrl != null &&
          _licensemageUrl != null &&
          _carpicmageUrl != null &&
          _regCardmageUrl != null &&
          _atcCardmageUrl != null &&
          dropdownValue != "Bank Select";
    });
  }

  List<dynamic> listlBank = [];
  Future<void> fetchBank() async {
    final String url = "http://${Global.ip_8080}/gotwo/get_bank.php";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          listlBank = json.decode(response.body); // แปลง JSON เป็น List
          // ไม่เปลี่ยนค่า dropdownPickup และ dropdownDrop ที่ตั้งค่าเป็น "Select Location"
        });
      } else {
        print("Failed to load data");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  static const List<String> list = <String>[
    'Bank Select',
  ];
  String dropdownValue = list.first;
  List<dynamic> listlocation = [];
  Future<void> fetchLocation() async {
    final String url = "http://${Global.ip_8080}/gotwo/get_location.php";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        setState(() {
          listlocation = json.decode(response.body); // แปลง JSON เป็น List
        });
      } else {
        debugPrint("Failed to load data");
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

//==========================================================================

  bool isImageSelected_idcardBtn = false;
  File? _idIimage; // เก็บภาพที่เลือก
  String? _idImageUrl; // เก็บ URL รูปภาพที่อัปโหลด
  Future<void> id_getImageGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // เปลี่ยนชื่อไฟล์เป็น "GP_timestamp"
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final directory = await getTemporaryDirectory();
      final newFileName = "GRID_$timestamp${path.extension(pickedFile.path)}";
      final newFilePath = path.join(directory.path, newFileName);

      final renamedFile = await File(pickedFile.path).copy(newFilePath);

      setState(() {
        _idIimage = renamedFile; // ใช้ไฟล์ที่เปลี่ยนชื่อ
      });

      // อัปโหลดไฟล์
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://${Global.ip_8080}/gotwo/upload_p.php'),
      );
      request.files
          .add(await http.MultipartFile.fromPath('image', _idIimage!.path));

      var response = await request.send();
      if (response.statusCode == 200) {
        final res = await http.Response.fromStream(response);
        final data = json.decode(res.body);

        if (data['file'] != null) {
          setState(() {
            _idImageUrl = data['file']; // ดึง URL ไฟล์ที่อัปโหลด
          });
        }
      } else {
        debugPrint('File upload failed');
      }
    }
  }

//===============================================
  bool isImageSelected_license = false;
  File? _licenseimage; // เก็บภาพที่เลือก
  String? _licensemageUrl; // เก็บ URL รูปภาพที่อัปโหลด
  Future<void> license_getImageGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // เปลี่ยนชื่อไฟล์เป็น "GP_timestamp"
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final directory = await getTemporaryDirectory();
      final newFileName = "GRLIC_$timestamp${path.extension(pickedFile.path)}";
      final newFilePath = path.join(directory.path, newFileName);

      final renamedFile = await File(pickedFile.path).copy(newFilePath);

      setState(() {
        _licenseimage = renamedFile; // ใช้ไฟล์ที่เปลี่ยนชื่อ
      });

      // อัปโหลดไฟล์
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://${Global.ip_8080}/gotwo/upload_p.php'),
      );
      request.files
          .add(await http.MultipartFile.fromPath('image', _licenseimage!.path));

      var response = await request.send();
      if (response.statusCode == 200) {
        final res = await http.Response.fromStream(response);
        final data = json.decode(res.body);

        if (data['file'] != null) {
          setState(() {
            _licensemageUrl = data['file']; // ดึง URL ไฟล์ที่อัปโหลด
          });
        }
      } else {
        debugPrint('File upload failed');
      }
    }
  }

//===============================================

  bool isImageSelected_carpic = false;
  File? _carpicimage; // เก็บภาพที่เลือก
  String? _carpicmageUrl; // เก็บ URL รูปภาพที่อัปโหลด
  Future<void> carpic_getImageGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // เปลี่ยนชื่อไฟล์เป็น "GP_timestamp"
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final directory = await getTemporaryDirectory();
      final newFileName = "GRCAR_$timestamp${path.extension(pickedFile.path)}";
      final newFilePath = path.join(directory.path, newFileName);

      final renamedFile = await File(pickedFile.path).copy(newFilePath);

      setState(() {
        _carpicimage = renamedFile; // ใช้ไฟล์ที่เปลี่ยนชื่อ
      });

      // อัปโหลดไฟล์
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://${Global.ip_8080}/gotwo/upload_p.php'),
      );
      request.files
          .add(await http.MultipartFile.fromPath('image', _carpicimage!.path));

      var response = await request.send();
      if (response.statusCode == 200) {
        final res = await http.Response.fromStream(response);
        final data = json.decode(res.body);

        if (data['file'] != null) {
          setState(() {
            _carpicmageUrl = data['file']; // ดึง URL ไฟล์ที่อัปโหลด
          });
        }
      } else {
        debugPrint('File upload failed');
      }
    }
  }

//===============================================

  bool isImageSelected_Reg = false;
  File? _regCardimage; // เก็บภาพที่เลือก
  String? _regCardmageUrl; // เก็บ URL รูปภาพที่อัปโหลด
  Future<void> regCard_getImageGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // เปลี่ยนชื่อไฟล์เป็น "GP_timestamp"
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final directory = await getTemporaryDirectory();
      final newFileName = "GRREG_$timestamp${path.extension(pickedFile.path)}";
      final newFilePath = path.join(directory.path, newFileName);

      final renamedFile = await File(pickedFile.path).copy(newFilePath);

      setState(() {
        _regCardimage = renamedFile; // ใช้ไฟล์ที่เปลี่ยนชื่อ
      });

      // อัปโหลดไฟล์
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://${Global.ip_8080}/gotwo/upload_p.php'),
      );
      request.files
          .add(await http.MultipartFile.fromPath('image', _regCardimage!.path));

      var response = await request.send();
      if (response.statusCode == 200) {
        final res = await http.Response.fromStream(response);
        final data = json.decode(res.body);

        if (data['file'] != null) {
          setState(() {
            _regCardmageUrl = data['file']; // ดึง URL ไฟล์ที่อัปโหลด
          });
        }
      } else {
        debugPrint('File upload failed');
      }
    }
  }

//===============================================

  bool isImageSelected_Atc = false;
  File? _atcCardimage; // เก็บภาพที่เลือก
  String? _atcCardmageUrl; // เก็บ URL รูปภาพที่อัปโหลด
  Future<void> atcCard_getImageGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // เปลี่ยนชื่อไฟล์เป็น "GP_timestamp"
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final directory = await getTemporaryDirectory();
      final newFileName = "GRATC_$timestamp${path.extension(pickedFile.path)}";
      final newFilePath = path.join(directory.path, newFileName);

      final renamedFile = await File(pickedFile.path).copy(newFilePath);

      setState(() {
        _atcCardimage = renamedFile; // ใช้ไฟล์ที่เปลี่ยนชื่อ
      });

      // อัปโหลดไฟล์
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://${Global.ip_8080}/gotwo/upload_p.php'),
      );
      request.files
          .add(await http.MultipartFile.fromPath('image', _atcCardimage!.path));

      var response = await request.send();
      if (response.statusCode == 200) {
        final res = await http.Response.fromStream(response);
        final data = json.decode(res.body);

        if (data['file'] != null) {
          setState(() {
            _atcCardmageUrl = data['file']; // ดึง URL ไฟล์ที่อัปโหลด
          });
        }
      } else {
        debugPrint('File upload failed');
      }
    }
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
          "img_car_registration":
              imgCarRegistration, // ตรวจสอบชื่อให้ตรงกับ PHP
          "img_act": imgAct,
          "expiration_date": expirationDate,
          "car_rigistration": carRegistration, // ใช้คีย์ที่ PHP รู้จัก
          "car_brand": carBrand,
          "bank": bank,
          "name_account": nameAccount,
          "number_bank": numberBank, // Flutter ส่งเป็น String
          "status_rider": statusRider,
          "reason": reason,
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body); // แปลง JSON เป็น Map
        if (data['status'] == 'success') {
          if (data['p'] == 'success') {
            print(data['messages']);
          }
          print(data['message']); // "Insert Success"
        } else {
          print(data['message']); // "Error Insert!"
        }
      } else {
        print("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBank();

    // เพิ่ม Listener เพื่อเช็คเมื่อมีการเปลี่ยนแปลงข้อมูล
    expirationController.addListener(validateFields);
    carRegistrationController.addListener(validateFields);
    carBrandController.addListener(validateFields);
    namebankAccountController.addListener(validateFields);
    accountNumberController.addListener(validateFields);
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
                    child: Expanded(
                      child: _inputFieldDatePicker(
                          "Expiration date", expirationController),
                    ),
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
              _inputField3("Enter account number", accountNumberController),
              const SizedBox(height: 5),
              _nextBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _inputFieldDatePicker(
      String hintText, TextEditingController controller) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Color(0xff1a1c43)),
    );

    return GestureDetector(
      onTap: () async {
        // เปิด Date Picker
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000), // วันที่เริ่มต้นที่สามารถเลือกได้
          lastDate: DateTime(2100), // วันที่สิ้นสุดที่สามารถเลือกได้
        );

        if (pickedDate != null) {
          // อัปเดตค่าใน TextEditingController
          String formattedDate =
              "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
          setState(() {
            controller.text = formattedDate; // แปลงวันที่เป็น String
          });
        }
      },
      child: AbsorbPointer(
        // ใช้ AbsorbPointer เพื่อปิดการป้อนข้อความตรงๆ
        child: SizedBox(
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
            readOnly: true, // ทำให้ไม่สามารถพิมพ์ในช่องนี้ได้
          ),
        ),
      ),
    );
  }

  Widget _backButton() {
    return GestureDetector(
      onTap: () {
        debugPrint("back");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const Loginpage(),
          ),
          (Route<dynamic> route) => false,
        );
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
          hintStyle: const TextStyle(color: Colors.grey),
          enabledBorder: border,
          focusedBorder: border,
        ),
        obscureText: isPassword,
      ),
    );
  }

  Widget _inputField3(String hintText, TextEditingController controller,
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
        keyboardType: TextInputType.number, // บังคับให้พิมพ์ได้เฉพาะตัวเลข
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly, // กรองเฉพาะตัวเลขเท่านั้น
        ],
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
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
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder: border,
      ),
      value: dropdownValue, // ค่าเริ่มต้นที่จะแสดง
      elevation: 16,
      style: const TextStyle(
        color: Color(0xff1a1c43),
        fontWeight: FontWeight.bold,
      ),
      borderRadius: BorderRadius.circular(18),
      onChanged: (String? value) {
        // ฟังก์ชันที่เรียกใช้เมื่อมีการเปลี่ยนค่า
        setState(() {
          dropdownValue = value!;
        });
      },
      items: [
        const DropdownMenuItem<String>(
          value: 'Bank Select',
          child: Text(
            'Bank Select',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        ...listlBank.map<DropdownMenuItem<String>>((dynamic bank) {
          return DropdownMenuItem<String>(
            value: bank['bank_List'], // สมมติว่าคีย์ชื่อธนาคารคือ 'bank_List'
            child: Text(bank['bank_List']),
          );
        }).toList(),
      ],
    );
  }

  Widget _nextBtn() {
    return ElevatedButton(
      onPressed: isNextBtnEnabled
          ? () {
              // ดำเนินการเมื่อข้อมูลครบถ้วน
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Processing Registration..."),
                ),
              );

              String statusRider0 = "0";
              String reasonNo = "no";

              insert_Register(
                widget.userCardImagePath.toString(),
                widget.username,
                widget.email,
                widget.phone,
                widget.gender,
                widget.createPassword,
                _idImageUrl.toString(),
                _licensemageUrl.toString(),
                _carpicmageUrl.toString(),
                _regCardmageUrl.toString(),
                _atcCardmageUrl.toString(),
                expirationController.text,
                carRegistrationController.text,
                carBrandController.text,
                dropdownValue.toString(),
                namebankAccountController.text,
                accountNumberController.text,
                statusRider0,
                reasonNo,
              );

              debugPrint("imgProfile: ${widget.userCardImagePath}");
              debugPrint("Username: ${widget.username}");
              debugPrint("Email: ${widget.email}");
              debugPrint("Phone: ${widget.phone}");
              debugPrint("Gender: ${widget.gender}");
              debugPrint("password : ${widget.createPassword}");
              debugPrint("imgIdCard : $_idImageUrl");
              debugPrint("imgDriverLicense : $_licensemageUrl");
              debugPrint("imgCarPicture : $_carpicmageUrl");
              debugPrint("imgCarRegistration : $_regCardmageUrl");
              debugPrint("imgAct : $_atcCardmageUrl");
              debugPrint("expirationDate : ${expirationController.text}");
              debugPrint("carRegistration : ${carRegistrationController.text}");
              debugPrint("carBrand : ${carBrandController.text}");
              debugPrint("bank : ${dropdownValue.toString()}");
              debugPrint("nameAccount : ${namebankAccountController.text}");
              debugPrint("numberBank : ${accountNumberController.text}");
              debugPrint("statusRider : $statusRider0");
              // ignore: unnecessary_brace_in_string_interps
              debugPrint("reason : ${reasonNo}");

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const Loginpage(),
                ),
                (Route<dynamic> route) => false,
              );
            }
          : null, // ปิดการใช้งานปุ่มหากข้อมูลไม่ครบ
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(120, 24),
        foregroundColor: Colors.blue,
        backgroundColor: isNextBtnEnabled
            ? const Color(0xff1a1c43)
            : Colors.grey, // สีปุ่มเปลี่ยนตามสถานะ
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 2),
      ),
      child: const SizedBox(
        width: double.infinity,
        child: Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
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
              debugPrint(_idImageUrl);
              id_getImageGallery().then((_) {
                if (_idImageUrl != null) {
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
                            _idImageUrl != null
                                ? Image.network(
                                    _idImageUrl!) // แสดงรูปภาพที่อัปโหลด
                                : const Text("No image selected"),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              debugPrint(_idImageUrl);
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
              debugPrint(_licensemageUrl);
              license_getImageGallery().then((_) {
                if (_licensemageUrl != null) {
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
                            _licensemageUrl != null
                                ? Image.network(
                                    _licensemageUrl!) // แสดงรูปภาพที่อัปโหลด
                                : const Text("No image selected"),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              debugPrint(_licensemageUrl);
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
              debugPrint(_carpicmageUrl);
              carpic_getImageGallery().then((_) {
                if (_carpicmageUrl != null) {
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
                            _carpicmageUrl != null
                                ? Image.network(
                                    _carpicmageUrl!) // แสดงรูปภาพที่อัปโหลด
                                : const Text("No image selected"),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              debugPrint(_carpicmageUrl);
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
              debugPrint(_regCardmageUrl);
              regCard_getImageGallery().then((_) {
                if (_regCardmageUrl != null) {
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
                            _regCardmageUrl != null
                                ? Image.network(
                                    _regCardmageUrl!) // แสดงรูปภาพที่อัปโหลด
                                : const Text("No image selected"),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              debugPrint(_regCardmageUrl);
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
              debugPrint(_atcCardmageUrl);
              atcCard_getImageGallery().then((_) {
                if (_atcCardmageUrl != null) {
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
                            _atcCardmageUrl != null
                                ? Image.network(
                                    _atcCardmageUrl!) // แสดงรูปภาพที่อัปโหลด
                                : const Text("No image selected"),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              debugPrint(_atcCardmageUrl);
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
    return const SnackBar(
      content: Text("Please fill in all fields and upload all images."),
    );
  }
}
