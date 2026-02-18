namespace ExlinkAPI.DTOs
{
    public class ApprovedCertifierDto
    {
        public Guid CertifierId { get; set; }
        public string CertifierCode { get; set; } = null!;
        public string CertifierName { get; set; } = null!;
    }
}
