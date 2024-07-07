using AutoMapper;
using CocktailChooser.API.Mappings;
using CocktailChooser.API.Models;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
Console.WriteLine($"Connection String: {connectionString}");
Console.WriteLine($"Database Exists: {File.Exists("../CocktailChooser.Data/Data/CocktailChooser.db")}");


builder.Services.AddControllers();
builder.Services.AddDbContext<CocktailChooserContext>(options =>
    options.UseSqlite(builder.Configuration.GetConnectionString("DefaultConnections")));
builder.Services.AddAutoMapper(typeof(MappingProfile));
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
    app.UseDeveloperExceptionPage();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
