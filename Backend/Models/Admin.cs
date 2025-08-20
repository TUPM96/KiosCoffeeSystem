using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Kios.Models
{
    public class Admin
    {
        [Key]
        public int AdminId { get; set; }

        public int? BranchId { get; set; }
        [ForeignKey("BranchId")]
        public Branch? Branch { get; set; }

        [Required, StringLength(50)]
        public string Username { get; set; } = string.Empty;

        [Required, StringLength(255)]
        public string PasswordHash { get; set; } = string.Empty;

        [Required, StringLength(100)]
        public string FullName { get; set; } = string.Empty;

        [Required, StringLength(100), EmailAddress]
        public string EmailAddress { get; set; } = string.Empty;

        [Required, StringLength(255)]
        public string AddressLine { get; set; } = string.Empty;

        [Required, StringLength(100)]
        public string ContactInfo { get; set; } = string.Empty;

        public bool IsActive { get; set; } = true;

        [Required, StringLength(50)]
        public string Role { get; set; } = "BRANCH_ADMIN";

        // Sửa lại cho đúng kiểu ngày giờ
        [Column(TypeName = "datetime2")]
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }
}