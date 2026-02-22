namespace ExlinkAPI.DTOs
{
    public class ProductUseIndicatorDto
    {
        public Guid ProductUseId { get; set; }
        public string UseCode { get; set; } = null!;
        public string Description { get; set; } = null!;
    }
}