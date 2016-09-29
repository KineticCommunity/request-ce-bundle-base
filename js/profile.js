(function($){
    $(function(){
        /* We hide the change password and confirm change password feilds for user clerity.
         * To not get a flicker when the page is loaded the hidden class must be on the element prior to page load.
         * First we remove the hidden class and then hide the elements (clean check it out.)
         * Then events are bound to a tag elements*/
        $('.hidden').hide().removeClass('hidden');
        $('#password-toggle').on('click', function(event){
            $('#password-section').toggle(200);
            //Password-toggle is an a tag that says "Change Password" we hide this when it is clicked to reduce clutter on the screen.
            $('#password-toggle').hide();
            //A cancel a tag appears at the same time as the change password inputs appaer.  
            //This will allow users to not change their password should they change thier minds.
            $('#cancel').toggle(150);
            //doing a preventDefault stops the # sign from being added to the url when the a tag is clicked.
            event.preventDefault();
        });
        $('#cancel').on('click', function(event){
            $('#password-section').toggle(110);
            $('#password-toggle').toggle(20);
            $('#cancel').hide();
            //If a user hits the cancel button we eleminate the test in the change password fields so that it doesn't get submitted.
            $('input#password').val('');
            $('input#passwordConfirmation').val('');
            event.preventDefault();
        });
        /* We are grabing the values then doing some basic vaidation before turning them into a JSON object
         * for use in a ajax POST to update the users profile.
         */
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

