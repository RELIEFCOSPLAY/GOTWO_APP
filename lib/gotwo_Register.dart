import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gotwo_app/global_ip.dart';
import 'package:gotwo_app/gotwo_Homepage.dart';
import 'package:gotwo_app/gotwo_Information.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Rider_Register extends StatefulWidget {
  const Rider_Register({super.key});

  @override
  State<Rider_Register> createState() => _Rider_RegisterState();
}

class _Rider_RegisterState extends State<Rider_Register> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emaiController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController createPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  static const List<String> list = <String>[
    'Gender',
    'Male',
    'Female',
  ];
  String dropdownValue = list.first;

  File? _userIimage; // เก็บภาพที่เลือก
  String? _userImageUrl; // เก็บ URL รูปภาพที่อัปโหลด
  Future<void> user_getImageGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // เปลี่ยนชื่อไฟล์เป็น "GP_timestamp"
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final directory = await getTemporaryDirectory();
      final newFileName = "GRU_$timestamp${path.extension(pickedFile.path)}";
      final newFilePath = path.join(directory.path, newFileName);

      final renamedFile = await File(pickedFile.path).copy(newFilePath);

      setState(() {
        _userIimage = renamedFile; // ใช้ไฟล์ที่เปลี่ยนชื่อ
      });

      // อัปโหลดไฟล์
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://${Global.ip_8080}/gotwo/upload_p.php'),
      );
      request.files
          .add(await http.MultipartFile.fromPath('image', _userIimage!.path));

      var response = await request.send();
      if (response.statusCode == 200) {
        final res = await http.Response.fromStream(response);
        final data = json.decode(res.body);

        if (data['file'] != null) {
          setState(() {
            _userImageUrl = data['file']; // ดึง URL ไฟล์ที่อัปโหลด
          });
        }
      } else {
        print('File upload failed');
      }
    }
  }

  bool isRegisterBtnEnabled = false; // สถานะปุ่ม
  void validateFields() {
    setState(() {
      isRegisterBtnEnabled = usernameController.text.isNotEmpty &&
          emaiController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          createPasswordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty &&
          dropdownValue != "Gender" &&
          _userImageUrl != null; // ตรวจสอบว่ามีรูปภาพหรือไม่
    });
  }

  @override
  void initState() {
    super.initState();

    // เพิ่ม Listener เพื่อเช็คเมื่อข้อมูลเปลี่ยนแปลง
    usernameController.addListener(validateFields);
    emaiController.addListener(validateFields);
    phoneController.addListener(validateFields);
    createPasswordController.addListener(validateFields);
    confirmPasswordController.addListener(validateFields);
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
                      padding: EdgeInsets.only(left: 50),
                      child: Text(
                        "Register",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 46,
                            color: Color(0xff1a1c43),
                            fontWeight: FontWeight.bold),
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
        padding: const EdgeInsets.only(left: 32, right: 32, top: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _addPhoto(),
              const SizedBox(height: 10),
              _inputField("Username", usernameController),
              const SizedBox(height: 10),
              _inputField("Email", emaiController),
              const SizedBox(height: 10),
              _inputField("Phone number", phoneController),
              const SizedBox(height: 10),
              _dropdown(),
              const SizedBox(height: 10),
              _inputField("Create Password", createPasswordController,
                  isPassword: true),
              const SizedBox(height: 10),
              _inputField("Confirm Password", confirmPasswordController,
                  isPassword: true),
              const SizedBox(height: 5),
              _registerBtn(),
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
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => GotwoHomepage(),
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

  Widget _addPhoto() {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xffffffff),
            elevation: 0.0,
            shadowColor: Colors.transparent,
          ),
          onPressed: () {
            user_getImageGallery(); // เรียกใช้งานฟังก์ชันเพื่อเลือกรูปภาพ
          },
          child: Container(
            width: 60, // ตั้งขนาดของ Container
            height: 60, // ตั้งขนาดของ Container
            decoration: BoxDecoration(
              color: const Color(0xff1a1c43),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xff1a1c43),
                width: 3,
              ),
            ),
            child: _userImageUrl != null // ตรวจสอบว่ามีรูปภาพที่เลือกหรือไม่
                ? ClipOval(
                    // ใช้ ClipOval เพื่อทำให้รูปเป็นวงกลม
                    child: Image.network(
                    _userImageUrl!,
                    fit: BoxFit.cover, // ปรับขนาดรูปภาพให้พอดีกับ Container
                    width: 60,
                    height: 60,
                  ))
                : const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 25,
                  ),
          ),
        ),
      ],
    );
  }

  Widget _inputField(String hintText, TextEditingController controller,
      {isPassword = false}) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xff1a1c43)));

    return TextField(
      style: const TextStyle(color: Color(0xff1a1c43)),
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Color(0xff1a1c43)),
        enabledBorder: border,
        focusedBorder: border,
      ),
      obscureText: isPassword,
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
          color: Color(0xff1a1c43), fontWeight: FontWeight.bold),
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

  Widget _registerBtn() {
    return ElevatedButton(
      onPressed: isRegisterBtnEnabled
          ? () {
              if (createPasswordController.text !=
                  confirmPasswordController.text) {
                // แสดงข้อความแจ้งเตือนหากรหัสผ่านไม่ตรงกัน
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Passwords do not match!"),
                  ),
                );
                return;
              }

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Registration Next"),
                ),
              );

              debugPrint("Username : ${usernameController.text}");
              debugPrint("Emai : ${emaiController.text}");
              debugPrint("Phone : ${phoneController.text}");
              debugPrint("Create Password : ${createPasswordController.text}");
              debugPrint(
                  "Confirm Password : ${confirmPasswordController.text}");
              debugPrint("Gender: ${dropdownValue.toLowerCase()}");
              debugPrint(_userImageUrl);

              // Navigate to GotwoInformation and send data
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => GotwoInformation(
                    username: usernameController.text,
                    email: emaiController.text,
                    phone: phoneController.text,
                    createPassword: createPasswordController.text,
                    confirmPassword: confirmPasswordController.text,
                    gender: dropdownValue.toLowerCase(),
                    userCardImagePath: _userImageUrl,
                  ),
                ),
                (Route<dynamic> route) => false,
              );
            }
          : null, // ปิดการใช้งานปุ่มหากข้อมูลไม่ครบ
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(120, 34),
        foregroundColor: Colors.blue,
        backgroundColor: isRegisterBtnEnabled
            ? const Color(0xff1a1c43)
            : Colors.grey, // สีปุ่มเปลี่ยนตามสถานะ
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 6),
      ),
      child: const SizedBox(
          width: double.infinity,
          child: Text(
            "Next",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.white),
          )),
    );
  }

  // Widget _snackBarnotification() {
  //   if (usernameController.text == "" &&
  //       emaiController.text == "" &&
  //       phoneController.text == "" &&
  //       createPasswordController.text == "" &&
  //       confirmPasswordController.text == "" &&
  //       dropdownValue == "Gender") {
  //     return Container(
  //       padding: const EdgeInsets.all(8),
  //       height: 70,
  //       decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(20),
  //           border: Border.all(color: Colors.redAccent)),
  //       child: const Row(
  //         children: [
  //           SizedBox(
  //             width: 48,
  //           ),
  //           Expanded(
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Text(
  //                   "Oh snap!",
  //                   style: TextStyle(
  //                     fontSize: 14,
  //                     color: Color(0xff1a1c43),
  //                   ),
  //                 ),
  //                 Text(
  //                   "Username or Password is Wrong",
  //                   style: TextStyle(
  //                     fontSize: 12,
  //                     color: Color(0xff1a1c43),
  //                   ),
  //                   maxLines: 2,
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  //   return Container();
  // }

  Widget _snackBarnotification() {
    return const SnackBar(
      content: Text("Please fill in all fields before continuing."),
    );
  }
}
