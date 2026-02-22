using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class RegulatoryDocumentRepository : IRegulatoryDocumentRepository
    {
        private readonly ExdocContext _context;

        public RegulatoryDocumentRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<RegulatoryDocumentDto>> GetAllAsync()
        {
            return await _context.RegulatoryDocuments
                .Select(d => new RegulatoryDocumentDto
                {
                    RegulatoryDocId = d.RegulatoryDocId,
                    DocumentTypeCode = d.DocumentTypeCode,
                    Description = d.Description
                }).ToListAsync();
        }

        public async Task<RegulatoryDocumentDto?> GetByIdAsync(Guid id)
        {
            var entity = await _context.RegulatoryDocuments.FindAsync(id);
            if (entity == null) return null;

            return new RegulatoryDocumentDto
            {
                RegulatoryDocId = entity.RegulatoryDocId,
                DocumentTypeCode = entity.DocumentTypeCode,
                Description = entity.Description
            };
        }

        public async Task<RegulatoryDocumentDto> CreateAsync(RegulatoryDocumentDto dto)
        {
            var entity = new RegulatoryDocument
            {
                RegulatoryDocId = Guid.NewGuid(),
                DocumentTypeCode = dto.DocumentTypeCode,
                Description = dto.Description
            };

            _context.RegulatoryDocuments.Add(entity);
            await _context.SaveChangesAsync();

            dto.RegulatoryDocId = entity.RegulatoryDocId;
            return dto;
        }

        public async Task<bool> UpdateAsync(Guid id, RegulatoryDocumentDto dto)
        {
            var entity = await _context.RegulatoryDocuments.FindAsync(id);
            if (entity == null) return false;

            entity.DocumentTypeCode = dto.DocumentTypeCode;
            entity.Description = dto.Description;

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
            var entity = await _context.RegulatoryDocuments.FindAsync(id);
            if (entity == null) return false;

            _context.RegulatoryDocuments.Remove(entity);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}