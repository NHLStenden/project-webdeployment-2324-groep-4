namespace BlazorBrandstof.Models;

public class Round
{
    public int Id { get; set; }
    public string Status { get; set; }
    public int OrderId { get; set; }
    
    public Dictionary<Product, int> AmountProducts { get; set; }
}