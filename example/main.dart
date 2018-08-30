import 'dart:async';
import '../lib/composite_subscription.dart';

main() {
  var numbers       = new StreamController();
  var letters       = new StreamController();
  var fruits        = new StreamController();
  var subscriptions = new CompositeSubscription();
  var numberSub     = numbers.stream.listen(print);
  var letterSub     = letters.stream.listen(print);
  var fruitSub      = fruits.stream.listen(print);

  // add the subscriptions to the composite
  subscriptions.add(numberSub);
  subscriptions.add(letterSub);
  subscriptions.add(fruitSub);

  // pump some data through these streams
  numbers.add(1);
  letters.add('a');
  fruits.add('Apples');
  numbers.add(2);
  letters.add('b');
  fruits.add('Oranges');

  // remove the fruit subscription from the composite
  subscriptions.remove(fruitSub);

  numbers.add(3);
  letters.add('c');
  fruits.add('Kiwis');

  // close the fruit stream
  fruits.close();

  // cancel the composite subscription
  subscriptions.cancel();

  // attempt to push addition data through
  numbers.add(4);
  letters.add('d');
  numbers.add(5);
  letters.add('e');

  // finalize the streams
  numbers.close();
  letters.close();
}