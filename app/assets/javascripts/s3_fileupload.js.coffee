$ ->
  $(".s3-fileupload").each ->
    form = $(this)
    $(this).fileupload
      url: form.attr("action")
      type: "POST"
      autoUpload: true
      dataType: "xml" # This is really important as s3 gives us back the url of the file in a XML document
      add: (event, data) ->
        $.ajax
          url: "/s3_fileupload_rails"
          type: "GET"
          dataType: "json"
          data: # send the file name to the server so it can generate the key param
            file: data.files[0].name

          async: false
          success: (data) ->
            
            # Now that we have our data, we update the form so it contains all
            # the needed data to sign the request
            form.find("input[name=key]").val data.key
            form.find("input[name=policy]").val data.policy
            form.find("input[name=signature]").val data.signature
        data.file_path = $('form.s3-fileupload').attr('action') + $('.s3-fileupload input[name=key]').val()
        data.submit()

      send: (e, data) ->
        $(".progress").fadeIn()

      progress: (e, data) ->
        
        # This is what makes everything really cool, thanks to that callback
        # you can now update the progress bar based on the upload progress
        percent = Math.round((e.loaded / e.total) * 100)
        $(".bar").css "width", percent + "%"

      fail: (e, data) ->
        console.log "fail"

      done: (event, data) ->
        console.log data.file_path
        $("#s3-fileupload-images").append("<img src='#{data.file_path}' class='img-rounded'/>")
        $(".progress").fadeOut 300, ->
          $(".bar").css "width", 0



