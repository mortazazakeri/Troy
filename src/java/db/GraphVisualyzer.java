package db;

import db.Edge;
import db.Node;
import db.GraphListItem;
import net.sf.json.JSONObject;
import java.util.ArrayList;
import java.util.List;
import java.util.HashMap;
import java.util.Map;
import db.ODBClass;

import javax.security.auth.message.callback.PrivateKeyCallback;

/**
 *
 * @author Amirian
 */
public class GraphVisualyzer 
{
    
    List<Node> nodesList;
    List<GraphListItem> edgesList;
    
    public GraphVisualyzer()
    {
        nodesList = db.ODBClass.getInstance().readAllNodes();
        edgesList = db.ODBClass.getInstance().getGraphForDrawing();
    }
    
    
    private void reNewData()
    {
        nodesList.clear();
        edgesList.clear();
        nodesList = db.ODBClass.getInstance().readAllNodes();
        edgesList = db.ODBClass.getInstance().getGraphForDrawing();
    }
    
    
    /**
     * Create a list of strings, Strings are in Json format
     * @return the list
     */
    public List<String> getJsonDataInStringList()
    {
        reNewData();
        JSONObject jsonObj = new JSONObject();
        List<String> jsonDataStrings = new ArrayList<String>();
        List<String> Adjacencies = new ArrayList<String>();
        Map nodeData = new HashMap();
        
        for (Node node : nodesList) 
        {
            jsonObj.clear();
            Adjacencies.clear();
            jsonObj.accumulate("adjacencies", Adjacencies);

            nodeData.clear();
            nodeData.put("$color", "#C74243");
            nodeData.put("$type", "circle");
            nodeData.put("$dim", 10);
            jsonObj.put("data", nodeData);

            jsonObj.put("id", node.getName());
            jsonObj.put("name", node.getName());
            jsonDataStrings.add(jsonObj.toString());
        }


        for (GraphListItem edge : edgesList) 
        {
            jsonObj.clear();
            Adjacencies.clear();
            Adjacencies.add(edge.getDestinationNodeName());
            jsonObj.accumulate("adjacencies", Adjacencies);

            nodeData.clear();
            nodeData.put("$color", "#C74243");
            nodeData.put("$type", "circle");
            nodeData.put("$dim", 10);
            jsonObj.put("data", nodeData);

            jsonObj.put("id", edge.getStartNodeName());
            jsonObj.put("name", edge.getStartNodeName());

            jsonDataStrings.add(jsonObj.toString());
        }
        
        return jsonDataStrings;
    }
    
    public boolean isAlredyDefinedEdge(String startNodeName, String endNodeName)
    {
        reNewData();
        boolean replica = false;
        for (GraphListItem edge : edgesList) 
        {
            if (   (edge.getStartNodeName().equals(startNodeName) && edge.getDestinationNodeName().equals(endNodeName)) 
                || (edge.getStartNodeName().equals(endNodeName) && edge.getDestinationNodeName().equals(startNodeName))  ) 
            {
                replica = true;
                break;
            }
        }
        return replica;
    }
    
    /**
     * returns an array.
     * @return -1 if node name does not exist
     */
    public int[] getNodeIds(String startNodeName, String endNodeName)
    {
        reNewData();
        int[] nodeIDs = new int[2];
        nodeIDs[0] = -1;
        nodeIDs[1] = -1;
        for (Node node : nodesList) 
            {
                if (node.getName().equals(startNodeName) && nodeIDs[0] == -1) 
                {
                    if (node.getIdr() != nodeIDs[1]) 
                    {
                        nodeIDs[0] = node.getIdr();
                        continue;
                    }
                }

                else if (node.getName().equals(endNodeName)&& nodeIDs[1] == -1) 
                {
                    if (node.getIdr() != nodeIDs[0]) 
                    {
                        nodeIDs[1] = node.getIdr();
                        continue;
                    }
                }
            }
        
        return nodeIDs;
    }
    
    
    public boolean isAlredyDefinedNode(String nodeName)
    {
        reNewData();
        boolean replica = false;
        for(Node node : nodesList)
        {
            if (node.getName().equals(nodeName)) 
            {
                replica = true;
                break;
            }
        }
        return replica;
    }
    
    
}