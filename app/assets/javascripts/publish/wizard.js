/**
 * Created by Willianson
 * At 2014-12-20
 */


var publish_wizard = {


	/* properties
	---------------------------------------------------------------------------------------*/
	cover_options_open 	: null,
	current_step 		: null,
	current_tab 		: null,
	transition_time 	: 500,
	step_change_running : false,


	/* initialization
	---------------------------------------------------------------------------------------*/
	init: function()
	{
		var me = this;
		
		// bind content navigation
		me.bindContentNavigation();

		// cover: bind cover background color
		me.bindCoverBackgroundColor();

		// cover: bind cover pattern
		me.bindCoverPattern();
		
		// cover: bind cover font styles
		me.bindCoverFontStyle();

		// cover: bind tools select
		me.bindCoverToolsSelect();

		// bind chapters sortable
		me.bindChaptersSortable();

		// bind form features
		me.bindFormFeatures();

		// bind form metadata
		me.bindFormMetadada();

		// bind form publication
		me.bindFormPublication();
		
		// bind progreesbar navigation
		me.bindProgressBarNavigation();

		// start
		$('a[data-step="step-content"]:first').trigger('click');
		$('#step-content a.ico-chapters').trigger('click');
		
		// fill chapters
		me.fillChapters();
	},


	/* bind content tab navigation
	---------------------------------------------------------------------------------------*/
	bindContentNavigation: function()
	{
		var me = this;

		// elements
		var el_links = $('aside.content-navigation').find('a');
		
		// action
		el_links.on('click', function(event)
		{
			event.preventDefault();

			// data
			var tab_class = $(this).data('tab');

			// action
			if (me.current_tab != null)
				me.hideTab( me.current_tab, callback = function(){ me.showTab($('.'+tab_class)); } );
			else
				me.showTab( $('.'+tab_class) );

			// current
			$(this).closest('ul').find('li').removeClass('current');
			$(this).closest('li').addClass('current');
		});
	},


	/* bind cover background color
	---------------------------------------------------------------------------------------*/
	bindCoverBackgroundColor: function()
	{
		var me = this;

		// elements
		var el_cover 		= $('.tab-cover-editor #cover');
		var el_choice 		= $('.tab-cover-editor .tool-color .choice');
		var el_color_list 	= $('.tab-cover-editor .tool-color .options .color-list');

		// data
		var initial_color 	= '#444';
		var is_running 		= false;

		// action
		el_color_list.on('mouseenter', 'td', function()
		{
			// validate
			if (is_running)
				return;

			// data
			var color = $(this).css('background-color');

			// action
			el_cover.css('background-color', color);

		}).on('mouseleave', function()
		{
			el_cover.css('background-color', initial_color);

		}).on('click', 'td', function()
		{
			// data
			var color = $(this).css('background-color');

			// action
			$(this).closest('table').find('.selected').removeClass('selected');
			$(this).addClass('selected');
			el_choice.css('background-color', color);
			el_cover.css('background-color', color);
			initial_color 	= color;
			is_running 		= true;
			
			// running
			setTimeout(function(){ is_running = false; }, 1000);
		});
	},


	/* bind cover pattern
	---------------------------------------------------------------------------------------*/
	bindCoverPattern: function()
	{
		var me = this;

		// elements
		var el_cover 		= $('.tab-cover-editor #cover');
		var el_choice 		= $('.tab-cover-editor .tool-pattern .choice');
		var el_pattern_list = $('.tab-cover-editor .tool-pattern .options a');

		// data
		var initial_pattern = 'pattern-linear-top';
		var holder_pattern 	= null;
		var is_running 		= false;
		
		// action
		el_pattern_list.on('mouseenter', function()
		{
			// validate
			if (is_running)
				return;

			// data
			var pattern_class = $(this).data('action');

			// action
			el_cover.removeClass(holder_pattern +' '+ initial_pattern).addClass(pattern_class);
			holder_pattern = pattern_class;

		}).on('mouseleave', function()
		{
			el_cover.removeClass(holder_pattern).addClass(initial_pattern);

		}).on('click', function()
		{
			// data
			var pattern_class 	= $(this).data('action');
			
			// action
			el_choice.removeClass(initial_pattern).addClass(pattern_class);
			el_cover.removeClass(initial_pattern).addClass(pattern_class);
			initial_pattern = pattern_class;
			is_running 		= true;
			
			// running
			setTimeout(function(){ is_running = false; }, 1000);
		});
	},

	
	/* bind cover font styles
	---------------------------------------------------------------------------------------*/
	bindCoverFontStyle: function()
	{
		var me = this;

		// elements
		var el_cover 		= $('.tab-cover-editor #cover');
		var el_choice 		= $('.tab-cover-editor .tool-font .choice');
		var el_color_list 	= $('.tab-cover-editor .tool-font .options .color-list');

		// data
		var initial_font_color 	= '#FFF';
		var is_running 			= false;
		
		// action
		el_color_list.on('mouseenter', 'td', function()
		{
			// validate
			if (is_running)
				return;

			// data
			var font_color = $(this).css('background-color');

			// action
			el_cover.css('color', font_color);

		}).on('mouseleave', function()
		{
			el_cover.css('color', initial_font_color);

		}).on('click', 'td', function()
		{
			// data
			var font_color = $(this).css('background-color');
			
			// action
			$(this).closest('table').find('.selected').removeClass('selected');
			$(this).addClass('selected');
			el_choice.css('color', font_color);
			el_cover.css('color', font_color);
			initial_font_color 	= font_color;
			is_running 			= true;
			
			// running
			setTimeout(function(){ is_running = false; }, 1000);
		});
	},


	/* bind tools select
	---------------------------------------------------------------------------------------*/
	bindCoverToolsSelect: function()
	{
		var me = this;

		// elements
		var el_selects 		= $('.tab-cover-editor .tools div[class^="tool-"] a.select');
		var el_body 	= $('body');

		// action
		el_selects.on('click', function(event)
		{
			event.preventDefault();
			common.stopEvent(event);
			
			// elements
			var this_options	= $(this).closest('div').find('.options');

			// action
			if (me.cover_options_open == null)
			{
				common.bubbleElement(this_options);
				me.cover_options_open = this_options;
			}
			else if	(me.cover_options_open[0] == this_options[0]) 
			{
				common.bubbleElement(this_options);
				me.cover_options_open = null;
			}
			else
			{
				common.bubbleElement(me.cover_options_open);
				common.bubbleElement(this_options);
				me.cover_options_open = this_options;
			}
		});

		// __clickout
		el_body.on('click', function()
		{
			if (me.cover_options_open != null)
			{
				common.bubbleElement(me.cover_options_open);
				me.cover_options_open = null;
			}
		});
	},


	/* bind sortable
	---------------------------------------------------------------------------------------*/
	bindChaptersSortable: function()
	{
		var me = this;

		// elements
		var el_chapters = $('.chapters');

		el_chapters.sortable({ 
			axis		: 'y',
			placeholder	: 'item placeholder',
			start		: function(event, ui)
			{
				$(ui.item).addClass('floating');
			},
			stop		: function(event, ui)
			{
				$(ui.item).removeClass('floating');
			},
		});
	    el_chapters.disableSelection();
	},


	/* bind features form
	---------------------------------------------------------------------------------------*/
	bindFormFeatures: function()
	{
		var me = this;

		// elements
		var el_form_measures 	= $('#book-measures-form');
		var el_form_style 		= $('#book-style-form');

		// data
		var rules_json_measures = { };
		var rules_json_style 	= { };

		var before_func = function()
		{
			cleanbox.showContentLoading();
		};

		var callback_func = function(output)
		{
			cleanbox.hideContentLoading();
			cleanbox.showOutput(output.type, output.result);

			console.log('# callback')
			console.log(output)
		};

		// action
		// __measures
		el_form_measures.find('input').on('change', function()
		{
			$(this).closest('form').submit();
		});
		common.bindFormValidation(el_form_measures, rules_json_measures, before_func, callback_func);

		// __style
		el_form_style.find('input').on('change', function()
		{
			$(this).closest('form').submit();
		});
		common.bindFormValidation(el_form_style, rules_json_style, before_func, callback_func);
	},


	/* bind form metadata
	---------------------------------------------------------------------------------------*/
	bindFormMetadada: function()
	{
		var me = this;

		// elements
		var el_form_info = $('#book-info-form');

		// data
		var rules_json_info = { 
			metadata_category: {
				required: true
			},
			metadata_title: {
				required: true
			},
			metadata_author_name: {
				required: true
			},
			metadata_description: {
				required: true
			},
			metadata_release: {
				required: true
			}
		};
		var rules_json_isbn = {  };

		var before_func = function()
		{
			cleanbox.showContentLoading();
		};

		var callback_func = function(output)
		{
			cleanbox.hideContentLoading();

			if (output.uuid)
				cleanbox.showOutput(true, 'Salvo!');
			else
				cleanbox.showOutput(output.type, output.result);

			// console.log('# callback')
			// console.log(output)
		};

		// action
		// __info
		common.bindFormValidation(el_form_info, rules_json_info, before_func, callback_func);
	},


	/* bind form publication
	---------------------------------------------------------------------------------------*/
	bindFormPublication: function()
	{
		var me = this;

		// elements
		var el_form_prices = $('#prices-form');

		// data
		var rules_json_prices = { 
			metadata_category: {
				required: true
			}
		};

		var before_func = function()
		{
			cleanbox.showContentLoading();
		};

		var callback_func = function(output)
		{
			cleanbox.hideContentLoading();
			cleanbox.showOutput(output.type, output.result);

			console.log('# callback')
			console.log(output)
		};

		// action
		// __prices
		el_form_prices.find('input').on('keyup', function()
		{
			me.runPriceCalculator();
		});
		common.bindFormValidation(el_form_prices, rules_json_prices, before_func, callback_func);
	},


	/* bind nav progressbar
	---------------------------------------------------------------------------------------*/
	bindProgressBarNavigation: function()
	{
		var me = this;

		// elements
		var el_ul_default 	= $('nav.progress-bar ul.default')
		var el_base_on 		= $('nav.progress-bar div.base-on')
		var el_links 		= $('nav.progress-bar').find('a');
		
		// action
		el_links.on('click', function(event)
		{
			event.preventDefault();

			// data
			var step_id 		= $(this).data('step');
			var base_on_width 	= $(this).closest('li').position().left + $(this).closest('li').width();

			// validation
			if (me.current_step != null && step_id == me.current_step.attr('id') || me.step_change_running)
				return false;

			// action
			me.step_change_running = true;
			
			// __set current
			el_ul_default.find('.current').removeClass('current');
			el_ul_default.find('a[data-step="'+step_id+'"]').closest('li').addClass('current');

			// __set progress-bar on width
			el_base_on.width(base_on_width+'px');

			// __show content
			if (me.current_step != null)
				me.hideStep( me.current_step, callback = function(){ me.showStep($('#'+step_id)); } );
			else
				me.showStep( $('#'+step_id));

			// __timeout
			setTimeout(function(){ me.step_change_running = false; }, 1500);
		});
	},


	/* fill chapters
	---------------------------------------------------------------------------------------*/
	fillChapters: function()
	{
		var me = this;

		// validate
		if (me.current_step == null || me.current_step.attr('id') != 'step-content')
			return false;

		var _callback = function(json_list)
		{
			// els
			var el_chapters 		= $('.chapters');
			var el_empty 			= $('.chapters .empty');
			
			// template
			var el_chapter_template = '';

			if ($('.chapters [role="template"]')[0])
				el_chapter_template = $('.chapters [role="template"]')[0].outerHTML.replace(' role="template"', '');

			// data
			var output 		= '';
			var list_size 	= json_list.length;

			// action
			for (var i = 0; i < list_size; i++)
			{
				// TODO: add prop time_ago at json objects.

				var html_temp = el_chapter_template;
					html_temp = html_temp.replace(/{chapter_id}/, json_list[i].uuid);
					html_temp = html_temp.replace(/{book_id}/, json_list[i].book_id);
					html_temp = html_temp.replace(/{title}/, json_list[i].title);
					html_temp = html_temp.replace(/{subtitle}/, json_list[i].subtitle);
					html_temp = html_temp.replace(/{autor}/, json_list[i].autor);
					html_temp = html_temp.replace(/{time_ago}/, json_list[i].updated_at);
				
				output += html_temp;
			}

			// append
			// el_chapters.html(output);
			el_chapters.find('.receiver').html(output);

			// height
			publish_wizard.showStep($('#step-content'));

			// empty
			if (list_size == 0)
				el_empty.show();
		}


		var book_id = $('#book_id').val();
		common.bridge('get', '/books/'+book_id+'/texts.json', null, _callback);
	},


	/* hide step
	---------------------------------------------------------------------------------------*/
	hideStep: function(step_element, callback)
	{
		var me = this;

		// data
		var tab_height = 0;

		// action
		step_element.css('overflow', 'hidden').stop(true, true).animate({ 'height': tab_height+'px', 'opacity': 0 }, me.transition_time, function()
		{
			// callback
			if (callback)
				callback();
		});

		// update
		me.current_step = null;
	},


	/* show step
	---------------------------------------------------------------------------------------*/
	showStep: function(step_element)
	{
		var me = this;
		step_element.css('overflow', 'auto');

		// data
		var tab_height = step_element[0].scrollHeight;

		// action
		step_element.css('overflow', 'initial').stop(true, true).animate({ 'height' : tab_height+'px', 'opacity': 1 }, me.transition_time, function(){ step_element.find('.content-navigation a:first').trigger('click'); });

		// update
		me.current_step = step_element;
	},


	/* hide tab
	---------------------------------------------------------------------------------------*/
	hideTab: function(tab_element, callback)
	{
		var me = this;

		// visibility
		tab_element.addClass('none');

		// update
		me.current_tab = null;

		// callback
		if (callback)
			callback();
	},


	/* run price calculator
	---------------------------------------------------------------------------------------*/
	runPriceCalculator: function()
	{
		var me = this;

		// elements
		var el_input 			= $('.calculator input[name="wanted_price"]');
		var el_production 		= $('.calculator span.production-price');
		var el_kickback 		= $('.calculator span.kickback-price');
		var el_final 			= $('.calculator span.final-price');
		
		// data
		var wanted_price 		= common.numberFormatDefault((el_input.val() || 0));
		var production_price 	= common.numberFormatDefault(el_production.text());
		var kickback_price 		= common.numberFormatDefault(el_kickback.text());
		var final_price 		= common.numberFormatBR((wanted_price + production_price + kickback_price));

		// action
		el_final.addClass('bounceIn').text(final_price);
		setTimeout(function(){ el_final.removeClass('bounceIn'); }, 1000);
	},


	/* show tab
	---------------------------------------------------------------------------------------*/
	showTab: function(tab_element)
	{
		var me = this;

		// visibility
		tab_element.css('opacity', 0).removeClass('none');

		// data
		var tab_height 					= tab_element.closest('.content').outerHeight()
		var content_navigation_height 	= tab_element.closest('div[id^="step-"]').find('aside').outerHeight();

		if (tab_height < content_navigation_height)
			tab_height = content_navigation_height;

		// action
		tab_element.stop(true, true).animate({ 'opacity': 1 }, me.transition_time * 3);
		if (me.current_step)
			me.current_step.stop(true, true).animate({ 'height': tab_height+'px' }, me.transition_time);

		// update
		me.current_tab = tab_element;
	},

};



$(document).ready(function()
{
	publish_wizard.init();
});



// TODO (WILL):
// 
// 		Basic (v1)
// 		X Definir estrutura JS desse arquivo;
// 		X Aplicar sortable no step 01;
// 		x Alternar entre conteudos by menu lateral;
// 		x Incluir comportamentos de form items no common.js (select, radio, checkbox);
// 		x Publication's Price: Apply money mask aligning to right;
// 		x Preços: fazer calculo realtime;
// 		? Definir metodos da rotina de gestao de capitulos;
// 		@ Cover tools interaction.
// 		/ Cover editor usar jquery ui draggable para titulo;
// 		- Load initial data by AJAX or Ruby? Meybe, Ruby.
// 		
// 		Evolution
// 		- Timer Interval to save data or in specific actions;
// 		- On arrive see a especific step, mais one goto-step();
// 		- Cover editor can be full screen mode.