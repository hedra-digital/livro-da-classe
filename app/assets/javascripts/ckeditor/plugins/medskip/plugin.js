CKEDITOR.plugins.add('medskip', { 
    init: function( editor ) {
        editor.addCommand('insertMedskip', { 
            exec : function(editor) {
                function getSelectionHtml(editor) {
                    var sel = editor.getSelection();
                    var ranges = sel.getRanges();
                    var el = new CKEDITOR.dom.element("div");
                    for (var i = 0, len = ranges.length; i < len; ++i) {
                        el.append(ranges[i].cloneContents());
                    }
                    return el.getHtml();
                }
                editor.insertHtml('<div class="medskip">' + getSelectionHtml(editor) + '</div>'); 
            } 
        }); 
        editor.ui.addButton('Medskip', { 
            label: 'Inserir medskip', 
            command: 'insertMedskip', 
            icon: 'medskip'
        }); 
    } 
});