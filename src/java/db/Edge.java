package db;

public class Edge
{
	private final int idr;

	private final float distance;

	private final int traffic;

	public Edge(int idr, float distance, int traffic)
	{
		this.idr = idr;
		this.traffic = traffic;
		this.distance = distance;
	}

	public int getIdr()
	{
		return idr;
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
