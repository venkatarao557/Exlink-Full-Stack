namespace ExlinkAPI.DTOs
{
    public class DeclarationIndicatorDto
    {
        public Guid DeclarationId { get; set; }
        public string IndicatorCode { get; set; } = null!;
        public string Description { get; set; } = null!;
    }
}
