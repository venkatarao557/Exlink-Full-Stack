namespace ExlinkAPI.DTOs
{
    public class IntendedUseDto
    {
        public Guid IntendedUseId { get; set; }
        public string UseCode { get; set; } = null!;
        public string Description { get; set; } = null!;
    }
}