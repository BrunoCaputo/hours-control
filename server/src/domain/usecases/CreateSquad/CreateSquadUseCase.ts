import type { UseCase } from "@core/resources/usecase";
import type { Squad } from "@domain/entities/Squad";
import type { ISquadRepository } from "@domain/repositories/ISquadRepository";

export class CreateSquadUseCase implements UseCase<Squad, Squad> {
  constructor(private squadRepository: ISquadRepository) {}

  async call(squadData: Squad): Promise<Squad> {
    try {
      const { squad } = await this.squadRepository.createSquad(squadData);

      return squad;
    } catch (error) {
      console.error(error);
      throw error;
    }
  }
}
