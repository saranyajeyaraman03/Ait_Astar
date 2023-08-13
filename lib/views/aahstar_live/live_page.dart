// Flutter imports:
import 'package:aahstar/views/aahstar_live/customavatar_builder.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';
import 'dart:math' as math;



class LivePage extends StatefulWidget {
  final String liveID;
  final bool isHost;

  const LivePage({
    Key? key,
    required this.liveID,
    this.isHost = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => LivePageState();
}

class LivePageState extends State<LivePage> {
  final liveController = ZegoUIKitPrebuiltLiveStreamingController();
  final String localUserID = math.Random().nextInt(10000).toString();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: 615752882 /*input your AppID*/,
        appSign: '596785632b3ab2fe340f4799142993ddeae3a5eccf780f4ec88f9e991927397e' /*input your AppSign*/,
        userID: localUserID,
        userName: 'user_$localUserID',
        liveID: widget.liveID,
        controller: liveController,
        config: (widget.isHost
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience())
          ..avatarBuilder = customAvatarBuilder,
      ),
    );
  }
}

