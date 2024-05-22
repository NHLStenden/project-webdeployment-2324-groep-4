using BlazorBrandstof.Models;
using Dapper;
using MySqlConnector;

namespace BlazorBrandstof.Repositories;

public class ProductRepo
{
    private static readonly string ConnectionString =
        ConfigurationHelper.Configuration.GetConnectionString("brandstof")!;
    
    public static IEnumerable<Product> GetAll()
    {
        using var connection = new MySqlConnection(ConnectionString);
        
        const string sql = "select * from products";
        var products = connection.Query<Product>(sql);

        return products;
    }

    public static Product? GetById(int id)
    {
        using var connection = new MySqlConnection(ConnectionString);
        
        const string sql = "select * from products where Id = @Id";
        var product = connection.QueryFirstOrDefault<Product>(sql, new { Id = id });

        return product;
    }

    public static Product Add(Product product)
    {
        using var connection = new MySqlConnection(ConnectionString);

        const string sql = "insert into products (Name, Price) values (@Name, @Price); SELECT LAST_INSERT_ID();";
        
        var newId = connection.ExecuteScalar<int>(sql, product);
        return GetById(newId)!;
    }

    public static void Remove(Product product)
    {
        using var connection = new MySqlConnection(ConnectionString);

        const string sql = "delete from products where Id = @Id";
        var numEffectedRows = connection.Execute(sql, product);
    }

    public static void Update(Product product)
    {
        using var connection = new MySqlConnection(ConnectionString);

        const string sql = "update products set Name, Price where Id = @Id";
        var numEffectedRows = connection.Execute(sql, product);
    }
}