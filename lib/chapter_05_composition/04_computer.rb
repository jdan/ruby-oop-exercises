# frozen_string_literal: true

# Implement the Computer and component classes here
#
# This exercise demonstrates complex composition: a Computer is composed
# of multiple interchangeable parts (CPU, Memory, Storage).
#
# Cpu class:
# - initialize(model, cores)
# - model reader
# - cores reader
# - specs method returns "#{model} (#{cores} cores)"
#
# Memory class:
# - initialize(size_gb)
# - size_gb reader
# - specs method returns "#{size_gb}GB RAM"
#
# Storage class:
# - initialize(size_gb, storage_type)
# - size_gb reader
# - storage_type reader
# - specs method returns "#{size_gb}GB #{storage_type}"
#
# Computer class:
# - initialize(cpu, memory, storage)
# - cpu, memory, storage readers
# - full_specs method returns "CPU: #{cpu.specs}, Memory: #{memory.specs}, Storage: #{storage.specs}"
# - upgrade_memory(new_memory) replaces memory component
# - upgrade_storage(new_storage) replaces storage component
# - total_storage_and_memory returns sum of memory.size_gb + storage.size_gb
