export class Squad {
  private _id?: number;
  private _name: string;

  constructor(squad: { id?: number; name: string }) {
    this._id = squad.id;
    this._name = squad.name;
  }

  public toJSON() {
    return {
      id: this._id,
      name: this._name,
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
}
