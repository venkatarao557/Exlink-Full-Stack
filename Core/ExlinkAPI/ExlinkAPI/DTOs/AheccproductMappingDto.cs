namespace ExlinkAPI.DTOs
{
    public class AheccproductMappingDto
    {
        public Guid MappingId { get; set; }
        public string Ahecc { get; set; } = null!;
        public string CutCode { get; set; } = null!;
        public string ProductTypeCode { get; set; } = null!;
        public string? Description { get; set; }
    }
}
