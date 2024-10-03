import type { UseCase } from "@core/resources/usecase";
import type { ISquadRepository } from "@domain/repositories/ISquadRepository";

interface Params {
  squadId: number;
  period: number;
}

interface ISpentHours {
  spentHours: number;
}

export class GetSquadMembersHoursUseCase
  implements UseCase<Record<string, ISpentHours>, Params>
{
  constructor(private squadRepository: ISquadRepository) {}

  async call(params: Params): Promise<Record<string, ISpentHours>> {
    try {
      const data = await this.squadRepository.getSquadMembersHoursByPeriod(
        params
      );

      const hoursPerMember: Record<string, { spentHours: number }> = {};
      for (const row of data) {
        hoursPerMember[row.id] = { spentHours: row.spentHours };
      }

      return hoursPerMember;
    } catch (error) {
      console.error(error);
      throw error;
    }
  }
}
