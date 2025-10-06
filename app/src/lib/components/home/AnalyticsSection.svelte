<script>
	/** @type {{ analytics?: import('$lib/data/home.js').AnalyticsSnapshot }} */
	let { analytics } = $props();

	const visitorCounts = analytics?.visitors?.map((entry) => entry.count) ?? [];
	const maxCount = visitorCounts.length ? Math.max(...visitorCounts) : 0;
</script>

<section id="analytics" class="container mx-auto px-6 pb-24 text-primary-50">
	<div class="mb-8">
		<h2 class="mb-2 text-3xl font-bold text-primary-50">Analytics privados con Umami</h2>
		<p class="text-primary-300">Datos reales sin comprometer la privacidad de tus usuarios</p>
	</div>

	<div class="mb-6 grid grid-cols-2 gap-4 md:grid-cols-4">
		<div class="rounded-lg border border-primary-800 bg-primary-900 p-4">
			<div class="text-sm text-primary-300">Visitantes únicos</div>
			<div class="mt-1 text-2xl font-bold text-primary-50">{analytics?.metrics?.totalVisitors}</div>
		</div>
		<div class="rounded-lg border border-primary-800 bg-primary-900 p-4">
			<div class="text-sm text-primary-300">Vistas de página</div>
			<div class="mt-1 text-2xl font-bold text-primary-50">{analytics?.metrics?.pageViews}</div>
		</div>
		<div class="rounded-lg border border-primary-800 bg-primary-900 p-4">
			<div class="text-sm text-primary-300">Bounce rate</div>
			<div class="mt-1 text-2xl font-bold text-primary-50">{analytics?.metrics?.bounceRate}</div>
		</div>
		<div class="rounded-lg border border-primary-800 bg-primary-900 p-4">
			<div class="text-sm text-primary-300">Duración promedio</div>
			<div class="mt-1 text-2xl font-bold text-primary-50">{analytics?.metrics?.avgDuration}</div>
		</div>
	</div>

	<div class="grid gap-4 md:grid-cols-3">
		<div class="rounded-lg border border-primary-800 bg-primary-900 p-6 md:col-span-2">
			<h3 class="mb-4 text-sm font-medium text-primary-300">Visitantes (última semana)</h3>
			<div class="flex items-end justify-between gap-2" style="height: 200px">
				{#each analytics?.visitors ?? [] as day}
					<div class="flex flex-1 flex-col items-center justify-end gap-2">
						<div
							class="w-full rounded-t bg-secondary-500 transition hover:bg-secondary-400"
							style={`height: ${maxCount ? (day.count / maxCount) * 100 : 0}%`}
						></div>
						<div class="text-xs text-primary-300">{day.date}</div>
					</div>
				{/each}
			</div>
		</div>

		<div class="rounded-lg border border-primary-800 bg-primary-900 p-6">
			<h3 class="mb-4 text-sm font-medium text-primary-300">Páginas principales</h3>
			<div class="space-y-4">
				{#each analytics?.topPages ?? [] as page}
					<div>
						<div class="mb-1 flex items-center justify-between">
							<span class="text-sm text-primary-100">{page.page}</span>
							<span class="text-xs text-secondary-300">{page.change}</span>
						</div>
						<div class="text-xs text-primary-300">{page.views} vistas</div>
					</div>
				{/each}
			</div>
		</div>
	</div>
</section>
