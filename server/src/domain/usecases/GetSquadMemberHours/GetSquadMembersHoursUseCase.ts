import type { UseCase } from "@core/resources/usecase";
import type { ISquadRepository } from "@domain/repositories/ISquadRepository";

interface Params {
  squadId: number;
  period: number;
}

interface Response {
  [employeeId: string]: { spentHours: number };
}

export class GetSquadMembersHoursUseCase implements UseCase<Response, Params> {
  constructor(private squadRepository: ISquadRepository) {}

  async call(params: Params): Promise<Response> {
    try {
      const data = await this.squadRepository.getSquadMembersHoursByPeriod(
        params
      );

      const membersHours: Record<string, { spentHours: number }> = {};
      for (const row of data) {
        membersHours[row.id] = { spentHours: row.spentHours };
      }

      return membersHours;
    } catch (error) {
      console.error(error);
      throw error;
    }
  }
}
