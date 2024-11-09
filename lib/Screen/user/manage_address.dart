import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nutra_nest/screen/bottom_navigation/bottom_navigation_screen.dart';
import 'package:nutra_nest/widgets/small_text_buttom.dart';

class ManageAddress extends StatelessWidget {
  const ManageAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(
              height: 57,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const MyHomePage(
                          setIndex: 3,
                        ),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          var curvedAnimation = CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeInOut, // Choose any curve here
                          );

                          return FadeTransition(
                            opacity: curvedAnimation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Container(
                      height: 39,
                      width: 39,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.arrow_back,
                        size: 26,
                        color: Colors.white,
                      )),
                ),
                const SizedBox(
                  width: 91.5,
                ),
                const Expanded(
                  child: Text(
                    'Manage Address',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Text(
                  'Saved Addresses',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            //----------------------------
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xFFAFB5BB),
                        borderRadius: BorderRadius.circular(9)),
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'House Name: ',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            Expanded(
                              child: Text(
                                'oakwood kottakkal',
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 13),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'House Number: ',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            Expanded(
                              child: Text(
                                'oakwood kottakkal',
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 13),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Street: ',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            Expanded(
                              child: Text(
                                'oakwood kottakkal',
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 13),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'City: ',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            Expanded(
                              child: Text(
                                'oakwood kodkldlfdljd',
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 13),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Pin code: ',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            Expanded(
                              child: Text(
                                'oakwood kottakkal',
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 13),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Country: ',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            Expanded(
                              child: Text(
                                'oakwood kottakkal',
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 13),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    top: 11,
                    right: 11,
                    child: Container(
                      height: 22,
                      width: 22,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5)),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 6, left: 6, right: 5),
                        child: Image.asset('assets/image copy 17.png'),
                      ),
                    ),
                  ),
                  const Positioned(
                    right: 11,
                    top: 57,
                    child: Text(
                      'Default Address',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                    ),
                  ),
                  Positioned(
                    bottom: 11,
                    right: 11,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(3)),
                      height: 19,
                      width: 70,
                      child: const Center(
                        child: Text(
                          'Edit  ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            //-------------------------------------------------
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFAFB5BB),
                      borderRadius: BorderRadius.circular(9)),
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'House Name: ',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w800),
                          ),
                          Expanded(
                            child: Text(
                              'oakwood kottakkal',
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 13),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'House Number: ',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w800),
                          ),
                          Expanded(
                            child: Text(
                              'oakwood kottakkal',
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 13),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Street: ',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w800),
                          ),
                          Expanded(
                            child: Text(
                              'oakwood kottakkal',
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 13),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'City: ',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w800),
                          ),
                          Expanded(
                            child: Text(
                              'oakwood kodkldlfdljd',
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 13),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Pin code: ',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w800),
                          ),
                          Expanded(
                            child: Text(
                              'oakwood kottakkal',
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 13),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Country: ',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w800),
                          ),
                          Expanded(
                            child: Text(
                              'oakwood kottakkal',
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 13),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 11,
                  right: 11,
                  child: Container(
                    height: 22,
                    width: 22,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 6, left: 6, right: 5),
                      child: Image.asset('assets/image copy 17.png'),
                    ),
                  ),
                ),
                const Positioned(
                  right: 11,
                  top: 57,
                  child: Text(
                    'Default Address',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                  ),
                ),
                Positioned(
                  bottom: 11,
                  right: 11,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(3)),
                    height: 19,
                    width: 70,
                    child: const Center(
                      child: Text(
                        'Edit  ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 95),
                child: SmallTextbutton(
                  buttomName: 'SUBMIT',
                  voidCallBack: () {},
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ]),
        ),
      ),
    );
  }
}
