import type { UseCase } from "@core/resources/usecase";
import type { Employee } from "@domain/entities/Employee";
import type { IEmployeeRepository } from "@domain/repositories/IEmployeeRepository";

export class CreateEmployeeUseCase implements UseCase<Employee, Employee> {
  constructor(private employeeRepository: IEmployeeRepository) {}

  async call(employeeData: Employee): Promise<Employee> {
    try {
      const { employee } = await this.employeeRepository.createEmployee(
        employeeData
      );

      return employee;
    } catch (error) {
      console.error(error);
      throw error;
    }
  }
}
