<script>
	import VisitsChart from '$lib/components/analytics/VisitsChart.svelte';

	/** @type {{ dataset: import('$lib/data/analytics.js').AnalyticsDataset }} */
	let { dataset } = $props();

	const trendClasses = {
		up: 'text-secondary-300',
		down: 'text-red-300',
		flat: 'text-primary-300'
	};
</script>

<section class="space-y-6">
	<header class="flex flex-col gap-2">
		<p class="text-xs uppercase tracking-wide text-secondary-300/80">Post deploy</p>
		<h3 class="text-xl font-semibold text-primary-50">Actividad en vivo</h3>
		<p class="text-sm text-primary-300">
			Últimos 24 minutos de tráfico simulados para validar el despliegue.
		</p>
	</header>

	<div class="grid gap-4 md:grid-cols-4">
		{#each dataset.metrics as metric}
			<div class="rounded-xl border border-primary-800 bg-primary-900/70 p-4">
				<p class="text-xs uppercase tracking-wide text-primary-400">{metric.label}</p>
				<p class="mt-2 text-2xl font-semibold text-primary-50">{metric.value}</p>
				<p class={`text-xs ${trendClasses[metric.trend]}`}>Variación {metric.delta}</p>
			</div>
		{/each}
	</div>

	<div class="grid gap-4 md:grid-cols-2">
		<div class="rounded-xl border border-primary-800 bg-primary-900/70 p-4">
			<div class="flex items-center justify-between">
				<h4 class="text-sm font-semibold text-primary-100">Visitas por bloque horario</h4>
				<span class="text-xs text-primary-400">Últimas 24h</span>
			</div>
			<div class="mt-4">
				<VisitsChart data={dataset.visits} />
			</div>
		</div>

		<div class="grid gap-4">
			<div class="rounded-xl border border-primary-800 bg-primary-900/70 p-4">
				<h4 class="text-sm font-semibold text-primary-100">Fuentes principales</h4>
				<ul class="mt-3 space-y-2">
					{#each dataset.sources as item}
						<li class="flex items-center justify-between rounded-lg border border-primary-800/80 bg-primary-950/50 px-3 py-2 text-sm text-primary-200">
							<span>{item.source}</span>
							<span class="flex items-center gap-2">
								<span>{item.percent}</span>
								<span class="text-secondary-300">{item.change}</span>
							</span>
						</li>
					{/each}
				</ul>
			</div>

			<div class="rounded-xl border border-primary-800 bg-primary-900/70 p-4">
				<h4 class="text-sm font-semibold text-primary-100">Eventos clave</h4>
				<ul class="mt-3 space-y-2">
					{#each dataset.events as evt}
						<li class="flex items-center justify-between rounded-lg border border-primary-800/80 bg-primary-950/50 px-3 py-2 text-sm text-primary-200">
							<span>{evt.name}</span>
							<span class="flex items-center gap-2">
								<span>{evt.count}</span>
								<span class="text-secondary-300">{evt.conversion}</span>
							</span>
						</li>
					{/each}
				</ul>
			</div>
		</div>
	</div>

	<div class="rounded-xl border border-primary-800 bg-primary-900/70 p-4">
		<h4 class="text-sm font-semibold text-primary-100">Rendimiento por región</h4>
		<table class="mt-3 w-full table-auto text-left text-sm text-primary-200">
			<thead class="text-xs uppercase tracking-wide text-primary-400">
				<tr>
					<th class="py-2">Región</th>
					<th class="py-2">Tráfico</th>
					<th class="py-2">Latencia</th>
				</tr>
			</thead>
			<tbody>
				{#each dataset.regions as region}
					<tr class="border-t border-primary-800/60">
						<td class="py-2">{region.region}</td>
						<td class="py-2">{region.percent}</td>
						<td class="py-2">{region.latency}</td>
					</tr>
				{/each}
			</tbody>
		</table>
	</div>
</section>
