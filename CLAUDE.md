# Ruby OOP Exercises

A TDD-based learning repository for practicing Object-Oriented Programming in Ruby.

## How to Use

1. Run `bundle install` to install dependencies
2. Run `rake spec` to see failing tests
3. Implement the classes in `lib/` to make tests pass
4. Work through chapters in order (01 → 10)

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
  chapter_08_design_patterns/          # Factory, Singleton, Observer, etc.
  chapter_09_metaprogramming_basics/   # define_method, method_missing, DSLs
  chapter_10_more_design_patterns/     # Template Method, State, Command, etc.
spec/
  (mirrors lib/ structure)
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

