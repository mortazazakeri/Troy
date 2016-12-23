package db;

import com.orientechnologies.orient.core.command.script.OCommandFunction;
import java.util.ArrayList;
import java.util.List;
import com.orientechnologies.orient.core.db.document.ODatabaseDocumentTx;
import com.orientechnologies.orient.core.metadata.function.OFunction;
import com.orientechnologies.orient.core.record.impl.ODocument;
import com.orientechnologies.orient.core.sql.OCommandSQL;
import com.orientechnologies.orient.core.sql.query.OSQLSynchQuery;
import com.tinkerpop.blueprints.Vertex;
import com.tinkerpop.blueprints.impls.orient.OrientEdge;
import com.tinkerpop.blueprints.impls.orient.OrientGraph;
import com.orientechnologies.orient.core.metadata.sequence.OSequence;
import com.orientechnologies.orient.core.sql.OCommandSQLResultset;
import com.orientechnologies.orient.core.sql.functions.OSQLFunction;
import com.orientechnologies.orient.core.sql.query.OSQLQuery;
import com.tinkerpop.blueprints.impls.orient.OrientDynaElementIterable;
import com.tinkerpop.blueprints.impls.orient.OrientElementIterable;
import com.tinkerpop.blueprints.impls.orient.OrientVertex;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.logging.Handler;

@SuppressWarnings("unchecked")
public class ODBClass
{

    private static ODBClass odbclassInstance = null;

    private final String EDGE = "DBEdge";
    private final String DRIVER = "Driver";
    private final String MANAGER = "Manager";
    private final String NODE = "Node";
    private final String TRIP = "Trip";
    private final String USER = "User";
    private final String VEHICLE = "Vehicle";
    private final String DBADDRESS = "remote:localhost";
    private final String DBNAME = "Taxi";
    private OrientGraph graphDB;
    private ODatabaseDocumentTx docDB;
    private final OSequence nodeseq, dbedgeseq, vehicleseq;
    private Handler handler;

    @SuppressWarnings("resource")
    private ODBClass()
    {
        docDB = new ODatabaseDocumentTx(DBADDRESS + "/" + DBNAME).open("admin", "admin");
        graphDB = new OrientGraph(DBADDRESS + "/" + DBNAME);
        nodeseq = graphDB.getRawGraph().getMetadata().getSequenceLibrary().getSequence("nodeseq");
        dbedgeseq = graphDB.getRawGraph().getMetadata().getSequenceLibrary().getSequence("dbedgeseq");
        vehicleseq = graphDB.getRawGraph().getMetadata().getSequenceLibrary().getSequence("vehicleseq");

    }

    public static ODBClass getInstance()
    {
        if (odbclassInstance == null)
        {
            odbclassInstance = new ODBClass();
        }
        return odbclassInstance;
    }

    public void insertDriver(String name, String userName,
            String password, int licenseNumber, int vehicleID)
    {
        ODocument driverDoc = new ODocument(DRIVER);
        driverDoc.field("name", name);
        driverDoc.field("password", password);
        driverDoc.field("username", userName);
        driverDoc.field("license_number", licenseNumber);
        driverDoc.field("vehicle_id", vehicleID);
        driverDoc.save();
    }

    public Driver readDriver(String username)
    {
        OSQLSynchQuery<ODocument> query = new OSQLSynchQuery<>(
                "SELECT FROM " + DRIVER + " WHERE username = ?");
        try
        {
            docDB.activateOnCurrentThread();
            List<ODocument> result = docDB.command(query).execute(username);
            return new Driver(
                    (String) result.get(0).field("name"),
                    (String) result.get(0).field("username"),
                    (String) result.get(0).field("password"),
                    (int) result.get(0).field("license_number"),
                    (int) result.get(0).field("vehicle_id"));
        } catch (Exception e)
        {
            return null;
        }
    }

