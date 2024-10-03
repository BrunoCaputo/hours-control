import { db } from "@data/db";
import { employee } from "@data/db/schema";
import { Employee } from "@domain/entities/Employee";
import type { IEmployeeRepository } from "@domain/repositories/IEmployeeRepository";

export class EmployeeRepository implements IEmployeeRepository {
  async createEmployee(
    employeeData: Employee
  ): Promise<{ employee: Employee }> {
    const { name, estimatedHours, squadId } = employeeData;

    const [data] = await db
      .insert(employee)
      .values({
        name,
        estimatedHours,
        squadId,
      })
      .returning();

    return {
      employee: new Employee(data),
    };
  }
}
