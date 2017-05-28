save_form = ->
  if ($('#driver_automobile_id').val() == '*Создание нового')
    $('#driver_automobile_id').remove()
    $("#driver_automobile_attributes_id").remove()
  else if ($('#driver_automobile_id').val() == '*Редактирование') #|| !($('#driver_automobile_id').val() == '')
    $("#driver_automobile_id").remove()

insert_form = ->
  f = $("#automobile-fieldset").attr("data-content")
  if ($("#driver_automobile_id").val() == '')
    $("#automobile-fields").html('Без автомобиля')
  else if ($('#driver_automobile_id').val() == '*Создание нового')
    $("#automobile-fields").html(f)
    # $('#driver_automobile_attributes_automobile_model').val('')
    # $('#driver_automobile_attributes_automobile_type').val('')
    # $('#driver_automobile_attributes_state_number').val('')
    # $('#driver_automobile_attributes_color').val('')
    # $('#driver_automobile_attributes_release').val('')
  else if ($('#driver_automobile_id').val() == '*Редактирование')
    $("#automobile-fields").html(f)
  else
    $("#automobile-fields").html('Выбран существующий автомобиль')

ready = ->
  insert_form()
  $("#driver_automobile_id").change -> insert_form()
  $('#save').on 'click', save_form

$(document).ready ready
$(document).on 'page:load', ready
