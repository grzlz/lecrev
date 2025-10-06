/**
 * @typedef {Object} NavLink
 * @property {string} label
 * @property {string} href
 */

/**
 * @typedef {Object} NavCta
 * @property {string} label
 * @property {string} href
 * @property {string} [icon]
 */

/** @type {NavLink[]} */
export const primaryNavLinks = [
	{ label: 'Inicio', href: '#inicio' },
	{ label: 'Características', href: '#caracteristicas' },
	{ label: 'Infraestructura', href: '#infraestructura' },
	{ label: 'Analytics', href: '#analytics' }
];

/** @type {NavCta} */
export const primaryNavCta = {
	label: 'Repositorio',
	href: 'https://github.com/grzlz/lecrev',
	icon: '↗'
};
