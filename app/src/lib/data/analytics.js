/**
 * @typedef {Object} AnalyticsMetric
 * @property {string} label
 * @property {string} value
 * @property {string} delta
 * @property {'up' | 'down' | 'flat'} trend
 */

/**
 * @typedef {Object} AnalyticsVisitPoint
 * @property {string} label
 * @property {number} value
 */

/**
 * @typedef {Object} AnalyticsSource
 * @property {string} source
 * @property {string} percent
 * @property {string} change
 */

/**
 * @typedef {Object} AnalyticsEvent
 * @property {string} name
 * @property {string} count
 * @property {string} conversion
 */

/**
 * @typedef {Object} AnalyticsRegion
 * @property {string} region
 * @property {string} percent
 * @property {string} latency
 */

/**
 * @typedef {Object} AnalyticsDataset
 * @property {AnalyticsMetric[]} metrics
 * @property {AnalyticsVisitPoint[]} visits
 * @property {AnalyticsSource[]} sources
 * @property {AnalyticsEvent[]} events
 * @property {AnalyticsRegion[]} regions
 */


/** @type {AnalyticsDataset} */
export const postDeployAnalytics = {
	metrics: [
		{ label: 'Visitantes únicos', value: '1.2k', delta: '+18%', trend: 'up' },
		{ label: 'Sesiones', value: '2.9k', delta: '+11%', trend: 'up' },
		{ label: 'Conversiones', value: '214', delta: '+6%', trend: 'flat' },
		{ label: 'Errores 5xx', value: '0', delta: '0%', trend: 'flat' }
	],
	visits: [
		{ label: '00:00', value: 35 },
		{ label: '03:00', value: 52 },
		{ label: '06:00', value: 68 },
		{ label: '09:00', value: 112 },
		{ label: '12:00', value: 174 },
		{ label: '15:00', value: 198 },
		{ label: '18:00', value: 221 },
		{ label: '21:00', value: 187 }
	],
	sources: [
		{ source: 'Directo', percent: '44%', change: '+8%' },
		{ source: 'Referrals', percent: '27%', change: '+3%' },
		{ source: 'Orgánico', percent: '19%', change: '+1%' },
		{ source: 'Social', percent: '10%', change: '+2%' }
	],
	events: [
		{ name: 'Registro completado', count: '142', conversion: '32%' },
		{ name: 'Demo solicitada', count: '68', conversion: '18%' },
		{ name: 'Descarga script', count: '51', conversion: '12%' }
	],
	regions: [
		{ region: 'CDMX, MX', percent: '36%', latency: '38ms' },
		{ region: 'Bogotá, CO', percent: '22%', latency: '51ms' },
		{ region: 'Buenos Aires, AR', percent: '17%', latency: '64ms' },
		{ region: 'Madrid, ES', percent: '8%', latency: '92ms' }
	]
};
