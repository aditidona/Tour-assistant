import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:wonderlust/utilities/language.dart';

class TranslatorPage extends StatefulWidget {
  const TranslatorPage({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<TranslatorPage> {
  bool isSpeaking = false; //boolean to tts
  bool isListening = false; //boolean to stt
  late stt.SpeechToText _speech;
  String speechtotext = " press below to speak";
  GoogleTranslator translator = GoogleTranslator(); //using google translator
  final _flutterTts = FlutterTts(); //text to speech
  Translation? out; //output
  final lang = TextEditingController(); //getting text
  late Language selectLang;
  final List<Language> _languageList = <Language>[
    const Language('af', 'Afrikaans'),
    const Language('sq', 'Albanian'),
    const Language('am', 'Amharic'),
    const Language('ar', 'Arabic'),
    const Language('hy', 'Armenian'),
    const Language('az', 'Azerbaijani'),
    const Language('eu', 'Basque'),
    const Language('be', 'Belarusian'),
    const Language('bn', 'Bengali'),
    const Language('bs', 'Bosnian'),
    const Language('bg', 'Bulgarian'),
    const Language('ca', 'Catalan'),
    const Language('ceb', 'Cebuano'),
    const Language('ny', 'Chichewa'),
    const Language('zh-cn', 'Chinese Simplified'),
    const Language('zh-tw', 'Chinese Traditional'),
    const Language('co', 'Corsican'),
    const Language('hr', 'Croatian'),
    const Language('cs', 'Czech'),
    const Language('da', 'Danish'),
    const Language('nl', 'Dutch'),
    const Language('en', 'English'),
    const Language('eo', 'Esperanto'),
    const Language('et', 'Estonian'),
    const Language('tl', 'Filipino'),
    const Language('fi', 'Finnish'),
    const Language('fr', 'French'),
    const Language('fy', 'Frisian'),
    const Language('gl', 'Galician'),
    const Language('ka', 'Georgian'),
    const Language('de', 'German'),
    const Language('el', 'Greek'),
    const Language('gu', 'Gujarati'),
    const Language('ht', 'Haitian Creole'),
    const Language('ha', 'Hausa'),
    const Language('haw', 'Hawaiian'),
    const Language('iw', 'Hebrew'),
    const Language('hi', 'Hindi'),
    const Language('hmn', 'Hmong'),
    const Language('hu', 'Hungarian'),
    const Language('is', 'Icelandic'),
    const Language('ig', 'Igbo'),
    const Language('id', 'Indonesian'),
    const Language('ga', 'Irish'),
    const Language('it', 'Italian'),
    const Language('ja', 'Japanese'),
    const Language('jw', 'Javanese'),
    const Language('kn', 'Kannada'),
    const Language('kk', 'Kazakh'),
    const Language('km', 'Khmer'),
    const Language('ko', 'Korean'),
    const Language('ku', 'Kurdish (Kurmanji)'),
    const Language('ky', 'Kyrgyz'),
    const Language('lo', 'Lao'),
    const Language('la', 'Latin'),
    const Language('lv', 'Latvian'),
    const Language('lt', 'Lithuanian'),
    const Language('lb', 'Luxembourgish'),
    const Language('mk', 'Macedonian'),
    const Language('mg', 'Malagasy'),
    const Language('ms', 'Malay'),
    const Language('ml', 'Malayalam'),
    const Language('mt', 'Maltese'),
    const Language('mi', 'Maori'),
    const Language('mr', 'Marathi'),
    const Language('mn', 'Mongolian'),
    const Language('my', 'Myanmar (Burmese)'),
    const Language('ne', 'Nepali'),
    const Language('no', 'Norwegian'),
    const Language('ps', 'Pashto'),
    const Language('fa', 'Persian'),
    const Language('pl', 'Polish'),
    const Language('pt', 'Portuguese'),
    const Language('ma', 'Punjabi'),
    const Language('ro', 'Romanian'),
    const Language('ru', 'Russian'),
    const Language('sm', 'Samoan'),
    const Language('gd', 'Scots Gaelic'),
    const Language('sr', 'Serbian'),
    const Language('st', 'Sesotho'),
    const Language('sn', 'Shona'),
    const Language('sd', 'Sindhi'),
    const Language('si', 'Sinhala'),
    const Language('sk', 'Slovak'),
    const Language('sl', 'Slovenian'),
    const Language('so', 'Somali'),
    const Language('es', 'Spanish'),
    const Language('su', 'Sundanese'),
    const Language('sw', 'Swahili'),
    const Language('sv', 'Swedish'),
    const Language('tg', 'Tajik'),
    const Language('ta', 'Tamil'),
    const Language('te', 'Telugu'),
    const Language('th', 'Thai'),
    const Language('tr', 'Turkish'),
    const Language('uz', 'Uzbek'),
    const Language('vi', 'Vietnamese'),
    const Language('cy', 'Welsh'),
    const Language('xh', 'Xhosa'),
    const Language('yi', 'Yiddish'),
    const Language('yo', 'Yoruba'),
    const Language('zu', 'Zulu'),
  ];

  void initializeTts() {
    _flutterTts.setStartHandler(() {
      setState(() {
        isSpeaking = true;
      });
    });
    _flutterTts.setCompletionHandler(() {
      setState(() {
        isSpeaking = false;
      });
    });
    _flutterTts.setErrorHandler((message) {
      setState(() {
        isSpeaking = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    initializeTts();
    selectLang = _languageList[35];
  }

  void speak() async {
    if (out.toString().isNotEmpty) {
      await _flutterTts.speak(out.toString());
    }
  }

  void stop() async {
    await _flutterTts.stop();
    setState(() {
      isSpeaking = false;
    });
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  void trans(String data, String lang) {
    translator.translate(data, to: lang) //translating to hi = hindi
        .then((output) {
      setState(() {
        out = output;
        //placing the translated text to the String to be used
      });
    });
  }

  void onListen() async {
    if (!isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus : $val'),
        onError: (val) => print('onError : $val'),
      );
      if (available) {
        setState(() {
          isListening = true;
        });
        _speech.listen(
            onResult: (val) => setState(() {
                  speechtotext = val.recognizedWords;
                }));
      }
    } else {
      setState(() {
        isListening = false;
        _speech.stop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" WanderLust Transalate !!"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: isListening,
        glowColor: Colors.cyan,
        endRadius: 80,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: onListen,
          child: Icon(isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          child: Center(
              child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Welcome To Wanderlust Translator',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                " Speak or Type in any language and select the language to translate and press the button to see the magic ",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: lang,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Or",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                speechtotext.toString(),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Please Select the language you want to translate",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.black, width: 4),
                ),
                child: DropdownButton<Language>(
                  value: selectLang,
                  onChanged: (Language? value) {
                    setState(() {
                      selectLang = value as Language;
                    });
                  },
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                  iconSize: 36,
                  isExpanded: true,
                  items: _languageList.map((Language lang) {
                    return DropdownMenuItem<Language>(
                      value: lang,
                      child: Text(
                        lang.name,
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.cyan)),
                child: const Text(
                    "Press to translate"), //on press to translate the language using function
                onPressed: () {
                  if (speechtotext != " press below to speak") {
                    trans(lang.text + " " + speechtotext, 'hi');
                  } else {
                    trans(lang.text, selectLang.code);
                  }
                },
              ),
              const SizedBox(height: 15),
              SizedBox(
                child: Center(
                  child: Text(
                    out.toString(), //translated string
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.cyan)),
                child: const Text("Press to Listen to translated text"),
                //on press to translate the language using function
                onPressed: () {
                  isSpeaking ? stop() : speak();
                },
              ),
            ],
          )),
        ),
      ),
    );
  }
}
