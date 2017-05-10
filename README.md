# Honeycomb Engineering Test - Makers Edition

## The brief

#### Product
The current API allows a user to add a material to an order, and specifying which and how the material is to be sent. It calculates the total cost of delivery and output's this as a printout to the CLI

#### Challenge

The challenge was to `Provide a means of defining and applying various discounts to the cost of delivering material to broadcasters.` and that `the solution to be flexible`.

## Approach

First I started with a test for a discount method that could be called in the order and wrote the appropriate code to pass the test. I then followed this up with tests and the necessary code, which would check that the specified discount in the brief were applied.

Once I had done this, TDD'ing all the way; I extracted these methods into a class so that when an order is created, a `Discount` object could be assigned to the order, which could be defined upon instantiation of the class, this covers where `flexible` requirement.

I updated the order class to pass the order items to the Discount class to allow it to calculate the required discount and return the amount of discount that that instance is set to apply.

This is then returned on the CLI output.

## Conclusion

I feel that I have fulfilled the draft, I have:
* `a mechanism for applying Discounts to orders`
* `a means of defining and applying various discounts`

All tests are passing.
