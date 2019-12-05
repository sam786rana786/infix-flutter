class Fee{

  String _title;
  String _dueDate;
  String _amount;
  String _paid;
  String _balance;
  String _status;
  String _discount;
  String _fine;


  Fee(this._title, this._dueDate, this._amount, this._paid, this._balance,
      this._status, this._discount, this._fine);


  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get status => _status;

  set status(String value) {
    _status = value;
  }

  String get balance => _balance;

  set balance(String value) {
    _balance = value;
  }

  String get paid => _paid;

  set paid(String value) {
    _paid = value;
  }

  String get amount => _amount;

  set amount(String value) {
    _amount = value;
  }

  String get dueDate => _dueDate;

  set dueDate(String value) {
    _dueDate = value;
  }

  String get fine => _fine;

  set fine(String value) {
    _fine = value;
  }

  String get discount => _discount;

  set discount(String value) {
    _discount = value;
  }


}