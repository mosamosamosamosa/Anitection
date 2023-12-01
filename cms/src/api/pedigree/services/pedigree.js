'use strict';

/**
 * pedigree service
 */

const { createCoreService } = require('@strapi/strapi').factories;

module.exports = createCoreService('api::pedigree.pedigree');
