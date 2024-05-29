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
        
        // query een gecombineerde lijst van categorieen + producten
        const string sql = "select c.CategoryId, c.Name, ProductId, p.Name, p.Price, p.CategoryId from categories c inner join products p on p.CategoryId = c.CategoryId";
        
        var result = connection.Query<Category, Product, Category>(sql, (category, product) => {
            category.Products.Add(product);
            return category;
        }, splitOn: "ProductId");
        
        // warm, koffie
        // warm, thee
        // koud, limonade,
        // koud, ijsthee

        // groepeer resultaat op basis van CategoryId
        result = result.GroupBy(c=> c.CategoryId, c=> c.Products, (id, group) =>
        {
            return new Category()
            {
                CategoryId = id,
                Name = CategoryRepo.GetById(id)!.Name,
                Products = group.SelectMany(x => x).ToList(),
            };
        });
        
        // warm, koffie, thee
        // koud, limonade, ijsthee
        
        return result;
    }

    public static Category? GetById(int id)
    {
        using var connection = new MySqlConnection(ConnectionString);
        
        const string sql = "select * from categories where CategoryId = @Id";
        var result = connection.QueryFirstOrDefault<Category>(sql, new { Id = id });

        return result;
    }
}