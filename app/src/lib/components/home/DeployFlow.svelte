<script>
import {
	deployDashboard as defaultDashboard,
	deploySteps as defaultSteps
} from '$lib/data/deploy.js';

	/** @type {{ open?: boolean; steps?: typeof defaultSteps; summary?: typeof defaultDashboard; onClose?: () => void }} */
	let {
		open = false,
		steps = defaultSteps,
		summary = defaultDashboard,
		onClose
	} = $props();

	let currentStep = $state(0);
	let stage = $state('steps'); // steps | deploying | dashboard

	const totalSteps = steps.length;
	/** @type {ReturnType<typeof setTimeout> | undefined} */
	let deployTimer;

	const reset = () => {
		currentStep = 0;
		stage = 'steps';
	};

	const close = () => {
		reset();
		onClose?.();
	};

	const goNext = () => {
		if (stage === 'steps') {
			if (currentStep < totalSteps - 1) {
				currentStep += 1;
			} else {
				stage = 'deploying';
			}
		} else if (stage === 'dashboard') {
			close();
		}
	};

	const goPrev = () => {
		if (stage === 'steps' && currentStep > 0) {
			currentStep -= 1;
		}
	};

	const cancel = () => {
		close();
	};

	$effect(() => {
		if (!open) {
			reset();
		}
	});

	$effect(() => {
		if (stage === 'deploying') {
			deployTimer = setTimeout(() => {
				stage = 'dashboard';
			}, 1800);
			return () => {
				if (deployTimer) {
					clearTimeout(deployTimer);
				}
			};
		}
	});
</script>

