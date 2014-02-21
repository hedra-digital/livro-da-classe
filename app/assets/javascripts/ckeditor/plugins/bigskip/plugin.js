CKEDITOR.plugins.add('bigskip', { 
    init: function( editor ) {
        editor.addCommand('insertBigskip', { 
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
                editor.insertHtml('<div class="bigskip">' + getSelectionHtml(editor) + '</div>'); 
            } 
        }); 
        editor.ui.addButton('Bigskip', { 
            label: 'Inserir bigskip', 
            command: 'insertBigskip', 
            icon: 'bigskip'
        }); 
    } 
});