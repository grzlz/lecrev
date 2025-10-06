<script>
	/**
	 * @typedef {Object} NavLink
	 * @property {string} label
	 * @property {string} href
	 */

	/**
	 * @typedef {Object} NavCta
	 * @property {string} label
	 * @property {string} href
	 * @property {string} [icon]
	 */

	/** @type {{ links?: NavLink[]; cta?: NavCta }} */
	let { links = [], cta } = $props();
	let isMenuOpen = $state(false);

	const toggleMenu = () => {
		isMenuOpen = !isMenuOpen;
	};

	const closeMenu = () => {
		isMenuOpen = false;
	};
</script>

<nav class="border-b border-primary-800 bg-primary-900/85 text-primary-100 backdrop-blur supports-[backdrop-filter]:bg-primary-900/70">
	<div class="container mx-auto flex items-center justify-between px-6 py-4">
		<a href="#inicio" class="flex items-center gap-3" onclick={closeMenu}>
			<span class="text-xl font-semibold text-primary-50">lecrev</span>
			<span class="rounded-md bg-secondary-500/20 px-2 py-0.5 text-xs font-medium text-secondary-200 ring-1 ring-secondary-500/30">
				LIVE
			</span>
		</a>

		<button
			type="button"
			class="inline-flex items-center justify-center rounded-md border border-primary-700 p-2 text-primary-200 transition hover:border-secondary-500 hover:text-secondary-300 md:hidden"
			onclick={toggleMenu}
			aria-expanded={isMenuOpen}
			aria-controls="primary-navigation"
		>
			<span class="sr-only">Abrir menú</span>
			{#if isMenuOpen}
				<svg class="h-5 w-5" viewBox="0 0 24 24" stroke="currentColor" fill="none" stroke-width="1.5">
					<path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
				</svg>
			{:else}
				<svg class="h-5 w-5" viewBox="0 0 24 24" stroke="currentColor" fill="none" stroke-width="1.5">
					<path stroke-linecap="round" stroke-linejoin="round" d="M4 6h16M4 12h16M4 18h16" />
				</svg>
			{/if}
		</button>

		<div
			id="primary-navigation"
			class={`absolute left-0 right-0 top-16 z-40 border-b border-primary-800 bg-primary-900 px-6 md:static md:flex md:flex-1 md:items-center md:justify-end md:border-none md:bg-transparent md:px-0 ${
				isMenuOpen ? 'block' : 'hidden'
			} md:block`}
		>
			<ul class="flex flex-col gap-4 py-4 md:flex-row md:items-center md:gap-8 md:py-0">
				{#each links as link}
					<li>
						<a
							href={link.href}
							class="text-sm text-primary-200 transition hover:text-secondary-300"
							onclick={closeMenu}
						>
							{link.label}
						</a>
					</li>
				{/each}
				{#if cta}
					<li class="md:ml-4">
						<a
							href={cta.href}
							class="inline-flex items-center gap-2 rounded-md border border-secondary-500/70 px-4 py-2 text-sm font-medium text-secondary-300 transition hover:bg-secondary-500 hover:text-primary-950"
							onclick={closeMenu}
						>
							<span>{cta.label}</span>
							{#if cta.icon}
								<span aria-hidden="true">{cta.icon}</span>
							{/if}
						</a>
					</li>
				{/if}
			</ul>
		</div>
	</div>
</nav>
