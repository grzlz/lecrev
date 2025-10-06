<script>
	/** @type {{ features?: import('$lib/data/home.js').FeatureHighlight[] }} */
	let { features = [] } = $props();
</script>

<section id="caracteristicas" class="container mx-auto px-6 pb-24">
	<div class="grid gap-4 md:grid-cols-3">
		{#each features as feature}
			<div class="group rounded-lg border border-primary-800 bg-primary-900 p-8 transition hover:border-secondary-500 hover:shadow-lg hover:shadow-secondary-500/25">
				<div class="mb-4 text-4xl text-secondary-300">{feature.icon}</div>
				<h3 class="mb-2 text-lg font-semibold text-primary-50">{feature.title}</h3>
				<p class="text-sm text-primary-300">{feature.description}</p>
			</div>
		{/each}
	</div>
</section>
