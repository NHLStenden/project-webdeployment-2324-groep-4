namespace BlazorBrandstof.Models;

public class Product
{
    public int ProductId { get; set; }
    public string Name { get; set; }
    public decimal Price { get; set; }
    
    public int CategoryId { get; set; }

    public List<string> Addons { get; set; } = new();
}