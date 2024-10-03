import type { FastifyPluginAsyncZod } from "fastify-type-provider-zod";
import z from "zod";

import { SquadController } from "@presentation/controllers/SquadController";

export const getSquadTotalHoursByPeriodRoute: FastifyPluginAsyncZod = async (
  app
) => {
  const controller = new SquadController();

  const querySchema = z.object({
    squad_id: z.coerce.number().int(),
    period: z.coerce.number().int().min(1),
  });

  app.get(
    "/squad/hours/total",
    {
      schema: {
        querystring: querySchema,
      },
    },
    controller.getSquadTotalHoursByPeriod.bind(controller)
  );
};
