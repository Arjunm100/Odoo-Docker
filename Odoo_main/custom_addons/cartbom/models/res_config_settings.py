# -*- coding: utf-8 -*-

from odoo import fields, models
class ResConfigSettings(models.TransientModel):
   _inherit = 'res.config.settings'

   product_ids = fields.Many2many(comodel_name='product.template')