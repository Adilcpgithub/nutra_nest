import 'package:flutter/material.dart';
import 'package:nutra_nest/utity/colors.dart';
import 'package:nutra_nest/widgets/image_carousel.dart';
import 'package:nutra_nest/widgets/textformfield.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _searchCountroller = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 41,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 70,
                  ),
                  const Expanded(
                    child: Text(
                      '     Hey! Nutra-Nest',
                      style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 17,
                      ),
                      GestureDetector(
                        onTap: () async {},
                        child: Container(
                            height: 41,
                            width: 41,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 1.5, color: CustomColors.green),
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Padding(
                                padding: EdgeInsets.all(7.0),
                                child: Icon(
                                  Icons.notifications,
                                  color: Colors.white,
                                ))),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: SizedBox(
                  height: 68,
                  child: CustomTextFormField(
                    borderColor: CustomColors.green,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 20, right: 23),
                      child: Icon(
                        Icons.search,
                        size: 30,
                        color: Colors.white,
                      ),
                    ),
                    controller: _searchCountroller,
                    labelText: 'Search',
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ImageCarousel()
            ],
          ),
        ),
      ),
    );
  }
}
