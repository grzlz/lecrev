<script lang="ts">
	import '../app.css';
	import favicon from '$lib/assets/favicon.svg';
	import Footer from '$lib/components/layout/Footer.svelte';
	import Navbar from '$lib/components/navigation/Navbar.svelte';
	import { footerBrand, footerMetaLinks, footerSections } from '$lib/data/footer.js';
	import { primaryNavCta, primaryNavLinks } from '$lib/data/navigation.js';

	let { children } = $props();
</script>

<svelte:head>
	<link rel="icon" href={favicon} />
</svelte:head>

<Navbar links={primaryNavLinks} cta={primaryNavCta} />

<main>
	{@render children?.()}
</main>

<Footer brand={footerBrand} sections={footerSections} metaLinks={footerMetaLinks} />
