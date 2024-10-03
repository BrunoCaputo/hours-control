import type { UseCase } from "@core/resources/usecase";
import type { Employee } from "@domain/entities/Employee";
import type { IEmployeeRepository } from "@domain/repositories/IEmployeeRepository";

export class CreateEmployeeUseCase implements UseCase<Employee, Employee> {
  constructor(private employeeRepository: IEmployeeRepository) {}

  async call(employee: Employee): Promise<Employee> {
    try {
      await this.employeeRepository.createEmployee(employee);

      return employee;
    } catch (error) {
      console.error(error);
      throw error;
    }
  }
}
