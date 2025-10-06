<script>
	let { onStartDeploy } = $props();

	const handleDeploy = () => {
		onStartDeploy?.();
	};

	const scrollToDocs = () => {
		if (typeof document === 'undefined') return;
		document.getElementById('caracteristicas')?.scrollIntoView({ behavior: 'smooth' });
	};
</script>

<section id="inicio" class="container mx-auto px-6 py-24 text-center text-primary-50">
	<div class="mx-auto max-w-4xl">
		<h1 class="mb-6 text-6xl font-bold leading-tight tracking-tight text-primary-50 md:text-7xl">
			Recuperemos el internet
			<span class="bg-gradient-to-br from-secondary-300 to-secondary-500 bg-clip-text text-transparent">
				en Hispanoamérica
			</span>
		</h1>
		<p class="mb-10 text-lg text-primary-200 md:text-xl">
			La nube ha resultado contraproducente. Esta infraestructura corre en una laptop gamer y te
			muestra cómo hacerlo tú también.
		</p>
		<div class="mb-20 flex flex-col items-center justify-center gap-4 sm:flex-row">
			<button
				type="button"
				class="rounded-md bg-secondary-500 px-6 py-2.5 text-sm font-medium text-primary-950 transition hover:bg-secondary-400"
				onclick={handleDeploy}
			>
				Desplegar
			</button>
			<button
				type="button"
				class="rounded-md border border-primary-600 px-6 py-2.5 text-sm font-medium text-primary-200 transition hover:border-secondary-500 hover:text-secondary-300"
				onclick={scrollToDocs}
			>
				Documentación
			</button>
		</div>
	</div>
</section>
