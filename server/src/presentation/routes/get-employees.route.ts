import type { FastifyPluginAsyncZod } from "fastify-type-provider-zod";

import { EmployeeController } from "@presentation/controllers/EmployeeController";

export const getEmployeesRoute: FastifyPluginAsyncZod = async (app) => {
  const controller = new EmployeeController();

  app.get("/employee", controller.get.bind(controller));
};
