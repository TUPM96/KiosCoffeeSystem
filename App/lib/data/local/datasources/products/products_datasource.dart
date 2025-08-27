import 'package:boilerplate/core/data/local/sembast/sembast_client.dart';
import 'package:boilerplate/data/local/constants/db_constants.dart';
import 'package:sembast/sembast.dart';

class ProductsDataSource {
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are Flogs objects converted to Map
  final _productsStore = intMapStoreFactory.store(DBConstants.STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
//  Future<Database> get _db async => await AppDatabase.instance.database;

  // database instance
  final SembastClient _sembastClient;

  // Constructor
  ProductsDataSource(this._sembastClient);

  // DB functions:--------------------------------------------------------------
  Future<int> insert(String post) async {
    return await _productsStore
        .add(_sembastClient.database, {'products': post});
  }

  Future<int> count() async {
    return await _productsStore.count(_sembastClient.database);
  }

  // Future<List<String>> getAllSortedByFilter({List<Filter>? filters}) async {
  //   //creating finder
  //   final finder = Finder(
  //       filter: filters != null ? Filter.and(filters) : null,
  //       sortOrders: [SortOrder(DBConstants.FIELD_ID)]);

  //   final recordSnapshots = await _receiptStore.find(
  //     _sembastClient.database,
  //     finder: finder,
  //   );

  //   // Making a List<Post> out of List<RecordSnapshot>
  //   return recordSnapshots.map((snapshot) {
  //     final goods = GoodsReceipt.fromJson(snapshot.value);
  //     // An ID is a key of a record from the database.
  //     goods.id = snapshot.key.toString();
  //     return goods;
  //   }).toList();
  // }

  Future<List<String>> getProductsFromDb() async {
    // post list
    var goodsList;

    // fetching data
    final recordSnapshots = await _productsStore.find(
      _sembastClient.database,
    );

    // Making a List<Post> out of List<RecordSnapshot>
    if (recordSnapshots.length > 0) {
      goodsList = recordSnapshots.map((snapshot) {
        return snapshot.value['products'].toString();
      }).toList();
    }

    return goodsList;
  }

  // Future<int> update(GoodsReceipt post) async {
  //   // For filtering by key (ID), RegEx, greater than, and many other criteria,
  //   // we use a Finder.
  //   final finder = Finder(filter: Filter.byKey(post.id));
  //   return await _receiptStore.update(
  //     _sembastClient.database,
  //     post.toJson(),
  //     finder: finder,
  //   );
  // }

  // Future<int> delete(GoodsReceipt post) async {
  //   final finder = Finder(filter: Filter.byKey(post.id));
  //   return await _receiptStore.delete(
  //     _sembastClient.database,
  //     finder: finder,
  //   );
  // }

  // Future deleteAll() async {
  //   await _receiptStore.drop(
  //     _sembastClient.database,
  //   );
}