    public List<Driver> readAllDrivers()
    {
        List<Driver> drivers = new ArrayList<>();
        OSQLSynchQuery<ODocument> query = new OSQLSynchQuery<>(
                "SELECT FROM " + DRIVER);
        try
        {
            docDB.activateOnCurrentThread();
            List<ODocument> result = docDB.command(query).execute();
            result.forEach((document) ->
            {
                drivers.add(
                        new Driver(document.field("name"),
                                document.field("username"),
                                document.field("password"),
                                document.field("license_number"),
                                document.field("vehicle_id")));
            });
            return drivers;
        } catch (Exception e)
        {
            return null;
        }
    }

    public void updateDriver(String name, String userName,
            String password, int licenseNumber, int vehicleID)
    {
        OCommandSQL query = new OCommandSQL("UPDATE " + DRIVER
                + " SET name = ?, password = ?"
                + ", license_number = ?, vehicle_id = ?"
                + " WHERE username = ?");
        docDB.activateOnCurrentThread();
        docDB.command(query).execute(name, password, licenseNumber, vehicleID, userName);
    }

    public void deleteDriver(String userName)
    {
        OCommandSQL query = new OCommandSQL(
                "DELETE FROM " + DRIVER + " WHERE username = ?");
        docDB.activateOnCurrentThread();
        docDB.command(query).execute(userName);
    }

    public void insertEdge(float distance, int traffic, int startNodeID,
            int endNodeID)
    {
        graphDB.command(new OCommandSQL("CREATE EDGE " + EDGE
                + " FROM (SELECT FROM " + NODE
                + " WHERE idr = ?) TO (SELECT FROM " + NODE + " WHERE idr = ?)"
                + "SET idr = ?, traffic = ?, distance = ?"))
                .execute(startNodeID, endNodeID, dbedgeseq.next(), traffic, distance);
        graphDB.commit();
    }

    public Edge readEdge(int idr)
    {
        try
        {
            for (OrientEdge v : (Iterable<OrientEdge>) graphDB
                    .command(new OCommandSQL(
                                    "SELECT FROM " + EDGE + " WHERE idr = ?"))
                    .execute(idr))
            {
                return new Edge(v.getProperty("idr"), v.getProperty("distance"),
                        v.getProperty("traffic"));
            }
        } catch (Exception e)
        {
        }
        return null;
    }

    public List<Edge> readAllEdges()
    {
        List<Edge> edges = new ArrayList<>();
        try
        {
            for (OrientEdge v : (Iterable<OrientEdge>) graphDB
                    .command(new OCommandSQL("SELECT FROM " + EDGE)).execute())
            {
                edges.add(new Edge(v.getProperty("idr"),
                        v.getProperty("distance"), v.getProperty("traffic")));
            }
            return edges;
        } catch (Exception e)
        {
            return null;
        }
    }

    public List<GraphListItem> getGraphForDrawing()
    {
        List<GraphListItem> result = new ArrayList<>();
        for (OrientEdge v : (Iterable<OrientEdge>) graphDB
                .command(new OCommandSQL("SELECT FROM " + EDGE)).execute())
        {
            String out = v.getProperty("out").toString().split("\\[")[1];
            out = out.substring(0, out.length() - 1);
            String in = v.getProperty("in").toString().split("\\[")[1];
            in = in.substring(0, in.length() - 1);
            result.add(new GraphListItem(v.getProperty("distance"),
                    v.getProperty("traffic"),
                    out,
                    in));
        }
        for (int i = 0; i <= result.size() - 1; i++)
        {
            for (Vertex v : (Iterable<Vertex>) graphDB.command(
                    new OCommandSQL("SELECT FROM " + NODE + " WHERE @rid = ?")).execute(result.get(i).getStartNodeName()))
            {
                result.get(i).setStartNodeName(v.getProperty("name"));
            }
            for (Vertex v : (Iterable<Vertex>) graphDB.command(
                    new OCommandSQL("SELECT FROM " + NODE + " WHERE @rid = ?")).execute(result.get(i).getDestinationNodeName()))
            {
                result.get(i).setDestinationNodeName(v.getProperty("name"));
            }
        }
        return result;
    }

