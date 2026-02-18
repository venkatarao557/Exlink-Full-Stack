namespace ExlinkAPI.DTOs
{
    public class CertificateReasonDto
    {
        public Guid ReasonId { get; set; }
        public int ReasonCode { get; set; }
        public string Description { get; set; } = null!;
    }
}