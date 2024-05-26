using BlazorBrandstof.Models;
using Dapper;
using MySqlConnector;

namespace BlazorBrandstof.Repositories;

public class CategoryRepo
{
    private static readonly string ConnectionString =
        ConfigurationHelper.Configuration.GetConnectionString("brandstof")!;
    
    public static IEnumerable<Category> GetAll()
    {
        using var connection = new MySqlConnection(ConnectionString);
        
        const string sql = "select c.Id, c.Name, p.Id, p.Name, p.Price, p.CategoryId from categories c inner join products p on p.CategoryId = c.Id";
        
        var result = connection.Query<Category, Product, Category>(sql, (category, product) => {
            category.Products.Add(product);
            return category;
        }, splitOn: "p.Id");

        return result;
    }

    public static Category? GetById(int id)
    {
        using var connection = new MySqlConnection(ConnectionString);
        
        const string sql = "select * from categories where Id = @Id";
        var result = connection.QueryFirstOrDefault<Category>(sql, new { Id = id });

        return result;
    }
}