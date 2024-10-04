import type { FastifyRequest } from "fastify";

import { SquadRepository } from "@data/repositories/SquadRepository";
import { Squad } from "@domain/entities/Squad";
import type { ISquadRepository } from "@domain/repositories/ISquadRepository";
import { CreateSquadUseCase } from "@domain/usecases/CreateSquad/CreateSquadUseCase";
import { GetSquadAverageHoursPerDayUseCase } from "@domain/usecases/GetSquadAverageHoursPerDay/GetSquadAverageHoursPerDayUseCase";
import { GetSquadMembersHoursUseCase } from "@domain/usecases/GetSquadMemberHours/GetSquadMembersHoursUseCase";
import { GetSquadsUseCase } from "@domain/usecases/GetSquads/GetSquadsUseCase";
import { GetSquadTotalHoursUseCase } from "@domain/usecases/GetSquadTotalHours/GetSquadTotalHoursUseCase";

interface ICreateSquadBody {
  name: string;
}

interface IGetSquadParams {
  squad_id: number;
  period: number; // Days
}

export class SquadController {
  private createSquad: CreateSquadUseCase;
  private getSquadAverageHoursPerDay: GetSquadAverageHoursPerDayUseCase;
  private getSquadMemberHours: GetSquadMembersHoursUseCase;
  private getSquads: GetSquadsUseCase;
  private getSquadTotalHours: GetSquadTotalHoursUseCase;

  constructor() {
    const squadRepository: ISquadRepository = new SquadRepository();
    this.createSquad = new CreateSquadUseCase(squadRepository);
    this.getSquadAverageHoursPerDay = new GetSquadAverageHoursPerDayUseCase(
      squadRepository
    );
    this.getSquadMemberHours = new GetSquadMembersHoursUseCase(squadRepository);
    this.getSquads = new GetSquadsUseCase(squadRepository);
    this.getSquadTotalHours = new GetSquadTotalHoursUseCase(squadRepository);
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

  async get(): Promise<{ squads: Squad[] }> {
    try {
      return await this.getSquads.call();
    } catch (error) {
      console.error("Failed to get squads.", error);
      throw error;
    }
  }

  async getMemberHoursByPeriod(
    request: FastifyRequest
  ): Promise<Record<string, { spentHours: number }>> {
    try {
      const { squad_id: squadId, period } = request.query as IGetSquadParams;

      return await this.getSquadMemberHours.call({
        squadId,
        period,
      });
    } catch (error) {
      console.error("Failed to get squad member hours.", error);
      throw error;
    }
  }

  async getSquadTotalHoursByPeriod(
    request: FastifyRequest
  ): Promise<{ squadSpentHours: number }> {
    try {
      const { squad_id: squadId, period } = request.query as IGetSquadParams;

      return await this.getSquadTotalHours.call({
        squadId,
        period,
      });
    } catch (error) {
      console.error("Failed to get squad total hours.", error);
      throw error;
    }
  }

  async getSquadAverageHoursPerDayByPeriod(
    request: FastifyRequest
  ): Promise<{ squadAverageHours: number }> {
    try {
      const { squad_id: squadId, period } = request.query as IGetSquadParams;

      return await this.getSquadAverageHoursPerDay.call({
        squadId,
        period,
      });
    } catch (error) {
      console.error("Failed to get squad average hours.", error);
      throw error;
    }
  }
}
