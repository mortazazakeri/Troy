package db;

public class Person
{
	private final String name;

	private final String userName;

	private final String password;

	public Person(String name, String userName, String password)
	{
		this.name = name;
		this.password = password;
		this.userName = userName;
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
