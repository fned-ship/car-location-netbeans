package location_voiture;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RentalDetails {
    public static String getRentalDetails(int customerId) {
        String sql = "SELECT get_customer_rental_details(?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            
            // Execute the query and get the result
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getString(1); // The result of the function will be in the first column
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
