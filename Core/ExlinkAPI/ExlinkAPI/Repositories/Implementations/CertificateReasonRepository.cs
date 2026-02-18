using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class CertificateReasonRepository : ICertificateReasonRepository
    {
        private readonly ExdocContext _context;

        public CertificateReasonRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<CertificateReasonDto>> GetAllAsync()
        {
            return await _context.CertificateReasons
                .Select(r => new CertificateReasonDto
                {
                    ReasonId = r.ReasonId,
                    ReasonCode = r.ReasonCode,
                    Description = r.Description
                }).ToListAsync();
        }

        public async Task<CertificateReasonDto?> GetByIdAsync(Guid id)
        {
            var reason = await _context.CertificateReasons.FindAsync(id);
            if (reason == null) return null;

            return new CertificateReasonDto
            {
                ReasonId = reason.ReasonId,
                ReasonCode = reason.ReasonCode,
                Description = reason.Description
            };
        }

        public async Task<CertificateReasonDto?> GetByCodeAsync(int code)
        {
            return await _context.CertificateReasons
                .Where(r => r.ReasonCode == code)
                .Select(r => new CertificateReasonDto
                {
                    ReasonId = r.ReasonId,
                    ReasonCode = r.ReasonCode,
                    Description = r.Description
                }).FirstOrDefaultAsync();
        }

        public async Task<CertificateReasonDto> CreateAsync(CertificateReasonDto reasonDto)
        {
            var entity = new CertificateReason
            {
                ReasonId = reasonDto.ReasonId == Guid.Empty ? Guid.NewGuid() : reasonDto.ReasonId,
                ReasonCode = reasonDto.ReasonCode,
                Description = reasonDto.Description
            };

            _context.CertificateReasons.Add(entity);
            await _context.SaveChangesAsync();

            reasonDto.ReasonId = entity.ReasonId;
            return reasonDto;
        }

        public async Task<bool> UpdateAsync(Guid id, CertificateReasonDto reasonDto)
        {
            var entity = await _context.CertificateReasons.FindAsync(id);
            if (entity == null) return false;

            entity.ReasonCode = reasonDto.ReasonCode;
            entity.Description = reasonDto.Description;

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
            var reason = await _context.CertificateReasons.FindAsync(id);
            if (reason == null) return false;

            _context.CertificateReasons.Remove(reason);
            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<bool> ExistsAsync(int code)
        {
            return await _context.CertificateReasons.AnyAsync(r => r.ReasonCode == code);
        }
    }
}
