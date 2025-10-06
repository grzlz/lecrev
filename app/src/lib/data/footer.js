/**
 * @typedef {Object} FooterLink
 * @property {string} label
 * @property {string} href
 * @property {boolean} [external]
 */

/**
 * @typedef {Object} FooterSection
 * @property {string} title
 * @property {FooterLink[]} links
 */

/**
 * @typedef {Object} FooterBrand
 * @property {string} name
 * @property {string} tagline
 */

/** @type {FooterBrand} */
export const footerBrand = {
	name: 'lecrev',
	tagline: 'Infraestructura soberana en tu propia máquina'
};

/** @type {FooterSection[]} */
export const footerSections = [
	{
		title: 'Mapa',
		links: [
			{ label: 'Inicio', href: '#inicio' },
			{ label: 'Características', href: '#caracteristicas' },
			{ label: 'Infraestructura', href: '#infraestructura' },
			{ label: 'Analytics', href: '#analytics' }
		]
	},
	{
		title: 'Recursos',
		links: [
			{ label: 'Repositorio', href: 'https://github.com/grzlz/lecrev', external: true },
			{ label: 'Roadmap', href: '/roadmap' },
			{ label: 'CI/CD', href: '/docs/ci-cd' }
		]
	},
	{
		title: 'Contacto',
		links: [
			{ label: 'Email', href: 'mailto:hola@lecrev.mx', external: true },
			{ label: 'Twitter', href: 'https://twitter.com/grzlz', external: true }
		]
	}
];

/** @type {FooterLink[]} */
export const footerMetaLinks = [
	{ label: 'Privacidad', href: '/docs/privacidad' },
	{ label: 'Términos', href: '/docs/terminos' }
];
