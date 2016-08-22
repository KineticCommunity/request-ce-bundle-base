(function($){
    $(function(){
        $('#password-section').removeClass('hidden').hide();
        $('#cancel').removeClass('hidden').hide();
        $('#password-toggle').on('click', function(event){
            $('#password-section').toggle(200);
            $('#password-toggle').hide();
            $('#cancel').toggle(150);
            event.preventDefault();
        });
        $('#cancel').on('click', function(event){
            $('#password-section').toggle(110);
            $('#password-toggle').toggle(20);
            $('#cancel').hide();
            $('input#password').val('');
            $('input#passwordConfirmation').val('');
            event.preventDefault();
        });
        $('button.save-profile').on('click', function(e){
            if ($('input#password').val() !== $('input#passwordConfirmation').val()){
                $('input#password').notifie({
                    anchor: 'div',
                    message: 'Passwords do not match.',
                    disable: false,
                    exitEvents: 'focus'
                });
                return;
            }
            var data = {
                displayName: $('input#displayName').val().trim(),
                email: $('input#email').val().trim(),
                preferredLocale: $('select#preferredLocale').val()
            };
            if ($('input#password').val().length > 0){
                data.password = $('input#password').val();
            }
            $.ajax({
                method: 'put',
                dataType: 'json',
                url: bundle.apiLocation()+'/me',
                data: JSON.stringify(data),
                beforeSend: function(jqXHR, settings){
                    $('button.save-profile').prop('disabled', true);
                    $('div.profile').notifie({
                            exit: true,
                            recurseExit: true
                        });
                },
                success: function(data, textStatus, jqXHR){
                    $('div.profile').notifie({
                        severity: 'success',
                            message: 'Saved changes to user ' + data.user.displayName,
                            expire: 5000
                        });
                },
                error: function(jqXHR, textStatus, errorThrown){
                    $('div.profile').notifie({
                            message: 'Failed to save changes'
                        });
                },
                complete: function(jqXHR, settings){
                    $('button.save-profile').prop('disabled', false);
                },
            });
        });
    });
})(jQuery);

