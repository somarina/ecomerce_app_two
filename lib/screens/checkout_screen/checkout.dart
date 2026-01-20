import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/checkout_args.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  bool isPriority = false;

  double get deliveryFee => isPriority ? 1.0 : 0.0;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args is! CheckoutArgs) {
      return const Scaffold(
        body: Center(child: Text("Checkout data missing")),
      );
    }

    final checkout = args;

    final double total =
        (checkout.price * checkout.quantity) + deliveryFee;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Checkout",
          style: GoogleFonts.spaceGrotesk(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle("Order Summary"),
            SizedBox(height: 16),
            _buildOrderItem(checkout),
            SizedBox(height: 24),
            _buildPriceRow(
              "Subtotal",
              checkout.price * checkout.quantity,
            ),
            Divider(height: 32),
            _buildDeliveryDetails(),
            Divider(height: 32),
            _buildSectionTitle("Delivery Options"),
            SizedBox(height: 12),
            _buildDeliveryOption(
              title: "Priority",
              subtitle: "20 mins",
              price: 1,
              selected: isPriority,
            ),
            SizedBox(height: 12),
            _buildDeliveryOption(
              title: "Standard",
              subtitle: "40 mins",
              price: 0,
              selected: !isPriority,
            ),

            Divider(height: 32),
            _buildSectionTitle("Payment Methods"),
            SizedBox(height: 18,),
            _builCashOnDelivery(),
            SizedBox(height: 5,),
            _builUserOfer(),
            Divider(height: 32),
            _buildTotalSection(total),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.spaceGrotesk(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildOrderItem(CheckoutArgs checkout) {
    final product = checkout.product;

    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            product.thumbnail,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: GoogleFonts.spaceGrotesk(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                   Text(
                    product.brand,
                    style: GoogleFonts.spaceGrotesk(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 13),
              Text(
                "Size:  ${checkout.size}",
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Column(
          children: [
            Text(
              "\$${checkout.price.toStringAsFixed(2)}USD",
              style: GoogleFonts.spaceGrotesk(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 6),
              decoration: BoxDecoration(
                color: const Color.fromARGB(102, 184, 184, 184),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                checkout.quantity.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceRow(String title, double value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              
            ),
          ),
          Text(
            "\$${value.toStringAsFixed(2)}USD",
            style: GoogleFonts.spaceGrotesk(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Delivery Options',
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Text(
                'Change',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: 16,
                  color: const Color(0xFF024E54),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Text(
          'Mr. Keat Somarina',
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            height: 1.5,
          ),
        ),
        SizedBox(height: 15,),
        Text(
          '#16B, St.318, S/K Tuol Svaay Prey \nMuoy, Khan Chamkaar Mon. Phnom Penh',
          style: GoogleFonts.spaceGrotesk(
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryOption({
    required String title,
    required String subtitle,
    required int price,
    required bool selected,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          isPriority = title == "Priority";
        });
      },
      borderRadius: BorderRadius.circular(25),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: selected ? const Color(0xFF024E54) : Colors.grey.shade500,
            width: selected ? 2.2 : 1.5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.spaceGrotesk(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text("•"),
                    SizedBox(width: 6),
                    Text(
                      subtitle,
                      style: GoogleFonts.spaceGrotesk(fontSize: 14,color: Colors.black),
                    ),
                  ],
                ),
                price != 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 6),
                    Text(
                      "Delivered directly to you with no stop in between",
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                )
              : SizedBox(),
              ],
            ),
            Text(
              price == 0 ? "Free" : "\$${price}USD",
              style: GoogleFonts.spaceGrotesk(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalSection(double total) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "\$${total.toStringAsFixed(2)}USD",
              style: GoogleFonts.spaceGrotesk(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              
              backgroundColor: const Color(0xFF024E54),
              
              shape: RoundedRectangleBorder(
                
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              "Place Order",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _builCashOnDelivery() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF024E54),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset('assets/icon/dollar_bill_icon.png'),
          )
        ),
        SizedBox(width: 15,),
        Text(
          'Cash On Delivery',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        _buildCashOnDeliveryButtonSheet(),
      ],
    );
  }

  Widget _buildCashOnDeliveryButtonSheet() {
    return IconButton(
      icon: Icon(Icons.arrow_forward_ios),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 12,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Drag handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Title
                  Text(
                    "Offers",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 8),

                  // Subtitle
                  Text(
                    "Have KhorAvGifts to redeem?",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  Text(
                    "Enter your gift code to your surprise!",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),


                  SizedBox(height: 20),

                  // Gift code label
                  Text(
                    "Gift code",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 8),

                  // TextField
                  TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "e.g. KK12345678",
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _builUserOfer() {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF024E54),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Image.asset('assets/icon/voucher_icon.png'),
          )
        ),
        SizedBox(width: 15,),
        Text(
          'User Offer',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        _buildUserOfferButtonSheet(),
      ],
    );
  }

  Widget _buildUserOfferButtonSheet() {
    return IconButton(
      icon: Icon(Icons.arrow_forward_ios),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                color: Color(0xFFF8F5FA),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // top handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),

                  Text(
                    "Payment Methods",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 20),

                  Text(
                    "Linked Methods",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),

                  SizedBox(height: 12),

                  // Cash on Delivery row
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF024E54),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/icon/dollar_bill_icon.png',
                          ),
                        ),
                      ),

                      SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          "Cash On Delivery",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),

                      Icon(
                        Icons.check_circle,
                        color: const Color(0xFF024E54),
                      ),
                    ],
                  ),

                  SizedBox(height: 24),

                  Text(
                    "Add Methods",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),

                  SizedBox(height: 12),

                  // Cards row
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFF024E54),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/icon/credit_card.png',
                          ),
                        ),
                      ),

                      SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          "Cards",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),

                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.teal.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          'assets/icon/aba_pay.png',
                        ),
                      ),

                      SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          "ABA PAY",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),

                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
            );

          },
        );
      },
    );
  }

}