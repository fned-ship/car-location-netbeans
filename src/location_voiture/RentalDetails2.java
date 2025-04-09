package location_voiture;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RentalDetails2 {

    public static List<RentalRecord> getRentalDetails(int customerId) {
        List<RentalRecord> rentalRecords = new ArrayList<>();

        // SQL query to call the PostgreSQL function
        String query = "SELECT * FROM get_customer_rental_details2(?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            // Set the customer_id parameter for the function
            stmt.setInt(1, customerId);

            // Execute the query
            try (ResultSet rs = stmt.executeQuery()) {
                // Loop through the results
                while (rs.next()) {
                    // Extract the results
                    String carReg = rs.getString("carReg");
                    int totalDuration = rs.getInt("total_duration");

                    // Create a RentalRecord object and add it to the list
                    rentalRecords.add(new RentalRecord(carReg, totalDuration));
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return rentalRecords;
    }
}
