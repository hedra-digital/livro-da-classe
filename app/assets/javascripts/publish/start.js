/**
 * Created by Willianson
 * At 2015-01-20
 */


var publish_start = {
	

	/* properties
	---------------------------------------------------------------------------------------*/
	// example 	: true,


	/* initialization
	---------------------------------------------------------------------------------------*/
	init: function()
	{
		var me = this;

		// bind form
		me.bindForm();

		// bind input title
		me.bindInputTitle();

		// bind input title
		me.bindInputSubtitle();

		// set focus
		me.setFocus();
	},


	/* bind form
	---------------------------------------------------------------------------------------*/
	bindForm: function()
	{
		var me = this;

		// data
		var el_form = $('#publish-form');
		var rules_json = {
			'book[title]': { 
				required 	: true
				// TODO: remote validate.
			},
			'book[book_data][autor]': {
				required 	: true
			},
		};

		var before_func = function()
		{
			cleanbox.showContentLoading();
		}

		var callback_func = function(output)
		{
			cleanbox.hideContentLoading();

			// TODO: add chave type at JSON returns.
			if (output.uuid)
			{
				cleanbox.showOutput(true, 'Salvando...');
				location.href = '/books/' + output.uuid + '/edit';
			}
			else
				cleanbox.showOutput(output.type, output.result);

			// console.log('# callback')
			// console.log(output)
		}

		// form validate
		common.bindFormValidation(el_form, rules_json, before_func, callback_func);
	},


	/* bind input title
	---------------------------------------------------------------------------------------*/
	bindInputTitle: function()
	{
		var me = this;

		// elements
		var el_input_title 	= $('input[name=title]');
		var el_counter 		= $('#title-counter');

		// data
		var maxlength = 50;

		// action
		common.setMaxLength(el_input_title, el_counter, maxlength, 'Restam {length} caracteres', '{length} acima do permitido');

		el_input_title.on('focus', function()
		{
			if ( $(this).val().length > (maxlength * 0.3) )
				el_counter.stop(true,true).fadeIn(200);
		}).on('blur', function()
		{
			el_counter.stop(true,true).fadeOut(200);
		}).on('keyup', function()
		{
			var tip = el_counter;
			if ( $(this).val().length > (maxlength * 0.3) && !tip.is(':visible'))
				tip.stop(true,true).fadeIn(200);
		});
	},


	/* bind input subtitle
	---------------------------------------------------------------------------------------*/
	bindInputSubtitle: function()
	{
		var me = this;

		// elements
		var el_input_subtitle 	= $('input[name=subtitle]');
		var el_counter 			= $('#subtitle-counter');

		// data
		var maxlength = 50;

		// action
		common.setMaxLength(el_input_subtitle, el_counter, maxlength, 'Restam {length} caracteres', '{length} acima do permitido');

		el_input_subtitle.on('focus', function()
		{
			if ( $(this).val().length > (maxlength * 0.3) )
				el_counter.stop(true,true).fadeIn(200);
		}).on('blur', function()
		{
			el_counter.stop(true,true).fadeOut(200);
		}).on('keyup', function()
		{
			var tip = el_counter;
			if ( $(this).val().length > (maxlength * 0.3) && !tip.is(':visible'))
				tip.stop(true,true).fadeIn(200);
		});
	},


	/* set focus
	---------------------------------------------------------------------------------------*/
	setFocus: function()
	{
		var me = this;

		// elements
		var el_first_input = $('form input[type!="hidden"][class!="none"],form select').first();
		
		// action
		el_first_input.focus();
		
	},

};



$(document).ready(function()
{
	publish_start.init();
});