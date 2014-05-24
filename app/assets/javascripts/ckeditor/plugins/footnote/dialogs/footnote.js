CKEDITOR.dialog.add( 'footnoteDialog', function( editor ) {
    return {
        title: 'Notas de Rodapé',
        minWidth: 400,
        minHeight: 200,
        footnote: null, // the footnote jquery node
        contents: [
        {
            id: 'tab-basic',
            label: 'Parametros Básicos',
            elements: [
            {
                type: 'text',
                id: 'foot-text',
                label: 'Texto da Nota',
                validate: CKEDITOR.dialog.validate.notEmpty( "Campo texto da nota de rodapé não pode ser vazio" )
            }
            ]
        }
        ],
        onShow: function(){
            if(this.footnote != null){
                this.setValueOf( 'tab-basic', 'foot-text', this.footnote.children("span").html() );
            }
        },
        onOk: function() {
            link = "<a class='footnote'><span>"+ this.getValueOf( 'tab-basic', 'foot-text' ) +"</span></a>&nbsp;"

            if(this.footnote != null){
                this.footnote.children("span").html(this.getValueOf( 'tab-basic', 'foot-text' ))
            }else{
                editor.insertHtml( link );
            }

        }
    };
});