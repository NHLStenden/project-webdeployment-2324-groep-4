using BlazorBrandstof.Models;
using Dapper;
using MySqlConnector;

namespace BlazorBrandstof.Repositories;

public class RoundRepo
{
    private static readonly string ConnectionString =
        ConfigurationHelper.Configuration.GetConnectionString("brandstof")!;
    
    public static IEnumerable<Round> GetAll()
    {
        using var connection = new MySqlConnection(ConnectionString);
        
        //const string sql = "select * from rounds";
        
        var sql = @"SELECT r.RoundId, Status, OrderId, p.ProductId, Name, Price, CategoryId
                FROM Rounds r
                INNER JOIN product_round pr ON pr.RoundId = r.RoundId
                INNER JOIN products p ON p.ProductId = pr.ProductId";
				
        var rounds = connection.Query<Round, Product, Round>(sql, (round, product) => {
            round.Products.Add(product);
            return round;
        }, splitOn: "OrderId");
	
        var result = rounds.GroupBy(r => r.OrderId).Select(g =>
        {
            var groupedRound = g.First();
            groupedRound.Products = g.Select(r => r.Products.Single()).ToList();
            return groupedRound;
        });

        foreach(var round in result)
        {
            Console.Write($"{round.RoundId}: ");
		
            foreach(var product in round.Products)
            {
                Console.Write($" {product.Name} ");
            }
		
            Console.Write(Environment.NewLine);
        }
        
        return result;
    }

    public static Round? GetById(int id)
    {
        using var connection = new MySqlConnection(ConnectionString);
        
        const string sql = "select * from rounds where RoundId = @Id";
        var result = connection.QueryFirstOrDefault<Round>(sql, new { Id = id });

        return result;
    }

    public static Round? Add(Round round)
    {
        using var connection = new MySqlConnection(ConnectionString);

        const string sql = @"
            insert into rounds (Status, OrderId) values (@Status, @OrderId);
            select LAST_INSERT_ID();
        ";
        
        var newId = connection.ExecuteScalar<int>(sql, round);

        foreach (var product in round.Products)
        {
            const string sql_products = @"insert into product_round (ProductId, RoundId, Amount) values (@ProductId, @RoundId, @Amount)";

            connection.Execute(sql_products, new { ProductId = product.ProductId, RoundId = newId, Amount = 1, });
        }

        return GetById(newId);
    }

    public static void Remove(Round round)
    {
        using var connection = new MySqlConnection(ConnectionString);

        const string sql = "delete from rounds where RoundId = @RoundId";
        var numEffectedRows = connection.Execute(sql, round);
    }
    
    public static void Update(Round round)
    {
        using var connection = new MySqlConnection(ConnectionString);

        const string sql = "update rounds set Status = @Status, OrderId = @OrderId where RoundId = @RoundId";
        var numEffectedRows = connection.Execute(sql, round);

        var productIdAmountDictionary = round.Products.GroupBy(item => item.ProductId)
            .ToDictionary(group => group.Key, group => group.Count());
        
        foreach (var pair in productIdAmountDictionary)
        {
            const string insert = @"insert into product_round (ProductId, RoundId, Amount) values (@ProductId, @RoundId, @Amount)";
            
            connection.Execute(insert, new { ProductId = pair.Key, RoundId = round.RoundId, Amount = pair.Value, });
        }
    }
}