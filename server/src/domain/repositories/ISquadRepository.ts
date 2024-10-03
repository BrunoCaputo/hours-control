import type { Squad } from "@domain/entities/Squad";

export interface ISquadRepository {
  createSquad: (squad: Squad) => Promise<{ squad: Squad }>;
}
