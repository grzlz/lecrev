<script>
	const stats = [
		{ label: 'Costo mensual', value: '$0', suffix: '' },
		{ label: 'Uptime', value: '99.9', suffix: '%' },
		{ label: 'Latencia', value: '<50', suffix: 'ms' },
		{ label: 'Privacidad', value: '100', suffix: '%' }
	];

	const features = [
		{
			icon: '🏠',
			title: 'Self-hosted',
			description: 'Tu infraestructura, tu control. Sin intermediarios.'
		},
		{
			icon: '🔒',
			title: 'Privacidad total',
			description: 'Analytics que respetan a tus usuarios. Nada de Google.'
		},
		{
			icon: '⚡',
			title: 'CI/CD automático',
			description: 'Push to deploy. GitHub Actions → Tu laptop → Live.'
		}
	];

	const analyticsData = {
		visitors: [
			{ date: 'Lun', count: 245 },
			{ date: 'Mar', count: 312 },
			{ date: 'Mié', count: 428 },
			{ date: 'Jue', count: 389 },
			{ date: 'Vie', count: 521 },
			{ date: 'Sáb', count: 198 },
			{ date: 'Dom', count: 167 }
		],
		topPages: [
			{ page: '/', views: 1247, change: '+12%' },
			{ page: '/docs', views: 823, change: '+8%' },
			{ page: '/api', views: 456, change: '+23%' }
		],
		metrics: {
			totalVisitors: '2.3k',
			pageViews: '5.8k',
			bounceRate: '42%',
			avgDuration: '3m 24s'
		}
	};
</script>

