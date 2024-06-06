using System.Security.Cryptography;
using System.Text;
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
        using (SHA256 sha256hash = SHA256.Create())
        {
            string password_hash = GetHash(sha256hash, password);
            
            // maak verbinding met database
            using var connection = new MySqlConnection(ConnectionString);
        
            const string sql = "select * FROM users WHERE UserName = @UserName AND PassWord = @PassWord";
        
            var result = connection.Query(sql, new
            {
                UserName = username,
                PassWord = password_hash,
            }).Count() > 0;

            return result;  
        }
    }
    
    private static string GetHash(HashAlgorithm hashAlgorithm, string input)
    {
        // Convert the input string to a byte array and compute the hash.
        byte[] data = hashAlgorithm.ComputeHash(Encoding.UTF8.GetBytes(input));

        // Create a new Stringbuilder to collect the bytes
        // and create a string.
        var sBuilder = new StringBuilder();

        // Loop through each byte of the hashed data
        // and format each one as a hexadecimal string.
        for (int i = 0; i < data.Length; i++)
        {
            sBuilder.Append(data[i].ToString("x2"));
        }

        // Return the hexadecimal string.
        return sBuilder.ToString();
    }

    // Verify a hash against a string.
    private static bool VerifyHash(HashAlgorithm hashAlgorithm, string input, string hash)
    {
        // Hash the input.
        var hashOfInput = GetHash(hashAlgorithm, input);

        // Create a StringComparer an compare the hashes.
        StringComparer comparer = StringComparer.OrdinalIgnoreCase;

        return comparer.Compare(hashOfInput, hash) == 0;
    }
}