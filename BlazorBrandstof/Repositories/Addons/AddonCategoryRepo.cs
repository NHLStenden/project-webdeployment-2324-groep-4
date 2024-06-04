using BlazorBrandstof.Models;
using Dapper;
using MySqlConnector;

using BlazorBrandstof.Models.Addons;

namespace BlazorBrandstof.Repositories.Addons;

public class AddonCategoryRepo
{
    private static readonly string ConnectionString =
        ConfigurationHelper.Configuration.GetConnectionString("brandstof")!;
    
    public static IEnumerable<AddonCategory> GetAll()
    {
        using var connection = new MySqlConnection(ConnectionString);
        
        const string sql = "select * from add_on_categories";

        var categories = connection.Query<AddonCategory>(sql);

        return categories;
    }

    public static AddonCategory? GetById(int id)
    {
        using var connection = new MySqlConnection(ConnectionString);

        const string sql = "select * from add_on_categories where AddonCategoryId = @Id";
        var category = connection.QueryFirstOrDefault<AddonCategory>(sql, new { Id = id });

        return category;
    }
}