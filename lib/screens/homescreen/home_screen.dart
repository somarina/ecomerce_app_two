import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecomerce_app_two/data/fashion_product.dart';
import 'package:ecomerce_app_two/models/fashion_model.dart';
import 'package:ecomerce_app_two/routes/app_image.dart';
import 'package:ecomerce_app_two/routes/app_routes.dart';
import 'package:ecomerce_app_two/data/categories.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int sliderIndex = 0;
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildContainer(),
              SizedBox(height: 40),
              _buildSlider(),
              SizedBox(height: 20),
              _buildCatagories(),
              SizedBox(height: 20),
              _buildProductGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCatagories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 50,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            padding: EdgeInsets.only(right: 8),
            separatorBuilder: (_, __) => SizedBox(width: 16),
            itemBuilder: (context, index) {
              return OutlinedButton(
                onPressed: () {
                  setState(() {
                    selectedCategoryIndex = index;
                  });
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  side: BorderSide(color: Colors.black, width: 2),
                  shape: StadiumBorder(),
                ),
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }


///////////        App Bar
  AppBar _buildAppBar(){
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.grey.shade200,
            child: Icon(Icons.person, color: Colors.black54),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Keat Somarina',
                style: GoogleFonts.spaceGrotesk(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'Ready to shopping!',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
      actions: [
        badges.Badge(
          badgeContent: Text('3'),
          child: Image.asset(AppImage.shopping, width: 24),
        ),
        SizedBox(width: 16),
      ],
    );
  }

  Widget _buildContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'GOOD\nAFTERNOON!',
          style: GoogleFonts.spaceGrotesk(
            color: Colors.black,
            fontSize: 53,
            fontWeight: FontWeight.bold,
            height: 1,
          ),
        ),
        SizedBox(height: 5,),
        Text(
          'Discover your unique style with KHOR AV store!',
          style: GoogleFonts.spaceGrotesk(
            color: Colors.black,
            height: 1,
            fontSize: 13,
          ),
        ),
      ],
    );
  }


///// //// CarouselSlider 
  Widget _buildSlider() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              // debugPrint("Index page : $index");

              setState(() {
                sliderIndex = index;
              });
            },
            height: 200.0,
            viewportFraction: 0.9,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 3),
          ),
          items:
              [AppImage.slider1, AppImage.slider2, AppImage.slider3].map((img) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: AssetImage(img),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 15),
        AnimatedSmoothIndicator(
          activeIndex: sliderIndex,
          count: 3,
          effect: JumpingDotEffect(
            dotWidth: 10,
            dotHeight: 10,
            // dotColor: Colors.amber, //unselected color
            activeDotColor: Colors.black,
          ),
        )
      ],
    );
  }


//////////////    build Product
  Widget _buildProductGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "All Product",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Row(
              children: [
                Text(
                  'View All',
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  onPressed: () {

                  },
                  icon: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ],
        ),
        
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 40,
            crossAxisSpacing: 10,
            mainAxisExtent: 280,

          ),
          itemBuilder: (context, index) {
            var productData = ProductModel.fromMap(fashionProducts[index]);

            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AppRoutes.detailscreen,
                  arguments: productData,
                );
              },
              child: _buildProductItem(productData),
            );
          },
          itemCount: fashionProducts.length,
        ),
      ],
    );
  }

  Column _buildProductItem(ProductModel productData) {
    return Column(
      children: [
        Expanded(
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xffebebeb),
            ),
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 12,),
                    Container(
                      width: 50,
                      height: 23,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${productData.discountPercentage.toStringAsFixed(0)}%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13, 
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    SizedBox(width: 75,),
                    IconButton(
                      onPressed: () {
                        
                      },
                      icon: Icon(Icons.bookmark),
                    )
                  ],
                ),
                Expanded(
                  child: CachedNetworkImage(
                    memCacheHeight: 400,
                    memCacheWidth: 400,
                    imageUrl: productData.thumbnail,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.withValues(alpha: 0.6),
                        highlightColor: Colors.white,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(93, 235, 235, 235),
                          ),
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
          ),
          
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              productData.brand,
              style: GoogleFonts.spaceGrotesk(
                color: Colors.black,
              ),
            ),
            Text(
              productData.title, 
              maxLines: 1,
              style: GoogleFonts.spaceGrotesk(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            Text("Price : \$${productData.price}", maxLines: 1),
          ],
        ),
      ],
    );
  }
}

// pushNamed(context, AppRoutes.screen2, argument : fashionProducts[index]);
// pushNamed(context, AppRoutes.screen2, argument : model);
