using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace CocktailChooser.API.Models;

public partial class CocktailChooserContext : DbContext
{
    public CocktailChooserContext()
    {
    }

    public CocktailChooserContext(DbContextOptions<CocktailChooserContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Amount> Amounts { get; set; }

    public virtual DbSet<Cocktail> Cocktails { get; set; }

    public virtual DbSet<CocktailIngredient> CocktailIngredients { get; set; }

    public virtual DbSet<CocktailRecipe> CocktailRecipes { get; set; }

    public virtual DbSet<CocktailSource> CocktailSources { get; set; }

    public virtual DbSet<CocktailTimePeriod> CocktailTimePeriods { get; set; }

    public virtual DbSet<GlassType> GlassTypes { get; set; }

    public virtual DbSet<Ingredient> Ingredients { get; set; }

    public virtual DbSet<IngredientType> IngredientTypes { get; set; }

    public virtual DbSet<MixerSubtype> MixerSubtypes { get; set; }

    public virtual DbSet<MixerType> MixerTypes { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlite("Data Source=R:\\_CODE\\cocktail-chooser\\CocktailChooser.Data\\Data\\CocktailChooser.db");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Cocktail>(entity =>
        {
            entity.Property(e => e.CocktailSourceId).HasColumnName("CocktailSourceID");
            entity.Property(e => e.IsPopular).HasDefaultValue(0);

            entity.HasOne(d => d.CocktailSource).WithMany(p => p.Cocktails).HasForeignKey(d => d.CocktailSourceId);

            entity.HasOne(d => d.GlassType).WithMany(p => p.Cocktails).HasForeignKey(d => d.GlassTypeId);

            entity.HasOne(d => d.TimePeriod).WithMany(p => p.Cocktails).HasForeignKey(d => d.TimePeriodId);
        });

        modelBuilder.Entity<CocktailIngredient>(entity =>
        {
            entity.HasNoKey();

            entity.HasOne(d => d.Amount).WithMany().HasForeignKey(d => d.AmountId);

            entity.HasOne(d => d.Cocktail).WithMany().HasForeignKey(d => d.CocktailId);

            entity.HasOne(d => d.Ingredient).WithMany().HasForeignKey(d => d.IngredientId);
        });

        modelBuilder.Entity<CocktailRecipe>(entity =>
        {
            entity.HasKey(e => new { e.CocktailId, e.StepNumber });

            entity.HasOne(d => d.Cocktail).WithMany(p => p.CocktailRecipes)
                .HasForeignKey(d => d.CocktailId)
                .OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<CocktailSource>(entity =>
        {
            entity.ToTable("CocktailSource");
        });

        modelBuilder.Entity<GlassType>(entity =>
        {
            entity.HasIndex(e => e.Name, "IX_GlassTypes_Name").IsUnique();
        });

        modelBuilder.Entity<Ingredient>(entity =>
        {
            entity.HasOne(d => d.IngredientType).WithMany(p => p.Ingredients).HasForeignKey(d => d.IngredientTypeId);

            entity.HasOne(d => d.MixerSubtype).WithMany(p => p.Ingredients).HasForeignKey(d => d.MixerSubtypeId);
        });

        modelBuilder.Entity<IngredientType>(entity =>
        {
            entity.HasIndex(e => e.Type, "IX_IngredientTypes_Type").IsUnique();
        });

        modelBuilder.Entity<MixerSubtype>(entity =>
        {
            entity.HasOne(d => d.MixerType).WithMany(p => p.MixerSubtypes).HasForeignKey(d => d.MixerTypeId);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
