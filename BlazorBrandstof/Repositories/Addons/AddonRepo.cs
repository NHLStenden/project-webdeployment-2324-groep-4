using BlazorBrandstof.Models;
using BlazorBrandstof.Models.Addons;
using Dapper;
using MySqlConnector;

namespace BlazorBrandstof.Repositories.Addons;

public class AddonRepo
{
    private static readonly string ConnectionString =
        ConfigurationHelper.Configuration.GetConnectionString("brandstof")!;
    
    public static IEnumerable<Addon> GetAll()
    {
        using var connection = new MySqlConnection(ConnectionString);
        
        const string sql = "select * from addons";

        var addons = connection.Query<Addon>(sql);

        return addons;
    }

    public static Addon? GetById(int id)
    {
        using var connection = new MySqlConnection(ConnectionString);

        const string sql = "select * from addons where AddonId = @Id";
        var addon = connection.QueryFirstOrDefault<Addon>(sql, new { Id = id });

        return addon;
    }
    
    public static IEnumerable<Addon>? GetByCategoryId(int id)
    {
        using var connection = new MySqlConnection(ConnectionString);

        const string sql = "select * from addons where AddonCategoryId = @Id";
        var addons = connection.Query<Addon>(sql, new { Id = id });

        return addons;
    }
}