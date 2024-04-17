import 'dart:io';

import 'package:ecommrece_application/controls/providers/shopping_card_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import '../controls/pay_config.dart';
import '../modes/custom_wedgits/add_to_card_button.dart';
import '../modes/custom_wedgits/custom_drawer.dart';

class CustomerShoppingScreen extends StatefulWidget {
  const CustomerShoppingScreen({super.key});

  @override
  State<CustomerShoppingScreen> createState() => _CustomerShoppingScreenState();
}

class _CustomerShoppingScreenState extends State<CustomerShoppingScreen> {
  String os = Platform.operatingSystem;

  var applePayButton = ApplePayButton(
    paymentConfiguration:
    PaymentConfiguration.fromJsonString(defaultApplePay),
    paymentItems: const [
      PaymentItem(
          label: 'Item 1',
          amount: '200',
          status: PaymentItemStatus.final_price),
      PaymentItem(
          label: 'Item 3',
          amount: '200',
          status: PaymentItemStatus.final_price),
      PaymentItem(
          label: 'Item 4',
          amount: '200',
          status: PaymentItemStatus.final_price),
    ],
    style: ApplePayButtonStyle.black,
    type: ApplePayButtonType.buy,
    margin: const EdgeInsets.only(top: 15.0),
    onPaymentResult: (result) => debugPrint(' Payment Result $result'),
    loadingIndicator: const Center(
      child: CircularProgressIndicator(),
    ),
  );

  var googlePayButton = GooglePayButton(
      paymentConfiguration:
      PaymentConfiguration.fromJsonString(defaultGooglePay),
      paymentItems: const [
        PaymentItem(
            label: 'Item 1',
            amount: '200',
            status: PaymentItemStatus.final_price),
        PaymentItem(
            label: 'Item 3',
            amount: '200',
            status: PaymentItemStatus.final_price),
        PaymentItem(
            label: 'Item 4',
            amount: '200',
            status: PaymentItemStatus.final_price),
      ],
      type: GooglePayButtonType.buy,
      margin: const EdgeInsets.only(top: 15.0),
      onPaymentResult: (result) => debugPrint(' Payment Result $result'),
      loadingIndicator: const Center(
        child: CircularProgressIndicator(),
      ));


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'bagzz',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Consumer<ShoppingCardProvider>(
              builder: (context, value, child) {
                if (value.cardItems.isEmpty) {
                  return const Center(
                    heightFactor: 25,
                    child: Text(
                      'Card is empty',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height *.7,
                        child: ListView.builder(
                          itemCount: value.cardItems.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Image.network(
                                          value.cardItems[index].image,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            value.cardItems[index].name,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text(
                                            'Wallet with chain',
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 16,
                                      ),
                                      AddToCardButton(
                                        buttonText: 'REMOVE',
                                        onTap: () {
                                          context
                                              .read<ShoppingCardProvider>()
                                              .removeCardItems(index);
                                          Fluttertoast.showToast(
                                            msg: 'Removed From Cart',
                                            gravity: ToastGravity.SNACKBAR,
                                            timeInSecForIosWeb: 1,
                                            textColor: Colors.white,
                                            fontSize: 16.0,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Platform.isIOS ? applePayButton : googlePayButton
                    ],
                  );
                }
              },
            ),

        ),
      ),
    );
  }
}
