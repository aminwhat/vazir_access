using Microsoft.AspNetCore.Mvc;

namespace backend.Contrllers;

[ApiController]
[Route("[controller]")]
public class HealthController : ControllerBase
{
    [HttpGet]
    public IActionResult Get()
    {
        return Ok("Everything is Okay");
    }
}