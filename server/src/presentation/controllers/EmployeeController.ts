import type { FastifyRequest } from "fastify";

import { EmployeeRepository } from "@data/repositories/EmployeeRepository";
import type { IEmployeeRepository } from "@domain/repositories/IEmployeeRepository";
import { CreateEmployeeUseCase } from "@domain/usecases/CreateEmployee/CreateEmployeeUseCase";
import { Employee } from "@domain/entities/Employee";

interface ICreateEmployeeBody {
  name: string;
  estimated_hours: number;
  squad_id: number;
}

export class EmployeeController {
  private createEmployee: CreateEmployeeUseCase;

  constructor() {
    const employeeRepository: IEmployeeRepository = new EmployeeRepository();
    this.createEmployee = new CreateEmployeeUseCase(employeeRepository);
  }

  async create(request: FastifyRequest): Promise<void> {
    try {
      const {
        name,
        estimated_hours: estimatedHours,
        squad_id: squadId,
      } = request.body as ICreateEmployeeBody;

      await this.createEmployee.call(
        new Employee({ name, estimatedHours, squadId })
      );
    } catch (error) {
      console.error("Failed to create employee.", error);
      throw error;
    }
  }
}
