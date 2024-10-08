import fastifyCors from "@fastify/cors";
import fastify from "fastify";
import {
  serializerCompiler,
  validatorCompiler,
  type ZodTypeProvider,
} from "fastify-type-provider-zod";

// Routes
import { createEmployeeRoute } from "./routes/create-employee.route";
import { createReportRoute } from "./routes/create-report.route";
import { createSquadRoute } from "./routes/create-squad.route";
import { getEmployeesRoute } from "./routes/get-employees.route";
import { getReportsBySquadIdRoute } from "./routes/get-reports-by-squad-id.route";
import { getSquadAverageHoursPerDayByPeriodRoute } from "./routes/get-squad-average-hours-per-day-by-period.route";
import { getSquadMembersHoursByPeriodRoute } from "./routes/get-squad-members-hours-by-period.route";
import { getSquadTotalHoursByPeriodRoute } from "./routes/get-squad-total-hours-by-period.route";
import { getSquadsRoute } from "./routes/get-squads.route";

const app = fastify().withTypeProvider<ZodTypeProvider>();

app.register(fastifyCors, {
  origin: "*",
});

app.setValidatorCompiler(validatorCompiler);
app.setSerializerCompiler(serializerCompiler);

// GET
app.register(getEmployeesRoute);
app.register(getReportsBySquadIdRoute);
app.register(getSquadAverageHoursPerDayByPeriodRoute);
app.register(getSquadMembersHoursByPeriodRoute);
app.register(getSquadTotalHoursByPeriodRoute);
app.register(getSquadsRoute);

// POST
app.register(createEmployeeRoute);
app.register(createReportRoute);
app.register(createSquadRoute);

app
  .listen({
    port: 3000,
    host: "0.0.0.0",
  })
  .then(() => {
    console.log("HTTP server listening on port 3000");
  });