    public void updateEdge(int idr, float distance, int traffic)
    {
        OCommandSQL query = new OCommandSQL("UPDATE " + EDGE
                + " SET distance = ?, traffic = ? " + " WHERE idr = ?");
        docDB.activateOnCurrentThread();
        docDB.command(query).execute(distance, traffic, idr);
        docDB.commit();
    }

    public void deleteEdge(int idr)
    {
        OCommandSQL query = new OCommandSQL(
                "DELETE EDGE " + EDGE + " WHERE idr = ?");
        docDB.activateOnCurrentThread();
        docDB.command(query).execute(idr);
        docDB.commit();
    }

    public void insertNode(String name, int latitude, int langtitude,
            List<Integer> driversIDs)
    {
        if (driversIDs == null)
        {
            driversIDs = new ArrayList<>();
        }
        Vertex v = graphDB.addVertex("class:" + NODE);
        v.setProperty("idr", nodeseq.next());
        v.setProperty("name", name);
        v.setProperty("lat", latitude);
        v.setProperty("lang", langtitude);
        v.setProperty("drivers_ids", driversIDs);
        graphDB.commit();
    }

    public Node readNode(int idr)
    {
        try
        {
            for (Vertex v : (Iterable<Vertex>) graphDB
                    .command(new OCommandSQL(
                                    "SELECT FROM " + NODE + " WHERE idr = ?"))
                    .execute(idr))
            {
                return new Node(v.getProperty("idr"), v.getProperty("name"),
                        v.getProperty("lat"), v.getProperty("lang"),
                        v.getProperty("drivers_ids"));
            }
        } catch (Exception e)
        {
        }
        return null;
    }

    public List<Node> readAllNodes()
    {
        List<Node> nodes = new ArrayList<>();
        try
        {
            for (Vertex v : (Iterable<Vertex>) graphDB
                    .command(new OCommandSQL("SELECT FROM " + NODE)).execute())
            {
                nodes.add(new Node(v.getProperty("idr"), v.getProperty("name"),
                        v.getProperty("lat"), v.getProperty("lang"),
                        v.getProperty("drivers_ids")));
            }
            return nodes;
        } catch (Exception e)
        {
            return null;
        }
    }

    public void updateNode(int idr, String name, int latitude, int langtitude,
            List<Integer> driversIDs)
    {
        if (driversIDs == null)
        {
            driversIDs = new ArrayList<>();
        }
        for (Vertex v : (Iterable<Vertex>) graphDB.command(
                new OCommandSQL("SELECT FROM " + NODE + " WHERE idr = ?"))
                .execute(idr))
        {
            v.setProperty("idr", idr);
            v.setProperty("name", name);
            v.setProperty("lat", latitude);
            v.setProperty("lang", langtitude);
            v.setProperty("drivers_ids", driversIDs);
        }
        graphDB.commit();
    }

    public void deleteNode(int idr)
    {
        for (Vertex v : (Iterable<Vertex>) graphDB.command(
                new OCommandSQL("SELECT FROM " + NODE + " WHERE idr = ?"))
                .execute(idr))
        {
            graphDB.removeVertex(v);
        }
        graphDB.commit();
    }

    public void insertTrip(String passengerName, String driverUserName, int startNodeID,
            int endNodeID)
    {
        ODocument driverDoc = new ODocument(TRIP);
        driverDoc.field("driver_id", driverUserName);
        driverDoc.field("end_node_id", endNodeID);
        driverDoc.field("passenger_name", passengerName);
        driverDoc.field("start_node_id", startNodeID);
        driverDoc.save();
    }

    public List<Trip> readPassengersTrips(String passengerName)
    {
        OSQLSynchQuery<ODocument> query = new OSQLSynchQuery<>(
                "SELECT FROM " + TRIP + " WHERE passenger_name = ?");
        try
        {
            docDB.activateOnCurrentThread();
            List<ODocument> result = docDB.command(query)
                    .execute(passengerName);
            List<Trip> trips = new ArrayList<>();
            result.forEach((document) ->
            {
                trips.add(new Trip(document.field("passenger_name"),
                        document.field("driver_id"),
                        document.field("start_node_id"),
                        document.field("end_node_id")));
            });
            return trips;
        } catch (Exception e)
        {
            return null;
        }
    }

