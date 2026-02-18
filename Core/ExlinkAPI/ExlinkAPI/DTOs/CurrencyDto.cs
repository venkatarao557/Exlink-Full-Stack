namespace ExlinkAPI.DTOs
{
    public class CurrencyDto
    {
        public Guid CurrencyId { get; set; }
        public string CurrencyUnit { get; set; } = null!;
        public string Description { get; set; } = null!;
    }
}