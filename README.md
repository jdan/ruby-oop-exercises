## ruby-oop-exercises

Some OOP exercises for the Ruby programming language.

### Running

```bash
bundle install
bundle exec rake spec
```

### Running Specific Tests

```bash
# Run tests for a specific chapter
bundle exec rspec spec/chapter_01_classes_and_objects/
bundle exec rspec spec/chapter_02_encapsulation/
bundle exec rspec spec/chapter_03_inheritance/

# Run tests for a single exercise
bundle exec rspec spec/chapter_01_classes_and_objects/01_dog_spec.rb
```

### Watching Files

Use guard to automatically run tests when you save a file:

```bash
bundle exec guard
```

When guard is running, saving any lib or spec file will automatically run the corresponding tests. For example, editing `lib/chapter_01_classes_and_objects/01_dog.rb` will trigger `spec/chapter_01_classes_and_objects/01_dog_spec.rb`.

Guard commands:
- `Enter` - run all tests
- `p` - pause file watching
- `e` - exit
