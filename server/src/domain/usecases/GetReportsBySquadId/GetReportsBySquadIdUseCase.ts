import type { UseCase } from "@core/resources/usecase";
import type { Report } from "@domain/entities/Report";
import type { IReportRepository } from "@domain/repositories/IReportRepository";

export class GetReportsBySquadIdUseCase
  implements UseCase<{ reports: Report[] }, Record<string, number>>
{
  constructor(private reportRepository: IReportRepository) {}

  async call(data: {
    squadId: number;
    period: number;
  }): Promise<{ reports: Report[] }> {
    try {
      const reports = await this.reportRepository.getReportsBySquadId(data);

      return { reports };
    } catch (error) {
      console.error(error);
      throw error;
    }
  }
}
