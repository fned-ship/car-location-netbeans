package location_voiture;

public class Test {
    public static void main(String[] args) {
        int customerId = 1; // Example customer ID
        String rentalDetails = RentalDetails.getRentalDetails(customerId);
        
        if (rentalDetails != null) {
            System.out.println("Rental Details: \n" + rentalDetails);
        } else {
            System.out.println("No rental details found for customer ID " + customerId);
        }
    }
}
