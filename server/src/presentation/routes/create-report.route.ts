import type { FastifyPluginAsyncZod } from "fastify-type-provider-zod";
import z from "zod";

import { ReportController } from "@presentation/controllers/ReportController";

export const createReportRoute: FastifyPluginAsyncZod = async (app) => {
  const controller = new ReportController();

  const bodySchema = z.object({
    description: z.string().min(1),
    employee_id: z.number().int(),
    spent_hours: z.number().int(),
  });

  app.post(
    "/report",
    {
      schema: {
        body: bodySchema,
      },
    },
    controller.create.bind(controller)
  );
};
