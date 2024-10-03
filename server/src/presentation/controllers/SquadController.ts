import type { FastifyRequest } from "fastify";

import { SquadRepository } from "@data/repositories/SquadRepository";
import { Squad } from "@domain/entities/Squad";
import type { ISquadRepository } from "@domain/repositories/ISquadRepository";
import { CreateSquadUseCase } from "@domain/usecases/CreateSquad/CreateSquadUseCase";

interface ICreateSquadBody {
  name: string;
}

export class SquadController {
  private createSquad: CreateSquadUseCase;

  constructor() {
    const userRepository: ISquadRepository = new SquadRepository();
    this.createSquad = new CreateSquadUseCase(userRepository);
  }

  async create(request: FastifyRequest): Promise<void> {
    try {
      const { name } = request.body as ICreateSquadBody;

      await this.createSquad.call(new Squad({ name }));
    } catch (error) {
      console.error("Failed to create squad.", error);
    }
  }
}
