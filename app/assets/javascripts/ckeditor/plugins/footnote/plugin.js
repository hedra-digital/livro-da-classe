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

    CKEDITOR.config.contentsCss.push(CKEDITOR.basePath + CKEDITOR.plugins.basePath + 'footnote/plugin2.css');

    // walk around for the image path
    CKEDITOR.addCss('a.sdfootnoteanc {background-image: url(' + CKEDITOR.getUrl(this.path + 'icons/footnote_red.png') + ') !important;}')

    // update the footnote for the old content and after paste
    CKEDITOR.instances.text_content.on("instanceReady", function(event){
      update_footnotes()
      // mouseover_event()
    });

    editor.on("afterPaste", function(event){
      update_footnotes()
    }, null, null, 0 );


    editor.on("doubleclick", function(event){
      var element = event.data.element;

      if(element.is("a") && element.getAttribute("class") == "sdfootnoteanc"){
        link = $(element.$)

        doc = $(CKEDITOR.instances.text_content.document.$)

        footnote_div = doc.find("div[data-id="+ link.attr("data-id") +"]")

        //footnote_div.css({top: (link.position().top + 20), left: link.position().left});

        $('#modal_inline').html(footnote_div.html())
        $("#footnote_modal").attr("data-id", link.attr("data-id")).modal()
        create_inline_ckeditor()

        // footnote_div.toggle()

        return false
      }
    }, null, null, 0 );


    // add footnote
    editor.addCommand('footnoteCmd', { 
      exec : function(editor) {
        $("#modal_inline").html("")
        $('#footnote_modal').attr("data-id", "").modal()
        create_inline_ckeditor()
      } 
    });
  }
});


// update the footnotes dom after paste 
// the dom like this: 
// footnote link:
// <a class="sdfootnoteanc" href="#sdfootnote1sym" name="sdfootnote1anc"><sup>1</sup></a>
// footnote body:
// <div id="sdfootnote1">
// <p><a class="sdfootnotesym" href="#sdfootnote1anc" name="sdfootnote1sym">1</a>Jorge Luiz, <em>S&atilde;o Paulo da garoa. </em>1998. Lorem ipsum dolor sit amet, consetetur sadi<strong>pscing elitr, se</strong>d diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.</p>
// <p>At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.</p>
// <p>At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.</p>
// </div>
function update_footnotes(){
  console.log("update footnote")
  doc = $(CKEDITOR.instances.text_content.document.$)

  doc.find("a.sdfootnoteanc").each(function(){
    if($(this).attr("data-id") == undefined){

      link_in_footnote_div = doc.find("a[href=#" + $(this).attr("name") + "]")

      footnote_div = link_in_footnote_div.parents("div[id=^sdfootnote]") 

      var uuid = get_uuid()

      $(this).removeAttr("data-cke-saved-name name data-cke-saved-href href").attr("data-id", uuid)

      link_in_footnote_div.remove()

      footnote_div.removeAttr("id").attr("data-id", uuid).addClass("sdfootnotesym")
    }
  })
}

function get_uuid(){
  return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
    var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
    return v.toString(16);
  });
}

// create inline ckeditor every time to make the its position right 
function create_inline_ckeditor(){
  var modal_in_ck = CKEDITOR.dom.element.get("modal_inline")

  if(!modal_in_ck.getEditor()){

    setTimeout (function(){
      var modal_inline_cke = CKEDITOR.inline("modal_inline", {
        customConfig: 'inline.js'
      });

      modal_inline_cke.on('instanceReady', function(event){
        // make the inline tool bar show
        $("#cke_modal_inline").css("z-index", 13000)

        modal_inline_cke.setReadOnly(false)
        // the newest version will fixed this bug
        // http://dev.ckeditor.com/ticket/9761
        var keystrokeHandler = modal_inline_cke.keystrokeHandler;
        keystrokeHandler.blockedKeystrokes[ 8 ] = +modal_inline_cke.readOnly;

        console.log("inline ckeditor created!")
      });
    }, 400);

  }
}

function destroy_inline_ckeditor(){
  var editor = CKEDITOR.instances.modal_inline
  if(editor){
    setTimeout (function(){
      editor.destroy()
      console.log("inline ckeditor destroied!")
    }, 400);
  }
}

// 
function mouseover_event(){
  console.log("add mouseover event to footnotes")

  doc = $(CKEDITOR.instances.text_content.document.$)

  doc.find("a.sdfootnoteanc").on("mouseover", function(){
    console.log("over")
  }).on("mouseout", function(){
    console.log("out")
  })
};