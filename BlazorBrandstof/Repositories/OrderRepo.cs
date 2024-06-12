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
        var orders = connection.Query<Order>(sql).ToList();
        
        foreach (var order in orders)
        {
            const string sqlRounds = "select * from rounds where OrderId = @OrderId";
            var rounds = RoundRepo.GetAll().Where(o => o.OrderId == order.OrderId);
            
            order.Rounds.AddRange(rounds);
        }

        return orders;
    }

    public static Order? GetById(int id)
    {
        using var connection = new MySqlConnection(ConnectionString);
        
        const string sql = "select * from orders where OrderId = @Id";
        var order = connection.QueryFirstOrDefault<Order>(sql, new { Id = id });
        
        const string sqlRounds = "select * from rounds where OrderId = @OrderId";
        var rounds = connection.Query<Round>(sqlRounds, new { OrderId = id });
            
        order?.Rounds.AddRange(rounds);

        return order;
    }

    public static Order? GetByTableId(int id)
    {
        using var connection = new MySqlConnection(ConnectionString);
        
        const string sql = "select * from orders where TableId = @Id and Status != 'Paid'";
        var order = connection.QueryFirstOrDefault<Order>(sql, new { Id = id });

        if (order != null)
        {
            const string sqlRounds = "select * from rounds where OrderId = @OrderId";
            var rounds = connection.Query<Round>(sqlRounds, new { OrderId = order.OrderId });
            
            order?.Rounds.AddRange(rounds);
        }

        return order;
    }
    
    public static Order Add(Order order)
    {
        using var connection = new MySqlConnection(ConnectionString);

        const string sql = "insert into orders (Timestamp, TableId, WaiterName, Status) values (@Timestamp, @TableId, @WaiterName, @Status); SELECT LAST_INSERT_ID();";
        
        var newId = connection.ExecuteScalar<int>(sql, order);
        return GetById(newId)!;
    }

    public static void Remove(Order order)
    {
        using var connection = new MySqlConnection(ConnectionString);

        const string sql = "delete from orders where OrderId = @Id";
        var numEffectedRows = connection.Execute(sql, order);
    }
    
    public static void Update(Order order)
    {
        using var connection = new MySqlConnection(ConnectionString);

        const string sql = "update orders set Status = @Status where OrderId = @OrderId";
        var numEffectedRows = connection.Execute(sql, new { Status = order.Status, OrderId = order.OrderId });
    }
}