    public void insertUser(String name, String userName,
            String password)
    {
        ODocument driverDoc = new ODocument(USER);
        driverDoc.field("name", name);
        driverDoc.field("password", password);
        driverDoc.field("username", userName);
        driverDoc.save();
    }

    public User readUser(String userName)
    {
        OSQLSynchQuery<ODocument> query = new OSQLSynchQuery<>(
                "SELECT FROM " + USER + " WHERE username = ?");
        try
        {
            docDB.activateOnCurrentThread();
            List<ODocument> result = docDB.command(query).execute(userName);
            return new User((String) result.get(0).field("name"),
                    (String) result.get(0).field("username"),
                    (String) result.get(0).field("password"));
        } catch (Exception e)
        {
            return null;
        }
    }

    public List<User> readAllUsers()
    {
        List<User> users = new ArrayList<>();
        OSQLSynchQuery<ODocument> query = new OSQLSynchQuery<>(
                "SELECT FROM " + USER);
        try
        {
            docDB.activateOnCurrentThread();
            List<ODocument> result = docDB.command(query).execute();
            result.forEach((document) ->
            {
                users.add(new User(document.field("name"), document.field("username"),
                        document.field("password")));
            });
            return users;
        } catch (Exception e)
        {
            return null;
        }
    }

    public void updateUser(String name, String userName, String password)
    {
        OCommandSQL query = new OCommandSQL(
                "UPDATE " + USER + " SET name = ?, password = ?"
                + " WHERE username = ?");
        docDB.activateOnCurrentThread();
        docDB.command(query).execute(name, password, userName);
    }

    public void deleteUser(String userName)
    {
        OCommandSQL query = new OCommandSQL(
                "DELETE FROM " + USER + " WHERE username = ?");
        docDB.activateOnCurrentThread();
        docDB.command(query).execute(userName);
    }

    public void insertManager(String name, String userName,
            String password)
    {
        ODocument driverDoc = new ODocument(MANAGER);
        driverDoc.field("name", name);
        driverDoc.field("password", password);
        driverDoc.field("username", userName);
        driverDoc.save();
    }

    public Manager readManager(String userName)
    {
        OSQLSynchQuery<ODocument> query = new OSQLSynchQuery<>(
                "SELECT FROM " + MANAGER + " WHERE username = ?");
        try
        {
            docDB.activateOnCurrentThread();
            List<ODocument> result = docDB.command(query).execute(userName);
            return new Manager((String) result.get(0).field("name"),
                    (String) result.get(0).field("username"),
                    (String) result.get(0).field("password"));
        } catch (Exception e)
        {
            return null;
        }
    }

    public List<Manager> readAllManagers()
    {
        List<Manager> users = new ArrayList<>();
        OSQLSynchQuery<ODocument> query = new OSQLSynchQuery<>(
                "SELECT FROM " + MANAGER);
        try
        {
            docDB.activateOnCurrentThread();
            List<ODocument> result = docDB.command(query).execute();
            result.forEach((document) ->
            {
                users.add(new Manager(document.field("name"), document.field("username"),
                        document.field("password")));
            });
            return users;
        } catch (Exception e)
        {
            return null;
        }
    }

    public void updateManager(String name, String userName, String password)
    {
        OCommandSQL query = new OCommandSQL("UPDATE " + MANAGER
                + " SET name = ?, password = ?"
                + " WHERE username = ?");
        docDB.activateOnCurrentThread();
        docDB.command(query).execute(name, password, userName);
    }

    public void deleteManager(String userName)
    {
        OCommandSQL query = new OCommandSQL(
                "DELETE FROM " + MANAGER + " WHERE username = ?");
        docDB.activateOnCurrentThread();
        docDB.command(query).execute(userName);
    }

