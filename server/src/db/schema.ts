import { pgTable, text, integer, timestamp } from "drizzle-orm/pg-core";

import { generateUniqueNumericId } from "../utils/generate-unique-id";

export const employee = pgTable("employee", {
  id: integer("id")
    .primaryKey()
    .unique()
    .$defaultFn(() => generateUniqueNumericId()),
  name: text("name").notNull(),
  estimatedHours: integer("estimatedHours").notNull(),
  squadId: integer("squadId")
    .references(() => squad.id)
    .notNull(),
});

export const squad = pgTable("squad", {
  id: integer("id")
    .primaryKey()
    .unique()
    .$defaultFn(() => generateUniqueNumericId()),
  name: text("name").notNull(),
});

export const reports = pgTable("reports", {
  id: integer("id")
    .primaryKey()
    .unique()
    .$defaultFn(() => generateUniqueNumericId()),
  description: text("description"),
  employeeId: integer("employeeId")
    .references(() => employee.id)
    .notNull(),
  spentHours: integer("spentHours").notNull(),
  createdAt: timestamp("createdAt", { withTimezone: true })
    .notNull()
    .defaultNow(),
});
