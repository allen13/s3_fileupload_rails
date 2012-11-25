(($) ->
  uploading = JST["s3_fileupload/templates/uploading"]
  complete = JST["s3_fileupload/templates/complete"]

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
          file_name = data.files[0].name
          data.file_path = createUploadInfo(form,file_name)
          data.view = $(uploading({title: file_name}))
          $("#s3-images").append(data.view)
          data.submit()
  
        progress: (e, data) ->
          percent = Math.round((e.loaded / e.total) * 100)
          data.view.find(".bar").css "width", percent + "%"
  
        fail: (e, data) ->
          console.log "S3 fileupload plugin failed."
  
        done: (event, data) ->
          console.log data.file_path
          data.view.replaceWith(complete(img_path:data.file_path))

      s3opts = $.merge(s3opts, opts)
      $(this).fileupload(s3opts)

  $('.s3-fileupload').s3fileupload()
) jQuery


