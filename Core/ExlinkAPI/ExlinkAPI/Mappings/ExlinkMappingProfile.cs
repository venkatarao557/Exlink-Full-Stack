using AutoMapper;
using System.Reflection;

namespace ExlinkAPI.Mappings
{
    public class ExlinkMappingProfile : Profile
    {
        public ExlinkMappingProfile()
        {
            // 1. Get the assembly where your Models and DTOs live
            var assembly = Assembly.GetExecutingAssembly();

            // 2. Get all types in your DTOs namespace
            var dtoTypes = assembly.GetTypes()
                .Where(t => t.IsClass && !t.IsAbstract && t.Name.EndsWith("Dto"))
                .ToList();

            // 3. Loop through DTOs and find their matching Model
            foreach (var dtoType in dtoTypes)
            {
                // Example: If DTO is "ApprovedCertifierDto", look for "ApprovedCertifier"
                var modelName = dtoType.Name.Replace("Dto", "");

                var modelType = assembly.GetTypes()
                    .FirstOrDefault(t => t.IsClass && t.Name == modelName);

                if (modelType != null)
                {
                    // Create a bi-directional map (Model <-> DTO)
                    CreateMap(modelType, dtoType).ReverseMap();
                }
            }

            // 4. Special Cases (if any names don't match the pattern exactly)
            // Example: CreateMap<AheccproductMapping, AheccproductMappingDto>().ReverseMap();
        }
    }
}