{#if open}
	<div class="fixed inset-0 z-50 flex items-center justify-center bg-primary-950/80 backdrop-blur">
		<div class="relative w-full max-w-4xl rounded-2xl border border-primary-800 bg-primary-900/95 p-6 shadow-xl shadow-primary-950/60">
			<header class="mb-6 flex items-start justify-between gap-4">
				<div>
					<p class="text-xs uppercase tracking-wide text-secondary-300/80">
						Demo · Flujo de despliegue
					</p>
					<h2 class="mt-1 text-2xl font-semibold text-primary-50">
						{#if stage === 'steps'}Paso {currentStep + 1} de {totalSteps}{:else if stage === 'deploying'}Desplegando cambios…{:else}Resultado del deploy{/if}
					</h2>
				</div>
				<button
					type="button"
					class="rounded-full border border-primary-700 p-2 text-primary-300 transition hover:border-secondary-500 hover:text-secondary-300"
					onclick={cancel}
					aria-label="Cerrar flujo de despliegue"
				>
					<svg class="h-4 w-4" viewBox="0 0 24 24" stroke="currentColor" fill="none" stroke-width="1.5">
						<path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
					</svg>
				</button>
			</header>

			{#if stage === 'steps'}
				<div class="grid gap-6 md:grid-cols-[1fr_260px]">
					<div>
						<ul class="space-y-3">
							{#each steps as step, index}
								{@const isCompleted = index < currentStep}
								{@const isActive = index === currentStep}
								<li
									class={`rounded-xl border p-4 transition ${
										isActive
											? 'border-secondary-500 bg-primary-800/80 shadow-lg shadow-secondary-500/20'
											: isCompleted
											? 'border-secondary-500/40 bg-primary-900'
											: 'border-primary-800 bg-primary-900 hover:border-primary-700'
									}`}
								>
									<div class="flex items-center gap-3">
										<span
											class={`flex h-7 w-7 items-center justify-center rounded-full text-xs font-semibold ${
												isActive
													? 'bg-secondary-500 text-primary-950'
												: isCompleted
													? 'bg-secondary-400/20 text-secondary-300'
												: 'bg-primary-800 text-primary-300'
											}`}
										>
											{index + 1}
										</span>
										<div>
											<h3 class="text-base font-semibold text-primary-50">{step.title}</h3>
											<p class="text-sm text-primary-300">{step.description}</p>
										</div>
									</div>
								</li>
							{/each}
						</ul>
					</div>

					<div class="flex flex-col justify-between gap-4 rounded-xl border border-primary-800 bg-primary-950/60 p-4">
						<div>
							<p class="text-xs uppercase tracking-wide text-primary-400">Comando</p>
							<div class="mt-2 rounded-lg border border-primary-800 bg-primary-900 p-3 font-mono text-sm text-secondary-300">
								{steps[currentStep]?.command}
							</div>
						</div>
						<div class="rounded-lg border border-secondary-500/20 bg-secondary-500/5 p-3 text-sm text-secondary-200">
							{steps[currentStep]?.hint}
						</div>
					</div>
				</div>

				<footer class="mt-6 flex flex-col gap-3 border-t border-primary-800 pt-4 md:flex-row md:items-center md:justify-between">
					<div class="flex items-center gap-2 text-xs text-primary-400">
						<div class="flex items-center gap-1">
							<span class="h-2 w-2 rounded-full bg-secondary-500"></span>
							<span>Activo</span>
						</div>
						<div class="flex items-center gap-1">
							<span class="h-2 w-2 rounded-full bg-secondary-400/20"></span>
							<span>Completado</span>
						</div>
					</div>
					<div class="flex justify-end gap-2">
						<button
							type="button"
							class="rounded-md border border-primary-700 px-4 py-2 text-sm font-medium text-primary-200 transition hover:border-secondary-500 hover:text-secondary-300 disabled:opacity-40"
							onclick={goPrev}
							disabled={currentStep === 0}
						>
							Atrás
						</button>
						<button
							type="button"
							class={`rounded-md px-4 py-2 text-sm font-semibold transition ${
								currentStep === totalSteps - 1
									? 'bg-secondary-500 text-primary-950 hover:bg-secondary-400'
									: 'bg-secondary-500/20 text-secondary-200 hover:bg-secondary-500 hover:text-primary-950'
							}`}
							onclick={goNext}
						>
							{currentStep === totalSteps - 1 ? 'Iniciar deploy' : 'Continuar'}
						</button>
					</div>
				</footer>
			{:else if stage === 'deploying'}
				<div class="flex flex-col items-center justify-center gap-6 py-12 text-center text-primary-200">
					<div class="relative h-16 w-16">
						<div class="absolute inset-0 animate-ping rounded-full bg-secondary-500/30"></div>
						<div class="relative flex h-16 w-16 items-center justify-center rounded-full bg-secondary-500 text-primary-950 shadow-lg shadow-secondary-500/40">
							<svg class="h-7 w-7" viewBox="0 0 24 24" stroke="currentColor" fill="none" stroke-width="1.5">
								<path stroke-linecap="round" stroke-linejoin="round" d="M4 17h16M4 12h16M4 7h16" />
							</svg>
						</div>
					</div>
					<div>
						<h3 class="text-xl font-semibold text-primary-50">Desplegando…</h3>
						<p class="mt-2 text-sm text-primary-300">
							Conectando con WSL2 vía Cloudflare Tunnel y refrescando PM2.
						</p>
					</div>
					<p class="text-xs uppercase tracking-[0.2em] text-secondary-300/70">Esto tomará unos segundos</p>
				</div>
				<footer class="flex items-center justify-end border-t border-primary-800 pt-4">
					<button
						type="button"
						class="rounded-md border border-primary-700 px-4 py-2 text-sm font-medium text-primary-200 transition hover:border-secondary-500 hover:text-secondary-300"
						onclick={cancel}
					>
						Cancelar demo
					</button>
				</footer>
		{:else}
			<section class="grid gap-6 md:grid-cols-[1.1fr_0.9fr]">
				<article class="rounded-xl border border-primary-800 bg-primary-950/60 p-4">
					<header class="flex flex-col gap-1 border-b border-primary-800 pb-3">
						<h3 class="text-lg font-semibold text-primary-50">Detalles del commit</h3>
							<p class="text-sm text-primary-300">{summary.commit.hash} · {summary.commit.message}</p>
							<p class="text-xs text-primary-400">{summary.commit.author} · {summary.commit.time}</p>
						</header>
						<ul class="mt-4 space-y-3">
							{#each summary.timeline as item}
								<li class="flex items-start justify-between gap-4 rounded-lg border border-primary-800 bg-primary-900/50 p-3">
									<div>
										<p class="text-sm font-medium text-primary-100">{item.label}</p>
										<p class="text-xs text-primary-400">Duración: {item.duration}</p>
									</div>
									<span class="inline-flex items-center rounded-full bg-secondary-500/15 px-2 py-0.5 text-xs font-semibold text-secondary-300">
										{item.status}
									</span>
								</li>
							{/each}
						</ul>
					</article>

					<aside class="flex flex-col gap-4">
						<div class="rounded-xl border border-secondary-500/20 bg-secondary-500/5 p-4">
							<h4 class="text-sm font-semibold uppercase tracking-wide text-secondary-300">Estado del entorno</h4>
							<p class="mt-2 text-sm text-primary-200">WSL2 · Ubuntu 22.04 · Cloudflare Tunnel activo</p>
						</div>
						<div class="grid gap-3">
							{#each summary.metrics as metric}
								<div class="rounded-lg border border-primary-800 bg-primary-900/60 p-3">
									<p class="text-xs uppercase tracking-wide text-primary-400">{metric.label}</p>
									<p class="mt-1 text-xl font-semibold text-primary-50">{metric.value}</p>
									<p class="text-xs text-secondary-300">Tendencia: {metric.trend}</p>
								</div>
							{/each}
						</div>
					</aside>
				</section>
				<footer class="mt-6 flex flex-col gap-3 border-t border-primary-800 pt-4 md:flex-row md:items-center md:justify-between">
					<div class="text-xs text-primary-400">Deploy listo. Puedes consultar métricas o repetir la demo.</div>
					<div class="flex flex-wrap gap-2">
						<button
							type="button"
							class="rounded-md border border-primary-700 px-4 py-2 text-sm font-medium text-primary-200 transition hover:border-secondary-500 hover:text-secondary-300"
							onclick={() => {
								stage = 'steps';
								currentStep = 0;
							}}
						>
							Volver a pasos
						</button>
						<a
							href="/analytics"
							class="rounded-md bg-secondary-500 px-4 py-2 text-sm font-semibold text-primary-950 transition hover:bg-secondary-400"
						>
							Ver analytics
						</a>
						<button
							type="button"
							class="rounded-md border border-primary-700 px-4 py-2 text-sm font-medium text-primary-200 transition hover:border-secondary-500 hover:text-secondary-300"
							onclick={close}
						>
							Cerrar demo
						</button>
					</div>
				</footer>
		{/if}
		</div>
	</div>
{/if}
