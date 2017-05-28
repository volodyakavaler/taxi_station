save_form = ->
  if ($('#order_tariff_id').val()   == '*Создание нового')
    $('#order_tariff_id').remove()
    $("#order_tariff_attributes_id").remove()
  else if ($('#order_tariff_id').val() == '*Редактирование')
    $('#order_tariff_id').remove()

insert_form = ->
  f = $("#tariff-fieldset").attr("data-content")
  if ($('#order_tariff_id').val() == '*Создание нового')
    $("#tariff-fields").html(f)
    # $("#order_tariff_attributes_name").val('')
    # $("#order_tariff_attributes_time_of_day").val('')
    # $("#order_tariff_attributes_range").val('')
    # $("#order_tariff_attributes_price_per_kilometer").val('')
  else if ($('#order_tariff_id').val() == '*Редактирование')
    $("#tariff-fields").html(f)
  else
    $("#tariff-fields").html("Выбран существующий тариф")

ready = ->
  insert_form()
  $("#order_tariff_id").change -> insert_form()
  $('#save').on 'click', save_form

$(document).ready ready
$(document).on 'page:load', ready
