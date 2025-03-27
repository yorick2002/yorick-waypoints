interface NuiResponse<T = any> {
  status: "ok" | "error";
  data: T | null;
}

export async function nuiFetch<T = any>(
  eventName: string,
  data: unknown = {}
): Promise<NuiResponse<T>> {
  const resourceName = (window as any).GetParentResourceName?.();
  
  try {
    const response = await fetch(`https://${resourceName}/${eventName}`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(data),
    });

    const result = await response.json();
    return { status: "ok", data: result };
  } catch (error) {
    console.error("NUI fetch failed:", error);
    return { status: "error", data: null };
  }
}
