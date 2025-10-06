<script>
	import { footerBrand as defaultBrand, footerMetaLinks as defaultMeta, footerSections as defaultSections } from '$lib/data/footer.js';

	/** @type {{ brand?: typeof defaultBrand; sections?: typeof defaultSections; metaLinks?: typeof defaultMeta }} */
	let { brand = defaultBrand, sections = defaultSections, metaLinks = defaultMeta } = $props();

	const currentYear = new Date().getFullYear();
</script>

<footer class="border-t border-primary-800 bg-primary-950 text-primary-300">
	<div class="container mx-auto grid gap-12 px-6 py-16 md:grid-cols-4">
		<div>
			<div class="flex items-center gap-2">
				<span class="text-xl font-semibold text-primary-50">{brand.name}</span>
				<span class="rounded-md bg-secondary-500/20 px-2 py-0.5 text-xs font-medium text-secondary-200 ring-1 ring-secondary-500/30">
					LIVE
				</span>
			</div>
			<p class="mt-4 max-w-xs text-sm text-primary-300">{brand.tagline}</p>
		</div>

		{#each sections as section}
			<div>
				<h3 class="mb-3 text-sm font-semibold uppercase tracking-wide text-primary-100">{section.title}</h3>
				<ul class="space-y-2">
					{#each section.links as link}
						<li>
							<a
								href={link.href}
								target={link.external ? '_blank' : undefined}
								rel={link.external ? 'noreferrer noopener' : undefined}
								class="text-sm text-primary-300 transition hover:text-secondary-300"
							>
								{link.label}
							</a>
						</li>
					{/each}
				</ul>
			</div>
		{/each}
	</div>

	<div class="border-t border-primary-800 bg-primary-900/60">
		<div class="container mx-auto flex flex-col gap-4 px-6 py-6 text-xs text-primary-400 md:flex-row md:items-center md:justify-between">
			<span>© {currentYear} {brand.name}. Hecho en Hispanoamérica.</span>
			<ul class="flex flex-wrap gap-4">
				{#each metaLinks as link}
					<li>
						<a
							href={link.href}
							class="transition hover:text-secondary-300"
						>
							{link.label}
						</a>
					</li>
				{/each}
			</ul>
		</div>
	</div>
</footer>
