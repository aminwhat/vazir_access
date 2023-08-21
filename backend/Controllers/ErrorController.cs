using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers;

[ApiController]
[Route("[controller]")]
public class ErrorController : ControllerBase
{
    public IActionResult Error()
    {
        return Problem();
    }
}