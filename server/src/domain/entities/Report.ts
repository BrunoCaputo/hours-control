export class Report {
  private _id?: number;
  private _description: string;
  private _employeeId: number;
  private _spentHours: number;
  private _createdAt?: Date;

  constructor(report: {
    id?: number;
    description: string;
    employeeId: number;
    spentHours: number;
    createdAt?: Date;
  }) {
    this._id = report.id;
    this._description = report.description;
    this._employeeId = report.employeeId;
    this._spentHours = report.spentHours;
    this._createdAt = report.createdAt;
  }

  // GETTERS AND SETTERS
  public get id(): number {
    return this._id ?? 0;
  }

  public get description(): string {
    return this._description;
  }
  public set description(newDescription: string) {
    this._description = newDescription;
  }

  public get employeeId(): number {
    return this._employeeId;
  }

  public get spentHours(): number {
    return this._spentHours;
  }
  public set spentHours(hours: number) {
    this._spentHours = hours;
  }

  public get createdAt(): Date {
    return this._createdAt ?? new Date();
  }
}
