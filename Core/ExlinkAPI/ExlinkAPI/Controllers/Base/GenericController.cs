using Microsoft.AspNetCore.Mvc;
using ExlinkAPI.Repositories.Interfaces;

namespace ExlinkAPI.Controllers.Base
{
    [ApiController]
    [Route("api/[controller]")]
    public abstract class GenericController<TEntity, TDto> : ControllerBase where TEntity : class
    {
        protected readonly IGenericRepository<TEntity, TDto> _repository;

        protected GenericController(IGenericRepository<TEntity, TDto> repository)
        {
            _repository = repository;
        }

        [HttpGet]
        public virtual async Task<ActionResult<IEnumerable<TDto>>> GetAll()
        {
            return Ok(await _repository.GetAllAsync());
        }

        [HttpGet("{id}")]
        public virtual async Task<ActionResult<TDto>> GetById(Guid id)
        {
            var result = await _repository.GetByIdAsync(id);
            if (result == null) return NotFound();
            return Ok(result);
        }

        [HttpPost]
        public virtual async Task<ActionResult<TDto>> Create(TDto dto)
        {
            var result = await _repository.CreateAsync(dto);
            // Assumes your DTO has an 'Id' property or equivalent for the route
            return CreatedAtAction(nameof(GetById), new { id = Guid.NewGuid() }, result);
        }

        [HttpDelete("{id}")]
        public virtual async Task<IActionResult> Delete(Guid id)
        {
            var success = await _repository.DeleteAsync(id);
            if (!success) return NotFound();
            return NoContent();
        }
    }
}