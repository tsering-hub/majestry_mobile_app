import 'package:flutter/material.dart';
import 'package:flutter_number_picker/flutter_number_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:majestry_mobile_app/repository/cart_repository.dart';
import 'package:majestry_mobile_app/utils/show_message.dart';
import 'package:majestry_mobile_app/utils/url.dart';

class FoodCard extends StatefulWidget {
  final id;
  final String? foodpic;
  final String? name;
  final int? price;
  final int? preparingtime;

  const FoodCard(
      {Key? key,
      this.id,
      this.foodpic,
      this.name,
      this.price,
      this.preparingtime})
      : super(key: key);

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  int? foodquantity;
  bool messageSuccess = false;

  _addtocart(foodId, int? quantity) async {
    bool isAdded = await CartRepository().addtocart(foodId, quantity);
    if (isAdded) {
      setState(() {
        messageSuccess = true;
      });
      displaySuccessMessage(context, "Added Successfully");
    } else {
      displayErrorMessage(context, "Not Added to cart");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network("$baseUrl${widget.foodpic}",
                fit: BoxFit.cover, width: double.infinity, height: 100),
            SizedBox(
              width: double.infinity,
              child: Text(
                "${widget.name}",
                textAlign: TextAlign.left,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Rs. ${widget.price}",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.orange[700]),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                "Preparing Time: ${widget.preparingtime} minutes",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[500]),
              ),
            ),
            Row(
              children: [
                const Text(
                  "Quantity : ",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                CustomNumberPicker(
                  initialValue: 1,
                  maxValue: 20,
                  minValue: 1,
                  step: 1,
                  onValue: (value) {
                    setState(() {
                      foodquantity = int.tryParse(value.toString());
                    });
                  },
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ElevatedButton(
                        key: const ValueKey("btnAddtoCart"),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.orange[700]),
                        ),
                        onPressed: () {
                          setState(() {
                            if (foodquantity != null) {
                              _addtocart(widget.id, foodquantity);
                            } else {
                              _addtocart(widget.id, 1);
                            }
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              FontAwesomeIcons.bagShopping,
                              size: 15,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Add to Bag",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
