# GoblinBrain Entity Framework Configuration

## GoblinBrainContext.cs

```cs
using GoblinBrain.Models;
using Microsoft.EntityFrameworkCore;

namespace GoblinBrain.Data;
public class GoblinBrainContext : DbContext
{
    public DbSet<ActionPlan> ActionPlans { get; set; }
    public DbSet<GoblinActivity> GoblinActivities { get; set; }
    public DbSet<Note> Notes { get; set; }
    public DbSet<Progress> Progresses { get; set; }
    public DbSet<Project> Projects { get; set; }
    public DbSet<Resource> Resources { get; set; }
    public DbSet<Skill> Skills { get; set; }
    public DbSet<TestQuestion> TestQuestions { get; set; }
    public GoblinBrainContext(DbContextOptions<GoblinBrainContext> options) : base(options)
    {

    }
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {

        // ActionPlans Table
        modelBuilder.Entity<ActionPlan>()
            .HasKey(ap => ap.ActionPlanId); // Set primary key

        modelBuilder.Entity<ActionPlan>()
            .Property(ap => ap.Goal)
            .IsRequired(); // Make Goal a required field

        modelBuilder.Entity<ActionPlan>()
            .Property(ap => ap.Steps)
            .IsRequired(); // Make Steps a required field 

        modelBuilder.Entity<ActionPlan>()
            .HasOne(ap => ap.Skill) // Configure one-to-one with Skills
            .WithMany()
            .HasForeignKey(ap => ap.SkillId);

        // Activities Table
        modelBuilder.Entity<GoblinActivity>()
            .HasKey(a => a.ActivityId); // Set primary key

        modelBuilder.Entity<GoblinActivity>()
            .Property(a => a.Name)
            .IsRequired(); // Make Name a required field

        modelBuilder.Entity<GoblinActivity>()
            .HasOne(a => a.Skill) // Configure one-to-one with Skills  
            .WithMany()
            .HasForeignKey(a => a.SkillId);

        modelBuilder.Entity<GoblinActivity>()
            .HasOne(a => a.Project) // Configure one-to-one with Projects
            .WithMany(p => p.Activities)
            .HasForeignKey(a => a.ProjectId);

        // Notes Table (Already set up with Progress model)

        // Progress Table
        modelBuilder.Entity<Progress>()
            .HasKey(p => p.ProgressId); // Set primary key

        modelBuilder.Entity<Progress>()
            .HasOne(p => p.Skill)
            .WithMany()
            .HasForeignKey(p => p.SkillId);

        modelBuilder.Entity<Progress>()
            .HasOne(p => p.GoblinActivity)
            .WithMany()
            .HasForeignKey(p => p.GoblinActivityId)
            .OnDelete(DeleteBehavior.Restrict); // Prevent cascade delete

        modelBuilder.Entity<Progress>()
            .HasOne(p => p.ActionPlan)
            .WithMany()
            .HasForeignKey(p => p.ActionPlanId)
            .OnDelete(DeleteBehavior.Restrict); // Prevent cascade delete

        modelBuilder.Entity<Progress>()
            .HasMany(p => p.Notes)
            .WithOne(n => n.Progress)
            .HasForeignKey(n => n.ProgressId);

        // Projects Table
        modelBuilder.Entity<Project>()
            .HasKey(p => p.ProjectId); // Set primary key

        modelBuilder.Entity<Project>()
            .Property(p => p.Name)
            .IsRequired(); // Make Name a required field

        modelBuilder.Entity<Project>()
            .HasMany(p => p.Activities) // Configure one-to-many with Activities
            .WithOne(a => a.Project);

        // Resources Table
        modelBuilder.Entity<Resource>()
            .HasOne(r => r.Skill) // Configure one-to-many with Skills
            .WithMany(s => s.Resources)
            .HasForeignKey(r => r.SkillId);

        modelBuilder.Entity<Resource>()
            .HasKey(r => r.ResourceId); // Set primary key

        modelBuilder.Entity<Resource>()
            .Property(r => r.Name)
            .IsRequired(); // Make Name a required field

        modelBuilder.Entity<Resource>()
            .HasOne(r => r.Skill)
            .WithMany()
            .HasForeignKey(r => r.SkillId);

        // Skills Table
        modelBuilder.Entity<Skill>()
            .HasMany(s => s.ChildSkills)
            .WithOne(cs => cs.ParentSkill)
            .HasForeignKey(cs => cs.ParentSkillId)
            .OnDelete(DeleteBehavior.Restrict);

        modelBuilder.Entity<Skill>()
            .HasKey(s => s.SkillId); // Set primary key

        modelBuilder.Entity<Skill>()
            .Property(s => s.Name)
            .IsRequired(); // Make Name a required field

        modelBuilder.Entity<Skill>()
            .HasMany(s => s.ProgressRecords) // Configure one-to-many with Progress
            .WithOne(p => p.Skill);

        modelBuilder.Entity<Skill>()
            .HasOne(s => s.ParentSkill) // Configure self-referencing
            .WithMany(ps => ps.ChildSkills)
            .HasForeignKey(s => s.ParentSkillId)
            .OnDelete(DeleteBehavior.Restrict); // Prevent delete if child skills exist

        // TestQuestions Table
        modelBuilder.Entity<TestQuestion>()
            .HasOne(tq => tq.Skill)
            .WithMany(s => s.TestQuestions)
            .HasForeignKey(tq => tq.SkillId); // Configure one-to-many with skills

        modelBuilder.Entity<TestQuestion>()
            .HasKey(tq => tq.QuestionId); // Set primary key

        modelBuilder.Entity<TestQuestion>()
            .Property(tq => tq.QuestionText)
            .IsRequired(); // Make QuestionText required

        modelBuilder.Entity<TestQuestion>()
            .Property(tq => tq.AnswerText)
            .IsRequired(); // Make AnswerText required

    }
}

```

