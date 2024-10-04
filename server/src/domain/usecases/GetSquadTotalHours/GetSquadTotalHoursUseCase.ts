import type { UseCase } from "@core/resources/usecase";
import type { ISquadRepository } from "@domain/repositories/ISquadRepository";

interface Params {
  squadId: number;
  period: number;
}

interface ISpentHours {
  squadSpentHours: number;
}

export class GetSquadTotalHoursUseCase implements UseCase<ISpentHours, Params> {
  constructor(private squadRepository: ISquadRepository) {}

  async call(params: Params): Promise<ISpentHours> {
    try {
      return await this.squadRepository.getSquadTotalHoursByPeriod(params);
    } catch (error) {
      console.error(error);
      throw error;
    }
  }
}
