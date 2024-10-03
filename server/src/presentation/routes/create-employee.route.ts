import z from "zod";

import { EmployeeController } from "@presentation/controllers/EmployeeController";
import type { FastifyPluginAsyncZod } from "fastify-type-provider-zod";

export const createEmployeeRoute: FastifyPluginAsyncZod = async (app) => {
  const controller = new EmployeeController();

  const bodySchema = z.object({
    name: z.string().min(1),
    estimated_hours: z.number().int().min(1).max(12),
    squad_id: z.number(),
  });

  app.post(
    "/employee",
    {
      schema: {
        body: bodySchema,
      },
    },
    controller.create.bind(controller)
  );
};
