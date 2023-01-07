import 'package:flutter/material.dart';
import 'package:majestry_mobile_app/repository/cart_repository.dart';
import 'package:majestry_mobile_app/repository/order_repository.dart';
import 'package:majestry_mobile_app/utils/show_message.dart';

class BottomModel extends StatefulWidget {
  final orderItems;
  final int? totalprice;
  final int? totalpreparingtime;
  final String? tablenumber;

  const BottomModel(
      {Key? key,
      this.orderItems,
      this.totalprice,
      this.totalpreparingtime,
      this.tablenumber})
      : super(key: key);

  @override
  State<BottomModel> createState() => _BottomModelState();
}

class _BottomModelState extends State<BottomModel> {
  final _tableController = TextEditingController(text: "1");

  final List<String> _paymentoption = [
    'Pay Cash',
    'Esewa',
    'Khalti',
  ]; // Option 2
  String? _paymentmethod;

  _postOrder(orderItems, totalprice, totalpreparingtime, tablenumber,
      paymentmethod) async {
    bool isAdded = await OrderRepository().postOrder(
        orderItems, totalprice, totalpreparingtime, tablenumber, paymentmethod);
    if (isAdded) {
      bool isDeleted = await CartRepository().deleteallcart();
      Navigator.pushNamed(context, "/foodsScreen");
      displaySuccessMessage(context, "Ordered Successfully");
    } else {
      displayErrorMessage(context, "Not Ordered");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                enabled: false,
                initialValue: "${widget.tablenumber}",
                decoration: const InputDecoration(
                  labelText: "Table Number",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                enabled: false,
                initialValue: "${widget.totalpreparingtime} min",
                decoration: const InputDecoration(
                  labelText: "Total Preparing Time",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                enabled: false,
                initialValue: "Rs. ${widget.totalprice}",
                decoration: const InputDecoration(
                  labelText: "Total Price",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButton(
                hint: _paymentmethod == null
                    ? const Text('Select payment option')
                    : Text(
                        _paymentmethod!,
                        style: const TextStyle(color: Colors.blue),
                      ),
                isExpanded: true,
                iconSize: 30.0,
                style: const TextStyle(color: Colors.blue),
                items: _paymentoption.map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val),
                    );
                  },
                ).toList(),
                onChanged: (String? val) {
                  setState(() {
                    _paymentmethod = val;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                  onPressed: () {
                    setState(() {
                      _postOrder(
                          widget.orderItems,
                          widget.totalprice,
                          widget.totalpreparingtime,
                          widget.tablenumber,
                          _paymentmethod);
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Icon(Icons.done), Text("Order")],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Icon(Icons.cancel), Text("Cancel")],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
