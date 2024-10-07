import type { FastifyPluginAsyncZod } from "fastify-type-provider-zod";
import z from "zod";

import { ReportController } from "@presentation/controllers/ReportController";

export const getReportsBySquadIdRoute: FastifyPluginAsyncZod = async (app) => {
  const controller = new ReportController();

  const paramsSchema = z.object({
    squad_id: z.coerce.number().int(),
  });

  app.get(
    "/report/:squad_id",
    {
      schema: {
        params: paramsSchema,
      },
    },
    controller.getBySquadId.bind(controller)
  );
};
