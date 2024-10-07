import type { FastifyPluginAsyncZod } from "fastify-type-provider-zod";
import z from "zod";

import { ReportController } from "@presentation/controllers/ReportController";

export const getReportsBySquadIdRoute: FastifyPluginAsyncZod = async (app) => {
  const controller = new ReportController();

  const paramsSchema = z.object({
    squad_id: z.coerce.number().int(),
  });

  const querySchema = z.object({
    period: z.coerce.number().int().min(1),
  });

  app.get(
    "/report/:squad_id",
    {
      schema: {
        params: paramsSchema,
        querystring: querySchema,
      },
    },
    controller.getBySquadId.bind(controller)
  );
};
