package db;

public class Driver extends ODBClass
{
	private int userID;

	private int licenseNumber;

	private int vehicleID;

	public Driver(int userID, int licenseNumber, int vehicleID)
	{
		this.userID = userID;
		this.licenseNumber = licenseNumber;
		this.vehicleID = vehicleID;
	}

	public int getLicenseNumber()
	{
		return licenseNumber;
	}

	public int getUser()
	{
		return userID;
	}

	public int getVehicle()
	{
		return vehicleID;
	}
}
