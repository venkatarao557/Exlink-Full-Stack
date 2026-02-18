using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class ApprovedCertifierRepository : IApprovedCertifierRepository
    {
        private readonly ExdocContext _context;

        public ApprovedCertifierRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<ApprovedCertifierDto>> GetAllAsync()
        {
            return await _context.ApprovedCertifiers
                .Select(c => new ApprovedCertifierDto
                {
                    CertifierId = c.CertifierId,
                    CertifierCode = c.CertifierCode,
                    CertifierName = c.CertifierName
                }).ToListAsync();
        }

        public async Task<ApprovedCertifierDto?> GetByIdAsync(Guid id)
        {
            var certifier = await _context.ApprovedCertifiers.FindAsync(id);
            if (certifier == null) return null;

            return new ApprovedCertifierDto
            {
                CertifierId = certifier.CertifierId,
                CertifierCode = certifier.CertifierCode,
                CertifierName = certifier.CertifierName
            };
        }

        public async Task<ApprovedCertifierDto> CreateAsync(ApprovedCertifierDto certifierDto)
        {
            var entity = new ApprovedCertifier
            {
                CertifierId = Guid.NewGuid(),
                CertifierCode = certifierDto.CertifierCode,
                CertifierName = certifierDto.CertifierName
            };

            _context.ApprovedCertifiers.Add(entity);
            await _context.SaveChangesAsync();

            certifierDto.CertifierId = entity.CertifierId;
            return certifierDto;
        }

        public async Task<bool> UpdateAsync(Guid id, ApprovedCertifierDto certifierDto)
        {
            var entity = await _context.ApprovedCertifiers.FindAsync(id);
            if (entity == null) return false;

            entity.CertifierCode = certifierDto.CertifierCode;
            entity.CertifierName = certifierDto.CertifierName;

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
            var certifier = await _context.ApprovedCertifiers.FindAsync(id);
            if (certifier == null) return false;

            _context.ApprovedCertifiers.Remove(certifier);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}