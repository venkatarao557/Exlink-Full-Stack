namespace ExlinkAPI.DTOs
{
    public class CertificatePrintIndicatorDto
    {
        public Guid PrintIndicatorId { get; set; }
        public string IndicatorCode { get; set; } = null!;
        public string Description { get; set; } = null!;
    }
}