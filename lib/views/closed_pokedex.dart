import 'package:flutter/material.dart';

class ClosedPokedex extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Stack(
          children: <Widget>[
            mainBackground(context),
            topLightWrapper(context),
            lights(),
            pokeball(context)
          ],
        ),
      ) 
    );
  }

  Container pokeball(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      child: Stack(
        children: <Widget>[
          Center(
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, 'list'),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                  border: Border.all(
                    color: Theme.of(context).primaryColorDark,
                    width: 15
                  )
                ), 
                child: Center(
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, 'list'),
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorDark,
                        shape: BoxShape.circle,
                      ),
                    ),
                  )
                )
              ),
            )
          ),
          Center(
            child: Container(
              color: Theme.of(context).primaryColorDark,
              height: 15,
            ),
          ),
        ],
      ),
    );
  }

  Container lights() {
    return Container(
      margin: EdgeInsets.only(right: 70, top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 2),
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
              border: Border.all(
                color: Colors.black,
                width: 1,
              )
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 2),
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.yellow,
              border: Border.all(
                color: Colors.black,
                width: 1,
              )
            ),
          ), 
          Container(
            margin: EdgeInsets.only(right: 2),
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
              border: Border.all(
                color: Colors.black,
                width: 1,
              )
            ),
          ),
        ],
      )
    );
  }

  Container mainBackground(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Row topLightWrapper(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 115,
          height: 115,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            border: Border(
              bottom: BorderSide(
                width: 2,
                color: Colors.black
              )
            )
          ),
          child: Container(
            margin: EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [BoxShadow(
                blurRadius: 5,
                spreadRadius: 1,
                offset: Offset(2, 3)
              )],
              border: Border.all(
                color: Colors.black,
                width: 1,
              )
            ),
            child: Container(
              margin: EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.lightBlue,
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                )
              ),
            ),
          ),
        ),
        Container(
          child: Transform(
            transform: Matrix4.skewY(-0.4),
            child: Container(
              height: 115,
              width: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border(
                  bottom: BorderSide(
                    width: 2,
                    color: Colors.black
                  )
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child:Container(
            height: 73,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              border: Border(
                bottom: BorderSide(
                  width: 2,
                  color: Colors.black
                )
              )
            ),
          ),
        )
      ],
    );
  }
}