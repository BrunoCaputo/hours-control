import type { FastifyRequest } from "fastify";

import { ReportRepository } from "@data/repositories/ReportRepository";
import { Report } from "@domain/entities/Report";
import type { IReportRepository } from "@domain/repositories/IReportRepository";
import { CreateReportUseCase } from "@domain/usecases/CreateReport/CreateReportUseCase";

interface ICreateReportBody {
  description: string;
  employee_id: number;
  spent_hours: number;
}

export class ReportController {
  private createSquad: CreateReportUseCase;

  constructor() {
    const reportRepository: IReportRepository = new ReportRepository();
    this.createSquad = new CreateReportUseCase(reportRepository);
  }

  async create(request: FastifyRequest): Promise<void> {
    try {
      const {
        description,
        employee_id: employeeId,
        spent_hours: spentHours,
      } = request.body as ICreateReportBody;

      await this.createSquad.call(
        new Report({ description, employeeId, spentHours })
      );
    } catch (error) {
      console.error("Failed to create report.", error);
    }
  }
}
