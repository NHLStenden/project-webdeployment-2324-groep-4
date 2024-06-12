namespace BlazorBrandstof.Models;

public class Order
{
    public int OrderId { get; set; }
    public DateTime Timestamp { get; set; }
    public int TableId { get; set; }
    public string WaiterName { get; set; }
    public string Status { get; set; }

    public List<Round> Rounds { get; set; } = new List<Round>();
    public List<Product> PaidProducts { get; set; } = new List<Product>();

    public List<Product> TotalProducts
    {
        get
        {
            return this.Rounds.SelectMany(x => x.Products).ToList();
        }
    }
}