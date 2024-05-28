namespace BlazorBrandstof.Models;

public class Round
{
    public int RoundId { get; set; }
    public string Status { get; set; }
    public int OrderId { get; set; }

    public List<Product> Products { get; set; } = new();
}