<!-- Hero Section -->
<div class="min-h-screen bg-black">
	<!-- Navigation -->
	<nav class="border-b border-gray-800">
		<div class="container mx-auto flex items-center justify-between px-6 py-4">
			<div class="flex items-center gap-3">
				<span class="text-xl font-semibold text-white">lecrev</span>
				<span class="rounded-md bg-green-500/10 px-2 py-0.5 text-xs font-medium text-green-400 ring-1 ring-green-500/20">
					LIVE
				</span>
			</div>
			<a
				href="https://github.com/grzlz/lecrev"
				class="rounded-md border border-gray-800 bg-black px-4 py-1.5 text-sm text-gray-300 transition hover:border-gray-700 hover:text-white"
			>
				GitHub
			</a>
		</div>
	</nav>

	<!-- Main Hero Content -->
	<div class="container mx-auto px-6 py-24">
		<div class="mx-auto max-w-4xl text-center">
			<!-- Main Headline -->
			<h1 class="mb-6 text-6xl font-bold leading-tight tracking-tight text-white md:text-7xl">
				Recuperemos el internet
				<span class="bg-gradient-to-br from-white to-gray-400 bg-clip-text text-transparent">
					en Hispanoamérica
				</span>
			</h1>

			<!-- Subheadline -->
			<p class="mb-10 text-lg text-gray-400 md:text-xl">
				La nube ha resultado contraproducente. Esta infraestructura corre en una laptop gamer y
				te muestra cómo hacerlo tú también.
			</p>

			<!-- CTA Buttons -->
			<div class="mb-20 flex flex-col items-center justify-center gap-4 sm:flex-row">
				<button
					class="rounded-md bg-white px-6 py-2.5 text-sm font-medium text-black transition hover:bg-gray-100"
				>
					Desplegar
				</button>
				<button
					class="rounded-md border border-gray-800 bg-black px-6 py-2.5 text-sm font-medium text-gray-300 transition hover:border-gray-700 hover:text-white"
				>
					Documentación
				</button>
			</div>

			<!-- Stats Grid -->
			<div class="mb-16 grid grid-cols-2 gap-4 md:grid-cols-4">
				{#each stats as stat}
					<div class="rounded-lg border border-gray-800 bg-gray-950 p-6">
						<div class="text-3xl font-bold text-white">
							{stat.value}<span class="text-gray-400">{stat.suffix}</span>
						</div>
						<div class="mt-1 text-sm text-gray-500">{stat.label}</div>
					</div>
				{/each}
			</div>

			<!-- Live Status -->
			<div class="inline-flex items-center gap-2 rounded-md border border-gray-800 bg-gray-950 px-4 py-2">
				<div class="relative flex h-2 w-2">
					<span class="absolute inline-flex h-full w-full animate-ping rounded-full bg-green-400 opacity-75"></span>
					<span class="relative inline-flex h-2 w-2 rounded-full bg-green-500"></span>
				</div>
				<span class="text-xs text-gray-400">
					Corriendo en WSL2 Ubuntu • Gaming Laptop • Sin AWS, sin Vercel, sin nube
				</span>
			</div>
		</div>
	</div>

	<!-- Features Section -->
	<div class="container mx-auto px-6 pb-24">
		<div class="grid gap-4 md:grid-cols-3">
			{#each features as feature}
				<div class="group rounded-lg border border-gray-800 bg-gray-950 p-8 transition hover:border-gray-700">
					<div class="mb-4 text-4xl">{feature.icon}</div>
					<h3 class="mb-2 text-lg font-semibold text-white">{feature.title}</h3>
					<p class="text-sm text-gray-500">{feature.description}</p>
				</div>
			{/each}
		</div>
	</div>

	<!-- Analytics Demo Section -->
	<div class="container mx-auto px-6 pb-24">
		<div class="mb-8">
			<h2 class="mb-2 text-3xl font-bold text-white">Analytics privados con Umami</h2>
			<p class="text-gray-500">Datos reales sin comprometer la privacidad de tus usuarios</p>
		</div>

		<!-- Analytics Metrics -->
		<div class="mb-6 grid grid-cols-2 gap-4 md:grid-cols-4">
			<div class="rounded-lg border border-gray-800 bg-gray-950 p-4">
				<div class="text-sm text-gray-500">Visitantes únicos</div>
				<div class="mt-1 text-2xl font-bold text-white">{analyticsData.metrics.totalVisitors}</div>
			</div>
			<div class="rounded-lg border border-gray-800 bg-gray-950 p-4">
				<div class="text-sm text-gray-500">Vistas de página</div>
				<div class="mt-1 text-2xl font-bold text-white">{analyticsData.metrics.pageViews}</div>
			</div>
			<div class="rounded-lg border border-gray-800 bg-gray-950 p-4">
				<div class="text-sm text-gray-500">Bounce rate</div>
				<div class="mt-1 text-2xl font-bold text-white">{analyticsData.metrics.bounceRate}</div>
			</div>
			<div class="rounded-lg border border-gray-800 bg-gray-950 p-4">
				<div class="text-sm text-gray-500">Duración promedio</div>
				<div class="mt-1 text-2xl font-bold text-white">{analyticsData.metrics.avgDuration}</div>
			</div>
		</div>

		<!-- Chart and Top Pages -->
		<div class="grid gap-4 md:grid-cols-3">
			<!-- Visitor Chart -->
			<div class="rounded-lg border border-gray-800 bg-gray-950 p-6 md:col-span-2">
				<h3 class="mb-4 text-sm font-medium text-gray-400">Visitantes (última semana)</h3>
				<div class="flex items-end justify-between gap-2" style="height: 200px">
					{#each analyticsData.visitors as day}
						<div class="flex flex-1 flex-col items-center justify-end gap-2">
							<div
								class="w-full rounded-t bg-white transition hover:bg-gray-300"
								style="height: {(day.count / 521) * 100}%"
							></div>
							<div class="text-xs text-gray-500">{day.date}</div>
						</div>
					{/each}
				</div>
			</div>

			<!-- Top Pages -->
			<div class="rounded-lg border border-gray-800 bg-gray-950 p-6">
				<h3 class="mb-4 text-sm font-medium text-gray-400">Páginas principales</h3>
				<div class="space-y-4">
					{#each analyticsData.topPages as page}
						<div>
							<div class="mb-1 flex items-center justify-between">
								<span class="text-sm text-white">{page.page}</span>
								<span class="text-xs text-green-400">{page.change}</span>
							</div>
							<div class="text-xs text-gray-500">{page.views} vistas</div>
						</div>
					{/each}
				</div>
			</div>
		</div>
	</div>
</div>
