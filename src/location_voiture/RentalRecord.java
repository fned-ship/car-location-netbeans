package location_voiture;

public class RentalRecord {
    private String carReg;
    private int totalDuration;

    public RentalRecord(String carReg, int totalDuration) {
        this.carReg = carReg;
        this.totalDuration = totalDuration;
    }

    public String getCarReg() {
        return carReg;
    }

    public int getTotalDuration() {
        return totalDuration;
    }
}
