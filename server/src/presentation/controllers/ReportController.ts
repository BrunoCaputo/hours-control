import type { FastifyRequest } from "fastify";

import { ReportRepository } from "@data/repositories/ReportRepository";
import { Report } from "@domain/entities/Report";
import type { IReportRepository } from "@domain/repositories/IReportRepository";
import { CreateReportUseCase } from "@domain/usecases/CreateReport/CreateReportUseCase";
import { GetReportsBySquadIdUseCase } from "@domain/usecases/GetReportsBySquadId/GetReportsBySquadIdUseCase";

interface ICreateReportBody {
  description: string;
  employee_id: number;
  spent_hours: number;
}

interface IGetReportsBySquadParams {
  squad_id: number;
}

interface IGetReportsBySquadQueryParams {
  period: number;
}

export class ReportController {
  private createReport: CreateReportUseCase;
  private getReports: GetReportsBySquadIdUseCase;

  constructor() {
    const reportRepository: IReportRepository = new ReportRepository();
    this.createReport = new CreateReportUseCase(reportRepository);
    this.getReports = new GetReportsBySquadIdUseCase(reportRepository);
  }

  async create(request: FastifyRequest): Promise<Report> {
    try {
      const {
        description,
        employee_id: employeeId,
        spent_hours: spentHours,
      } = request.body as ICreateReportBody;

      return await this.createReport.call(
        new Report({ description, employeeId, spentHours })
      );
    } catch (error) {
      console.error("Failed to create report.", error);
      throw error;
    }
  }

  async getBySquadId(request: FastifyRequest): Promise<{ reports: Report[] }> {
    try {
      const { squad_id: squadId } = request.params as IGetReportsBySquadParams;
      const { period } = request.query as IGetReportsBySquadQueryParams;
      return await this.getReports.call({ squadId, period });
    } catch (error) {
      console.error("Failed to get reports by squad ID.", error);
      throw error;
    }
  }
}
