package location_voiture;

import java.util.List;

public class RentalDetailsTest {
    public static void main(String[] args) {
        // Call the getRentalDetails method from RentalDetails2 with customerId = 1
        List<RentalRecord> rentalDetails = RentalDetails2.getRentalDetails(1);

        // Check if there are any records and print them
        if (rentalDetails.isEmpty()) {
            System.out.println("No rental details found for customer ID 1");
        } else {
            for (RentalRecord record : rentalDetails) {
                System.out.println("Car Registration: " + record.getCarReg());
                System.out.println("Total Rental Duration: " + record.getTotalDuration() + " days");
                System.out.println("----------");
            }
        }
    }
}
