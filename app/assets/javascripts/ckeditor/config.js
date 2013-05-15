CKEDITOR.editorConfig = function(config) {
  config.toolbar = [
    { name: 'basicstyles', items: [ 'Bold', 'Italic' ] },
    { name: 'insert', items: [ 'Image' ] },
    { name: 'clipboard', items: [ 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo' ] },
    { name: 'document', items: [ 'Source' ] }
  ];

  config.language = 'pt-BR';
};
