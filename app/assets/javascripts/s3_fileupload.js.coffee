(($) ->
  createUploadInfo = (form,file_name) ->
    upload_info = JSON.parse($.ajax(
      type: "GET"
      dataType: "json"
      url: "/s3_fileupload_rails"
      async: false
      data:
        file: file_name
    ).responseText)

    $("input[name=key]",form).val(upload_info.key)
    $("input[name=policy]",form).val(upload_info.policy)
    $("input[name=signature]",form).val(upload_info.signature)

    #Return file path
    form.attr('action') + upload_info.key
    
  $.fn.s3fileupload = (opts = {})->
    @each ->
      form = $(this)
      s3opts =
        url: form.attr("action")
        type: "POST"
        autoUpload: true
        add: (event, data) ->
          data.file_path = createUploadInfo(form,data.files[0].name)
          data.submit()

        send: (e, data) ->
          $(".progress").fadeIn()
  
        progress: (e, data) ->
          percent = Math.round((e.loaded / e.total) * 100)
          $(".bar").css "width", percent + "%"
  
        fail: (e, data) ->
          console.log "S3 fileupload plugin failed."
  
        done: (event, data) ->
          console.log data.file_path
          $("#s3-fileupload-images").append("<img src='#{data.file_path}' class='img-rounded'/>")
          $(".progress").fadeOut 300, ->
            $(".bar").css "width", 0
      s3opts = $.merge(s3opts, opts)
      $(this).fileupload(s3opts)
) jQuery

$('.s3-fileupload').s3fileupload()


