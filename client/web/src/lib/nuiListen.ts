export interface NuiMessage<T = unknown> {
  type: string;
  data: T;
}

const registeredListeners = new Map<string, (event: MessageEvent<NuiMessage<any>>) => void>();

export function onNuiMessage<T = unknown>(
  type: string,
  callback: (data: T) => void
): () => void {
  if (registeredListeners.has(type)) {
    window.removeEventListener("message", registeredListeners.get(type)!);
  }

  const listener = (event: MessageEvent<NuiMessage<T>>) => {
    if (event.data.type === type) {
      callback(event.data.data);
    }
  };

  window.addEventListener("message", listener);
  registeredListeners.set(type, listener);

  return () => {
    window.removeEventListener("message", listener);
    registeredListeners.delete(type);
  };
}
