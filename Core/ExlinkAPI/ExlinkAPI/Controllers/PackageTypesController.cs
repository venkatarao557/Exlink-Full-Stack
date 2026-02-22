using ExlinkAPI.DTOs;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PackageTypesController : ControllerBase
    {
        private readonly IPackageTypeRepository _repository;

        public PackageTypesController(IPackageTypeRepository repository)
        {
            _repository = repository;
        }

        // GET: api/PackageTypes
        [HttpGet]
        public async Task<ActionResult<IEnumerable<PackageTypeDto>>> GetPackageTypes()
        {
            return Ok(await _repository.GetAllAsync());
        }

        // GET: api/PackageTypes/5
        [HttpGet("{id}")]
        public async Task<ActionResult<PackageTypeDto>> GetPackageType(Guid id)
        {
            var result = await _repository.GetByIdAsync(id);
            return result == null ? NotFound() : Ok(result);
        }

        // PUT: api/PackageTypes/5
        [HttpPut("{id}")]
        public async Task<IActionResult> PutPackageType(Guid id, PackageTypeDto dto)
        {
            var success = await _repository.UpdateAsync(id, dto);
            return success ? NoContent() : NotFound();
        }

        // POST: api/PackageTypes
        [HttpPost]
        public async Task<ActionResult<PackageTypeDto>> PostPackageType(PackageTypeDto dto)
        {
            var result = await _repository.CreateAsync(dto);
            return CreatedAtAction(nameof(GetPackageType), new { id = result.PackageTypeId }, result);
        }

        // DELETE: api/PackageTypes/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePackageType(Guid id)
        {
            var success = await _repository.DeleteAsync(id);
            return success ? NoContent() : NotFound();
        }
    }
}