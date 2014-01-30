CKEDITOR.editorConfig = function(config) {

  config.extraPlugins = 'eqneditor,charcount,texttransform,footnote';

  /* Char Count Plugin */
  config.maxLength = 0;
  config.maxWords = 0;

  config.keystrokes =
  [
    [ CKEDITOR.ALT + 121 /*F10*/, 'toolbarFocus' ],
    [ CKEDITOR.ALT + 122 /*F11*/, 'elementsPathFocus' ],

    [ CKEDITOR.SHIFT + 121 /*F10*/, 'contextMenu' ],

    [ CKEDITOR.CTRL + 90 /*Z*/, 'undo' ],
    [ CKEDITOR.CTRL + 89 /*Y*/, 'redo' ],
    [ CKEDITOR.CTRL + CKEDITOR.SHIFT + 90 /*Z*/, 'redo' ],

    [ CKEDITOR.CTRL + 76 /*L*/, 'link' ],

    [ CKEDITOR.CTRL + 66 /*B*/, 'bold' ],
    [ CKEDITOR.CTRL + 73 /*I*/, 'italic' ],
    [ CKEDITOR.CTRL + 85 /*U*/, 'underline' ],

    //[ CKEDITOR.CTRL + 86 /*V*/, 'pastetext' ],
    //[ CKEDITOR.SHIFT + 45 /*INS*/, 'pastetext' ],

    [ CKEDITOR.ALT + 109 /*-*/, 'toolbarCollapse' ]
  ];

  config.toolbar = [   
    { name: 'clipboard', items : [ 'Undo','Redo' ] },
    { name: 'editing', items : [ 'Find','Replace','-','SelectAll','-','SpellChecker', 'Scayt' ] },
    { name: 'links', items : [ 'Anchor' ] },
    { name: 'document', items : [ 'Source' ] },
    { name: 'tools', items : [ 'Maximize', 'ShowBlocks' ] },
    { name: 'plugins', items: [ 'TransformTextToUppercase', 'TransformTextToLowercase', 'TransformTextCapitalize', 'TransformTextSwitcher', '-','CharCount' ] },
    '/',
    { name: 'basicstyles', items : [ 'Bold','Italic','Subscript','Superscript','-','RemoveFormat' ] },
    { name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock' ] },
    { name: 'insert', items : [ 'Image','Table','HorizontalRule','SpecialChar','EqnEditor', 'FootNote' ] },
    { name: 'colors', items : [ 'TextColor','BGColor' ] },
    { name: 'styles', items : [ 'Format' ] }
  ];

  /*config.toolbar = [
    { name: 'basicstyles', items: [ 'Bold', 'Italic' ] },
    { name: 'insert', items: [ 'Image' ] },
    { name: 'clipboard', items: [ 'Cut', 'Copy', 'PasteText', '-', 'Undo', 'Redo' ] },
    { name: 'colors', items: [ 'BGColor' ] },
    { name: 'document', items: [ 'Source' ] },
    { name: 'latex', items: [ 'EqnEditor' ] }
  ];*/
  
  config.language = 'pt-BR';

  /* Filebrowser routes */
  // The location of an external file browser, that should be launched when "Browse Server" button is pressed.
  config.filebrowserBrowseUrl = "/ckeditor/attachment_files";

  // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Flash dialog.
  config.filebrowserFlashBrowseUrl = "/ckeditor/attachment_files";

  // The location of a script that handles file uploads in the Flash dialog.
  config.filebrowserFlashUploadUrl = "/ckeditor/attachment_files";

  // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Link tab of Image dialog.
  config.filebrowserImageBrowseLinkUrl = "/ckeditor/pictures";

  // The location of an external file browser, that should be launched when "Browse Server" button is pressed in the Image dialog.
  config.filebrowserImageBrowseUrl = "/ckeditor/pictures";

  // The location of a script that handles file uploads in the Image dialog.
  config.filebrowserImageUploadUrl = "/ckeditor/pictures";

  // The location of a script that handles file uploads.
  config.filebrowserUploadUrl = "/ckeditor/attachment_files";

  // Because of 
  config.hideDialogFields = "image:info:htmlPreview";

  config.allowedContent = 
      'h1 h2 h3 h4 h5 h6 strong em blockquote ol ul li;' +
      'a(latex-close)[*]; a[!name,!href];' +
      'img[*];' +
      'table tr th td caption;' +
      'span(latex-inputbox); span{color,background-color};' +
      'p[align]; p{align,text-align};' +
      'div[!id];';

  // Rails CSRF token
  config.filebrowserParams = function(){
    var csrf_token, csrf_param, meta,
        metas = document.getElementsByTagName('meta'),
        params = new Object();

    for ( var i = 0 ; i < metas.length ; i++ ){
      meta = metas[i];

      switch(meta.name) {
        case "csrf-token":
          csrf_token = meta.content;
          break;
        case "csrf-param":
          csrf_param = meta.content;
          break;
        default:
          continue;
      }
    }

    if (csrf_param !== undefined && csrf_token !== undefined) {
      params[csrf_param] = csrf_token;
    }

    return params;
  };

  config.addQueryString = function( url, params ){
    var queryString = [];

    if ( !params ) {
      return url;
    } else {
      for ( var i in params )
        queryString.push( i + "=" + encodeURIComponent( params[ i ] ) );
    }

    return url + ( ( url.indexOf( "?" ) != -1 ) ? "&" : "?" ) + queryString.join( "&" );
  };

  // Integrate Rails CSRF token into file upload dialogs (link, image, attachment and flash)
  CKEDITOR.on( 'dialogDefinition', function( ev ){
    // Take the dialog name and its definition from the event data.
    var dialogName = ev.data.name;
    var dialogDefinition = ev.data.definition;
    var content, upload;

    if (CKEDITOR.tools.indexOf(['link', 'image', 'attachment', 'flash'], dialogName) > -1) {
      content = (dialogDefinition.getContents('Upload') || dialogDefinition.getContents('upload'));
      upload = (content == null ? null : content.get('upload'));

      if (upload && upload.filebrowser && upload.filebrowser['params'] === undefined) {
        upload.filebrowser['params'] = config.filebrowserParams();
        upload.action = config.addQueryString(upload.action, upload.filebrowser['params']);
      }
    }

    //customize class field for childrens approuch [VIZIR]
    if (dialogName == 'image')
    {
      for (var i in dialogDefinition.contents)
      {
        var contents = dialogDefinition.contents[i];

        if (contents.id == "info")
        {
          var classField = dialogDefinition.contents[3].elements[2];
          dialogDefinition.contents[3].elements[2] = null;

          classField.widths[0] = '100%';
          classField.widths[1] = '0%';
          classField.children[0].label = 'Intenção de tamanho para a imagem publicada';
          classField.children[0].type = 'select';
          classField.children[0].default = 'medium-intention';
          classField.children[0].items = [];
          classField.children[0].items.push(['Imagem com Tamanho Pequeno','small-intention']);
          classField.children[0].items.push(['Imagem com Tamanho Médio','medium-intention']);
          classField.children[0].items.push(['Imagem com Tamanho Grande','big-intention']);
          delete classField.children[1];
          contents.elements.splice(1, 0, classField);
          contents.elements[2].label = 'Legenda da Imagem';
          delete contents.elements[3].children[0].children[0]; //remove the width, heigth, border, etc fields
        }
      }

      dialogDefinition.onLoad = function () { 
        var dialog = CKEDITOR.dialog.getCurrent(); 

        var elem = dialog.getContentElement('info','htmlPreview');     
        elem.getElement().hide(); 

        $('#cke_50_textInput').attr('disabled','disabled');
         
        dialog.hidePage('advanced'); 
      }; 
    }
  });

  /*CKEDITOR.on('instanceReady', function(ck) { 
    ck.editor.removeMenuItem('paste'); 
  });*/

};

// Blocking the paste keystroke
//CKEDITOR.config.blockedKeystrokes.push(CKEDITOR.CTRL + 86 /*V*/);

CKEDITOR.addCss('.small-intention { zoom: 0.3; -moz-transform: scale(0.3); }');
CKEDITOR.addCss('.medium-intention { zoom: 0.6; -moz-transform: scale(0.6); }');
CKEDITOR.addCss('.big-intention { zoom: 1; -moz-transform: scale(1); }');
CKEDITOR.addCss('.latex-inputbox { background-color: #73b8f7; cursor: pointer; -webkit-border-radius: 3px; border-radius: 5px; padding: 3px; margin: 3px; margin-left: 5px;}');
CKEDITOR.addCss('.latex-close { cursor: pointer; font-size: 12px; color: #fff; padding: 5px; }')
//CKEDITOR.addCss('.latex-close:before { content: "×"; }');

CKEDITOR.instances.text_content.on('contentDom', function() {
  CKEDITOR.instances.text_content.document.on('keyup', function(event) {
    var key = event.data.getKey();
    var editor = CKEDITOR.instances.text_content;
    var content = editor.document.getBody().getHtml();
    if (content.match(/@(.*?)@/) != null){
      var inside = content.match(/@(.*?)@/)[0];
      inside = inside.replace(/@/g,"");
      if (inside.length != 0){
        content = content.replace(/@(.*?)@/, "<span class='latex-inputbox'>"+inside+"<a class='latex-close' onclick='this.parentNode.remove();'>×</a></span><span>&nbsp;</span>");
        editor.document.getBody().setHtml(content); 
      }
      var range = editor.createRange();
      range.moveToElementEditEnd( range.root );
      editor.getSelection().selectRanges( [ range ] );
    }
  });
});

CKEDITOR.instances.text_content.on('instanceReady', function() {
  var content = CKEDITOR.instances.text_content.document.getBody().getHtml();
  content = content.replace(/data-cke-pa-onclick/g, "onclick");
  CKEDITOR.instances.text_content.document.getBody().setHtml(content);
});
