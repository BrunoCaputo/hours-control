import { defineConfig } from "drizzle-kit";
import { env } from "./src/shared/env";

export default defineConfig({
  schema: "./src/data/db/schema.ts",
  out: "./.migrations",
  dialect: "postgresql",
  dbCredentials: {
    url: env.DATABASE_URL,
  },
});
