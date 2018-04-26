


$(document).ready ->
    $('input[type=radio]').on 'change', () ->
        $(this).closest("form").submit();
