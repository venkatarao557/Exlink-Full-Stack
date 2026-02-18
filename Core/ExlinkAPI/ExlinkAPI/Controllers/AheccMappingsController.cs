using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class AheccMappingsController : ControllerBase
    {
        private readonly IAheccMappingRepository _repository;

        public AheccMappingsController(IAheccMappingRepository repository)
        {
            _repository = repository;
        }

        // GET: api/AheccMappings
        // Fetches all mappings, including the related CutType data
        [HttpGet]
        public async Task<ActionResult<IEnumerable<AheccproductMappingDto>>> GetMappings()
        {
            return Ok(await _repository.GetAllAsync());
        }

        // GET: api/AheccMappings/search?ahecc=123
        // Since there is no Primary Key, we search by the indexed Ahecc code
        [HttpGet("search")]
        public async Task<ActionResult<IEnumerable<AheccproductMappingDto>>> GetByAhecc([FromQuery] string ahecc)
        {
            var results = await _repository.SearchByAheccAsync(ahecc);
            if (!results.Any()) return NotFound();
            return Ok(results);
        }

        // POST: api/AheccMappings
        // You can still Insert into keyless tables
        [HttpPost]
        public async Task<ActionResult<AheccproductMappingDto>> CreateMapping(AheccproductMappingDto mappingDto)
        {
            var result = await _repository.CreateAsync(mappingDto);
            return CreatedAtAction(nameof(GetByAhecc), new { ahecc = result.Ahecc }, result);
        }
    }
}