# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"

# Exit visual-mode after aligning
atom.commands.add 'atom-text-editor', 'atom-alignment:apply-close', ->
  editorElement = atom.views.getView(atom.workspace.getActiveTextEditor())
  atom.commands.dispatch(editorElement, 'atom-alignment:alignMultiple')
  atom.commands.dispatch(editorElement, 'vim-mode-plus:reset-normal-mode')
