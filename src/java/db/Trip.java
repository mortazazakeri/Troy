package db;

public class Trip
{

    private final String passengerName;

    private final String driverID;

    private final int startNodeID;

    private final int endNodeID;

    public Trip(String passengerName, String driverID, int startNodeID, int endNodeID)
    {
        this.driverID = driverID;
        this.startNodeID = startNodeID;
        this.endNodeID = endNodeID;
        this.passengerName = passengerName;
    }

    public String getDriverID()
    {
        return driverID;
    }

    public int getStartNodeID()
    {
        return startNodeID;
    }

    public int getEndNodeID()
    {
        return endNodeID;
    }

    public String getPassengerName()
    {
        return passengerName;
    }
}
