import 'package:flutter/material.dart';

class Member {
  String memberName;
  String courseName;

  Member({this.memberName, this.courseName});
}

class Cache {
  static Map<String, List<Member>> cache = {
    'IP-83': [
      Member(memberName: 'Alexander Kuharenko'),
      Member(memberName: 'Yehor  Kanaev')
    ],
    'IP-84': [
      Member(memberName: 'Oleg Kovalyshen'),
      Member(memberName: 'Vlad Kuchin')
    ],
  };
}

mixin Author {
  String getAuthor() {
    return 'Andrii Boiko IP-83';
  }
}

class Course with Author {
  String courseName;
  Set<Member> _members = {};

  Course(courseName) {
    this.courseName = courseName;
  }

  String get membersCount {
    return 'You got ${this._members.length} members in your course';
  }

  set members(Set<Member> memberList) => _members = memberList;

  Map<String, Member> getMembersMap() {
    Map<String, Member> map = Map();

    assert(this._members.isNotEmpty, 'List must not be empty');

    void createMap() {
      for (var member in this._members) {
        map[member.memberName] =
            Member(memberName: member.memberName, courseName: this.courseName);
      }
    }

    createMap();

    return map;
  }

  List<Member> getMemberList() {
    List<Member> mappedMembers = this._members.toList()
      ..map((member) =>
          Member(memberName: member.memberName, courseName: this.courseName));
    return mappedMembers;
  }

  void addMember({member: Member}) {
    this._members.add(member);
  }

  factory Course.fromGroup(
      [String groupName = 'IP-83', String courseName = 'Programming']) {
    if (Cache.cache.containsKey(groupName)) {
      Course course = Course(courseName);
      course.members = Cache.cache[groupName].toSet();
      return course;
    }
    return Course(courseName);
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    Course course = new Course('Flutter');

    // course.getMembersMap();

    print(course.getAuthor());

    Member member = Member(memberName: 'Bill Gates');

    print(member.memberName);

    course.addMember(member: member);

    print(course.getMemberList()[0].memberName);

    print(course.membersCount);

    print(course.getMembersMap()['Bill Gates'].memberName);

    Course course1 = Course.fromGroup();

    print(course1.membersCount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Andrii Boiko IP-83'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
