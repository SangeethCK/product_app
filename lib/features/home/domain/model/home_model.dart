class HomeModel {
  int? productId;
  String? productName;
  String? productSlug;
  String? displayProductName;
  String? displayCategoryName;
  int? offerFlag;
  String? productPrice;
  int? productOutOfStock;
  int? hasService;
  int? isVariant;
  String? resourceSmallName;
  String? resourceSmallPath;
  String? resourceMediumName;
  String? resourceMediumPath;
  String? cdnUrl;
  int? storeId;
  String? categoryName;
  String? categorySlug;
  dynamic offerPrice;
  int? offerPricePercentage;
  String? offerType;
  int? offerTypeId;
  bool? addToCart;
  int? prodCartQty;
  int? prodTypeId;
  String? unitName;
  int? itemsPerPack;
  bool? wishlisted;
  int? isSessionAvailable;
  int? mainCategoryId;
  int? productQty;
  int? rawCount;
  int? prodPurchaseLimit;
  int? maxOfferQty;

  HomeModel({
    this.productId,
    this.productName,
    this.productSlug,
    this.displayProductName,
    this.displayCategoryName,
    this.offerFlag,
    this.productPrice,
    this.productOutOfStock,
    this.hasService,
    this.isVariant,
    this.resourceSmallName,
    this.resourceSmallPath,
    this.resourceMediumName,
    this.resourceMediumPath,
    this.cdnUrl,
    this.storeId,
    this.categoryName,
    this.categorySlug,
    this.offerPrice,
    this.offerPricePercentage,
    this.offerType,
    this.offerTypeId,
    this.addToCart,
    this.prodCartQty,
    this.prodTypeId,
    this.unitName,
    this.itemsPerPack,
    this.wishlisted,
    this.isSessionAvailable,
    this.mainCategoryId,
    this.productQty,
    this.rawCount,
    this.prodPurchaseLimit,
    this.maxOfferQty,
  });

  HomeModel copyWith({
    int? productId,
    String? productName,
    String? productSlug,
    String? displayProductName,
    String? displayCategoryName,
    int? offerFlag,
    String? productPrice,
    int? productOutOfStock,
    int? hasService,
    int? isVariant,
    String? resourceSmallName,
    String? resourceSmallPath,
    String? resourceMediumName,
    String? resourceMediumPath,
    String? cdnUrl,
    int? storeId,
    String? categoryName,
    String? categorySlug,
    dynamic offerPrice,
    int? offerPricePercentage,
    String? offerType,
    int? offerTypeId,
    bool? addToCart,
    int? prodCartQty,
    int? prodTypeId,
    String? unitName,
    int? itemsPerPack,
    bool? wishlisted,
    int? isSessionAvailable,
    int? mainCategoryId,
    int? productQty,
    int? rawCount,
    int? prodPurchaseLimit,
    int? maxOfferQty,
  }) =>
      HomeModel(
        productId: productId ?? this.productId,
        productName: productName ?? this.productName,
        productSlug: productSlug ?? this.productSlug,
        displayProductName: displayProductName ?? this.displayProductName,
        displayCategoryName: displayCategoryName ?? this.displayCategoryName,
        offerFlag: offerFlag ?? this.offerFlag,
        productPrice: productPrice ?? this.productPrice,
        productOutOfStock: productOutOfStock ?? this.productOutOfStock,
        hasService: hasService ?? this.hasService,
        isVariant: isVariant ?? this.isVariant,
        resourceSmallName: resourceSmallName ?? this.resourceSmallName,
        resourceSmallPath: resourceSmallPath ?? this.resourceSmallPath,
        resourceMediumName: resourceMediumName ?? this.resourceMediumName,
        resourceMediumPath: resourceMediumPath ?? this.resourceMediumPath,
        cdnUrl: cdnUrl ?? this.cdnUrl,
        storeId: storeId ?? this.storeId,
        categoryName: categoryName ?? this.categoryName,
        categorySlug: categorySlug ?? this.categorySlug,
        offerPrice: offerPrice ?? this.offerPrice,
        offerPricePercentage: offerPricePercentage ?? this.offerPricePercentage,
        offerType: offerType ?? this.offerType,
        offerTypeId: offerTypeId ?? this.offerTypeId,
        addToCart: addToCart ?? this.addToCart,
        prodCartQty: prodCartQty ?? this.prodCartQty,
        prodTypeId: prodTypeId ?? this.prodTypeId,
        unitName: unitName ?? this.unitName,
        itemsPerPack: itemsPerPack ?? this.itemsPerPack,
        wishlisted: wishlisted ?? this.wishlisted,
        isSessionAvailable: isSessionAvailable ?? this.isSessionAvailable,
        mainCategoryId: mainCategoryId ?? this.mainCategoryId,
        productQty: productQty ?? this.productQty,
        rawCount: rawCount ?? this.rawCount,
        prodPurchaseLimit: prodPurchaseLimit ?? this.prodPurchaseLimit,
        maxOfferQty: maxOfferQty ?? this.maxOfferQty,
      );

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        productId: json["product_id"],
        productName: json["product_name"],
        productSlug: json["product_slug"],
        displayProductName: json["display_product_name"],
        displayCategoryName: json["display_category_name"]!,
        offerFlag: json["offer_flag"],
        productPrice: json["product_price"],
        productOutOfStock: json["product_out_of_stock"],
        hasService: json["has_service"],
        isVariant: json["is_variant"],
        resourceSmallName: json["resource_small_name"],
        resourceSmallPath: json["resource_small_path"],
        resourceMediumName: json["resource_medium_name"],
        resourceMediumPath: json["resource_medium_path"],
        cdnUrl: json["cdn_url"],
        storeId: json["store_id"],
        categoryName: json["category_name"],
        categorySlug: json["category_slug"],
        offerPrice: json["offer_price"],
        offerPricePercentage: json["offer_price_percentage"],
        offerType: json["offer_type"],
        offerTypeId: json["offer_type_id"],
        addToCart: json["add_to_cart"],
        prodCartQty: json["prod_cart_qty"],
        prodTypeId: json["prod_type_id"],
        unitName: json["unit_name"],
        itemsPerPack: json["items_per_pack"],
        wishlisted: json["wishlisted"],
        isSessionAvailable: json["is_session_available"],
        mainCategoryId: json["main_category_id"],
        productQty: json["product_qty"],
        rawCount: json["raw_count"],
        prodPurchaseLimit: json["prod_purchase_limit"],
        maxOfferQty: json["max_offer_qty"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "product_slug": productSlug,
        "display_product_name": displayProductName,
        "display_category_name": displayCategoryName,
        "offer_flag": offerFlag,
        "product_price": productPrice,
        "product_out_of_stock": productOutOfStock,
        "has_service": hasService,
        "is_variant": isVariant,
        "resource_small_name": resourceSmallName,
        "resource_small_path": resourceSmallPath,
        "resource_medium_name": resourceMediumName,
        "resource_medium_path": resourceMediumPath,
        "cdn_url": cdnUrl,
        "store_id": storeId,
        "category_name": categoryName,
        "category_slug": categorySlug,
        "offer_price": offerPrice,
        "offer_price_percentage": offerPricePercentage,
        "offer_type": offerType,
        "offer_type_id": offerTypeId,
        "add_to_cart": addToCart,
        "prod_cart_qty": prodCartQty,
        "prod_type_id": prodTypeId,
        "unit_name": unitName,
        "items_per_pack": itemsPerPack,
        "wishlisted": wishlisted,
        "is_session_available": isSessionAvailable,
        "main_category_id": mainCategoryId,
        "product_qty": productQty,
        "raw_count": rawCount,
        "prod_purchase_limit": prodPurchaseLimit,
        "max_offer_qty": maxOfferQty,
      };
}
