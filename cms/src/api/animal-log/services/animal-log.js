'use strict';

/**
 * animal-log service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::animal-log.animal-log');
