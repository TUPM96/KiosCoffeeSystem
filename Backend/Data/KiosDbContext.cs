using Microsoft.EntityFrameworkCore;
using Kios.Models;

namespace Kios.Data
{
    public class KiosDbContext : DbContext
    {
        public KiosDbContext(DbContextOptions<KiosDbContext> options) : base(options) { }
        public DbSet<Admin> Admins { get; set; }
        public DbSet<Branch> Branches { get; set; }
        public DbSet<City> Cities { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<Admin>().ToTable("admin");
            modelBuilder.Entity<Branch>().ToTable("branch");
        }
    }
}
