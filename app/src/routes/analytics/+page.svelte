<script>
	import { onDestroy } from 'svelte';
	import PostDeployAnalytics from '$lib/components/analytics/PostDeployAnalytics.svelte';
	import { postDeployAnalytics } from '$lib/data/analytics.js';

	const baseMetrics = postDeployAnalytics.metrics.map((metric) => ({ ...metric }));
	const baseVisits = postDeployAnalytics.visits.map((point) => point.value);
	const baseSources = postDeployAnalytics.sources.map((item) => ({ ...item }));
	const baseEvents = postDeployAnalytics.events.map((evt) => ({ ...evt }));
	const baseRegions = postDeployAnalytics.regions.map((reg) => ({ ...reg }));

	let dataset = $state(structuredClone(postDeployAnalytics));

	const pickTrend = () => {
		const sample = Math.random();
		if (sample > 0.65) return 'up';
		if (sample < 0.2) return 'down';
		return 'flat';
	};

	/** @param {'up' | 'down' | 'flat'} trend */
	const trendDelta = (trend) => {
		if (trend === 'flat') return '0%';
		const magnitude = Math.floor(Math.random() * 6) + 2;
		return `${trend === 'up' ? '+' : '-'}${magnitude}%`;
	};

	/** @param {string} percent */
	const jitterPercent = (percent) => {
		const value = parseFloat(percent);
		const jitter = (Math.random() - 0.5) * 2; // -1 a 1 aprox
		return `${Math.max(0, Math.min(100, Math.round(value + jitter)))}%`;
	};

	const mutateDataset = () => {
		dataset = {
			metrics: baseMetrics.map((metric) => {
				const trend = pickTrend();
				return { ...metric, trend, delta: trendDelta(trend) };
			}),
			visits: baseVisits.map((base, idx) => ({
				label: postDeployAnalytics.visits[idx].label,
				value: Math.max(12, Math.round(base * (0.85 + Math.random() * 0.3)))
			})),
			sources: baseSources.map((item) => ({
				...item,
				percent: jitterPercent(item.percent),
				change: `${Math.random() > 0.5 ? '+' : '-'}${Math.floor(Math.random() * 4) + 1}%`
			})),
			events: baseEvents.map((evt) => ({
				...evt,
				count: `${Math.round(Number(evt.count) * (0.9 + Math.random() * 0.2))}`
			})),
			regions: baseRegions.map((region) => ({
				...region,
				latency: `${Math.max(25, Math.round(parseInt(region.latency, 10) * (0.9 + Math.random() * 0.15)))}ms`
			}))
		};
	};

	const timer = setInterval(mutateDataset, 4000);

	onDestroy(() => {
		clearInterval(timer);
	});
</script>

<section class="container mx-auto space-y-8 px-6 py-16">
	<header class="flex flex-col gap-2">
		<p class="text-xs uppercase tracking-wide text-secondary-300/80">Demo en vivo</p>
		<h1 class="text-3xl font-semibold text-primary-50">Analytics de despliegue</h1>
		<p class="text-sm text-primary-300">
			Datos simulados que se refrescan cada 4 segundos para emular tráfico real tras un deploy en WSL2.
		</p>
	</header>

	<PostDeployAnalytics dataset={dataset} />
</section>
