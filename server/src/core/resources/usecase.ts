export abstract class UseCase<
  T = unknown,
  K extends object = Record<string, unknown>
> {
  abstract call(params: K): Promise<T>;
}
