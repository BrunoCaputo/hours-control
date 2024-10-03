import type { Squad } from "@domain/entities/Squad";

export interface ISquadRepository {
  createSquad: (squad: Squad) => Promise<{ squad: Squad }>;

  getSquadMembersHoursByPeriod(data: {
    squadId: number;
    period: number;
  }): Promise<
    {
      id: number;
      spentHours: number;
    }[]
  >;

  getSquadTotalHoursByPeriod(data: {
    squadId: number;
    period: number;
  }): Promise<{
    squadSpentHours: number;
  }>;
}
