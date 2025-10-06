/**
 * @typedef {Object} HomeStat
 * @property {string} label
 * @property {string} value
 * @property {string} suffix
 */

/**
 * @typedef {Object} FeatureHighlight
 * @property {string} icon
 * @property {string} title
 * @property {string} description
 */

/**
 * @typedef {Object} VisitorSample
 * @property {string} date
 * @property {number} count
 */

/**
 * @typedef {Object} TopPageEntry
 * @property {string} page
 * @property {number} views
 * @property {string} change
 */

/**
 * @typedef {Object} AnalyticsSnapshot
 * @property {{ totalVisitors: string; pageViews: string; bounceRate: string; avgDuration: string }} metrics
 * @property {VisitorSample[]} visitors
 * @property {TopPageEntry[]} topPages
 */

/** @type {HomeStat[]} */
export const homeStats = [
	{ label: 'Costo mensual', value: '$0', suffix: '' },
	{ label: 'Uptime', value: '99.9', suffix: '%' },
	{ label: 'Latencia', value: '<50', suffix: 'ms' },
	{ label: 'Privacidad', value: '100', suffix: '%' }
];

/** @type {FeatureHighlight[]} */
export const featureHighlights = [
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

/** @type {AnalyticsSnapshot} */
export const analyticsSnapshot = {
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
