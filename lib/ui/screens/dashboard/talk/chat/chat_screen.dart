import 'package:felicidade/common/utils/color_constants.dart';
import 'package:felicidade/common/utils/image_paths.dart';
import 'package:felicidade/ui/screens/dashboard/journaling/journaling_dashboard_controller.dart';
import 'package:felicidade/ui/screens/dashboard/talk/talkToSomeone/talk_to_someone_controller.dart';
import 'package:felicidade/ui/widget/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../common/utils/Styles.dart';
import '../../../../../common/utils/app_constants.dart';
import '../../../../../common/utils/strings.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../widget/image_view.dart';
import 'chat_controller.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<StatefulWidget> createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final ChatController chatController =
  Get.put(ChatController());

  @override
  void initState() {
    super.initState();
  }



  @override
  void dispose() {
    super.dispose();
    Get.delete<ChatController>();
  }

  final TextEditingController _messageController = TextEditingController();


  List<Map<String, dynamic>> messages = [
    {
      "text": "Hello Rohit, I hope you are doing well let me know what problems are you facing",
      "isSender": false,
      "time": "Wed 8:21 AM"
    },
    {
      "text": "I'm not feeling well, I want someone to talk",
      "isSender": true
    },
    {
      "text": "I'm not feeling well for now",
      "isSender": true
    },
    {
      "text": "Ok, tell me about yourself and how can I help you",
      "isSender": false
    }
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        messages.add({"text": _messageController.text.trim(), "isSender": true});
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Obx(() {
      return ModalProgressHUD(
          color: Colors.black.withOpacity(0.6),
          dismissible: false,
          progressIndicator: AppConstants.loader(context),
          inAsyncCall: chatController.isLoading.value,
          child:Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leadingWidth: 55,
              leading: GestureDetector(
                onTap: (){
                  Get.back();
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 15.w),
                  child: ImageView(
                    width: 40.sp,
                    height: 40.sp,
                    boxFit: BoxFit.contain,
                    image: AppSvgIcons.icBackIcon,
                    imageType: ImageType.svg,
                  ),
                ),
              ),
              title: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/icons/pngIcons/a1.jpg"), // Add your profile image
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Rajeshwari", style: Styles.textFontBold(size: 16)),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: "● ", // The bullet point
                              style: Styles.textFontBold(size: 14,color: Color(0xFF7DDE86))
                            ),
                            TextSpan(
                              text: "Always active", // The text
                              style: Styles.textFontMedium(size: 13,color: Color(0xFF72777A))
                            ),
                          ],
                        ),
                      )

                    ],
                  ),
                ],
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 15.w),
                  child: ImageView(
                    width: 80.sp,
                    height: 40.sp,
                    boxFit: BoxFit.contain,
                    image: AppSvgIcons.icCallCutIcon,
                    imageType: ImageType.svg,
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      bool isSender = messages[index]["isSender"];
                      return Align(
                        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSender ? Color(0xFFF2F8FF) : Color(0xFFF2F4F5),
                            borderRadius: BorderRadius.only(
                              topLeft:isSender ? Radius.circular(12):Radius.zero,
                              topRight: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                              bottomRight: isSender ? Radius.zero : Radius.circular(12),
                            ),
                          ),
                          child: Text(
                            messages[index]["text"],
                            style: Styles.textFontRegular(size: 18,color: isSender ? Color(0xFF006BE5) : Color(0xFF303437))
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      // Text Input Field
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: LIGHT_GREY_COLOR3,
                                blurRadius: 10,
                                spreadRadius: 2,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Type a message...",
                              border: InputBorder.none,
                              hintStyle: Styles.textFontRegular(color: Color(0xFF72777A), size: 18),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 10),

                      // Send Button
                      GestureDetector(
                        onTap: () {
                          print("Send button tapped");
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.black87,
                          radius: 24,
                          child: ImageView(
                            width: 20.sp,
                            height: 20.sp,
                            boxFit: BoxFit.contain,
                            image: AppSvgIcons.icMessageSendIcon,
                            imageType: ImageType.svg,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ));
    });
  }
}
