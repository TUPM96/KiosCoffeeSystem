using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Kios.Models;
using Kios.Data;

namespace Kios.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DashboardController : ControllerBase
    {
        private readonly KiosDbContext _context;

        public DashboardController(KiosDbContext context)
        {
            _context = context;
        }

        // 1. Summary endpoint: jobs, clients, admins, drivers, lorries, containers
        [HttpGet("summary")]
        public async Task<ActionResult<object>> GetSummary()
        {
            var adminsCount = await _context.Admins.CountAsync();
          

            return Ok(new
            {
                adminsCount,
            });
        }
    }
}
