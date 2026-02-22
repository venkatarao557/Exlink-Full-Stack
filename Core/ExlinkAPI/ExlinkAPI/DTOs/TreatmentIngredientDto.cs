namespace ExlinkAPI.DTOs
{
    public class TreatmentIngredientDto
    {
        public Guid IngredientId { get; set; }
        public int IngredientCode { get; set; }
        public string Description { get; set; } = null!;
    }
}