import type { Report } from "@domain/entities/Report";

export interface IReportRepository {
  createReport: (report: Report) => Promise<{ report: Report }>;

  getReportsBySquadId: (squadId: number) => Promise<Report[]>;
}
