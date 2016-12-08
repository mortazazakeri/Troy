package db;

import java.util.ArrayList;
import java.util.List;


import com.orientechnologies.orient.core.db.document.ODatabaseDocumentTx;
import com.orientechnologies.orient.core.record.impl.ODocument;
import com.orientechnologies.orient.core.sql.OCommandSQL;
import com.orientechnologies.orient.core.sql.query.OSQLSynchQuery;
import com.tinkerpop.blueprints.Vertex;
import com.tinkerpop.blueprints.impls.orient.OrientEdge;
import com.tinkerpop.blueprints.impls.orient.OrientGraph;

@SuppressWarnings("unchecked")
public class ODBClass
{

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

    @SuppressWarnings("resource")
    public ODBClass()
    {
        graphDB = new OrientGraph(DBADDRESS + "/" + DBNAME);
        docDB = new ODatabaseDocumentTx(DBADDRESS + "/" + DBNAME).open("root",
                "123456");
    }

    public void insertDriver(int licenseNumber, int userID, int vehicleID)
    {
        ODocument driverDoc = new ODocument(DRIVER);
        driverDoc.field("licence_number", licenseNumber);
        driverDoc.field("user_id", userID);
        driverDoc.field("vehicle_id", vehicleID);
        driverDoc.save();
    }

    public Driver readDriver(int userID)
    {
        OSQLSynchQuery<ODocument> query = new OSQLSynchQuery<ODocument>(
                "SELECT FROM " + DRIVER + " WHERE user_id = ?");
        try
        {
            List<ODocument> result = docDB.command(query).execute(userID);
            return new Driver((int)result.get(0).field("user_id"),
                    (int)result.get(0).field("licence_number"),
                    (int)result.get(0).field("vehicle_id"));
        } catch (Exception e)
        {
            return null;
        }
    }

    public List<Driver> readAllDrivers()
    {
        List<Driver> drivers = new ArrayList<>();
        OSQLSynchQuery<ODocument> query = new OSQLSynchQuery<ODocument>(
                "SELECT FROM " + DRIVER);
        try
        {
            List<ODocument> result = docDB.command(query).execute();
            for (ODocument document : result)
            {
                drivers.add(new Driver(document.field("user_id"),
                        document.field("licence_number"),
                        document.field("vehicle_id")));
            }
            return drivers;
        } catch (Exception e)
        {
            return null;
        }
    }

    public void updateDriver(int licenseNumber, int userID, int vehicleID)
    {
        OCommandSQL query = new OCommandSQL("UPDATE " + DRIVER
                + " SET licence_number = ? " + " WHERE user_id = ?");
        docDB.command(query).execute(licenseNumber, userID);
        query = new OCommandSQL("UPDATE " + DRIVER + " SET vehicle_id = ? "
                + " WHERE user_id = ?");
        docDB.command(query).execute(vehicleID, userID);
    }

    public void deleteDriver(int userID)
    {
        OCommandSQL query = new OCommandSQL(
                "DELETE FROM " + DRIVER + " WHERE user_id = ?");
        docDB.command(query).execute(userID);
    }

    public void insertEdge(int id, float distance, int traffic, int startNodeID,
            int endNodeID)
    {
        graphDB.command(new OCommandSQL("CREATE EDGE " + EDGE
                + " FROM (SELECT FROM " + NODE
                + " WHERE idr = ?) TO (SELECT FROM " + NODE + " WHERE idr = ?)"
                + "SET idr = ?, traffic = ?, distance = ?"))
                .execute(startNodeID, endNodeID, id, traffic, distance);
    }

