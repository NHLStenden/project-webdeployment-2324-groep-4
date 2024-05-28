using BlazorBrandstof.Models;
using Dapper;
using MySqlConnector;

namespace BlazorBrandstof.Repositories;

public class OrderRepo
{
    private static readonly string ConnectionString =
        ConfigurationHelper.Configuration.GetConnectionString("brandstof")!;
    
    public static IEnumerable<Order> GetAll()
    {
        using var connection = new MySqlConnection(ConnectionString);
        
        const string sql = "select * from orders";
        var orders = connection.Query<Order>(sql);

        return orders;
    }

    public static Order? GetById(int id)
    {
        using var connection = new MySqlConnection(ConnectionString);
        
        const string sql = "select * from orders where OrderId = @Id";
        var Order = connection.QueryFirstOrDefault<Order>(sql, new { Id = id });

        return Order;
    }

    public static Order Add(Order Order)
    {
        using var connection = new MySqlConnection(ConnectionString);

        const string sql = "insert into orders (Timestamp, TableId, WaiterName) values (@Timestamp, @TableId, @WaiterName); SELECT LAST_INSERT_ID();";
        
        var newId = connection.ExecuteScalar<int>(sql, Order);
        return GetById(newId)!;
    }

    public static void Remove(Order Order)
    {
        using var connection = new MySqlConnection(ConnectionString);

        const string sql = "delete from orders where OrderId = @Id";
        var numEffectedRows = connection.Execute(sql, Order);
    }
}