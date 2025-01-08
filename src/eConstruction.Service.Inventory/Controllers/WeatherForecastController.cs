using Microsoft.AspNetCore.Mvc;

namespace eConstruction.Service.Inventory.Controllers
{
    [ApiController]
    [ApiExplorerSettings(GroupName = "v1")]
    [Route("[controller]")]
    public class WeatherForecastController : ControllerBase
    {
        private static readonly string[] Summaries = new[]
        {
            "Inventory-Freezing",
            "Inventory-Bracing",
            "Inventory-Chilly",
            "Inventory-Cool",
            "Inventory-Mild",
            "Inventory-Warm",
            "Inventory-Balmy",
            "Inventory-Hot",
            "Inventory-Sweltering",
            "Inventory-Scorching"
        };

        private readonly ILogger<WeatherForecastController> _logger;

        public WeatherForecastController(ILogger<WeatherForecastController> logger)
        {
            _logger = logger;
        }

        [HttpGet(Name = "GetInventoryWeatherForecast")]
        public IEnumerable<WeatherForecast> GetInventoryWeatherForecast()
        {
            return Enumerable.Range(1, 5).Select(index => new WeatherForecast
            {
                Date = DateOnly.FromDateTime(DateTime.Now.AddDays(index)),
                TemperatureC = Random.Shared.Next(-20, 55),
                Summary = Summaries[Random.Shared.Next(Summaries.Length)]
            })
            .ToArray();
        }
    }
}
