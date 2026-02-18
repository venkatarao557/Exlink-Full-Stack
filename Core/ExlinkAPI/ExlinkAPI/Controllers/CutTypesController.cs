using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.AspNetCore.Mvc;

namespace ExlinkAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CutTypesController : ControllerBase
    {
        private readonly ICutTypeRepository _repository;

        public CutTypesController(ICutTypeRepository repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public async Task<ActionResult<IEnumerable<CutTypeDto>>> GetCutTypes()
        {
            var cuts = await _repository.GetAllAsync();
            return Ok(cuts.Select(c => MapToDto(c)));
        }

        [HttpGet("{id}")]
        public async Task<ActionResult<CutTypeDto>> GetCutType(Guid id)
        {
            var cutType = await _repository.GetByIdAsync(id);
            if (cutType == null) return NotFound();
            return Ok(MapToDto(cutType));
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> PutCutType(Guid id, CutTypeDto cutTypeDto)
        {
            if (id != cutTypeDto.CutTypeId) return BadRequest();

            var cutType = MapToEntity(cutTypeDto);
            _repository.Update(cutType);

            try
            {
                await _repository.SaveChangesAsync();
            }
            catch (Exception)
            {
                if (!await _repository.ExistsAsync(id)) return NotFound();
                throw;
            }

            return NoContent();
        }

        [HttpPost]
        public async Task<ActionResult<CutTypeDto>> PostCutType(CutTypeDto cutTypeDto)
        {
            var cutType = MapToEntity(cutTypeDto);
            await _repository.AddAsync(cutType);
            await _repository.SaveChangesAsync();

            return CreatedAtAction(nameof(GetCutType), new { id = cutType.CutTypeId }, MapToDto(cutType));
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCutType(Guid id)
        {
            await _repository.DeleteAsync(id);
            if (!await _repository.SaveChangesAsync()) return NotFound();
            return NoContent();
        }

        // Simple manual mapping helpers (Consider AutoMapper for larger projects)
        private static CutTypeDto MapToDto(CutType c) => new()
        {
            CutTypeId = c.CutTypeId,
            CommodityId = c.CommodityId,
            CutCode = c.CutCode,
            Description = c.Description,
            BoneInIndicator = c.BoneInIndicator,
            BeefVealIndicator = c.BeefVealIndicator,
            ChemicalLeanIndicator = c.ChemicalLeanIndicator
        };

        private static CutType MapToEntity(CutTypeDto d) => new()
        {
            CutTypeId = d.CutTypeId,
            CommodityId = d.CommodityId,
            CutCode = d.CutCode,
            Description = d.Description,
            BoneInIndicator = d.BoneInIndicator,
            BeefVealIndicator = d.BeefVealIndicator,
            ChemicalLeanIndicator = d.ChemicalLeanIndicator
        };
    }
}