import 'package:flutter/material.dart';
import 'package:gotwo_app/gotwo_Homepage.dart';
import 'package:gotwo_app/gotwo_Register.dart';

class GotwoCondition extends StatefulWidget {
  const GotwoCondition({super.key});

  @override
  State<GotwoCondition> createState() => _GotwoConditionState();
}

class _GotwoConditionState extends State<GotwoCondition> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
                    padding: EdgeInsets.only(left:10),
                    child: Text(
                      "Term and condition",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const Text(
              //   "Term and condition",
              //   style: TextStyle(
              //     fontWeight: FontWeight.bold,
              //     fontSize: 27,
              //     color: Color(0xFF1A1C43),
              //   ),
              // ),
              const SizedBox(height: 5),
              const Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "ข้อความสำคัญ - กรุณาอ่านข้อกำหนดและเงื่อนไขนี้อย่างรอบคอบในการใช้บริการ ท่านตกลงว่า ท่านได้อ่าน เข้าใจ ยอมรับ และตกลงข้อกำหนดและเงื่อนไข เงื่อนไขที่ระบุในแบบฟอร์มการลงทะเบียนสำหรับคนขับ และจรรยาบรรณคนขับรวมถึงเอกสารอื่นๆ และข้อมูลใดๆ ที่บริษัทได้จัดเตรียมให้ (ไม่ว่าท่านจะได้เซ็นรับหรือไม่ก็ตาม) นอกจากนี้ ท่านยังตกลงปฏิบัติตามคำรับรองที่ท่านได้ให้ไว้ด้านล่าง หากท่านไม่ตกลงหรือไม่ปฏิบัติตามเงื่อนไขในการใช้บริการนี้ (ตามที่ได้นิยามไว้ด้านล่าง) และประสงค์ที่จะไม่ใช้บริการต่อไป กรุณาหยุดใช้แอปพลิเคชัน (ตามที่ได้นิยามไว้ด้านล่าง) หรือหยุดใช้บริการ",
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Color(0xFF1A1C43),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "ข้อกำหนดและเงื่อนไขตามที่ระบุในเอกสารนี้ (รวมเรียกว่า “เงื่อนไขในการใช้บริการ” หรือ “ข้อตกลง” ฉบับนี้) ให้ถือเป็นข้อตกลงทางกฎหมายระหว่างท่าน และแอปพลิเคชั่น GoTwo การใช้แอปพลิเคชันที่จัดเตรียมให้ ด้วยการดาวน์โหลด ติดตั้งหรือใช้ซอฟท์แวร์ใดๆ ที่เกี่ยวข้องตามที่ได้จัดเตรียมไว้ให้ ซึ่งมีวัตถุประสงค์โดยรวมเพื่อให้ผู้ใช้บริการสามารถใช้บริการขนส่งไปยังจุดหมายปลายทางที่กำหนดไว้ (“ลูกค้า”) โดยแอปพลิเคชันจะมีไว้เพื่อหาเพื่อนร่วมเดินทาง(ลูกค้า)กับผู้ให้บริการจัดหายานพาหนะ(คนขับ)ซึ่งเป็นบุคคลภายนอกกับผู้ใช้บริการที่ต้องการรับบริการขนส่งไปยังจุดหมายปลายทางที่กำหนดไว้ (รวมเรียกว่า “บริการ”) โดยท่านยอมรับและตกลงโดยชัดแจ้งที่จะผูกพันตามเงื่อนไขในการใช้บริการและการแก้ไขและการเพิ่มเติมใดๆ ของเงื่อนไขในการใช้บริการที่อาจมีขึ้นในอนาคต",
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Color(0xFF1A1C43),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "ทางแอปพลิเคชันเสนอข้อมูลและวิธีการแก่ผู้ขับรถ ในการจัดบริการขนขนส่งให้แก่ลูกค้า ให้ได้รับลูกค้า และติดต่อกับลูกค้า แต่บริษัทไม่ได้ให้และไม่มีเจตนาที่จะให้บริการขนส่ง หรือกระทำไม่ว่าจะด้วยประการใดๆในฐานะผู้ประกอบการรถรับจ้างสาธารณะ ผู้ให้บริการรับขน และจะไม่รับผิดชอบ หรือรับผิดใดๆ ต่อการให้บริการขนส่งที่ท่านให้บริการแก่ลูกค้า",
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Color(0xFF1A1C43),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "1. คำรับรองและคำรับประกัน",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Color(0xFF1A1C43),
                              ),
                            ),
                            Text(
                              "ในการใช้บริการ ท่านได้รับรองและรับประกันโดยชัดแจ้งว่า ท่านมีสิทธิตามกฎหมายที่จะยอมรับและตกลงที่จะปฏิบัติตามเงื่อนไขในการใช้บริการและท่านมีอายุอย่างน้อย 18 (สิบแปด) ปีบริบูรณ์ หรือสามารถเข้าทำสัญญาได้ตามกฎหมาย ทางแอปพลิเคชันจะไม่สามารถให้บริการแก่บุคคลที่ถูกห้ามไม่ให้เข้าทำสัญญาไม่ว่าด้วยเหตุใดๆ ก็ตาม หรือบุคคลที่มีอายุต่ำกว่า 18 (สิบแปด) ปีบริบูรณ์ หรือเว้นแต่กรณีที่บุคคลนั้นสามารถเข้าทำสัญญาได้ตามขอบเขตที่กฎหมายที่ใช้บังคับนั้นจะอนุญาต ทั้งนี้ ในการใช้บริการ ท่านยังรับรองและรับประกันว่า ท่านมีสิทธิ อำนาจและความสามารถในการใช้บริการและตกลงผูกพัน ปฏิบัติตามเงื่อนไขในการใช้บริการ นอกจากนี้ ท่านยืนยันว่า ข้อมูลทั้งหมดที่ท่านได้จัดเตรียมให้แก่บริษัทนั้นเป็นข้อมูลที่ถูกต้องและเป็นจริง การใช้บริการของท่านนั้นเพื่อการใช้ส่วนตัวสำหรับท่าน ในการใช้บริการ ท่านรับรอง รับประกัน สัญญา และตกลงว่า",
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Color(0xFF1A1C43),
                              ),
                            ),
                            Text(
                              "• ท่านมีใบอนุญาตขับขี่ที่ถูกต้องตามกฎหมาย ได้รับอนุญาตให้ควบคุมรถจักรยานยนต์ และมีใบอนุญาต ได้รับอนุมัติ และมีอำนาจในการให้บริการขนส่งแก่บุคคลภายนอก ตามกฎหมายที่มีผลบังคับใช้ในประเทศของท่าน ",
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Color(0xFF1A1C43),
                              ),
                            ),
                            Text(
                              "• ท่านมีใบอนุญาต ได้รับอนุมัติ และมีอำนาจที่เกี่ยวข้องกับ และในการเป็นเจ้าของยานพาหนะ ซึ่งท่านประสงค์จะใช้ในการให้บริการขนส่ง และยานพาหนะนั้นอยู่ในสภาพใช้การได้ดี และเป็นไปตามมาตรฐานด้านความปลอดภัยของอุตสาหกรรมสำหรับยานพาหนะประเภทนั้น",
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Color(0xFF1A1C43),
                              ),
                            ),
                            Text(
                              "• ท่านไม่เคยต้องคำพิพากษาถึงที่สุดว่ากระทำความผิดอาญาเกี่ยวกับทรัพย์ เพศ และ/หรือชีวิตและร่างกาย (เช่นยักยอกทรัพย์ ฆ่าคน ข่มขืน)",
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Color(0xFF1A1C43),
                              ),
                            ),
                            Text(
                              "• ท่านจะใช้อุปกรณ์ด้านความปลอดภัยที่เหมาะสม (อาทิเช่น หมวกนิรภัย)",
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Color(0xFF1A1C43),
                              ),
                            ),
                            Text(
                              "• เมื่อท่านคลิกยืนยันการรับผู้โดยสาร ท่านจะต้องรับผิดชอบต่อข้อเรียกร้อง คำพิพากษา และความรับผิดใดทั้งหมดจากอุบัติเหตุ ความสูญหาย หรือความเสียหาย รวมถึงแต่ไม่จำกัดอยู่เพียง การบาดเจ็บของบุคคล การเสียชีวิต ความเสียหายโดยสิ้นเชิง และความเสียหายในทรัพย์สิน ซึ่งเกิดจากหรือถูกกล่าวโทษว่าเกิดจากยานพาหนะ และ/หรือรถรับจ้างสาธารณะ/บริการขนส่ง ไม่ว่าจะได้ประกอบการอย่างไร",
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Color(0xFF1A1C43),
                              ),
                            ),
                            Text(
                              "• ท่านจะไม่ใช้แอพพลิเคชั่น และ/หรือซอฟท์แวร์เพื่อก่อให้เกิดการรบกวน ความรำคาญ ความไม่สะดวก หรือไม่ได้ทำการจองจริง",
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Color(0xFF1A1C43),
                              ),
                            ),
                            Text(
                              "• ท่านจะไม่ใช้บริการ แอพพลิเคชั่น และ/หรือซอฟท์แวร์เพื่อวัตถุประสงค์อื่นนอกเหนือจากการได้รับบริการ",
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Color(0xFF1A1C43),
                              ),
                            ),
                            Text(
                              "• ท่านตกลงว่า ท่านจะให้ความร่วมมือกับบริษัทในการในการสืบสวนการกระทำความผิดตามที่บริษัทร้องขอ และท่านตกลงจะให้ความช่วยเหลือแก่บริษัทในการปฏิบัติตามการสืบสวนภายใน คำสั่งของราชการ หรือข้อกำหนดของกฎหมายใดๆ ที่มีผลบังคับใช้ในขณะนั้น",
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Color(0xFF1A1C43),
                              ),
                            ),
                            Text(
                              "• ท่านตกลงรับผิดชอบต่อหน้าที่และความรับผิดทั้งหมดแต่เพียงผู้เดียวสำหรับความสูญหายหรือความเสียหายทั้งหมดที่เกิดขึ้นกับท่าน ลูกค้า บริษัท หรือบุคคลภายนอกใดๆ ซึ่งเป็นผลมาจากการไม่ปฏิบัติตามเงื่อนไขในการใช้บริการนี้",
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Color(0xFF1A1C43),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "2. การชำระเงิน",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Color(0xFF1A1C43),
                              ),
                            ),
                            Text(
                              "เงินใดๆ ที่แอปพลิเคชันเรียกเก็บจากท่านสำหรับบริการนั้นถึงกำหนดชำระทันทีและไม่สามารถคืนเงินได้ (“ค่าบริการ”) นโยบายการไม่คืนเงินนี้มีผลบังคับใช้ทุกเมื่อ ไม่ว่าจะเป็นกรณีที่ท่านตัดสินใจยุติการใช้บริการ การตัดสินใจของแอปพลิเคชันที่จะยุติหรือพักการใช้บริการของท่าน การหยุดชะงักในบริการไม่ว่าจะเป็นกรณีที่ได้วางแผนไว้ โดยอุบัติเหตุ โดยจงใจ หรือด้วยเหตุผลใดก็ตามท่านรับทราบว่ายอดเงินที่ลูกค้าชำระแก่ท่านนั้น รวมค่าบริการ ซึ่งท่านได้จัดเก็บไว้แทนแอปพลิเคชัน ท่านรับทราบว่าทางแอปพลิเคชันเป็นผู้กำหนดค่าบริการเป็นครั้งคราวด้วยดุลยพินิจของบริษัทบริษัทมีดุลยพินิจแต่เพียงผู้เดียวที่จะเสนอ และอัตราที่แตกต่างกันให้แก่ลูกค้า โดยท่านจะต้องปฏิบัติตามข้อเสนอดังกล่าว แอปพลิเคชันอาจกำหนดหรือเปลี่ยนแปลงค่าบริการได้ตามที่จำเป็นหรือเหมาะสมแก่ธุรกิจ ทั้งนี้โดยดุลพินิจอย่างเด็ดขาดของแอปพลิเคชัน",
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Color(0xFF1A1C43),
                              ),
                            ),
                            Text(
                              "แอปพลิเคชันจะจัดการชำระเงินไปยังท่าน(“กระเป๋าเงินคนขับ”) ท่านรับทราบและยอมรับว่าท่านได้รับการชี้แจงจากบริษัทโดยชอบเกี่ยวกับวิธีการและขั้นตอนการใช้งานและการจัดการกระเป๋าเงินคนขับแล้ว ท่านอาจตรวจสอบยอดคงเหลือของกระเป๋าเงินคนขับได้ผ่านแอพพลิเคชั่น ยอดคงเหลือในกระเป๋าเงินคนขับที่ปรากฏในแอพพลิเคชั่นถือเป็นหลักฐานอันเป็นที่ยุติของยอดคงเหลือในกระเป๋าเงินคนขับของท่าน ท่านรับทราบและยอมรับว่าบริษัทมีดุลยพินิจแต่เพียงผู้เดียวในการหัก ยึดหน่วง ยกเลิก หรือกระทำการใดๆ แก่เงินสดและเครดิตในกระเป๋าเงินคนขับของท่าน หากแอปพลิเคชันมีเหตุผลควรเชื่อได้ว่าท่านกระทำการฉ้อฉล ผิดกฎหมาย หรืออาชญากรรมใดๆ หรือเมื่อบริษัทมีเหตุผลควรเชื่อได้ว่าท่านฝ่าฝืนข้อตกลงและเงื่อนไขระหว่างท่านกับบริษัท เงื่อนไขที่ระบุในแบบฟอร์มการลงทะเบียนสำหรับคนขับ จรรยาบรรณคนขับ หรือนโยบายอื่นใดที่แอปพลิเคชันจะได้กำหนดเป็นครั้งคราว หรือเมื่อท่านไม่ได้ใช้บริการโดยหยุดให้บริการขนส่งแก่ลูกค้าเป็นระยะเวลาใดระยะเวลาหนึ่งตามที่กำหนดโดยแอปพลิเคชัน",
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Color(0xFF1A1C43),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "3. การชำระเงินโดยลูกค้า",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Color(0xFF1A1C43),
                              ),
                            ),
                            Text(
                              "ลูกค้าอาจเลือกชำระเงินสำหรับบริการด้วยPaymentเท่านั่น ",
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Color(0xFF1A1C43),
                              ),
                            ),
                            Text(
                              "ลูกค้าจะยกข้อร้องเรียนใดๆ เกี่ยวกับการให้บริการของท่านขึ้นกับท่านโดยตรง แอปพลิเคชันมีสิทธิที่จะระงับการประมวลผลธุรกรรมใดๆ หากแอปพลิเคชันมีเหตุผลควรเชื่อได้ว่าธุรกรรมดังกล่าวเป็นการฉ้อฉล ผิดกฎหมาย หรือเกี่ยวข้องกับอาชญากรรมใดๆ หรือเมื่อทางแอปพลิเคชันมีเหตุผลควรเชื่อได้ว่าลูกค้าฝ่าฝืนข้อตกลงและเงื่อนไขระหว่างลูกค้ากับแอปพลิเคชัน ในกรณีดังกล่าวท่านจะไม่เอาผิดกับแอปพลิเคชันในการยึดหน่วง ล่าช้า ระงับ หรือยกเลิกการชำระเงินใดๆแก่ท่าน",
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Color(0xFF1A1C43),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "4. นโยบายการยกเลิกของคนขับ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Color(0xFF1A1C43),
                              ),
                            ),
                            Text(
                              "ลูกค้าหวังพึ่งพาท่านในใช้บริการเดินทางร่วมกัน ท่านยอมรับว่าการยกเลิกจำนวนมาก/บ่อยครั้ง หรือเพิกเฉยไม่ยอมรับการจองจากลูกค้านั้นจะเป็นการสร้างประสบการณ์การเดินทางที่ไม่ดีให้แก่ลูกค้า และจะสร้างผลกระทบในด้านลบต่อชื่อเสียงและภาพลักษณ์ของแอปพลิเคชันในขณะที่ท่านสามารถยกเลิกการจองได้ การยกเลิกนั้นจะต้องอยู่บนเหตุผลที่รับได้ตามที่ปรากฏบนแอปพลิเคชัน แอปพลิเคชันสงวนสิทธิที่จะดำเนินการใดๆที่ทางแอปพลิเคชันเห็นว่าเหมาะสมต่อการใช้งานการยกเลิกบนแอปพลิเคชันโดยมิชอบ รวมถึงแต่ไม่จำกัดอยู่เพียงการใช้เหตุผลเท็จในการยกเลิกการยกเลิกที่ไม่ได้อยู่บนเหตุผลที่รับได้ หรือการเพิกเฉยไม่รับการจอง (รวมเรียกว่า “การปฏิเสธ”) จะถูกนับเพื่อกำหนดการจำกัดการเข้าถึงและเครือข่ายของท่าน (“การระงับใช้”) ทางแอปพลิเคชันสงวนสิทธิในการเปลี่ยนแปลงเงื่อนไขใดๆ ในนโยบายการยกเลิกของคนขับ และวิธีการคำนวณการปฏิเสธและการระงับใช้ โดยเป็นดุลยพินิจของทางแอปพลิเคชันแต่เพียงผู้เดียว และไม่ต้องแจ้งให้ท่านทราบอีก",
                              style: TextStyle(
                                // fontWeight: FontWeight.bold,
                                fontSize: 10,
                                color: Color(0xFF1A1C43),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isChecked = !isChecked;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isChecked
                                ? const Color(0xFF1A1C43)
                                : Colors.black,
                            width: 1,
                          ),
                          color: isChecked
                              ? const Color(0xFF1A1C43)
                              : Colors.transparent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: isChecked
                              ? const Icon(
                                  Icons.check,
                                  size: 7.0,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.check_box_outline_blank,
                                  size: 7.0,
                                  color: Colors.transparent,
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'I accept and agree to the Terms of Use.',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: isChecked
                      ? () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Rider_Register()),
                              (Route<dynamic> route) => false);
                        }
                      : null,
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(const Color(0xFF1A1C43)),
                    minimumSize: WidgetStateProperty.all(const Size(90, 40)),
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
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
            builder: (context) => const GotwoHomepage(),
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
}
