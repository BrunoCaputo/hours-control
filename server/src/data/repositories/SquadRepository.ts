import dayjs from "dayjs";
import { and, eq, gte, lte, sql, sum } from "drizzle-orm";

import { db } from "@data/db";
import { employee, reports, squad } from "@data/db/schema";
import { Squad } from "@domain/entities/Squad";
import type { ISquadRepository } from "@domain/repositories/ISquadRepository";

export class SquadRepository implements ISquadRepository {
  async createSquad(squadData: Squad): Promise<{ squad: Squad }> {
    const { name } = squadData;

    const [data] = await db.insert(squad).values({ name }).returning();

    return {
      squad: new Squad(data),
    };
  }

  async getSquadMembersHoursByPeriod(data: {
    squadId: number;
    period: number;
  }): Promise<{ [employeeId: string]: { spentHours: number } }> {
    const { squadId, period } = data;

    const initialPeriodDate = dayjs().subtract(period, "days").toDate();
    const today = dayjs().toDate();

    const spentHoursByMember = db.$with("spent_hours_by_member").as(
      db
        .select({
          employeeId: reports.employeeId,
          spentHours: sum(reports.spentHours).as("spentHours"),
        })
        .from(reports)
        .where(
          and(
            lte(reports.createdAt, today),
            gte(reports.createdAt, initialPeriodDate)
          )
        )
        .groupBy(reports.employeeId)
    );

    const filterSquadMembersById = db.$with("filter_squad_members_by_id").as(
      db
        .select({
          id: employee.id,
          squadId: employee.squadId,
          spentHours: spentHoursByMember.spentHours,
        })
        .from(employee)
        .innerJoin(
          spentHoursByMember,
          eq(employee.id, spentHoursByMember.employeeId)
        )
        .where(eq(employee.squadId, squadId))
    );

    const result = await db
      .with(spentHoursByMember, filterSquadMembersById)
      .select({
        id: filterSquadMembersById.id,
        spentHours:
          sql/*sql*/ `COALESCE(${filterSquadMembersById.spentHours}, 0)`.mapWith(
            Number
          ),
      })
      .from(filterSquadMembersById);

    const membersHours: { [employeeId: string]: { spentHours: number } } = {};
    for (const row of result) {
      membersHours[row.id] = { spentHours: row.spentHours };
    }

    return membersHours;
  }
}
