package db;

import java.util.List;

public class Node
{
	private final int idr;

	private final String name;

	private final int latitude;

	private final int langtitude;

	private final List<Integer> driversIDs;

	public Node(int idr, String name, int latitude, int langtitude,
			List<Integer> driversIDs)
	{
		this.idr = idr;
		this.driversIDs = driversIDs;
		this.langtitude = langtitude;
		this.latitude = latitude;
		this.name = name;
	}

	public List<Integer> getDriversIDs()
	{
		return driversIDs;
	}

	public int getIdr()
	{
		return idr;
	}

	public int getLangtitude()
	{
		return langtitude;
	}

	public int getLatitude()
	{
		return latitude;
	}

	public String getName()
	{
		return name;
	}
}
