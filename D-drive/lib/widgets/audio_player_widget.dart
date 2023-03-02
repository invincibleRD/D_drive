import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String url;
  AudioPlayerWidget(this.url);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  AudioPlayer audioPlayer = AudioPlayer();
  late Source audioUrl;
  Duration duration = Duration();
  Duration position = Duration();

  bool playing =false;
  @override
  initState(){
    audioUrl=UrlSource(widget.url);
    handlAudio();
    super.initState();
  }

  handlAudio()async{
    // await audioPlayer.play();
    // await audioPlayer.pause();
    // await audioPlayer.seek(Duration(seconds: 10));
    // await audioPlayer.stop();
    if(playing){
      var res =  await audioPlayer.pause();
    }else{
      var res =  await audioPlayer.play(audioUrl);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image(
            image: AssetImage('images/headphones.png'),
            fit: BoxFit.cover,
          ),
          Slider.adaptive(
              min: 0.0, value: 20, max: 40, onChanged: (double value) {}),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.fast_rewind_rounded),
                color: Colors.white,
                iconSize: 32,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.play_circle_fill),
                color: Colors.white,
                iconSize: 32,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.fast_forward_rounded),
                color: Colors.white,
                iconSize: 32,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
