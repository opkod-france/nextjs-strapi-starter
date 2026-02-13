const STRAPI_URL = process.env.NEXT_PUBLIC_STRAPI_URL ?? "http://localhost:1337";

interface StrapiResponse<T> {
  data: T;
  meta: {
    pagination?: {
      page: number;
      pageSize: number;
      pageCount: number;
      total: number;
    };
  };
}

interface StrapiError {
  status: number;
  name: string;
  message: string;
}

/**
 * Typed fetch wrapper for the Strapi REST API.
 *
 * @example
 * const { data } = await strapi<Article[]>("/api/articles?populate=*");
 */
export async function strapi<T = unknown>(
  path: string,
  options?: RequestInit
): Promise<StrapiResponse<T>> {
  const url = `${STRAPI_URL}${path}`;

  const res = await fetch(url, {
    headers: {
      "Content-Type": "application/json",
      ...options?.headers,
    },
    ...options,
  });

  if (!res.ok) {
    const error: StrapiError = await res.json().catch(() => ({
      status: res.status,
      name: "UnknownError",
      message: res.statusText,
    }));
    throw new Error(`Strapi error ${error.status}: ${error.message}`);
  }

  return res.json();
}

/**
 * Build a full Strapi media URL from a relative path.
 */
export function strapiMedia(path: string | null | undefined): string | null {
  if (!path) return null;
  if (path.startsWith("http")) return path;
  return `${STRAPI_URL}${path}`;
}
