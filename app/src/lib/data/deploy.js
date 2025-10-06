/**
 * @typedef {Object} DeployStep
 * @property {string} title
 * @property {string} description
 * @property {string} command
 * @property {string} [hint]
 */

/**
 * @typedef {Object} DeployTimelineItem
 * @property {string} label
 * @property {string} status
 * @property {string} duration
 */

/**
 * @typedef {Object} DeployMetric
 * @property {string} label
 * @property {string} value
 * @property {string} trend
 */

/**
 * @typedef {Object} DeployDashboard
 * @property {{ hash: string; message: string; author: string; time: string }} commit
 * @property {DeployTimelineItem[]} timeline
 * @property {DeployMetric[]} metrics
 */

/** @type {DeployStep[]} */
export const deploySteps = [
	{
		title: 'Preparar cambios',
		description: 'Confirma que los tests pasan en tu máquina antes de integrar.',
		command: 'npm run check',
		hint: 'Mantén el main siempre verde para despliegues seguros.'
	},
	{
		title: 'Push a GitHub',
		description: 'Sube la rama principal para que se dispare el workflow.',
		command: 'git push origin main',
		hint: 'GitHub Actions arranca en cuanto detecta el push.'
	},
	{
		title: 'Construir en CI',
		description: 'La acción mock construye el front y verifica el proyecto.',
		command: 'npm install && npm run check',
		hint: 'Usamos Node 20 y cacheo de npm para acelerar.'
	},
	{
		title: 'Publicar artefactos',
		description: 'El runner empaqueta el build y lo deja listo para producción.',
		command: 'tar -czf app.tar.gz build/',
		hint: 'El bundle queda disponible en /opt/lecrev/releases.'
	},
	{
		title: 'Deploy a la laptop',
		description: 'El runner se conecta vía Cloudflare Tunnel a WSL2.',
		command: 'ssh deploy@mock-host "pm2 reload lecrev-app"',
		hint: 'Todo viaja cifrado, sin exponer puertos públicos.'
	},
	{
		title: 'Verificar estado',
		description: 'Comprueba métricas y logs para confirmar el despliegue.',
		command: 'umami.lecrev.local / pm2 logs',
		hint: 'Si algo falla, revertimos con git y reiniciamos el proceso.'
	}
];

/** @type {DeployDashboard} */
export const deployDashboard = {
	commit: {
		hash: '2c8b1d4',
		message: 'feat: modulariza flujo de despliegue',
		author: 'guillermo',
		time: '02:51:33'
	},
	timeline: [
		{ label: 'Git push recibido', status: 'Completado', duration: '2s' },
		{ label: 'CI · npm run check', status: 'Completado', duration: '42s' },
		{ label: 'Build estático', status: 'Completado', duration: '18s' },
		{ label: 'Transferencia SSH', status: 'Completado', duration: '9s' },
		{ label: 'PM2 reload', status: 'Completado', duration: '3s' }
	],
	metrics: [
		{ label: 'Latencia global', value: '42ms', trend: 'estable' },
		{ label: 'CPU host', value: '36%', trend: '↓4%' },
		{ label: 'Memoria app', value: '512MB', trend: '↓12%' }
	]
};
