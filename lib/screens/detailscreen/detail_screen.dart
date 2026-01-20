import 'package:badges/badges.dart' as badges;
import 'package:ecomerce_app_two/models/checkout_args.dart';
import 'package:flutter/material.dart';
import 'package:ecomerce_app_two/models/fashion_model.dart';

import '../../routes/app_image.dart';
import '../../routes/app_routes.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int quantity = 1;
  String selectedSize = 'S';
  bool isExpanded = false;


  @override
  Widget build(BuildContext context) {
    final ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;

    final double discountedPrice =
        product.price * (1 - product.discountPercentage / 100);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(product),
            SizedBox(height: 24),
            _buildTitle(product.title),
            SizedBox(height: 12),
            _buildPrice(product, discountedPrice),
            SizedBox(height: 16),
            _buildDescription(product.description),
            SizedBox(height: 20),
            _buildProductInfo(product),
            SizedBox(height: 24),
            _buildSizeSelector(),
            SizedBox(height: 24),
            _buildQuantityAndCart(discountedPrice, product.stock),
            SizedBox(height: 24),
            _buildBuyNowButton(product),
            SizedBox(height: 30),
            _buildPolicies(product),
            SizedBox(height: 25),
            _buildTitle("Return Policy"),
            SizedBox(height: 10),
            _buildTextPolicy(
              "You may return most new ,unopened times within 30days of delivery for a full refund.We'll also pay the return shipping costs if the return is a result of our error(you received an incorrect or defective item,etc.). ",
            ),
            SizedBox(height: 25),
            _buildTitle("Shipping"),
            SizedBox(height: 10),
            _buildTextPolicy(
              'We can ship to virtually any address in the world. Note that there are restrictions on on some products, and some prodcts cannot be shipped to international destienstiond'
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- APP BAR ----------------
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Detail',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      // actions: [
      //   badges.Badge(
      //     badgeContent: Text(
      //       '2',
      //       style: TextStyle(color: Colors.white, fontSize: 10),
      //     ),
      //     badgeStyle: const badges.BadgeStyle(
      //       badgeColor: Colors.red,
      //     ),
      //     child: IconButton(
      //       icon: Image.asset(AppImage.shopping, width: 26),
      //       onPressed: () {},
      //     ),
      //   ),
      //   SizedBox(width: 18),
      // ],
      actions: [
        badges.Badge(
          badgeContent: Text('3'),
          child: Image.asset(AppImage.shopping, width: 24),
        ),
        SizedBox(width: 16),
      ],
    );
  }

  // ---------------- IMAGE ----------------
  Widget _buildProductImage(ProductModel product) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      color: Colors.grey,
      // child: Image.network(data.thumbnail),
      child: Image.network(
        product.thumbnail,
        fit: BoxFit.cover,
      ),
    );
  }

  // ---------------- TITLE ----------------
  Widget _buildTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // ---------------- PRICE ----------------
  Widget _buildPrice(ProductModel product, double discountedPrice) {
    return Row(
      children: [
        Text(
          'Price : \$${discountedPrice.toStringAsFixed(2)}USD',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '${product.discountPercentage.toStringAsFixed(2)}% off',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------- DESCRIPTION ----------------
  Widget _buildDescription(String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          description,
          maxLines: isExpanded ? null : 4,
          overflow:
              isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15,
            color: Colors.black54,
            height: 1.5,
          ),
        ),
        SizedBox(height: 6),
        GestureDetector(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            isExpanded ? 'Read less' : 'Read more',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------- PRODUCT INFO ----------------
  Widget _buildProductInfo(ProductModel product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(
          'AVAILABLE:',
          product.availabilityStatus,
          color: product.availabilityStatus == 'In Stock'
              ? Colors.green
              : Colors.red,
        ),
        _buildInfoRow('TAG:', product.tags.join(', ')),
        _buildInfoRow('SKU:', product.sku),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 15,
                color: color ?? Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- SIZE SELECTOR ----------------
  Widget _buildSizeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size: $selectedSize',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: ['S', 'M', 'L', 'XL','XXL'].map((size) {
            final bool isSelected = size == selectedSize;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedSize = size;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                width: 43,
                height: 55,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  size,
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // ---------------- QUANTITY & CART ----------------
  Widget _buildQuantityAndCart(double discountedPrice, int stock) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quantity:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: quantity > 1
                        ? () => setState(() => quantity--)
                        : null,
                  ),
                  Text(
                    quantity.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: quantity < stock
                        ? () => setState(() => quantity++)
                        : null,
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  
                  onPressed: stock == 0 ? null : () {},
                  style: OutlinedButton.styleFrom(
                    
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      
                      borderRadius: BorderRadius.circular(30),
                    ),
                    side: BorderSide(color: Colors.black, width: 2),
                  ),
                  child: Text(
                    stock == 0
                        ? 'Out of Stock'
                        : 'Add to cart - ${(discountedPrice * quantity).toStringAsFixed(2)}USD',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 4),
            Container(
              width: 43,
              height: 43,
              decoration: BoxDecoration(
                // color: Colors.amber,
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: IconButton(
                  icon: Image.asset(AppImage.saeved, width: 26),
                  // icon: Icon(Icons.bookmark_border),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------- BUY NOW ----------------
  Widget _buildBuyNowButton(ProductModel product) {
    final double discountedPrice =
        product.price * (1 - product.discountPercentage / 100);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes.checkout,
            arguments: CheckoutArgs(
              product: product,
              size: selectedSize,
              quantity: quantity,
              price: discountedPrice,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal.shade900,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          'BUY NOW',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ---------------- POLICIES ----------------
  Widget _buildPolicies(ProductModel product) {
    return Column(
      children: [
        _buildPolicyRow(
          'assets/icon/shipping.png',
          product.shippingInformation,
        ),
        _buildPolicyRow(
          'assets/icon/security_warning_icon.png',
          product.warrantyInformation,
        ),
      ],
    );
  }

  Widget _buildPolicyRow(String iconPath, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Image.asset(
            iconPath,
            width: 35,
            height: 35,
            color: Colors.black, // optional (remove if colored icons)
            
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                height: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextPolicy(String textPolicy) {
    return Text(
      textPolicy,
      style: TextStyle(
        fontSize: 15,
      ),
    );
  }

}