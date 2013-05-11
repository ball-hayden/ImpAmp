$ ->
  $('.pad a').click (e) ->
    e.preventDefault()

    $pad = $(e.currentTarget).closest(".pad")
    return if $pad.hasClass("error") || $pad.hasClass("disabled")

    if e.ctrlKey
      renamePad($pad)
    else
      playPad($pad)

    return false

playPad = ($pad) ->
  $progress = $pad.find(".progress")
  $progress.show()

  $pad.find("audio")[0].play()

renamePad = ($pad) ->
  $modal = $(nameChangeModal)
  $('body').append($modal)
  $modal.modal('show')
  $modal.on 'hidden', ->
    $modal.remove()

  $('#renameInput').val($pad.data("name"))

  $('#renameButton').click (e) ->
    e.preventDefault()
    newName = $('#renameInput').val()

    page = impamp.pads.getPage $pad
    key  = impamp.pads.getKey  $pad

    impamp.storage.done (storage) ->
      storage.setPadName page, key, newName, ->
        impamp.loadPad($pad)
        $modal.modal('hide')

    return false

nameChangeModal = """
<div class="modal hide fade">
  <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h3>Rename Pad</h3>
  </div>
  <div class="modal-body">
    <input id="renameInput">
  </div>
  <div class="modal-footer">
    <a href="#" class="btn"  data-dismiss="modal"        >Cancel</a>
    <a href="#" class="btn btn-primary" id="renameButton">Rename</a>
  </div>
</div>
"""