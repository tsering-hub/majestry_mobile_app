import 'package:flutter/material.dart';
import 'package:majestry_mobile_app/repository/cart_repository.dart';
import 'package:majestry_mobile_app/utils/show_message.dart';
import 'package:majestry_mobile_app/utils/url.dart';

class CartCard extends StatefulWidget {
  final id;
  final String? foodpic;
  final String? name;
  final int? quantity;
  final int? price;
  final int? preparingtime;

  const CartCard(
      {Key? key,
      this.id,
      this.foodpic,
      this.name,
      this.quantity,
      this.price,
      this.preparingtime})
      : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  _deleteCart(id) async {
    bool isDeleted = await CartRepository().deleteacart(id);
    if (isDeleted) {
      Navigator.pop(context); // pop current page
      Navigator.pushNamed(context, "/cartScreen");
      displaySuccessMessage(context, "Deleted Successfully");
    } else {
      displayErrorMessage(context, "Not Deleted");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Image.network(
                  "$baseUrl${widget.foodpic}",
                  fit: BoxFit.cover,
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.name}",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Quantity: ${widget.quantity}"),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Price: Rs. ${widget.price} * ${widget.quantity}"),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        Text(
                            "${widget.preparingtime} min * ${widget.quantity}"),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {
                  _deleteCart(widget.id);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
