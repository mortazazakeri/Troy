package db;

import java.util.List;

public class Node extends ODBClass
{
	private int id;

	private String name;

	private int latitude;

	private int langtitude;

	private List<Integer> driversIDs;

	public Node(int id, String name, int latitude, int langtitude,
			List<Integer> driversIDs)
	{
		this.id = id;
		this.driversIDs = driversIDs;
		this.langtitude = langtitude;
		this.latitude = latitude;
		this.name = name;
	}

	public List<Integer> getDriversIDs()
	{
		return driversIDs;
	}

	public int getId()
	{
		return id;
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
