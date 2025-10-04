<script>
	import HeroSection from '$lib/components/home/HeroSection.svelte';
	import StatsGrid from '$lib/components/home/StatsGrid.svelte';
	import LiveStatus from '$lib/components/home/LiveStatus.svelte';
	import FeaturesSection from '$lib/components/home/FeaturesSection.svelte';
	import AnalyticsSection from '$lib/components/home/AnalyticsSection.svelte';
	import { analyticsSnapshot, featureHighlights, homeStats } from '$lib/data/home.js';
</script>

<div class="min-h-screen bg-black">
	<HeroSection />
	<StatsGrid stats={homeStats} />
	<LiveStatus />
	<FeaturesSection features={featureHighlights} />
	<AnalyticsSection analytics={analyticsSnapshot} />
</div>
