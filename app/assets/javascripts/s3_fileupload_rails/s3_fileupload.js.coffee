#= require jquery-fileupload

s3_fileupload = (opts) ->
  $('#fileupload').fileupload
    add: (e, data) ->
      # types = /(\.|\/)(gif|jpe?g|png)$/i
      # file = data.files[0]
      # if types.test(file.type) || types.test(file.name)
      #   data.context = $(tmpl("template-upload", file))
      #   $('#fileupload').append(data.context)
      #   data.submit()
      # else
      #   alert("#{file.name} is not a gif, jpeg, or png image file")

      $.ajax
        url: "/s3_fileupload_rails"
        type: "GET"
        dataType: "json"
        data:
          doc:
            title: data.files[0].name
      
        async: false
        success: (data) -> 
          form.find("input[name=key]").val data.key
          form.find("input[name=policy]").val data.policy
          form.find("input[name=signature]").val data.signature
          
        data.submit()

    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')
    
    done: (e, data) ->
      file = data.files[0]
      domain = $('#fileupload').attr('action')
      path = $('#fileupload input[name=key]').val().replace('${filename}', file.name)
      to = $('#fileupload').data('post')
      content = {}
      content[$('#fileupload').data('as')] = domain + path
      $.post(to, content)
      data.context.remove() if data.context # remove progress bar
    
    fail: (e, data) ->
      alert("#{data.files[0].name} failed to upload.")
      console.log("Upload failed:")
      console.log(data)
  