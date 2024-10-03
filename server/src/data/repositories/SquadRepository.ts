import { db } from "@data/db";
import { squad } from "@data/db/schema";
import { Squad } from "@domain/entities/Squad";
import type { ISquadRepository } from "@domain/repositories/ISquadRepository";

export class SquadRepository implements ISquadRepository {
  async createSquad(squadData: Squad): Promise<{ squad: Squad }> {
    const { name } = squadData;

    const [data] = await db.insert(squad).values({ name }).returning();

    return {
      squad: new Squad(data),
    };
  }
}
