namespace ExlinkAPI.DTOs
{
    public class CertificateRequestStatusDto
    {
        public Guid RequestStatusId { get; set; }
        public string StatusCode { get; set; } = null!;
        public string Description { get; set; } = null!;
        public DateTime? DateEffective { get; set; }
    }
}