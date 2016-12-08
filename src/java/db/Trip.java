package db;

public class Trip extends ODBClass
{
	private String passengerName;

	private int driverID;

	private int startNodeID;

	private int endNodeID;

	public Trip(String passengerName, int driverID, int startNodeID,
			int endNodeID)
	{
		this.driverID = driverID;
		this.startNodeID = startNodeID;
		this.endNodeID = endNodeID;
		this.passengerName = passengerName;
	}

	public int getDriverID()
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
