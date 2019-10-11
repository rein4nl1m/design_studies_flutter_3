import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;

  AnimationController animController;
  Animation<double> animTransUserName;
  Animation<double> animTransPassword;
  Animation<double> animOpacityForgetPassword;
  Animation<double> animButtonCircular;

  @override
  void initState() {
    super.initState();
    animController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    animTransUserName = Tween<double>(
      begin: 0,
      end: 350,
    ).animate(animController);
    animTransPassword = Tween<double>(
      begin: 0,
      end: -350,
    ).animate(animController);
    animOpacityForgetPassword = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(animController);
    animButtonCircular = Tween<double>(
      begin: 8,
      end: 40,
    ).animate(animController);
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget buttonSignIn(
        {bool isLoading = false,
        double circular = 8.0,
        double width = double.infinity,
        double height = 50,
        Function onTap,
        EdgeInsets padding = const EdgeInsets.only(
            right: 30.0, left: 30.0, top: 70, bottom: 70)}) {
      _loading() {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        );
      }

      _text() {
        return Text(
          "Sign In",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.white),
        );
      }

      return InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding,
          child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(circular),
                color: Colors.red,
              ),
              alignment: Alignment.center,
              child: isLoading ? _loading() : _text()),
        ),
      );
    }

    _onTap() {
      isLoading = !isLoading;
      if (animController.value > 0) {
        animController.reverse();
      } else {
        animController.forward();
      }
    }

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 70, top: 100),
                child: Icon(Icons.adjust,
                    size: 100, color: Theme.of(context).primaryColor),
              ),
              AnimatedBuilder(
                animation: animTransUserName,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 15),
                  child: TextField(
                      decoration: InputDecoration(
                          labelText: "Username",
                          hintText: "Username",
                          border: OutlineInputBorder())),
                ),
                builder: (BuildContext context, Widget child) {
                  return Transform.translate(
                    offset: Offset(animTransUserName.value, 0),
                    child: child,
                  );
                },
              ),
              AnimatedBuilder(
                animation: animTransPassword,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 30),
                  child: TextField(
                      decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "********",
                          border: OutlineInputBorder()),
                      obscureText: true),
                ),
                builder: (BuildContext context, Widget child) {
                  return Transform.translate(
                    offset: Offset(animTransPassword.value, 0),
                    child: child,
                  );
                },
              ),
              AnimatedBuilder(
                animation: animOpacityForgetPassword,
                child: Text("Forgot Password?",
                    style: TextStyle(color: Colors.grey[400])),
                builder: (BuildContext context, Widget child) {
                  return Opacity(
                    opacity: animOpacityForgetPassword.value,
                    child: child,
                  );
                },
              ),
            ]),
            AnimatedBuilder(
              animation: animController,
              builder: (BuildContext context, Widget child) {
                return buttonSignIn(
                    width: 50,
                    isLoading: isLoading,
                    onTap: _onTap,
                    circular: animButtonCircular.value);
              },
            )
          ],
        ),
      ),
    );
  }
}
