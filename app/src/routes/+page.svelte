<script>
	import HeroSection from '$lib/components/home/HeroSection.svelte';
	import StatsGrid from '$lib/components/home/StatsGrid.svelte';
	import LiveStatus from '$lib/components/home/LiveStatus.svelte';
	import FeaturesSection from '$lib/components/home/FeaturesSection.svelte';
	import AnalyticsSection from '$lib/components/home/AnalyticsSection.svelte';
	import DeployFlow from '$lib/components/home/DeployFlow.svelte';
	import { analyticsSnapshot, featureHighlights, homeStats } from '$lib/data/home.js';
	import { deployDashboard, deploySteps } from '$lib/data/deploy.js';

	let isDeployFlowOpen = $state(false);

	const openDeployFlow = () => {
		isDeployFlowOpen = true;
	};

	const closeDeployFlow = () => {
		isDeployFlowOpen = false;
	};
</script>

<div class="space-y-16 pb-24">
	<HeroSection onStartDeploy={openDeployFlow} />
	<StatsGrid stats={homeStats} />
	<LiveStatus />
	<FeaturesSection features={featureHighlights} />
	<AnalyticsSection analytics={analyticsSnapshot} />
</div>

<DeployFlow open={isDeployFlowOpen} steps={deploySteps} summary={deployDashboard} onClose={closeDeployFlow} />
