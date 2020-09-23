import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 1',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Mykhailo Mishyn TI-72'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Function createCalculator(int base) => ([int value]) => base * value ?? 1;

int getRandomInRange({int min = 0, @required int max}) {
  final _random = new Random();

  if (max < min) {
    max += min;
    min = max - min;
    max -= min;
  }

  return min + _random.nextInt(max - min);
}

Set<String> names = {
  'Gat',
  'Rabb',
  'Foxx',
  'Frig',
  'Doggo',
  'Slimo',
  'Catten',
  'Ducken',
  'Cowward',
  'Rat de Mouses',
};

Set<String> bynames = {
  '',
  'Bad',
  'Big',
  'Ugly',
  'Angry',
  'Toxic',
  'Little',
  'Sneaky',
  'Strong',
  'Scaring',
};

class _Monster {
  String _name;
  int _health;
  int _curHealth;
  int _expirience;

  String get name => _name;
  int get health => _health;
  int get curHealth => _curHealth;

  final _calculateHealth = createCalculator(15);
  final _calculateExpirience = createCalculator(10);

  String _createName() {
    String name = [...names][getRandomInRange(max: names.length)];
    String byname = [...bynames][getRandomInRange(max: bynames.length)];
    if (byname.length > 0) byname += ' ';

    return byname + name;
  }

  _Monster([int level = 1]) {
    _name = _createName();
    _health = _calculateHealth(level);
    _expirience = _calculateExpirience(level);
    _curHealth = _health;
  }

  _Monster.boss(level) {
    _name = _createName().toUpperCase();
    _health = _calculateHealth(level) * level;
    _expirience = _calculateExpirience(level) + 2 * level;
    _curHealth = _health;
  }

  int takeDamage(int damage) {
    if (_curHealth < damage) return _expirience;
    _curHealth -= damage;
    return 0;
  }
}

class _Buff {
  String _name;

  String get name => _name;

  _Buff(String name) {
    _name = name;
  }
}

class _DamageBuff extends _Buff {
  int _bonus;

  int get bonus => _bonus;

  _DamageBuff(int bonus) : super('damage') {
    _bonus = bonus;
  }
}

class _Hero {
  int _level;
  int _expirience;
  int _expirienceReq;
  int _damage;
  Map<String, dynamic> _buffs = {'damage': 0};

  int get level => _level;
  int get expirience => _expirience;
  int get expirienceReq => _expirienceReq;
  int get damage => _damage + _buffs['damage'] ?? 0;

  final _calculateLevelRequirement = createCalculator(50);
  final _calculateDamage = createCalculator(2);

  _Hero() {
    _level = 1;
    _expirience = 0;
    _expirienceReq = _calculateLevelRequirement(1);
    _damage = _calculateDamage(1);
  }

  void _levelUp() {
    _expirience -= _expirienceReq;
    _level++;
    _expirienceReq = _calculateLevelRequirement(_level);
    _damage = _calculateDamage(_level);
  }

  bool gainExpirience(int exp) {
    _expirience += exp;
    if (_expirience >= _expirienceReq) {
      _levelUp();
      return true;
    }
    return false;
  }

  void gainBuff(_Buff buff) {
    if (buff is _DamageBuff) _buffs[buff.name] = buff.bonus;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  _Monster _monster = _Monster();
  _Hero _hero = _Hero();
  int _attackCounter = 0;
  int _buffTimer = 0;
  int _buffCD = 0;
  bool _buffCDFlag = false;

  void _dealDamage() {
    int expirience = _monster.takeDamage(_hero.damage);
    if (expirience > 0) {
      if (_hero.gainExpirience(expirience)) {
        _monster = new _Monster.boss(_hero.level);
      } else {
        _monster = new _Monster(_hero.level);
      }
    }

    int _buffTimerCur = _buffTimer - 1;
    int _buffCDCur = _buffCD - 1;

    if (_buffTimerCur == 0) _hero.gainBuff(new _DamageBuff(0));

    setState(() {
      _attackCounter++;
      _buffTimer = _buffTimerCur;
      _buffCD = _buffCDCur;
      _buffCDFlag = _buffCDCur > 0;
    });
  }

  void _gainDamageBuff() {
    final _Buff buff = _DamageBuff((_attackCounter / 10).round());
    _hero.gainBuff(buff);
    setState(() {
      _buffTimer = _hero.level;
      _buffCD = _hero.level * 5;
      _buffCDFlag = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You are at ${_hero.level} level (${_hero.expirience}/${_hero.expirienceReq} EXP).',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text('Current damage: ${_hero.damage}.'),
              const Divider(
                color: Colors.white,
                height: 50,
                thickness: 0,
                endIndent: 0,
              ),
              Text(
                'You met ${_monster.name} (${_monster.curHealth}/${_monster.health} HP)!',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(''),
              Text('You did $_attackCounter attacks this far!'),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: !_buffCDFlag ? _gainDamageBuff : null,
              backgroundColor: _buffCDFlag ? Color(0x666666FF) : null,
              tooltip: 'Buff damage!',
              child: Icon(_buffCDFlag ? Icons.av_timer : Icons.fitness_center),
            ),
            FloatingActionButton(
              onPressed: _dealDamage,
              tooltip: 'Deal damage!',
              child: Icon(Icons.colorize),
            ),
          ],
        ));
  }
}
