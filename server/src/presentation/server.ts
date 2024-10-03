import fastifyCors from "@fastify/cors";
import fastify from "fastify";
import {
  serializerCompiler,
  validatorCompiler,
  type ZodTypeProvider,
} from "fastify-type-provider-zod";

// Routes
import { createEmployeeRoute } from "./routes/create-employee.route";

const app = fastify().withTypeProvider<ZodTypeProvider>();

app.register(fastifyCors, {
  origin: "*",
});

app.setValidatorCompiler(validatorCompiler);
app.setSerializerCompiler(serializerCompiler);

app.register(createEmployeeRoute);

app
  .listen({
    port: 3000,
  })
  .then(() => {
    console.log("HTTP server listening on port 3000");
  });
