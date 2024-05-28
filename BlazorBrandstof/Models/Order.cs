namespace BlazorBrandstof.Models;

public class Order
{
    public int OrderId { get; set; }
    public DateTime Timestamp { get; set; }
    public int TableId { get; set; }
    public string WaiterName { get; set; }

    public List<Round> Rounds { get; set; } = new List<Round>();
}