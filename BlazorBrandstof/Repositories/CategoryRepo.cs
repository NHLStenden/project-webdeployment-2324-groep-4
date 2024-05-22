﻿using BlazorBrandstof.Models;
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
        
        const string sql = "select * from categories";
        var result = connection.Query<Category>(sql);
        
        

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

        const string sql = "delete from products where Id = @Id";
        var numEffectedRows = connection.Execute(sql, table);
    }
}