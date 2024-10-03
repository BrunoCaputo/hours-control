import type { FastifyPluginAsyncZod } from "fastify-type-provider-zod";
import z from "zod";

import { SquadController } from "@presentation/controllers/SquadController";

export const getSquadAverageHoursByPeriodRoute: FastifyPluginAsyncZod = async (
  app
) => {
  const controller = new SquadController();

  const querySchema = z.object({
    squad_id: z.coerce.number().int(),
    period: z.coerce.number().int().min(1),
  });

  app.get(
    "/squad/hours/average",
    {
      schema: {
        querystring: querySchema,
      },
    },
    controller.getSquadAverageHoursByPeriod.bind(controller)
  );
};
