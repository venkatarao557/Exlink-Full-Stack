using ExlinkAPI.DTOs;
using ExlinkAPI.Models;
using ExlinkAPI.Repositories.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ExlinkAPI.Repositories.Implementations
{
    public class CertificatePrintIndicatorRepository : ICertificatePrintIndicatorRepository
    {
        private readonly ExdocContext _context;

        public CertificatePrintIndicatorRepository(ExdocContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<CertificatePrintIndicatorDto>> GetAllAsync()
        {
            return await _context.CertificatePrintIndicators
                .Select(i => new CertificatePrintIndicatorDto
                {
                    PrintIndicatorId = i.PrintIndicatorId,
                    IndicatorCode = i.IndicatorCode,
                    Description = i.Description
                }).ToListAsync();
        }

        public async Task<CertificatePrintIndicatorDto?> GetByIdAsync(Guid id)
        {
            var indicator = await _context.CertificatePrintIndicators.FindAsync(id);
            if (indicator == null) return null;

            return new CertificatePrintIndicatorDto
            {
                PrintIndicatorId = indicator.PrintIndicatorId,
                IndicatorCode = indicator.IndicatorCode,
                Description = indicator.Description
            };
        }

        public async Task<CertificatePrintIndicatorDto> CreateAsync(CertificatePrintIndicatorDto indicatorDto)
        {
            var entity = new CertificatePrintIndicator
            {
                PrintIndicatorId = indicatorDto.PrintIndicatorId == Guid.Empty ? Guid.NewGuid() : indicatorDto.PrintIndicatorId,
                IndicatorCode = indicatorDto.IndicatorCode,
                Description = indicatorDto.Description
            };

            _context.CertificatePrintIndicators.Add(entity);
            await _context.SaveChangesAsync();

            indicatorDto.PrintIndicatorId = entity.PrintIndicatorId;
            return indicatorDto;
        }

        public async Task<bool> UpdateAsync(Guid id, CertificatePrintIndicatorDto indicatorDto)
        {
            var entity = await _context.CertificatePrintIndicators.FindAsync(id);
            if (entity == null) return false;

            entity.IndicatorCode = indicatorDto.IndicatorCode;
            entity.Description = indicatorDto.Description;

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
            var indicator = await _context.CertificatePrintIndicators.FindAsync(id);
            if (indicator == null) return false;

            _context.CertificatePrintIndicators.Remove(indicator);
            await _context.SaveChangesAsync();
            return true;
        }
    }
}



