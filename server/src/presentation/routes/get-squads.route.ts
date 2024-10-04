import type { FastifyPluginAsyncZod } from "fastify-type-provider-zod";

import { SquadController } from "@presentation/controllers/SquadController";

export const getSquadsRoute: FastifyPluginAsyncZod = async (app) => {
  const controller = new SquadController();

  app.get("/squad", controller.get.bind(controller));
};
