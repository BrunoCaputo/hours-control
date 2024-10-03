import type { FastifyPluginAsyncZod } from "fastify-type-provider-zod";
import z from "zod";

import { SquadController } from "@presentation/controllers/SquadController";

export const createSquadRoute: FastifyPluginAsyncZod = async (app) => {
  const controller = new SquadController();

  const bodySchema = z.object({
    name: z.string().min(1),
  });

  app.post(
    "/squad",
    {
      schema: {
        body: bodySchema,
      },
    },
    controller.create.bind(controller)
  );
};
