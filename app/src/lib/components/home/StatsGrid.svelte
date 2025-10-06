<script>
	/** @type {{ stats?: import('$lib/data/home.js').HomeStat[] }} */
	let { stats = [] } = $props();
</script>

<section class="container mx-auto px-6 text-primary-50">
	<div class="mb-16 grid grid-cols-2 gap-4 md:grid-cols-4">
		{#each stats as stat}
			<div class="rounded-lg border border-primary-800 bg-primary-900 p-6 shadow-lg shadow-primary-950/40">
				<div class="text-3xl font-bold text-primary-50">
					{stat.value}<span class="text-primary-200">{stat.suffix}</span>
				</div>
				<div class="mt-1 text-sm text-primary-300">{stat.label}</div>
			</div>
		{/each}
	</div>
</section>
