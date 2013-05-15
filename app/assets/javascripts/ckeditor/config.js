CKEDITOR.editorConfig = function(config) {
  config.toolbarGroups = [
    { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
    { name: 'clipboard', groups: [ 'clipboard', 'undo' ] },
    { name: 'links' },
    { name: 'insert' },
    { name: 'document', groups: [ 'mode' ] }
  ];

  config.language = 'pt-BR';
};
