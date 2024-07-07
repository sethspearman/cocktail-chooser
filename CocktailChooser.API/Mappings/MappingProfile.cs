using AutoMapper;
using CocktailChooser.API.Models;
using CocktailChooser.API.DTOs;

namespace CocktailChooser.API.Mappings
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<Cocktail, CocktailDto>().ReverseMap();
            CreateMap<Ingredient, IngredientDto>().ReverseMap();
            CreateMap<CocktailRecipe, CocktailRecipeDto>().ReverseMap();
        }
    }
}