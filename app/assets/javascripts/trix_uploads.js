// Turn off the default Trix captions

if (typeof Trix.config.attachments !== 'undefined') {
  Trix.config.attachments.preview.caption = { name: false, size: false }
}

function uploadAttachment(attachment) {
  // Create our form data to submit
  var file = attachment.file;
  var form = new FormData;
  form.append("Content-Type", file.type);
  form.append("image[image]", file);

// Create our XHR request
  var xhr = new XMLHttpRequest;
  xhr.open("POST", "/admin/images.json", true);
  xhr.setRequestHeader("X-CSRF-Token", Rails.csrfToken());

// Report file uploads back to Trix
  xhr.upload.onprogress = function(event) {
    var progress = event.loaded / event.total * 100;
    attachment.setUploadProgress(progress);
  }

  // Tell Trix what url and href to use on successful upload
  xhr.onload = function() {
    if (xhr.status === 201) {
      var data = JSON.parse(xhr.responseText);
      return attachment.setAttributes({
        url: data.image_url,
      })
    }
  }

  return xhr.send(form);
}

document.addEventListener("trix-attachment-add", function(event) {
  var attachment = event.attachment;
  if (attachment.file) {
    return uploadAttachment(attachment);
  }
});