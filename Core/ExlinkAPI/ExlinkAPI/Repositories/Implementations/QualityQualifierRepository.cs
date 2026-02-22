using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class QualityQualifierRepository : IQualityQualifierRepository
    {
        private readonly ExdocContext _context;

        public QualityQualifierRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<QualityQualifierDto>> GetAllAsync()
        {
            return await _context.QualityQualifiers
                .Select(q => new QualityQualifierDto
                {
                    QualityQualifierId = q.QualityQualifierId,
                    QualityQualifierName = q.QualityQualifier1
                }).ToListAsync();
        }

        public async Task<QualityQualifierDto?> GetByIdAsync(Guid id)
        {
            var entity = await _context.QualityQualifiers.FindAsync(id);
            if (entity == null) return null;

            return new QualityQualifierDto
            {
                QualityQualifierId = entity.QualityQualifierId,
                QualityQualifierName = entity.QualityQualifier1
            };
        }

        public async Task<QualityQualifierDto> CreateAsync(QualityQualifierDto dto)
        {
            var entity = new QualityQualifier
            {
                QualityQualifierId = Guid.NewGuid(),
                QualityQualifier1 = dto.QualityQualifierName
            };

            _context.QualityQualifiers.Add(entity);
            await _context.SaveChangesAsync();

            dto.QualityQualifierId = entity.QualityQualifierId;
            return dto;
        }

        public async Task<bool> UpdateAsync(Guid id, QualityQualifierDto dto)
        {
            var entity = await _context.QualityQualifiers.FindAsync(id);
            if (entity == null) return false;

            entity.QualityQualifier1 = dto.QualityQualifierName;

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
            var entity = await _context.QualityQualifiers.FindAsync(id);
            if (entity == null) return false;

            _context.QualityQualifiers.Remove(entity);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}