## Data Model Objects

```cs
// All objects are in their own .cs class file
// All files include this header
namespace GoblinBrain.Models;
```

```cs
// ActionPlans Table
public class ActionPlan
{
    public int ActionPlanId { get; set; } // The primary key for each action plan 💥
    public string Goal { get; set; } // The goal this plan aims to achieve 🎯
    public int SkillId { get; set; } // Foreign key linking to a Skill 🔗
    public string Steps { get; set; } // The steps required to complete the plan 🚶‍♂️
    public DateTime[] Deadlines { get; set; } // Deadlines for each step 🕰️
    public string ProgressStatus { get; set; } // Current status of the plan 🚦

    public Skill Skill { get; set; } // Navigation property to the associated Skill
}

// Activities Table 
public class GoblinActivity
{
    public int ActivityId { get; set; } // The primary key for each activity 🔑
    public string Name { get; set; } // Name of the activity ✏️
    public int SkillId { get; set; } // Foreign key linking to a Skill 🔗
    public int? ProjectId { get; set; } // Foreign key linking to a Project (nullable) 🔗
    public int TimeEstimate { get; set; } // Estimated time to complete (in mins) ⌚

    public Skill Skill { get; set; } // Navigation property to the associated Skill
    public Project Project { get; set; } // Navigation property to the associated Project  
}

// Notes Table
public class Note
{
    public int NoteId { get; set; } // The primary key for each note 🗝️
    public string Content { get; set; } // The actual note content 📝
    public DateTime Timestamp { get; set; } // Timestamp when note was created/updated ⌚
    public int ProgressId { get; set; } // Foreign key linking to a Progress record 🔗

    public Progress Progress { get; set; } // Navigation property to associated Progress
}

// Progress Table
public class Progress
{
    public int ProgressId { get; set; } // The primary key for each progress record 🔑
    public int SkillId { get; set; } // Foreign key linking to a Skill 🔗
    public int Proficiency { get; set; } // GG's current proficiency level for the skill 🧠
    public DateTime DateLearned { get; set; } // Date when progress was made 📅
    public int? ActivityId { get; set; } // Foreign key linking to an Activity (nullable) 🔗
    public int? ActionPlanId { get; set; } // Foreign key linking to an ActionPlan (nullable) 🔗

    public Skill Skill { get; set; } // Navigation property to associated Skill
    public GoblinActivity Activity { get; set; } // Navigation property to associated Activity
    public ActionPlan ActionPlan { get; set; } // Navigation property to associated ActionPlan
    public ICollection<Note> Notes { get; set; } // Collection of associated Notes
}

// Projects Table
public class Project 
{
    public int ProjectId { get; set; } // The primary key for each project 🔑
    public string Name { get; set; } // Name of the project 📄
    public string Description { get; set; } // Description of the project goals 📃
    public string Status { get; set; } // Current status (In Progress, Completed, etc.) 🚥

    public ICollection<GoblinActivity> Activities { get; set; } // Collection of associated Activities
}

// Resources Table  
public class Resource
{
    public int ResourceId { get; set; } // The primary key for each resource 🔑
    public string Name { get; set; } // Name or title of the resource 📚
    public string UrlLink { get; set; } // URL or link to the resource 🌐
    public string Type { get; set; } // Type of resource (Website, Book, Video, etc.) 🧩
    public int SkillId { get; set; } // Foreign key linking to a Skill 🔗
    public string Description { get; set; } // Brief description of the resource 📄
    public int? UserRating { get; set; } // GG's rating of the resource's helpfulness ⭐
    public DateTime? LastAccessed { get; set; } // Last time GG accessed the resource ⌚
    public bool Completed { get; set; } // Whether GG has completed the resource ✅

    public Skill Skill { get; set; } // Navigation property to the associated Skill
}

// Skills Table
public class Skill
{
    public int SkillId { get; set; } // The primary key for each skill 🔑
    public string Name { get; set; } // Name of the skill ✏️
    public string Category { get; set; } // Category the skill falls under 🗃️
    public int? ParentSkillId { get; set; } // Foreign key for parent skill (nullable) 🔗
    public int Difficulty { get; set; } // Difficulty level of the skill (1-5) 📈

    public Skill ParentSkill { get; set; } // Navigation property to the parent Skill 
    public ICollection<Skill> ChildSkills { get; set; } // Collection of child Skills
    public ICollection<Progress> ProgressRecords { get; set; } // Collection of Progress records
    public ICollection<Resource> Resources { get; set; } // Collection of associated Resources
    public ICollection<TestQuestion> TestQuestions { get; set; } // Collection of TestQuestions
}

// TestQuestions Table
public class TestQuestion
{
    public int QuestionId { get; set; } // The primary key for each question 🔑
    public int SkillId { get; set; } // Foreign key linking to a Skill 🔗
    public string QuestionText { get; set; } // The actual question text 🤔
    public string AnswerText { get; set; } // The correct answer text 💯

    public Skill Skill { get; set; } // Navigation property to the associated Skill
}
```
