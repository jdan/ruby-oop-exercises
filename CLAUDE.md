# Ruby OOP Exercises

A TDD-based learning repository for practicing Object-Oriented Programming in Ruby.

## How to Use

1. Run `bundle install` to install dependencies
2. Run `rake spec` to see failing tests
3. Implement the classes in `lib/` to make tests pass
4. Work through chapters in order (01 → 07)

## Running Tests

```bash
# Run all tests
rake spec

# Run tests for a specific chapter
bundle exec rspec spec/chapter_01_classes_and_objects/
bundle exec rspec spec/chapter_02_encapsulation/
bundle exec rspec spec/chapter_03_inheritance/

# Run tests for a single exercise
bundle exec rspec spec/chapter_01_classes_and_objects/01_dog_spec.rb
```

## Linting

```bash
rake lint              # Check for style issues
rake lint:autocorrect  # Auto-fix issues
```

RuboCop config is in `.rubocop.yml`.

## Project Structure

```
lib/
  chapter_01_classes_and_objects/      # Basic class creation
  chapter_02_encapsulation/            # Data hiding, accessors
  chapter_03_inheritance/              # Subclasses, super, overriding
  chapter_04_modules_and_mixins/       # Modules, include, extend
  chapter_05_composition/              # Has-a relationships, delegation
  chapter_06_polymorphism_and_duck_typing/  # Interface compatibility
  chapter_07_solid_principles/         # SRP, OCP, LSP, ISP, DIP
spec/
  chapter_01_classes_and_objects/      # Tests for chapter 1
  chapter_02_encapsulation/            # Tests for chapter 2
  chapter_03_inheritance/              # Tests for chapter 3
  chapter_04_modules_and_mixins/       # Tests for chapter 4
  chapter_05_composition/              # Tests for chapter 5
  chapter_06_polymorphism_and_duck_typing/  # Tests for chapter 6
  chapter_07_solid_principles/         # Tests for chapter 7
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

- Chapter 08: Design Patterns (Factory, Singleton, Observer)
- Chapter 09: Metaprogramming Basics
- Chapter 10: Testing and TDD Patterns
