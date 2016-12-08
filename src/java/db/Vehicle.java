package db;

public class Vehicle extends ODBClass
{
	private String color;

	private int id;

	private int pelak;

	private int type;

	public Vehicle(String color, int id, int pelak, int type)
	{
		this.color = color;
		this.id = id;
		this.pelak = pelak;
		this.type = type;
	}

	public String getColor()
	{
		return color;
	}

	public int getId()
	{
		return id;
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
