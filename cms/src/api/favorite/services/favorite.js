'use strict';

/**
 * favorite service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::favorite.favorite');
