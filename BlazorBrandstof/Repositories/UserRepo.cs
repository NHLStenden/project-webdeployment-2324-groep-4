using System.Security.Cryptography; // wordt gebruikt voor hashing
using System.Text; // voor het werken met strings en encoding
using BlazorBrandstof.Models; // bevat modelklassen voor applicatie
using Dapper; // voor eenvoudige Database interacties
using MySqlConnector; // mySQL connecter voor het werken met mySQL database

namespace BlazorBrandstof.Repositories;

public class UserRepo
{
    // haalt de connection string op uit de configuratie
    private static readonly string ConnectionString =
        ConfigurationHelper.Configuration.GetConnectionString("brandstof")!;
    
    // Methode om gebruikersnaam en wachtwoord te verifieren
    public static bool Verify(string username, string password)
    {
        // Maak een hash object aan
        using (SHA256 sha256hash = SHA256.Create())
        {
            // Hash het wachtwoord
            string password_hash = GetHash(sha256hash, password);
            
            // maak verbinding met database
            using var connection = new MySqlConnection(ConnectionString);
        
            // SQL-query om de gebruiker te verifieren
            const string sql = "select * FROM users WHERE UserName = @UserName AND PassWord = @PassWord";
        
            // Voer de query uit en controleer of er een resultaat is
            var result = connection.Query(sql, new
            {
                UserName = username,
                PassWord = password_hash,
            }).Count() > 0;

            // Retourneer true als er een gebruiker is gevonden, anders false
            return result;  
        }
    }
    
    // Methode om een string te hashen met een gegeven hash-algoritme
    private static string GetHash(HashAlgorithm hashAlgorithm, string input)
    {
        // Converteer de invoer string naar een byte-array en bereken de hash
        byte[] data = hashAlgorithm.ComputeHash(Encoding.UTF8.GetBytes(input));

        // maak een nieuwe StringBuilder om de bytes te verzamelen
        // en een string te creeren
        var sBuilder = new StringBuilder();

        // LOOP door elke byte van de gehashte data
        // en formatteer elke byte als een hexadecimale string
        for (int i = 0; i < data.Length; i++)
        {
            sBuilder.Append(data[i].ToString("x2"));
        }

        // return de hexadecimale string.
        return sBuilder.ToString();
    }

    // Methode om een hash te verifieren tegen een string
    private static bool VerifyHash(HashAlgorithm hashAlgorithm, string input, string hash)
    {
        // Hash de invoer
        var hashOfInput = GetHash(hashAlgorithm, input);

        // Maak een StringComparer om de hashes te vergelijken
        StringComparer comparer = StringComparer.OrdinalIgnoreCase;

        // Vergelijk de hashes en retourneer het resultaat
        return comparer.Compare(hashOfInput, hash) == 0;
    }
}