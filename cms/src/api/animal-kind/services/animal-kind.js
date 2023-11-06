'use strict';

/**
 * animal-kind service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::animal-kind.animal-kind');
