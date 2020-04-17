import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';

class DocBot extends StatefulWidget {
  @override
  _DocBotState createState() => _DocBotState();
}

class _DocBotState extends State<DocBot> {

  @override
  void initState() {
    super.initState();
    initialise();
  }

  void initialise() async {
  }

  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();

  Widget _buildTextComposer() {
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration:
                    new InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> response(query) async {
    _textController.clear();
    print(query);
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/json/symptomschecker.json")
            .build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogflow.detectIntent(query);
    print(response);
    ChatMessage message = new ChatMessage(
      text: response.getMessage() ??
          new CardDialogflow(response.getListMessage()[0]).title,
      name: "Mrs. Doc. Bot",
      type: false,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

  Future<void> _handleSubmitted(String text) async {
    _textController.clear();
    ChatMessage message = new ChatMessage(
      text: text,
      name: "Patient",
      type: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
    print(text);
    print(message);
    await response(text);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(
            'Mrs. Doc Bot',
            style: Theme.of(context).textTheme.title,
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,  
        ),
        body: new Column(children: <Widget>[
        new Flexible(
            child: new ListView.builder(
          padding: new EdgeInsets.all(8.0),
          reverse: true,
          itemBuilder: (_, int index) => _messages[index],
          itemCount: _messages.length,
        )),
        new Divider(height: 1.0),
        new Container(
          decoration: new BoxDecoration(color: Theme.of(context).cardColor),
          child: _buildTextComposer(),
        ),
      ]),
    );
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.name, this.type});

  final String text;
  final String name;
  final bool type;

  List<Widget> otherMessage(context) {
    return <Widget>[
      new Container(
        margin: const EdgeInsets.only(right: 16.0),
        child: new CircleAvatar(
          child: Image(image: AssetImage("assets/images/doc.png"),),
          radius: 22.0,
        ),
      ),
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text(this.name,
                style: new TextStyle(fontWeight: FontWeight.bold)),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(text),
            ),
          ],
        ),
      ),
    ];
  }

  List<Widget> myMessage(context) {
    return <Widget>[
      new Expanded(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            new Text(this.name, style: new TextStyle(fontWeight: FontWeight.bold)),
            new Container(
              margin: const EdgeInsets.only(top: 5.0),
              child: new Text(text),
            ),
          ],
        ),
      ),
      new Container(
        margin: const EdgeInsets.only(left: 16.0),
        child: new CircleAvatar(
          child: Image(image: AssetImage("assets/images/patient.JPG"),),
          radius: 22.0,
        ),
      ),
      
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? myMessage(context) : otherMessage(context),
      ),
    );
  }
}