    public void insertVehicle(String color, int pelak, int type)
    {
        ODocument driverDoc = new ODocument(VEHICLE);
        driverDoc.field("color", color);
        driverDoc.field("idr", vehicleseq.next());
        driverDoc.field("pelak", pelak);
        driverDoc.field("type", type);
        driverDoc.save();
    }

    public Vehicle readVehicle(int idr)
    {
        OSQLSynchQuery<ODocument> query = new OSQLSynchQuery<>(
                "SELECT FROM " + VEHICLE + " WHERE idr = ?");
        try
        {
            docDB.activateOnCurrentThread();
            List<ODocument> result = docDB.command(query).execute(idr);
            return new Vehicle(
                    (String) result.get(0).field("color"),
                    (int) result.get(0).field("idr"),
                    (int) result.get(0).field("pelak"),
                    (int) result.get(0).field("type"));
        } catch (Exception e)
        {
            return null;
        }
    }

    public List<Vehicle> readAllVehicles()
    {
        List<Vehicle> vehicles = new ArrayList<>();
        OSQLSynchQuery<ODocument> query = new OSQLSynchQuery<>(
                "SELECT FROM " + VEHICLE);
        try
        {
            docDB.activateOnCurrentThread();
            List<ODocument> result = docDB.command(query).execute();
            result.forEach((document) ->
            {
                vehicles.add(new Vehicle(document.field("color"),
                        document.field("idr"), document.field("pelak"),
                        document.field("type")));
            });
            return vehicles;
        } catch (Exception e)
        {
            return null;
        }
    }

    public void updateVehicle(String color, int idr, int pelak, int type)
    {
        OCommandSQL query = new OCommandSQL("UPDATE " + VEHICLE
                + " SET color = ?, pelak = ?, type = ?" + " WHERE idr = ?");
        docDB.activateOnCurrentThread();
        docDB.command(query).execute(color, pelak, type, idr);
    }

    public void deleteVehicle(int idr)
    {
        OCommandSQL query = new OCommandSQL(
                "DELETE FROM " + VEHICLE + " WHERE idr = ?");
        docDB.activateOnCurrentThread();
        docDB.command(query).execute(idr);
    }

    public List<String> getCheapestPath(int startNodeID, int destinationNodeID)
    {
        List<String> result = new ArrayList<>();
        String rid1 = ((Vertex) ((Iterable) graphDB.command(new OCommandSQL("SELECT FROM "
                + NODE + " WHERE idr = ?")).execute(startNodeID)).iterator().next()).getProperty("@rid").toString();
        rid1 = rid1.split("\\[")[1];
        rid1 = rid1.substring(0, rid1.length() - 1);

        String rid2 = ((Vertex) ((Iterable) graphDB.command(new OCommandSQL("SELECT FROM "
                + NODE + " WHERE idr = ?")).execute(destinationNodeID)).iterator().next()).getProperty("@rid").toString();
        rid2 = rid2.split("\\[")[1];
        rid2 = rid2.substring(0, rid2.length() - 1);

        Iterable i = graphDB.command(new OCommandSQL("SELECT dijkstra (" + rid1 + ", " + rid2 + ", 'distance').asString() FROM " + NODE))
                .execute();
        Vertex v = (Vertex) i.iterator().next();
        String t = v.getProperty("dijkstra").toString();
        t = t.substring(1, t.length() - 1);
        String[] split = t.split("\\,");
        for (String str : split)
        {
            str = str.split("\\[")[1];
            str = str.substring(0, str.length() - 1);
            Iterable it = (Iterable) (graphDB.command(new OCommandSQL("SELECT FROM "
                    + NODE + " WHERE @rid = " + str)).execute());
            Vertex vv = ((Vertex) (it.iterator().next()));
            result.add(vv.getProperty("name"));
        }
        return result;
    }

    public void closeDB()
    {
        graphDB.shutdown();
        docDB.activateOnCurrentThread();
        docDB.close();
    }
}
