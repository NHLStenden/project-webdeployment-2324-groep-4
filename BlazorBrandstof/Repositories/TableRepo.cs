using BlazorBrandstof.Models;
using Dapper;
using MySqlConnector;

namespace BlazorBrandstof.Repositories;

public class TableRepo
{
    private static readonly string ConnectionString =
        ConfigurationHelper.Configuration.GetConnectionString("brandstof")!;
    
    public static IEnumerable<Table> GetAll()
    {
        using var connection = new MySqlConnection(ConnectionString);
        
        const string sql = "select * from tables";
        var result = connection.Query<Table>(sql);

        return result;
    }

    public static Table? GetByName(string name)
    {
        using var connection = new MySqlConnection(ConnectionString);
        
        const string sql = "select * from tables where Name = @Name";
        var result = connection.QueryFirstOrDefault<Table>(sql, new { Name = name });

        return result;
    }

    public static void Add(Table table)
    {
        using var connection = new MySqlConnection(ConnectionString);

        const string sql = "insert into tables (Name) values (@Name);";
        
        var newId = connection.Execute(sql, table);
    }

    public static void Remove(Table table)
    {
        using var connection = new MySqlConnection(ConnectionString);

        const string sql = "delete from tables where Name = @Name";
        var numEffectedRows = connection.Execute(sql, table);
    }
}