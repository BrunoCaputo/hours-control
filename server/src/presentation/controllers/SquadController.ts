import type { FastifyRequest } from "fastify";

import { SquadRepository } from "@data/repositories/SquadRepository";
import { Squad } from "@domain/entities/Squad";
import type { ISquadRepository } from "@domain/repositories/ISquadRepository";
import { CreateSquadUseCase } from "@domain/usecases/CreateSquad/CreateSquadUseCase";
import { GetSquadMembersHoursUseCase } from "@domain/usecases/GetSquadMemberHours/GetSquadMembersHoursUseCase";

interface ICreateSquadBody {
  name: string;
}

interface IGetMemberHoursParams {
  squad_id: number;
  period: number; // Days
}

export class SquadController {
  private createSquad: CreateSquadUseCase;
  private getSquadMemberHours: GetSquadMembersHoursUseCase;

  constructor() {
    const squadRepository: ISquadRepository = new SquadRepository();
    this.createSquad = new CreateSquadUseCase(squadRepository);
    this.getSquadMemberHours = new GetSquadMembersHoursUseCase(squadRepository);
  }

  async create(request: FastifyRequest): Promise<Squad> {
    try {
      const { name } = request.body as ICreateSquadBody;

      return await this.createSquad.call(new Squad({ name }));
    } catch (error) {
      console.error("Failed to create squad.", error);
      throw error;
    }
  }

  async getMemberHoursByPeriod(request: FastifyRequest): Promise<{
    [employeeId: string]: { spentHours: number };
  }> {
    try {
      const { squad_id: squadId, period } =
        request.query as IGetMemberHoursParams;

      console.log({ squadId, period });

      return await this.getSquadMemberHours.call({
        squadId,
        period,
      });
    } catch (error) {
      console.error("Failed to get squad member hours.", error);
      throw error;
    }
  }
}
