export class Employee {
  private _id?: number;
  private _name: string;
  private _estimatedHours: number;
  private _squadId: number;

  constructor(employee: {
    id?: number;
    name: string;
    estimatedHours: number;
    squadId: number;
  }) {
    this._id = employee.id;
    this._name = employee.name;
    this._estimatedHours = employee.estimatedHours;
    this._squadId = employee.squadId;
  }

  public toJSON() {
    return {
      id: this._id,
      name: this._name,
      estimatedHours: this._estimatedHours,
      squadId: this._squadId,
    };
  }

  // GETTERS AND SETTERS
  public get id(): number {
    return this._id ?? 0;
  }

  public get name(): string {
    return this._name;
  }
  public set name(newName: string) {
    this._name = newName;
  }

  public get estimatedHours(): number {
    return this._estimatedHours;
  }
  public set estimatedHours(hours: number) {
    this._estimatedHours = hours;
  }

  public get squadId(): number {
    return this._squadId;
  }
  public set squadId(newSquadId: number) {
    this._squadId = newSquadId;
  }
}
