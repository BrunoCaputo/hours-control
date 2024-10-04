import type { UseCase } from "@core/resources/usecase";
import type { ISquadRepository } from "@domain/repositories/ISquadRepository";

interface Params {
  squadId: number;
  period: number;
}

interface IAverageHours {
  squadAverageHours: number;
}

export class GetSquadAverageHoursPerDayUseCase
  implements UseCase<IAverageHours, Params>
{
  constructor(private squadRepository: ISquadRepository) {}

  async call(params: Params): Promise<IAverageHours> {
    try {
      const { squadSpentHours } =
        await this.squadRepository.getSquadTotalHoursByPeriod(params);

      return {
        squadAverageHours: Number.parseFloat(
          (squadSpentHours / params.period).toFixed(2)
        ),
      };
    } catch (error) {
      console.error(error);
      throw error;
    }
  }
}
