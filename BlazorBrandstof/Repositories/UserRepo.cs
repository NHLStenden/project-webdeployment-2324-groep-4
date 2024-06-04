using BlazorBrandstof.Models;
using Dapper;
using MySqlConnector;

namespace BlazorBrandstof.Repositories;

public class UserRepo
{
    private static readonly string ConnectionString =
        ConfigurationHelper.Configuration.GetConnectionString("brandstof")!;
    
    public static bool Verify(string username, string password)
    {
        // maak verbinding met database
        using var connection = new MySqlConnection(ConnectionString);
        
        const string sql = "select * FROM users WHERE UserName = @UserName AND PassWord = @PassWord";
        
        var result = connection.Query(sql, new
        {
            UserName = username,
            PassWord = password,
        }).Count() > 0;

        return result;
    }
}