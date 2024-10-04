import type { UseCase } from "@core/resources/usecase";
import type { Squad } from "@domain/entities/Squad";
import type { ISquadRepository } from "@domain/repositories/ISquadRepository";

export class GetSquadsUseCase implements UseCase {
  constructor(private squadRepository: ISquadRepository) {}

  async call(): Promise<{ squads: Squad[] }> {
    try {
      const squads = await this.squadRepository.getSquads();

      return { squads };
    } catch (error) {
      console.error(error);
      throw error;
    }
  }
}
