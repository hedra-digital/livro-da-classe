/* 
 * Create by Willianson Araujo 
 * At 2013-07-18
 */




var cleanbox = {


	/* properties
	---------------------------------------------------------------------------------------*/
	animation_time 	: 200,
	output_duration	: 6000,


	/* initialization
	---------------------------------------------------------------------------------------*/
	init: function()
	{
		var me = this;

		// bind callers
		me.bindCallers();

		// bind closers
		me.bindClosers();
	},


	/* bind callers
	---------------------------------------------------------------------------------------*/
	bindCallers: function()
	{
		var me = this;

		// elements
		var el_body 	= $('body');
		var el_callers 	= 'a[rel="cleanbox"]';
		
		// action
		el_body.on('click', el_callers, function(event)
		{
			event.preventDefault();

			// data
			var destine 	= $(this).attr('href');
			var params 		= $(this).data('params');
			var onclose 	= $(this).data('onclose');

			if (params) 
				destine += '?'+params;

			// action
			me.open(destine, onclose);
		});
	},


	/* bind closers
	---------------------------------------------------------------------------------------*/
	bindClosers: function()
	{
		var me = this;

		// elements
		var el_body 	= $('body');
		var el_closers 	= '[rel="cleanbox-close"]';

		// action
		el_body.on('click', el_closers, function(event)
		{
			event.preventDefault();
			
			// close
			me.close();
		});
	},


	/* close
	---------------------------------------------------------------------------------------*/
	close: function()
	{
		var me = this;

		// elements
		var el_last_cleanbox = parent.$('.cleanbox:last');

		// callback
		var _onclose = el_last_cleanbox.data('onclose');
		if (_onclose && _onclose != undefined)
				eval(_onclose);

		// action
		el_last_cleanbox.fadeOut(me.animation_time, function()
		{
			$(this).remove();
		});
	},


	/* hide content loading
	---------------------------------------------------------------------------------------*/
	hideContentLoading: function()
	{
		var me = this;

		// elements
		var el_content_loading = $('section.content div.loading');

		// action
		el_content_loading.fadeOut(me.animation_time, function(){ $(this).remove(); });
	},


	/* iframes loaded
	---------------------------------------------------------------------------------------*/
	iframeLoaded: function(element)
	{
		var me = this;

		// action
		$(element).fadeIn(me.animation_time, function()
		{
			$(this).closest('.cleanbox').removeClass('loading');
		});
	},


	/* open
	---------------------------------------------------------------------------------------*/
	open: function(reference, _onclose)
	{
		var me = this;

		// elements
		var el_body = parent.$('body');
		
		// data
		var new_cleanbox = null;
		var type 		 = null;

		// // callback
		// // el_last_cleanbox.data('callback');
		// var _onclose = el_last_cleanbox.data('callback');
		
		// if (_onclose)
		// 		eval(_onclose);

		// action
		// _element
		if (reference.indexOf('#') == 0 || reference.indexOf('.') == 0)
		{
			new_cleanbox = me.template({ type: 'element', content: 'TODO: apply content by reference.' });
		}

		// _iframe
		else
		{
			new_cleanbox = me.template(
			{ 
				type 	: 'iframe', 
				url 	: reference, 
				onclose : _onclose 
			});
		}

		// _append
		el_body.append( new_cleanbox );
	},


	/* show content loading
	---------------------------------------------------------------------------------------*/
	showContentLoading: function()
	{
		var me = this;

		// elements
		var el_content = $('section.content');

		// action
		el_content.append('<div class="loading none"></div>').find('.loading').fadeIn(me.animation_time);
	},


	/* show output
	---------------------------------------------------------------------------------------*/
	showOutput: function(type, message)
	{
		var me = this;

		// template
		var html_output =  '<div id="cleanbox-output" class="success">'
			html_output += '	<div id="output-message" class="radius-5 shadow-30"></div>'
			html_output += '</div>';

		// elements
		var el_body 			= $('body');
		var el_output 			= $('#cleanbox-output');
		var el_output_message 	= el_output.find('#output-message');

		// validate
		if (el_output.length == 0)
		{
			console.log('append output')
			el_body.append(html_output);
			el_output 			= $('#cleanbox-output');
			el_output_message 	= el_output.find('#output-message');
		}

		// action
		// __class
		if(eval(type))
			el_output.addClass('success');
		else
			el_output.addClass('error');
		
		// __message
		el_output_message.text(message);

		// __show
		el_output.stop(false, false).animate({'top': '25px'}, (me.animation_time * 2.5), 'easeInOutBack');

		// __hide
		setTimeout(function(){
			el_output.stop(false, false).animate({'top': '-100px'}, (me.animation_time * 2.5), 'easeInOutBack');
		}, me.output_duration);
	},


	/* template
	---------------------------------------------------------------------------------------*/
	template: function(params)
	{
		// validate
		if (params.length == 0)
			alert('cleanbox.template(): Param "type" must be set.')
				
		// data
		var output 		= null;

		// action
		switch(params.type)
		{
			case 'iframe':
				output = '<div class="cleanbox loading" data-onclose="'+params.onclose+'"><iframe src="'+params.url+'" frameborder="0" onload="cleanbox.iframeLoaded(this);"></iframe></div>';
				break;

			case 'element':
				output = '<div class="cleanbox"  data-callback="'+params.callback+'">'+params.content+'</div>';
				break;

			default:
				alert('template "'+params.type+'" not implemmented.');
		}

		// output
		return  output;
	},
	
};




$(document).ready(function()
{
	cleanbox.init();
});