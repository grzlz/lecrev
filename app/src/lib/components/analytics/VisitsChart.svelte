<script>
	import { onMount } from 'svelte';
	import { scaleBand, scaleLinear } from 'd3-scale';
	import { select } from 'd3-selection';
	import { axisBottom, axisLeft } from 'd3-axis';
	import { max } from 'd3-array';
	import { transition } from 'd3-transition';
	import { easeCubicOut } from 'd3-ease';

	/** @type {{ data: import('$lib/data/analytics.js').AnalyticsVisitPoint[] }} */
	let { data } = $props();

	const margin = { top: 16, right: 16, bottom: 32, left: 48 };
	const width = 520;
	const height = 220;
	const innerWidth = width - margin.left - margin.right;
	const innerHeight = height - margin.top - margin.bottom;

	/** @type {SVGSVGElement | undefined} */
	let svgEl;
	/** @type {SVGGElement | undefined} */
	let barsGroupEl;
	/** @type {SVGGElement | undefined} */
	let xAxisGroupEl;
	/** @type {SVGGElement | undefined} */
	let yAxisGroupEl;

	/** @type {any} */
	let barsGroup;
	/** @type {any} */
	let xAxisGroup;
	/** @type {any} */
	let yAxisGroup;

	const renderChart = () => {
		if (!barsGroup || !xAxisGroup || !yAxisGroup || !data?.length) return;

		const xScale = scaleBand()
			.domain(data.map((/** @type {import('$lib/data/analytics.js').AnalyticsVisitPoint} */ point) => point.label))
			.range([0, innerWidth])
			.padding(0.25);

		const maxValue = max(data, (/** @type {import('$lib/data/analytics.js').AnalyticsVisitPoint} */ point) => point.value) ?? 0;
		const yScale = scaleLinear()
			.domain([0, maxValue * 1.1 || 1])
			.range([innerHeight, 0])
			.nice();

		const animation = transition().duration(600).ease(easeCubicOut);

		const bars = barsGroup
			.selectAll('rect')
			.data(data, (/** @type {import('$lib/data/analytics.js').AnalyticsVisitPoint} */ point) => point.label);

		bars
			.join(
				(/** @type {any} */ enter) =>
					enter
						.append('rect')
						.attr('x', (/** @type {import('$lib/data/analytics.js').AnalyticsVisitPoint} */ point) => xScale(point.label) ?? 0)
						.attr('y', innerHeight)
						.attr('height', 0)
						.attr('width', xScale.bandwidth())
						.attr('rx', 6)
						.attr('class', 'fill-secondary-500/80')
						.call((/** @type {any} */ selection) =>
							selection
								.transition(animation)
								.attr('y', (/** @type {import('$lib/data/analytics.js').AnalyticsVisitPoint} */ point) => yScale(point.value))
								.attr('height', (/** @type {import('$lib/data/analytics.js').AnalyticsVisitPoint} */ point) => innerHeight - yScale(point.value))
						),
				(/** @type {any} */ update) =>
					update.call((/** @type {any} */ selection) =>
						selection
							.transition(animation)
							.attr('x', (/** @type {import('$lib/data/analytics.js').AnalyticsVisitPoint} */ point) => xScale(point.label) ?? 0)
							.attr('width', xScale.bandwidth())
							.attr('y', (/** @type {import('$lib/data/analytics.js').AnalyticsVisitPoint} */ point) => yScale(point.value))
							.attr('height', (/** @type {import('$lib/data/analytics.js').AnalyticsVisitPoint} */ point) => innerHeight - yScale(point.value))
						),
				(/** @type {any} */ exit) =>
					exit.call((/** @type {any} */ selection) =>
						selection
							.transition(animation)
							.attr('y', innerHeight)
							.attr('height', 0)
							.remove()
					)
			)
			.attr('opacity', 0.95);

		xAxisGroup
			.transition(animation)
			.call(axisBottom(xScale).tickSizeOuter(0))
			.call((/** @type {any} */ selection) => {
				selection.selectAll('text').attr('fill', 'currentColor');
				selection.selectAll('line').attr('stroke', 'currentColor');
			});

		yAxisGroup
			.transition(animation)
			.call(axisLeft(yScale).ticks(4).tickSizeOuter(0))
			.call((/** @type {any} */ selection) => {
				selection.selectAll('text').attr('fill', 'currentColor');
				selection.selectAll('line').attr('stroke', 'currentColor');
				selection.selectAll('path').attr('stroke', 'currentColor');
			});
	};

	onMount(() => {
		const svg = select(svgEl);
		barsGroup = select(barsGroupEl);
		xAxisGroup = select(xAxisGroupEl);
		yAxisGroup = select(yAxisGroupEl);

		svg
			.attr('viewBox', `0 0 ${width} ${height}`)
			.attr('preserveAspectRatio', 'xMidYMid meet');

		renderChart();

		return () => {
			barsGroup = undefined;
			xAxisGroup = undefined;
			yAxisGroup = undefined;
		};
	});

	$effect(renderChart);
</script>

<div class="h-[220px] w-full">
	<svg bind:this={svgEl} class="h-full w-full" aria-hidden="true">
		<g transform={`translate(${margin.left},${margin.top})`}>
			<g bind:this={barsGroupEl}></g>
			<g bind:this={xAxisGroupEl} transform={`translate(0, ${innerHeight})`} class="text-[10px] text-primary-400"></g>
			<g bind:this={yAxisGroupEl} class="text-[10px] text-primary-400"></g>
		</g>
	</svg>
</div>
