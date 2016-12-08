package db;

public class Edge extends ODBClass
{
	private int id;

	private float distance;

	private int traffic;

	public Edge(int id, float distance, int traffic)
	{
		this.id = id;
		this.traffic = traffic;
		this.distance = distance;
	}

	public int getId()
	{
		return id;
	}

	public float getDistance()
	{
		return distance;
	}

	public int getTraffic()
	{
		return traffic;
	}
}
