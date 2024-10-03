import type { UseCase } from "@core/resources/usecase";
import type { ISquadRepository } from "@domain/repositories/ISquadRepository";

interface Params {
  squadId: number;
  period: number;
}

interface IAverageHours {
  squadAverageHours: number;
}

export class GetSquadAverageHoursUseCase
  implements UseCase<IAverageHours, Params>
{
  constructor(private squadRepository: ISquadRepository) {}

  async call(params: Params): Promise<IAverageHours> {
    try {
      return await this.squadRepository.getSquadAverageHoursByPeriod(params);
    } catch (error) {
      console.error(error);
      throw error;
    }
  }
}
