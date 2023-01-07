import 'package:flutter/material.dart';
import 'package:majestry_mobile_app/utils/url.dart';

class CardFood extends StatefulWidget {
  final String? foodpic;
  final String? name;
  final int? price;
  final int? preparingtime;
  const CardFood(
      {Key? key, this.foodpic, this.name, this.price, this.preparingtime})
      : super(key: key);

  @override
  State<CardFood> createState() => _CardFoodState();
}

class _CardFoodState extends State<CardFood> {
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
          children: [
            Image.network("$baseUrl${widget.foodpic}",
                fit: BoxFit.cover, width: double.infinity, height: 100),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                "${widget.name}",
                textAlign: TextAlign.left,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(
              height: 10,
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
            const SizedBox(
              height: 10,
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
          ],
        ),
      ),
    );
  }
}
