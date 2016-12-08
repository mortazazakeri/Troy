package db;

public class User extends ODBClass
{
	private int id;

	private String name;

	private String userName;

	private String password;

	public User(int id, String name, String userName, String password)
	{
		this.id = id;
		this.name = name;
		this.password = password;
		this.userName = userName;
	}

	public int getId()
	{
		return id;
	}

	public String getName()
	{
		return name;
	}

	public String getPassword()
	{
		return password;
	}

	public String getUserName()
	{
		return userName;
	}
}
