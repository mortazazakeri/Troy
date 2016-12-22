package db;

public class GraphListItem
{
	private final float distance;

	private final int traffic;

        // Start point
	private String startNodeName;

        // Destination point
        private String destinationNodeName;

	public GraphListItem(float distance, int traffic,
                                    String startNodeName,
                                    String destinationNodeName)
	{
            this.distance = distance;
            this.traffic = traffic;
            this.startNodeName = startNodeName;
            this.destinationNodeName = destinationNodeName;
	}

    public float getDistance() 
    {
        return distance;
    }

    public int getTraffic() 
    {
        return traffic;
    }

    public String getStartNodeName() 
    {
        return startNodeName;
    }

    public String getDestinationNodeName() 
    {
        return destinationNodeName;
    }
    
    public void setStartNodeName(String name)
    {
        this.startNodeName = name;
    }
    
    public void setDestinationNodeName(String name)
    {
        this.destinationNodeName = name;
    }
}
