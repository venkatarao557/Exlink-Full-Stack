using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class StateRepository : IStateRepository
    {
        private readonly ExdocContext _context;

        public StateRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<StateDto>> GetAllAsync()
        {
            return await _context.States
                .Select(s => new StateDto
                {
                    StateId = s.StateId,
                    StateCode = s.StateCode,
                    StateName = s.StateName
                }).ToListAsync();
        }

        public async Task<StateDto?> GetByIdAsync(Guid id)
        {
            var entity = await _context.States.FindAsync(id);
            if (entity == null) return null;

            return new StateDto
                {
                    StateId = entity.StateId,
                    StateCode = entity.StateCode,
                    StateName = entity.StateName
                };
        }

        public async Task<StateDto> CreateAsync(StateDto dto)
        {
            var entity = new State
            {
                StateId = Guid.NewGuid(),
                StateCode = dto.StateCode,
                StateName = dto.StateName
            };

            _context.States.Add(entity);
            await _context.SaveChangesAsync();

            dto.StateId = entity.StateId;
            return dto;
        }

        public async Task<bool> UpdateAsync(Guid id, StateDto dto)
        {
            var entity = await _context.States.FindAsync(id);
            if (entity == null) return false;

            entity.StateCode = dto.StateCode;
            entity.StateName = dto.StateName;

            try
            {
                await _context.SaveChangesAsync();
                return true;
            }
            catch (DbUpdateConcurrencyException)
            {
                return false;
            }
        }

        public async Task<bool> DeleteAsync(Guid id)
        {
            var entity = await _context.States.FindAsync(id);
            if (entity == null) return false;

            _context.States.Remove(entity);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}