    public Edge readEdge(int id)
    {
        try
        {
            for (OrientEdge v : (Iterable<OrientEdge>) graphDB
                    .command(new OCommandSQL(
                                    "SELECT FROM " + EDGE + " WHERE idr = ?"))
                    .execute(id))
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

    public void updateEdge(int id, float distance, int traffic)
    {
        OCommandSQL query = new OCommandSQL("UPDATE " + EDGE
                + " SET distance = ?, traffic = ? " + " WHERE idr = ?");
        docDB.command(query).execute(distance, traffic, id);
    }

    public void deleteEdge(int id)
    {
        OCommandSQL query = new OCommandSQL(
                "DELETE EDGE " + EDGE + " WHERE idr = ?");
        docDB.command(query).execute(id);
    }

    public void insertNode(int id, String name, int latitude, int langtitude,
            List<Integer> driversIDs)
    {
        if (driversIDs == null)
        {
            driversIDs = new ArrayList<>();
        }
        Vertex v = graphDB.addVertex("class:" + NODE);
        v.setProperty("idr", id);
        v.setProperty("name", name);
        v.setProperty("lat", latitude);
        v.setProperty("lang", langtitude);
        v.setProperty("drivers_ids", driversIDs);
        graphDB.commit();
    }

    public Node readNode(int id)
    {
        try
        {
            for (Vertex v : (Iterable<Vertex>) graphDB
                    .command(new OCommandSQL(
                                    "SELECT FROM " + NODE + " WHERE idr = ?"))
                    .execute(id))
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

    public void updateNode(int id, String name, int latitude, int langtitude,
            List<Integer> driversIDs)
    {
        for (Vertex v : (Iterable<Vertex>) graphDB.command(
                new OCommandSQL("SELECT FROM " + NODE + " WHERE idr = ?"))
                .execute(id))
        {
            v.setProperty("idr", id);
            v.setProperty("name", name);
            v.setProperty("lat", latitude);
            v.setProperty("lang", langtitude);
            v.setProperty("drivers_ids", driversIDs);
        }
        graphDB.commit();
    }

    public void deleteNode(int id)
    {
        for (Vertex v : (Iterable<Vertex>) graphDB.command(
                new OCommandSQL("SELECT FROM " + NODE + " WHERE idr = ?"))
                .execute(id))
        {
            graphDB.removeVertex(v);
        }
        graphDB.commit();
    }

    public void insertTrip(String passengerName, int driverID, int startNodeID,
            int endNodeID)
    {
        ODocument driverDoc = new ODocument(TRIP);
        driverDoc.field("driver_id", driverID);
        driverDoc.field("end_node_id", endNodeID);
        driverDoc.field("passenger_name", passengerName);
        driverDoc.field("start_node_id", startNodeID);
        driverDoc.save();
    }

    public List<Trip> readPassengersTrips(String passengerName)
    {
        OSQLSynchQuery<ODocument> query = new OSQLSynchQuery<ODocument>(
                "SELECT FROM " + TRIP + " WHERE passenger_name = ?");
        try
        {
            List<ODocument> result = docDB.command(query)
                    .execute(passengerName);
            List<Trip> trips = new ArrayList<>();
            for (ODocument document : result)
            {
                trips.add(new Trip(document.field("passenger_name"),
                        document.field("driver_id"),
                        document.field("start_node_id"),
                        document.field("end_node_id")));
            }
            return trips;
        } catch (Exception e)
        {
            return null;
        }
    }

    public void insertUser(int id, String name, String userName,
            String password)
    {
        ODocument driverDoc = new ODocument(USER);
        driverDoc.field("idr", id);
        driverDoc.field("name", name);
        driverDoc.field("password", password);
        driverDoc.field("username", userName);
        driverDoc.save();
    }

    public User readUser(int id)
    {
        OSQLSynchQuery<ODocument> query = new OSQLSynchQuery<ODocument>(
                "SELECT FROM " + USER + " WHERE idr = ?");
        try
        {
            List<ODocument> result = docDB.command(query).execute(id);
            return new User((int)result.get(0).field("idr"),
                   (String) result.get(0).field("name"),
                    (String)result.get(0).field("username"),
                    (String)result.get(0).field("password"));
        } catch (Exception e)
        {
            return null;
        }
    }

    public List<User> readAllUsers()
    {
        List<User> users = new ArrayList<>();
        OSQLSynchQuery<ODocument> query = new OSQLSynchQuery<ODocument>(
                "SELECT FROM " + USER);
        try
        {
            List<ODocument> result = docDB.command(query).execute();
            for (ODocument document : result)
            {
                users.add(new User((int)result.get(0).field("idr"),
                       (String) document.field("name"),(String) document.field("username"),
                        (String) document.field("password")));
            }
            return users;
        } catch (Exception e)
        {
            return null;
        }
    }

    public void updateUser(int id, String name, String userName,
            String password)
    {
        OCommandSQL query = new OCommandSQL(
                "UPDATE " + USER + " SET name = ?, username = ?, password = ?"
                + " WHERE idr = ?");
        docDB.command(query).execute(name, userName, password, id);
    }

    public void deleteUser(int id)
    {
        OCommandSQL query = new OCommandSQL(
                "DELETE FROM " + USER + " WHERE idr = ?");
        docDB.command(query).execute(id);
    }

    public void insertManager(int id, String name, String userName,
            String password)
    {
        ODocument driverDoc = new ODocument(MANAGER);
        driverDoc.field("idr", id);
        driverDoc.field("name", name);
        driverDoc.field("password", password);
        driverDoc.field("username", userName);
        driverDoc.save();
    }

    public User readManager(int id)
    {
        OSQLSynchQuery<ODocument> query = new OSQLSynchQuery<ODocument>(
                "SELECT FROM " + MANAGER + " WHERE idr = ?");
        try
        {
            List<ODocument> result = docDB.command(query).execute(id);
            return new User((int)result.get(0).field("idr"),
                  (String)  result.get(0).field("name"),
                  (String) result.get(0).field("username"),
                  (String)  result.get(0).field("password"));
        } catch (Exception e)
        {
            return null;
        }
    }

    public List<User> readAllManagers()
    {
        List<User> users = new ArrayList<>();
        OSQLSynchQuery<ODocument> query = new OSQLSynchQuery<ODocument>(
                "SELECT FROM " + MANAGER);
        try
        {
            List<ODocument> result = docDB.command(query).execute();
            for (ODocument document : result)
            {
                users.add(new User((int)result.get(0).field("idr"),
                       (String) document.field("name"), (String)document.field("username"),
                       (String) document.field("password")));
            }
            return users;
        } catch (Exception e)
        {
            return null;
        }
    }

    public void updateManager(int id, String name, String userName,
            String password)
    {
        OCommandSQL query = new OCommandSQL("UPDATE " + MANAGER
                + " SET name = ?, username = ?, password = ?"
                + " WHERE idr = ?");
        docDB.command(query).execute(name, userName, password, id);
    }

    public void deleteManager(int id)
    {
        OCommandSQL query = new OCommandSQL(
                "DELETE FROM " + MANAGER + " WHERE idr = ?");
        docDB.command(query).execute(id);
    }

    public void insertVehicle(String color, int id, int pelak, int type)
    {
        ODocument driverDoc = new ODocument(VEHICLE);
        driverDoc.field("color", color);
        driverDoc.field("idr", id);
        driverDoc.field("pelak", pelak);
        driverDoc.field("type", type);
        driverDoc.save();
    }

    public Vehicle readVehicle(int id)
    {
        OSQLSynchQuery<ODocument> query = new OSQLSynchQuery<ODocument>(
                "SELECT FROM " + VEHICLE + " WHERE idr = ?");
        try
        {
            List<ODocument> result = docDB.command(query).execute(id);
            return new Vehicle((String)result.get(0).field("color"),
                   (int) result.get(0).field("idr"), (int)result.get(0).field("pelak"),
                   (int) result.get(0).field("type"));
        } catch (Exception e)
        {
            return null;
        }
    }

    public List<Vehicle> readAllVehicles()
    {
        List<Vehicle> vehicles = new ArrayList<>();
        OSQLSynchQuery<ODocument> query = new OSQLSynchQuery<ODocument>(
                "SELECT FROM " + VEHICLE);
        try
        {
            List<ODocument> result = docDB.command(query).execute();
            for (ODocument document : result)
            {
                vehicles.add(new Vehicle(document.field("color"),
                        document.field("idr"), document.field("pelak"),
                        document.field("type")));
            }
            return vehicles;
        } catch (Exception e)
        {
            return null;
        }
    }

    public void updateVehicle(String color, int id, int pelak, int type)
    {
        OCommandSQL query = new OCommandSQL("UPDATE " + VEHICLE
                + " SET color = ?, pelak = ?, type = ?" + " WHERE idr = ?");
        docDB.command(query).execute(color, pelak, type, id);
    }

    public void deleteVehicle(int id)
    {
        OCommandSQL query = new OCommandSQL(
                "DELETE FROM " + VEHICLE + " WHERE idr = ?");
        docDB.command(query).execute(id);
    }

    public void closeDB()
    {
        graphDB.shutdown();
        docDB.close();
    }
}
