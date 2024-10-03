import type { UseCase } from "@core/resources/usecase";
import type { Report } from "@domain/entities/Report";
import type { IReportRepository } from "@domain/repositories/IReportRepository";

export class CreateReportUseCase implements UseCase<Report, Report> {
  constructor(private reportRepository: IReportRepository) {}

  async call(reportData: Report): Promise<Report> {
    try {
      const { report } = await this.reportRepository.createReport(reportData);

      return report;
    } catch (error) {
      console.error(error);
      throw error;
    }
  }
}
