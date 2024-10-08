import dayjs from "dayjs";
import { and, desc, eq, gte, lte } from "drizzle-orm";

import { db } from "@data/db";
import { employee, reports } from "@data/db/schema";
import { Report } from "@domain/entities/Report";
import type { IReportRepository } from "@domain/repositories/IReportRepository";

export class ReportRepository implements IReportRepository {
  async createReport(reportData: Report): Promise<{ report: Report }> {
    const { description, employeeId, spentHours } = reportData;

    const [data] = await db
      .insert(reports)
      .values({ description, employeeId, spentHours })
      .returning();

    return { report: new Report(data) };
  }

  async getReportsBySquadId(data: {
    squadId: number;
    period: number;
  }): Promise<Report[]> {
    const { squadId, period } = data;

    const initialPeriodDate = dayjs().subtract(period, "days").toDate();
    const today = dayjs().toDate();

    const squadEmployees = db.$with("squad_employees").as(
      db
        .select({
          id: employee.id,
          squadId: employee.squadId,
        })
        .from(employee)
        .where(eq(employee.squadId, squadId))
    );

    const reportList = await db
      .with(squadEmployees)
      .select()
      .from(reports)
      .innerJoin(squadEmployees, eq(squadEmployees.id, reports.employeeId))
      .where(
        and(
          lte(reports.createdAt, today),
          gte(reports.createdAt, initialPeriodDate)
        )
      )
      .orderBy(desc(reports.createdAt));

    return reportList.map(({ reports }) => new Report(reports));
  }
}
