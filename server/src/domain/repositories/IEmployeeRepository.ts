import type { Employee } from "@domain/entities/Employee";

export interface IEmployeeRepository {
  createEmployee: (employee: Employee) => Promise<{ employee: Employee }>;
}
