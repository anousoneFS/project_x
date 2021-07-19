import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatBotScreen extends StatelessWidget {
  static String routeName = "/chat-bot-screen";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
        statusBarBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("LINE Chat Bot"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              "ສະແກນ QR-code ຢູ່ ແອັບພິເຄຊັນ Line \n ເພື່ອໃຊ້ BOT CEIT-FARM",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontFamily: "NotoSansLao"),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: size.width * 0.6,
                height: size.width * 0.6,
                padding: EdgeInsets.all(5),
                color: Colors.blue,
                child: Image.asset("assets/images/qr_code_line_chat_bot.png"),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Card(
                elevation: 2,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 25,
                    child: Image.asset("assets/images/bot-secretary.png"),
                  ),
                  title: Text(
                    "BOT CEIT-FARM",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'NotoSansLao',
                    ),
                  ),
                  subtitle: Text(
                    "ລາຍງານສະພາບແວດລ້ອມໃນໂຮງເຮືອນ",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'NotoSansLao',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,),
              child: Text(
                "BOT CEIT-FARM ແມ່ນ bot ທີ່ໃຊ້ໄວ້ແຈ້ງເຕືອນ ແລະ ສາມາດສອບຖາມຂໍ້ມູນຕ່າງໆໄດ້ເຊັ່ນ: ຖາມລາຄາຫຸ້ນ, ລາຄາ bitcoin, ປະຫວັດບຸກຄົນສຳຄັນ, ຄຳຄົມ ເປັນຕົ້ນ.",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "NotoSansLao",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
