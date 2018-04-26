#= require s3_direct_upload

#console.log("Loading s3_direct_update script")
$ ->
    $("#s3-uploader").S3Uploader
        progress_bar_target: $('.js-progress-bars')
        remove_completed_progress_bar: true
        additional_data:{ id: $("#item_id").val(), attachto: "description" }
    
    $('#s3-uploader').bind "s3_upload_complete", (e, content) ->
        #console.log("Updating s3_direct_update script started...")
        #console.log("Content "+JSON.stringify(content))
        $('#uploads_container').append("<br/><span>"+content.filename+" uploaded.</span>")
        $('#media_filetype').val(content.filetype)
        $('#media_filepath').val(unescape(content.filepath))
        $('#media_filesize').val(content.filesize)
        $('#media_s3_url').val(unescape(content.url))
        $('#media_last_modified').val(content.lastModifiedDate)
        #console.log("Updating s3_direct_update script ended.")

