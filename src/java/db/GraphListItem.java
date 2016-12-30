package db;

public class GraphListItem
{
	private final float distance;

	private final int traffic;

        // Start point
	private String startNodeName;

        // Destination point
        private String destinationNodeName;
        
        private int startNodeID;
        
        private int destinationNodeID;
        
        private int edgeID;

	public GraphListItem(float distance, int traffic, int startNodeID, int destinationNodeID,
                                    String startNodeName,
                                    String destinationNodeName, int edgedID)
	{
            this.distance = distance;
            this.traffic = traffic;
            this.startNodeID = startNodeID;
            this.destinationNodeID = destinationNodeID;
            this.startNodeName = startNodeName;
            this.destinationNodeName = destinationNodeName;
            this.edgeID = edgedID;
	}

    public float getDistance() 
    {
        return distance;
    }

    public int getEdgeID() {
        return edgeID;
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
    
    public int getStartNodeID()
    {
        return startNodeID;
    }

    public int getDestinationNodeID()
    {
        return destinationNodeID;
    }

    public void setDestinationNodeID(int destinationNodeID) {
        this.destinationNodeID = destinationNodeID;
    }

    public void setDestinationNodeName(String destinationNodeName) {
        this.destinationNodeName = destinationNodeName;
    }

    public void setStartNodeID(int startNodeID) {
        this.startNodeID = startNodeID;
    }

    public void setStartNodeName(String startNodeName) {
        this.startNodeName = startNodeName;
    }
}
