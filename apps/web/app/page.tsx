import { strapi } from "@/lib/strapi";

export default async function Home() {
  // Example: fetch from Strapi (will fail until you create content types)
  // const { data } = await strapi("/api/articles?populate=*");

  return (
    <main className="flex min-h-screen flex-col items-center justify-center gap-8 p-8">
      <div className="text-center space-y-4">
        <h1 className="text-4xl font-bold tracking-tight">
          Next.js + Strapi Starter
        </h1>
        <p className="text-lg text-gray-600 max-w-md">
          Your full-stack project is ready. Create content types in Strapi and
          start building.
        </p>
      </div>

      <div className="flex gap-4">
        <a
          href="http://localhost:1337/admin"
          target="_blank"
          rel="noopener noreferrer"
          className="rounded-lg bg-indigo-600 px-6 py-3 text-sm font-medium text-white hover:bg-indigo-700 transition-colors"
        >
          Open Strapi Admin
        </a>
        <a
          href="https://docs.strapi.io"
          target="_blank"
          rel="noopener noreferrer"
          className="rounded-lg border border-gray-300 px-6 py-3 text-sm font-medium text-gray-700 hover:bg-gray-50 transition-colors"
        >
          Strapi Docs
        </a>
      </div>
    </main>
  );
}
