import random
import sys

items = [
    {"value": 10, "weight": 5},
    {"value": 40, "weight": 4},
    {"value": 30, "weight": 6},
    {"value": 50, "weight": 3},
]

capacity = 10
population_size = 6
generations = 10

# Random solutions
def random_solution():
    return [random.choice([0, 1]) for _ in items]

# Fitness function
def fitness(solution):
    total_value = sum(item["value"] for item, take in zip(items, solution) if take)
    total_weight = sum(item["weight"] for item, take in zip(items, solution) if take)
    return total_value if total_weight <= capacity else 0  

# Pick two best solutions
def select(population):
    return sorted(population, key=fitness, reverse=True)[:2]

# Crossover: Single-point crossover
def crossover(parent1, parent2):
    point = random.randint(1, len(parent1) - 1)
    return parent1[:point] + parent2[point:], parent2[:point] + parent1[point:]

# Mutation: Flip a random bit
def mutate(solution):
    index = random.randint(0, len(solution) - 1)
    solution[index] = 1 - solution[index]
    return solution

# Genetic Algorithm Execution
population = [random_solution() for _ in range(population_size)]
parents = select(population)

print(f"Parents: {population}")



for _ in range(generations):
    parents = select(population)
    offspring = []
    
    for _ in range(population_size // 2):
        child1, child2 = crossover(*parents)
        offspring.append(mutate(child1))
        offspring.append(mutate(child2))
    
    population = offspring
    print(population)
# Best solution
best_solution = max(population, key=fitness)
print("Best solution:", best_solution, "Value:", fitness(best_solution))
