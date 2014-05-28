CKEDITOR.plugins.add( 'footnote', {
  icons: 'footnote',
  init: function( editor ) {
    editor.addCommand( 'footnoteDialog', new CKEDITOR.dialogCommand( 'footnoteDialog' ) );
    editor.ui.addButton( 'Footnote', {
      label: 'Insere uma nota de rodapé',
      command: 'footnoteCmd',
      toolbar: 'insert'
    });

    CKEDITOR.dialog.add( 'footnoteDialog', this.path + 'dialogs/footnote.js' );

    // add the plugin css
    if (typeof CKEDITOR.config.contentsCss === 'string') {
      CKEDITOR.config.contentsCss = [CKEDITOR.config.contentsCss];
    } 

    CKEDITOR.config.contentsCss.push(CKEDITOR.basePath + CKEDITOR.plugins.basePath + 'footnote/plugin.css');

    // walk around for the image path
    CKEDITOR.addCss('a.sdfootnoteanc {background-image: url(' + CKEDITOR.getUrl(this.path + 'icons/footnote_red.png') + ') !important;}')

    editor.on("doubleclick", function(event) {
      var element = event.data.element;

      if(element.is("a") && element.getAttribute("class") == "sdfootnoteanc"){
        doc = $(CKEDITOR.instances.text_content.document.$)

        link = $(element.$)

      // uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
      //   var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
      //   return v.toString(16);
      // });

      // if(link.attr("data-id") == undefined){
      //   link.attr("data-id", uuid)
      // }

      link_at_the_end = doc.find("a[href=#" + link.attr("name") + "]")

      // if(doc.find("div[data-id="+ link.attr("data-id") +"]").size() == 0){
      //   div_at_the_end = doc.find("div[data-id="+ link.attr("data-id") +"]")
      // }else{
      //   div_at_the_end = link_at_the_end.parents("div[id=^sdfootnote]") 
      // }
      div_at_the_end = link_at_the_end.parents("div[id=^sdfootnote]") 
      // if(div_at_the_end.attr("data-id") == undefined){
      //   div_at_the_end.attr("data-id", link.attr("data-id"))
      // }

      // div_at_the_end.find("a.sdfootnotesym").remove()

      div_at_the_end.css({top: (link.position().top + 20), left: link.position().left});

      div_at_the_end.toggle()


      return false
    }
  }, null, null, 0 );


      // 
      editor.addCommand('footnoteCmd', { 
        exec : function(editor) {
          editor.insertHtml("<div class='footnote'><div class='footnote-content'>aa</div></div>"); 
        } 
      });
    }
  });
