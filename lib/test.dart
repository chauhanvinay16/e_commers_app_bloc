// import 'package:flutter/material.dart';
//
// class ProductListScreen extends StatelessWidget {
//   final List<Product> getProductModal;
//
//   const ProductListScreen({Key? key, required this.getProductModal}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // return ListView.separated(
//     //   separatorBuilder: (context, i) => const SizedBox(height: 14), // Using a fixed value for simplicity
//     //   itemCount: getProductModal.length,
//     //   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//     //   itemBuilder: (context, index) {
//     //     return GestureDetector(
//     //       onTap: () async {
//     //         var refresh = await Navigator.push(
//     //           context,
//     //           MaterialPageRoute(
//     //             builder: (context) => ProductDetailsScreen(getProductsModel: getProductModal[index]),
//     //           ),
//     //         );
//     //
//     //         if (refresh == true) {
//     //           context.read<GetProductsCubit>().getproducts();
//     //         }
//     //       },
//     //       child: Card(
//     //         margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
//     //         elevation: 4,
//     //         shape: RoundedRectangleBorder(
//     //           borderRadius: BorderRadius.circular(10),
//     //         ),
//     //         child: Padding(
//     //           padding: const EdgeInsets.all(10),
//     //           child: Column(
//     //             crossAxisAlignment: CrossAxisAlignment.start,
//     //             children: [
//     //               Row(
//     //                 crossAxisAlignment: CrossAxisAlignment.start,
//     //                 children: [
//     //                   CircleAvatar(
//     //                     maxRadius: 40,
//     //                     backgroundImage: NetworkImage(getProductModal[index].category?.image ?? ""),
//     //                   ),
//     //                   const SizedBox(width: 10),
//     //                   Expanded(
//     //                     child: Column(
//     //                       crossAxisAlignment: CrossAxisAlignment.start,
//     //                       children: [
//     //                         Text(
//     //                           getProductModal[index].title ?? "",
//     //                           style: const TextStyle(
//     //                             fontSize: 18,
//     //                             fontWeight: FontWeight.bold,
//     //                           ),
//     //                         ),
//     //                         const SizedBox(height: 5),
//     //                         Row(
//     //                           children: [
//     //                             const Icon(Icons.category, size: 16, color: Colors.grey),
//     //                             const SizedBox(width: 5),
//     //                             Text(
//     //                               getProductModal[index].category?.name ?? "",
//     //                               style: const TextStyle(
//     //                                 color: Colors.grey,
//     //                                 fontSize: 14,
//     //                               ),
//     //                             ),
//     //                           ],
//     //                         ),
//     //                         const SizedBox(height: 5),
//     //                         Row(
//     //                           children: [
//     //                             const Icon(Icons.attach_money, size: 16, color: Colors.grey),
//     //                             const SizedBox(width: 5),
//     //                             Text(
//     //                               "₹${getProductModal[index].price.toString()}",
//     //                               style: const TextStyle(
//     //                                 color: Colors.grey,
//     //                                 fontSize: 14,
//     //                               ),
//     //                             ),
//     //                           ],
//     //                         ),
//     //                       ],
//     //                     ),
//     //                   ),
//     //                   const Spacer(),
//     //                   Column(
//     //                     children: [
//     //                       EditProductButton(
//     //                         productId: getProductModal[index].id.toString(),
//     //                         title: getProductModal[index].title.toString(),
//     //                         category: getProductModal[index].category?.name ?? "",
//     //                         price: getProductModal[index].price ?? 0,
//     //                       ),
//     //                       const SizedBox(height: 5),
//     //                       DeleteProductButton(
//     //                         id: getProductModal[index].id.toString(),
//     //                         goback: false,
//     //                       ),
//     //                     ],
//     //                   )
//     //                 ],
//     //               ),
//     //               const SizedBox(height: 10),
//     //               Text(
//     //                 getProductModal[index].description ?? "",
//     //                 style: const TextStyle(
//     //                   color: Colors.grey,
//     //                   fontSize: 14,
//     //                   fontWeight: FontWeight.normal,
//     //                 ),
//     //                 textAlign: TextAlign.justify,
//     //               )
//     //             ],
//     //           ),
//     //         ),
//     //       ),
//     //     );
//     //   },
//     // );
//   }
// }
