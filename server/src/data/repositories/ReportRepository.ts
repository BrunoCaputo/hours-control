import { db } from "@data/db";
import { reports } from "@data/db/schema";
import { Report } from "@domain/entities/Report";
import type { IReportRepository } from "@domain/repositories/IReportRepository";

export class ReportRepository implements IReportRepository {
  async createReport(reportData: Report): Promise<{ report: Report }> {
    const { description, employeeId, spentHours } = reportData;

    const [data] = await db
      .insert(reports)
      .values({ description, employeeId, spentHours })
      .returning();

    return {
      report: new Report(data),
    };
  }
}
