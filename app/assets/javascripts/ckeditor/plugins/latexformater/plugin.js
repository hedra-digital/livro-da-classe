CKEDITOR.plugins.add('latexformater',
{
  requires : ['richcombo'],
  init : function( editor )
  {
    // array of strings to choose from that'll be inserted into the editor
    var strings = [];
    strings.push(['versos', 'versos', 'formata versos']);
    strings.push(['epígrafe', 'epígrafe', 'insere epígrafe']);
    //strings.push(['nota de rodapé', 'nota de rodapé', 'insere uma nota de rodapé']);
    //strings.push(['novo capítulo', 'novo capítulo', 'insere novo capítulo']);
    strings.push(['espaço pequeno', 'espaço pequeno', 'espaço pequeno entrelinhas']);
    strings.push(['espaço médio', 'espaço médio', 'espaço médio entrelinhas']);
    strings.push(['espaço grande', 'espaço grande', 'espaço grande entrelinhas']);

    // add the menu to the editor
    editor.ui.addRichCombo('LatexFormater',
    {
      label:    'Extras',
      title:    'Extras',
      voiceLabel: 'Extras',
      className:  'cke_format',
      multiSelect:false,
      panel:
      {
        css: [ editor.config.contentsCss, CKEDITOR.skin.getPath('editor') ],
        voiceLabel: editor.lang.panelVoiceLabel
      },

      init: function()
      {
        this.startGroup( "Extras");
        for (var i in strings)
        {
          this.add(strings[i][0], strings[i][1], strings[i][2]);
        }
      },

      onClick: function( value )
      {
        if (value == 'versos'){
          CKEDITOR.currentInstance.commands.insertVerse.exec()
        }else if(value == 'epígrafe'){
          CKEDITOR.currentInstance.commands.epigraphDialog.exec()
        }else if(value == 'nota de rodapé'){
          // CKEDITOR.currentInstance.commands.footnoteDialog.exec()
        }else if(value == 'novo capítulo'){
          // CKEDITOR.currentInstance.commands.chapterDialog.exec()
        }else if(value == 'espaço pequeno'){
          CKEDITOR.currentInstance.commands.insertSmallskip.exec()
        }else if(value == 'espaço médio'){
          CKEDITOR.currentInstance.commands.insertMedskip.exec()
        }else if(value == 'espaço grande'){
          CKEDITOR.currentInstance.commands.insertBigskip.exec()
        }
      }
    });
}
});
