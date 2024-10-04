import type { UseCase } from "@core/resources/usecase";
import type { Employee } from "@domain/entities/Employee";
import type { IEmployeeRepository } from "@domain/repositories/IEmployeeRepository";

export class GetEmployeesUseCase implements UseCase {
  constructor(private employeeRepository: IEmployeeRepository) {}

  async call(): Promise<Employee[]> {
    try {
      return await this.employeeRepository.getEmployees();
    } catch (error) {
      console.error(error);
      throw error;
    }
  }
}
