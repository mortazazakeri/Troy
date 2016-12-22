package db;

public class Driver extends Person
{
	private final int licenseNumber;

	private final int vehicleID;

	public Driver(String name, String userName, String password, int licenseNumber, int vehicleID)
	{
                super(name, userName, password);
		this.licenseNumber = licenseNumber;
		this.vehicleID = vehicleID;
	}

	public int getLicenseNumber()
	{
		return licenseNumber;
	}
        
	public int getVehicle()
	{
		return vehicleID;
	}
}
