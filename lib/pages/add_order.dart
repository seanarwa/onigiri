import 'package:flutter/material.dart';
import 'package:onigiri/api/firebase/db/item.dart';
import 'package:onigiri/api/firebase/db/order.dart';
import 'package:onigiri/models/index.dart';
import 'package:onigiri/widgets/add_order/item_row.dart';

class AddOrderPage extends StatefulWidget {
  AddOrderPage({Key key}) : super(key: key);

  static final String routeName = '/order/add';

  @override
  _AddOrderPageState createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  final _formKey = GlobalKey<FormState>();

  List<ItemRow> _itemRows = [];
  List<Item> _items = [];
  Order _order = Order(
    id: "ORDER_ID",
    items: {},
  );
  bool _isLoading = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    _fetchItems();
    super.initState();
  }

  void _fetchItems() async {
    setState(() {
      _isLoading = true;
    });
    _items = await ItemAPI.getAll();
    setState(() {
      _isLoading = false;
    });
  }

  Widget _renderHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Place Order",
          style: TextStyle(
            color: Colors.black,
            fontSize: 32.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _renderLoading() {
    return CircularProgressIndicator();
  }

  Widget _renderForm() {
    if (_isLoading) {
      return _renderLoading();
    }

    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ..._itemRows,
              SizedBox(height: 20.0),
              FlatButton.icon(
                textColor: Colors.blue,
                icon: Icon(Icons.add),
                label: Text("Add item"),
                onPressed: () {
                  setState(() {
                    _itemRows.add(ItemRow(
                      items: _items,
                    ));
                  });
                },
              ),
              SizedBox(height: 20.0),
              ButtonTheme(
                minWidth: 200.0,
                height: 50.0,
                child: RaisedButton(
                  color: Colors.blue,
                  textColor: Colors.white,
                  child: Text("Submit"),
                  onPressed: () async {
                    if (_isSubmitting) return;
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        _isSubmitting = true;
                      });
                      _formKey.currentState.save();
                      await OrderAPI.add(_order);
                      Navigator.of(context).pop(_order);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 30.0,
              horizontal: screenWidth * 0.2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _renderHeader(),
                SizedBox(height: 10.0),
                _renderForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
