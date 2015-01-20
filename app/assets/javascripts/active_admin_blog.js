(function() {
    var wait = null,
        preview = function() {
                $.post('/blogs/preview', {
                    title: $('#blog_title').val(),
                    markup: $('#blog_description').val(),
                    image: $('#blog_image').val()
                }, function(data) {
                    $('#text').html(data);
                }, 'html');
    }
    $('#blog_description').keyup(function(ev) {
        clearTimeout($.data(this, 'timer'));

        wait = setTimeout(preview, 500);
        $(this).data('timer', wait);
    });

    var action = $('#edit_blog').attr('action'),
        id = action ? action.split('/')[3] : -1;

    // launch initial preview
    preview();

    if (id >= 0) {
        new Dropzone("#preview", {
            previewsContainer: $('#image')[0],
            url: "/blogs/"+id+"/upload/",
            createImageThumbnails: false
        })
        .on('success', function(file) {
            $('#image img').attr('src', '/images/'+id+'/original/'+file.name);
        })
        .on('sending', function(file, xhr) {
            xhr.setRequestHeader('X-CSRF-Token', $('input[name="authenticity_token"]').val())
        })
    } else {
        $('#image').remove();
        $('legend span').text('Create blog first before changing its image');
    }

})();

