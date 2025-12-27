# Ruby OOP Exercises

A TDD-based learning repository for practicing Object-Oriented Programming in Ruby.

## How to Use

1. Run `bundle install` to install dependencies
2. Run `rake spec` to see failing tests
3. Implement the classes in `lib/` to make tests pass
4. Work through chapters in order (01 → 02 → 03)

## Project Structure

```
lib/
  chapter_01_classes_and_objects/   # Basic class creation
  chapter_02_encapsulation/         # Data hiding, accessors
  chapter_03_inheritance/           # Subclasses, super, overriding
spec/
  chapter_01_classes_and_objects/   # Tests for chapter 1
  chapter_02_encapsulation/         # Tests for chapter 2
  chapter_03_inheritance/           # Tests for chapter 3
```

## Conventions

- Exercises numbered `01_`, `02_`, etc. within each chapter
- Each exercise has a lib file (to implement) and spec file (tests)
- Progress from simpler to more complex within each chapter

## Adding New Chapters

When asking Claude to generate a new chapter:

1. Specify the OOP topic (e.g., "polymorphism", "modules and mixins", "composition")
2. Request 5-6 exercises with progressive difficulty
3. Follow existing naming: `chapter_XX_topic_name/`

### Example Prompt

```
Add a new chapter on Modules and Mixins. Include 5 exercises:
- Start with basic module inclusion
- Progress to namespacing and extend vs include
- End with a practical mixin example
Follow the existing project conventions.
```

## Chapter Ideas for Future

- Chapter 04: Modules and Mixins
- Chapter 05: Composition over Inheritance
- Chapter 06: Polymorphism and Duck Typing
- Chapter 07: SOLID Principles
- Chapter 08: Design Patterns (Factory, Singleton, Observer)
