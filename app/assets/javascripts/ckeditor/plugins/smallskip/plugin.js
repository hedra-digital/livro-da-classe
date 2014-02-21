CKEDITOR.plugins.add('smallskip', { 
    init: function( editor ) {
        editor.addCommand('insertSmallskip', { 
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
                editor.insertHtml('<div class="smallskip">' + getSelectionHtml(editor) + '</div>'); 
            } 
        }); 
        editor.ui.addButton('Smallskip', { 
            label: 'Inserir smallskip', 
            command: 'insertSmallskip', 
            icon: 'smallskip'
        }); 
    } 
});