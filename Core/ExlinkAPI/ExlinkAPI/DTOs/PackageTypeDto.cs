namespace ExlinkAPI.DTOs
{
    public class PackageTypeDto
    {
        public Guid PackageTypeId { get; set; }
        public string PackageTypeCode { get; set; } = null!;
        public string Description { get; set; } = null!;
    }
}