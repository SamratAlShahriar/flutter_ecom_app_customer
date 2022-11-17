import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../custom_widgets/additional_image_view_item.dart';
import '../../models/product_model.dart';
import '../../providers/product_provider.dart';
import '../../utils/constants_values.dart';
import '../../utils/helper_functions.dart';
import '../../utils/widget_functions.dart';

class ProductDetailsPage extends StatefulWidget {
  static const String routeName = '/product_details_page';

  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late ProductModel productModel;
  late ProductProvider productProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    productModel = ModalRoute.of(context)!.settings.arguments as ProductModel;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          productModel.productName,
        ),
      ),
      body: ListView(
        children: [
          CachedNetworkImage(
            imageUrl: productModel.thumbnailImageUrl,
            width: double.infinity,
            height: 200,
            fit: BoxFit.contain,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          SizedBox(
            height: 100,
            child: Center(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: productModel.additionalImages.length,
                itemBuilder: (context, index) {
                    return AdditionalImageViewItem(
                      child: InkWell(
                        onTap: () {
                          _showImageOnDialog(index);
                        },
                        child: CachedNetworkImage(
                          fit: BoxFit.contain,
                          imageUrl: productModel.additionalImages[index],
                          placeholder: (context, url) => const Center(
                            child: Center(child: CircularProgressIndicator()),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error_outline_sharp,
                            size: 60,
                          ),
                        ),
                      ),
                    );
                },
              ),
            ),
          ),
          ListTile(
            title: Text(productModel.productName),
            subtitle: Text(productModel.category.categoryName),
          ),
          ListTile(
            title:
                Text('Sale Price : $currencySymbol ${productModel.salePrice}'),
            subtitle: Text(
              'Stock : ${productModel.stock}',
            ),
            trailing: IconButton(
              onPressed: () {
                showSingleTextInputDialog(
                    context: context,
                    hint: 'New Price...',
                    title: 'Update Sale Price',
                    onSubmit: (value) {
                      productProvider
                          .updateProductField(productModel.productId!,
                              productFieldSalePrice, num.parse(value))
                          .then((v) {
                        productModel.salePrice = num.parse(value);
                        setState(() {});
                      });
                    });
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          SwitchListTile(
            value: productModel.available,
            onChanged: (value) {
              setState(() {
                productModel.available = value;
              });
              productProvider.updateProductField(
                  productModel.productId!, productFieldAvailable, value);
            },
            title: const Text('Available'),
          ),
          SwitchListTile(
            value: productModel.featured,
            onChanged: (value) {
              setState(() {
                productModel.featured = value;
              });
              productProvider.updateProductField(
                  productModel.productId!, productFieldFeatured, value);
            },
            title: const Text('Featured'),
          ),
          if (productModel.descriptions != null)
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Descriptions',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: productModel.descriptions?.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final desM = productModel.descriptions?[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          "${desM?.descriptionTitle}",
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        subtitle: Text("${desM?.description}",
                            textAlign: TextAlign.justify,
                            style: Theme.of(context).textTheme.bodySmall),
                      );
                    },
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }


  void _addImage() async {
    final selectedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (selectedFile != null) {
      EasyLoading.show(status: 'Please wait...');
      try {
        final downloadUrl =
            await productProvider.uploadImage(selectedFile.path);
        final previousList = productModel.additionalImages;
        previousList.add(downloadUrl);
        await productProvider.updateProductField(
            productModel.productId!, productFieldImages, previousList);
        EasyLoading.dismiss();
        if (mounted) {
          showMsg(context, 'Uploaded!');
        }
        setState(() {});
      } catch (error) {
        EasyLoading.dismiss();
        if (mounted) {
          showMsg(context, 'Upload Failed!');
        }
        rethrow;
      }
    }
  }

  void _showImageOnDialog(int index) {
    final url = productModel.additionalImages[index];
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.cancel_outlined,
                    )),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CachedNetworkImage(
                height: MediaQuery.of(context).size.height / 2,
                imageUrl: url,
                fit: BoxFit.contain,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () async {
                      EasyLoading.show(status: 'Deleting...');
                      try {
                        await productProvider.deleteImage(url);
                        final tempList = productModel.additionalImages;
                        tempList.removeAt(index);
                        await productProvider.updateProductField(
                          productModel.productId!,
                          productFieldImages,
                          tempList,
                        );
                        EasyLoading.dismiss();

                        setState(() {

                        });
                        if (mounted) {
                          showMsg(context, 'Deleted');
                        }
                      } catch (error) {
                        EasyLoading.dismiss();
                        if (mounted) {
                          showMsg(context, error.toString());
                        }
                      }
                      if (mounted) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(
                      Icons.delete,
                      size: 36.0,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
