/**
 * Created by Willianson
 * At 2015-01-20
 */


var common = {
	

	/* properties
	---------------------------------------------------------------------------------------*/
	// example 	: true,


	/* initialization
	---------------------------------------------------------------------------------------*/
	init: function()
	{
		var me = this;

		// bind input checkbox
		me.bindInputCheckbox();

		// bind input radio
		me.bindInputRadio();
		
		// bind input select
		me.bindInputSelect();
	},


	/**
	 * Bind a validation to form.
	 * @param  {html_obj}	form_obj      		Ex: $('form')
	 * @param  {json} 		rules_json    		Ex: { name: {required:true}, email: {required:true} }
	 * @param  {function} 	before_func
	 * @param  {function} 	callback_func
	 * @return {void}       The return is sended to callback only.
	 */
	bindFormValidation: function(form_obj, rules_json, before_func, callback_func)
	{
		var me = this;

		// elements
		var el_form = form_obj;

		// action
		el_form.validate({
			rules			: rules_json,
			errorClass      : 'invalid',
			validClass      : '',
			errorPlacement 	: function(error, element)
			{
				return false;
			},
			highlight		: function(element, errorClass, validClass)
			{
				$(element).parent().addClass(errorClass);
			},
			unhighlight		: function(element, errorClass, validClass)
			{
				$(element).parent().removeClass(errorClass);
			},
			submitHandler   : function()
			{ 
				// data
				var form_url		= el_form.attr('action');
				var form_method		= el_form.attr('method');
				var form_data		= el_form.serializeArray();

				// action
				if (before_func())
					before_func();

				me.bridge(form_method, form_url, form_data, callback_func);
				return false;
			}
		});
	},


	/**
	 * Bind events on custom input checkbox.
	 * @return {void}
	 */
	bindInputCheckbox: function()
	{
		var me = this;

		// elements
		var el_form = $('form');

		// action
		el_form.on('change', 'div.form-item.checkbox input', function()
		{
			// elements
			var el_form_item = $(this).closest('.form-item');

			// action
			el_form_item.toggleClass('checked');
		});

		// _hover
		el_form.on('mouseenter', 'div.form-item.checkbox', function()
		{
			$(this).addClass('hover');
		});

		// _leave
		el_form.on('mouseleave', 'div.form-item.checkbox', function()
		{
			$(this).removeClass('hover');
		});
	},


	/**
	 * Bind events on custom input radio.
	 * @return {void}
	 */
	bindInputRadio: function()
	{
		var me = this;

		// elements
		var el_form = $('form');

		// action
		el_form.on('change', 'div.form-item.radio input', function()
		{
			// elements
			var el_form_item 		= $(this).closest('.form-item');
			var el_form_item_name	= $(this).attr('name');
			var el_form_group_items = $(this).closest('form').find('input[type="radio"][name="'+el_form_item_name+'"]');

			// action
			el_form_group_items.closest('.form-item').removeClass('checked');
			el_form_item.toggleClass('checked');
		});

		// _hover
		el_form.on('mouseenter', 'div.form-item.radio', function()
		{
			$(this).addClass('hover');
		});

		// _leave
		el_form.on('mouseleave', 'div.form-item.radio', function()
		{
			$(this).removeClass('hover');
		});
	},


	/**
	 * Bind events on custom input select.
	 * @return {void}
	 */
	bindInputSelect: function()
	{
		var me = this;

		// elements
		var el_form = $('form');

		// action
		el_form.on('change', 'div.form-item.select select', function()
		{
			// elements
			var el_input_viewer = $(this).next('input');

			// data
			var selected_text = $(this)[0].options[$(this)[0].selectedIndex].text;

			// action
			el_input_viewer.val(selected_text);
		});

		// _hover
		el_form.on('mouseenter', 'div.form-item.select select', function()
		{
			$(this).next('input').addClass('hover');
		});

		// _leave
		el_form.on('mouseleave', 'div.form-item.select select', function()
		{
			$(this).next('input').removeClass('hover');
		});

		// _focus
		el_form.on('focus', 'div.form-item.select select', function()
		{
			$(this).click();
			$(this).next('input').addClass('focus');
		});

		// _blur
		el_form.on('blur', 'div.form-item.select select', function()
		{
			$(this).next('input').removeClass('focus');
		});
	},


	/**
	 * Sends data to url by ajax and returns output json to callback.
	 * @param  {string} 	_url
	 * @param  {json} 		_data     		Ex: { name: john, age: 20 }
	 * @param  {function} 	_callback 
	 * @return {void}
	 */
	bridge: function(_method, _url, _data, _callback)
	{
		var me = this;

		// callback
		var _callback = _callback || null;

		// action
		$.post(_url, _data, _callback);

		// $.ajax({
		// 	url			: _url,
		// 	type		: _method,
		// 	dataType	: 'json',
		// 	data 		: _data,
		// 	success		: function(output)
		// 	{
		// 		if (_callback)
		// 			_callback(output);
		// 	},
		// 	error 		: function(output)
		// 	{
		// 		// debug
		// 		// TODO: save error log database.
		// 		console.log(output);
		// 		console.log("error");
		// 	},
		// });
	},


	/**
	 * Show or hide a element with bubble effect.
	 * @param  {html_obj} 	element_obj			Ex: $('div')
	 * @return {void}            
	 */
	bubbleElement: function(element_obj, callback_func)
	{
		var me = this;

		// data
		var is_visible = element_obj.is(':visible');

		// action
		if (is_visible)
				element_obj.css({'display': 'block', 'opacity': '1'}).stop(true, true).animate({'opacity': '0', 'margin-top': '-30px'}, 500, 'easeOutBack', function(){ $(this).css('display', 'none'); });
			else
				element_obj.css({'display': 'block', 'opacity': '0', 'margin-top': '-30px'}).stop(true, true).animate({'opacity': '1', 'margin-top': '0'}, 300, 'easeOutBack');

		// __callback
		if (callback_func)
			callback_func(!is_visible);
	},


	/**
	 * Change opacity for element keeping RGB color.
	 * @param  {html_obj}	element 			Ex: $('div')
	 * @param  {0-100} 		opacity
	 * @return {void}
	 */
	changeRGBOpactity: function(element_obj, opacity)
	{
		var me = this;

		// data
		var current_color 	= element_obj.css('background-color');
		match 				= /rgba?\((\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*(,\s*\d+[\.\d+]*)*\)/g.exec(current_color)
		alpha				= opacity > 1 ? (opacity / 100) : opacity;

		// action
		element_obj.css('backgroundColor', 'rgba(' + [match[1],match[2],match[3],alpha].join(',') + ')');
	},


	/**
	 * Conver monetary number from default to BR.
	 * @param  {string} 	number 		Ex. 1000.00
	 * @return {int}					Ex. 1.000,00
	 */
	numberFormatBR: function(number)
	{
		return number.toFixed(2).replace(/[.]/g,'x').replace(/[,]/g,'.').replace(/[x]/g,',');
	},


	/**
	 * Conver monetary number from BR to default.
	 * @param  {string} 	number 		Ex. 1.000,00
	 * @return {int}					Ex. 1000.00
	 */
	numberFormatDefault: function(number)
	{
		return eval(number.replace(/[.]/g,'').replace(/[,]/g,'.'));
	},


	/**
	 * Add max length to element and returns the length to another element.	
	 * @param {html_obj} 	input_obj 			Ex: $('input')
	 * @param {html_obj} 	counter_obj 		Ex: $('div')
	 * @param {int} 		maxlength   		
	 * @param {string} 		string_less 		Ex: 'Restam {length} caracteres'
	 * @param {string} 		string_more 		Ex: '{length} caracteres acima do permitido'
	 */
	setMaxLength: function(input_obj, counter_obj, maxlength, string_less, string_more)
	{
		var me = this;

		// data
		var string_less 	= (string_less || '{length}');
		var string_more 	= (string_more || '{length}');
		var length_current 	= input_obj.val().length;
		var length_left 	= maxlength - input_obj.val().length;

		// init
		if (length_current <= maxlength)
			final_string = string_less.replace('{length}', length_left);
		else
			final_string = string_more.replace('{length}', [length_left]);
		counter_obj.html(final_string);

		// action
		input_obj.attr('maxlength', maxlength);
		input_obj.on('keyup change', function()
		{
			// data
			length_current 	= $(this).val().length;
			length_left 	= maxlength - $(this).val().length;

			if (length_current <= maxlength)
				final_string = string_less.replace('{length}', length_left);
			else
				final_string = string_more.replace('{length}', [length_left]);

			counter_obj.html(final_string);
		});
	},


	/**
	 * Stop event's propagation.
	 * @param  {event} 		event 		Ex: this.event
	 * @return {void}
	 */
	stopEvent: function(event)
	{
		if (typeof event.stopPropagation != "undefined")
		    event.stopPropagation();
		
		else if (typeof event.cancelBubble != "undefined")
		    event.cancelBubble = true;
	},

};



$(document).ready(function()
{
	common.init();
});
