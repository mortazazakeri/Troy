package db;

public class Vehicle
{
	private final String color;

	private final int idr;

	private final int pelak;

	private final int type;

	public Vehicle(String color, int idr, int pelak, int type)
	{
		this.color = color;
		this.idr = idr;
		this.pelak = pelak;
		this.type = type;
	}

	public String getColor()
	{
		return color;
	}

	public int getIdr()
	{
		return idr;
	}

	public int getPelak()
	{
		return pelak;
	}

	public int getType()
	{
		return type;
	}
}
