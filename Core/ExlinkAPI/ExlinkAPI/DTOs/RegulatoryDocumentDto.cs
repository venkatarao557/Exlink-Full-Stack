namespace ExlinkAPI.DTOs
{
    public class RegulatoryDocumentDto
    {
        public Guid RegulatoryDocId { get; set; }
        public string DocumentTypeCode { get; set; } = null!;
        public string Description { get; set; } = null!;
    }
}