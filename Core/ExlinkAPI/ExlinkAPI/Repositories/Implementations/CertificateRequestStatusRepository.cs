using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class CertificateRequestStatusRepository : ICertificateRequestStatusRepository
    {
        private readonly ExdocContext _context;

        public CertificateRequestStatusRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<CertificateRequestStatusDto>> GetAllAsync()
        {
            return await _context.CertificateRequestStatuses
                .Select(s => new CertificateRequestStatusDto
                {
                    RequestStatusId = s.RequestStatusId,
                    StatusCode = s.StatusCode,
                    Description = s.Description,
                    DateEffective = s.DateEffective
                }).ToListAsync();
        }

        public async Task<CertificateRequestStatusDto?> GetByIdAsync(Guid id)
        {
            var status = await _context.CertificateRequestStatuses.FindAsync(id);
            if (status == null) return null;

            return new CertificateRequestStatusDto
            {
                RequestStatusId = status.RequestStatusId,
                StatusCode = status.StatusCode,
                Description = status.Description,
                DateEffective = status.DateEffective
            };
        }

        public async Task<CertificateRequestStatusDto> CreateAsync(CertificateRequestStatusDto statusDto)
        {
            var entity = new CertificateRequestStatus
            {
                RequestStatusId = statusDto.RequestStatusId == Guid.Empty ? Guid.NewGuid() : statusDto.RequestStatusId,
                StatusCode = statusDto.StatusCode,
                Description = statusDto.Description,
                DateEffective = statusDto.DateEffective ?? DateTime.UtcNow
            };

            _context.CertificateRequestStatuses.Add(entity);
            await _context.SaveChangesAsync();

            statusDto.RequestStatusId = entity.RequestStatusId;
            return statusDto;
        }

        public async Task<bool> UpdateAsync(Guid id, CertificateRequestStatusDto statusDto)
        {
            var entity = await _context.CertificateRequestStatuses.FindAsync(id);
            if (entity == null) return false;

            entity.StatusCode = statusDto.StatusCode;
            entity.Description = statusDto.Description;
            entity.DateEffective = statusDto.DateEffective;

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
            var status = await _context.CertificateRequestStatuses.FindAsync(id);
            if (status == null) return false;

            _context.CertificateRequestStatuses.Remove(status);
            await _context.SaveChangesAsync();
            return true;
        }

        public async Task<bool> CodeExistsAsync(string code)
        {
            return await _context.CertificateRequestStatuses.AnyAsync(s => s.StatusCode == code);
        }
    }
}