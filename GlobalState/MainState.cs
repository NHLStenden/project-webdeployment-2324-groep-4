using System.Net;

namespace cafe.GlobalState;

public class MainState
{
    public static string? Theme { get ; set; }
    // private readonly HttpClient _httpClient;
    public MainState()
    {
        Theme = "dark";
        Console.WriteLine(Theme);
    }
}
