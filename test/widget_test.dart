import 'package:flutter/material.dart';
import 'dart:async'; // For Timer


class VerticalImageGrid extends StatefulWidget {


  const VerticalImageGrid({super.key});

  @override
  State<StatefulWidget> createState() => _VerticalImageGridState();
}

class _VerticalImageGridState extends State<VerticalImageGrid> {
  final List<String> imageUrls = List.generate(30, (index) {
    return 'https://plus.unsplash.com/premium_photo-1689977968861-9c91dbb16049?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D${index + 1}';
  });

  late ScrollController _scrollController1;
  late ScrollController _scrollController2;
  late ScrollController _scrollController3;

  late Timer _timer1;
  late Timer _timer2;
  late Timer _timer3;

  @override
  void initState() {
    super.initState();

    _scrollController1 = ScrollController();
    _scrollController2 = ScrollController();
    _scrollController3 = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling();
    });
  }

  void _startScrolling() {
    _timer1 = Timer.periodic(Duration(milliseconds: 30), (timer) {
      if (_scrollController1.hasClients && _scrollController1.position.hasContentDimensions) {
        _scrollController1.jumpTo(_scrollController1.offset + 1);
        if (_scrollController1.offset >= _scrollController1.position.maxScrollExtent) {
          _scrollController1.jumpTo(0);
        }
      }
    });

    _timer2 = Timer.periodic(Duration(milliseconds: 30), (timer) {
      if (_scrollController2.hasClients && _scrollController2.position.hasContentDimensions) {
        _scrollController2.jumpTo(_scrollController2.offset - 1);
        if (_scrollController2.offset <= _scrollController2.position.minScrollExtent) {
          _scrollController2.jumpTo(_scrollController2.position.maxScrollExtent);
        }
      }
    });

    _timer3 = Timer.periodic(Duration(milliseconds: 30), (timer) {
      if (_scrollController3.hasClients && _scrollController3.position.hasContentDimensions) {
        _scrollController3.jumpTo(_scrollController3.offset + 1);
        if (_scrollController3.offset >= _scrollController3.position.maxScrollExtent) {
          _scrollController3.jumpTo(0);
        }
      }
    });
  }


  @override
  void dispose() {
    // Dispose controllers and timers to avoid memory leaks
    _scrollController1.dispose();
    _scrollController2.dispose();
    _scrollController3.dispose();
    _timer1.cancel();
    _timer2.cancel();
    _timer3.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Vertical Image Grid')),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // First Column (scrolls down to up)
          Expanded(
            child: ListView.builder(
              controller: _scrollController1,
              itemCount: imageUrls.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 50,
                  height: 80,
                  margin: EdgeInsets.all(5),
                  child: Image.network(
                    imageUrls[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 5),
          // Second Column (scrolls up to down)
          Expanded(
            child: ListView.builder(
              controller: _scrollController2,
              itemCount: imageUrls.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 50,
                  height: 80,
                  margin: EdgeInsets.all(5),
                  child: Image.network(
                    imageUrls[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 5),
          // Third Column (scrolls down to up)
          Expanded(
            child: ListView.builder(
              controller: _scrollController3,
              itemCount: imageUrls.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 50,
                  height: 80,
                  margin: EdgeInsets.all(5),
                  child: Image.network(
                    imageUrls[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: VerticalImageGrid(),
//   ));
// }