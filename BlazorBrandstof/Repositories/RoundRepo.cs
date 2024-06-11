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
        
        // query een gecombineerde lijst van rounds, product_round, products
        const string sql = @"select * from rounds";
				
        var rounds = connection.Query<Round>(sql).ToList();

        foreach (var round in rounds)
        {
            const string sqlProducts = "select * from product_round where RoundId = @RoundId";

            var productsRound = connection.Query(sqlProducts, new { RoundId = round.RoundId});

            foreach (var entry in productsRound)
            {
                for (int i = 0; i < entry.Amount; i++)
                {
                    round.Products.Add(ProductRepo.GetById(entry.ProductId));
                }
            }
        }
        
        return rounds;
    }

    public static Round? GetById(int id)
    {
        using var connection = new MySqlConnection(ConnectionString);
        
        const string sql = "select * from rounds where RoundId = @Id";
        var round = connection.QueryFirstOrDefault<Round>(sql, new { Id = id });
        
        const string sqlProducts = "select * from product_round where RoundId = @RoundId";
        var productsRound = connection.Query(sqlProducts, new { RoundId = round.RoundId });

        foreach (var entry in productsRound)
        {
            for (int i = 0; i < entry.Amount; i++)
            {
                round.Products.Add(ProductRepo.GetById(entry.ProductId));
            }
        }

        return round;
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

        // Maak een dictionary van productId, Aantal
        var productIdAmountDictionary = round.Products.GroupBy(item => item.ProductId)
            .ToDictionary(group => group.Key, group => group.Count());
        
        foreach (var pair in productIdAmountDictionary)
        {
            const string insert = @"insert into product_round (ProductId, RoundId, Amount) values (@ProductId, @RoundId, @Amount)";
            
            connection.Execute(insert, new { ProductId = pair.Key, RoundId = round.RoundId, Amount = pair.Value, });
        }
    }
}