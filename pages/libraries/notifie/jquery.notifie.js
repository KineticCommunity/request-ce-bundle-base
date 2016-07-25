/**
 * Notifie JS
 * Version 0.3
 * 
 * Library that extends jQuery to add a .notifie(options) function for displaying alerts and confirmations.
 * Requires jQuery, Bootstrap, FontAwesome
 * 
 * Parameters
 * 
 *  -options:    (Optional) Javascript Object with settings for the notification.
 * 
 * 
 * Options (All of these are optional. If you pass it, it will overwrite the default.)
 * 
 *  -anchor:    String -> jQuery selector
 *              Default: null
 *              Finds the closest element matching this selector to use as anchor of the notifications.
 *              Examples: 'div' or 'li.main'
 *           
 *  -type:      String -> 'alert' or 'confirm
 *              Default: 'alert'
 *              Defines the type of notification to display.
 * 
 *  -severity:  String -> 'danger' or 'warning' or 'info' or 'success'
 *              Default: 'danger'
 *              Defines the style of the notification.
 * 
 *  -message:   String
 *              Default: 'Error'
 *              Text to display inside the notification.
 * 
 *  -margin:    Object -> Available properties: inherit[true|false|padding], margin[#px|#px #px|...], margin-top[#px], margin-bottom, margin-left, margin-right
 *              Default: {inherit:true}
 *              Sets the margins of the notification. 
 *              Examples: {inherit:true} -> Will copy the margins of the anchor.
 *                      {inherit:true, 'margin-top':'10px'} -> Will copy the margins of the anchor, and then set the top margin to 10px.
 *                      {inherit:false, 'margin-top':'10px'} or {'margin-top':'10px'} -> Will set the top margin to 10px. Will not set any other margins.
 *                      {'margin':'5px'} -> Will set all margins to 5px.
 *                      {inherit:true, 'margin-bottom':'inverse'} -> Will copy the margins of the anchor, but will use the inverse of the bottom margin.
 *                          (ie. If the anchor's margin-bottom is 5px, the notification will get a margin-bottom of -5px)
 * 
 *  -onShow:    Function
 *              Default: function(){}
 *              Function to call when the notification is shown. Context is the calling element.
 * 
 *  -onConfirm: Function
 *              Default: function(){}
 *              Function to call when alert is closed or confirm button is pressed in confirmation notification.
 *           
 *  -onReject:  Function
 *              Default: function(){}
 *              Function to call when confirmation notification is closed or reject button is pressed in confirmation notification.
 * 
 *  -clearExisting: Boolean
 *                  Default: true
 *                  If true, closes any existing notifications at this level before opening a new one.
 * 
 *  -exitEvents:    String -> Javascript event name(s)
 *                  Default: ''
 *                  Applies only when 1 notification will be opened (ie: calling element or its anchor translates toa  single element, not a list of elements).
 *                  Events that will get added to calling element that will close the notifications.
 *                  You may pass multiple events by separating them by spaces.
 *                  Examples: 'click' or 'focus' or 'click focus'
 * 
 *  -textButtons:   Boolean
 *                  Default: false
 *                  If true, buttons in a confirmation notification will show text instead of icons.
 * 
 *  -confirmText:   String
 *                  Default: 'OK'
 *                  If textButtons is true, this text will display on the confirm button.
 * 
 *  -rejectText:    String
 *                  Default: 'Cancel'
 *                  If textButtons is true, this text will display on the reject button.
 *                  
 *  -duration:  Number
 *              Default: 100
 *              Amount of milliseconds that the animation of showing/hiding the notification should take.
 *              Setting to 0 removes the animation.
 * 
 *  -expire:    Number
 *              Default: null
 *              Applies only if type is alert. Amount of milliseconds that the alert will stay on screen before automatically disappearing.
 * 
 *  -disable:   Boolean
 *              Default: true
 *              If true, the calling element will be disabled when the notification is shown, and enabled when the notification is closed.
 * 
 *  -toggle:    Boolean
 *              Default: false
 *              If true and if notification at the anchor level already exists, this .notifie() call will only close that notification.
 * 
 *  -exit:      Boolean
 *              Default: false
 *              If true, this .notifie() call will only close the notification(s) at the anchor level.
 * 
 *  -recurseExit:   Boolean
 *                  Default: false
 *                  Applies only if exit is true. If true, closes all notifications at the anchor level and inside all children of the anchor.
 * 
 */
jQuery.fn.extend({
    notifie: function(options){
        var self = $(this);
        // Merge passed in options with defaults
        options = jQuery.extend(true, {
            anchor: null,
            type: "alert",
            severity: "danger",
            message: "Error",
            margin: {inherit:true},
            onShow: function(){},
            onConfirm: function(){},
            onReject: function(){},
            clearExisting: true,
            exitEvents: '',
            textButtons: false,
            confirmText: "OK",
            rejectText: "Cancel",
            duration: 100,
            expire: null,
            disable: true,
            toggle: false,
            exit: false,
            recurseExit: false
        }, options || {});
        
        // Get owner of notification
        var owner = self.closest(options.anchor).length ? self.closest(options.anchor) : self;
        
        // Close existing notification(s)
        if (options.exit || (owner.prevUntil(':not(div.notifie)').length > 0 && options.toggle)){
            // If recurseExit is true, close all notifications under owner
            if (options.recurseExit){
                // Find notifications immediately before owner and close
                owner.prevUntil(':not(div.notifie)').trigger('exit', false);
                // Find all notifications in all descendants close
                owner.find('div.notifie').trigger('exit', false);
            }
            // If recurseExit is false, close only children notifications under owner
            else {
                // Find notifications immediately before owner and close
                owner.prevUntil(':not(div.notifie)').trigger('exit', false);
            }
        }
        // Show new notification
        else {
            // Verify type and severity, and set to default if not one of the acceptable options
            options.type = $.inArray(options.type, ["alert", "confirm"]) < 0 ? "alert" : options.type;
            options.severity = $.inArray(options.severity, ["success", "info", "warning", "danger"]) < 0 ? "danger" : options.severity;
            // Check type of notification
            var isAlert = options.type === "alert";
            var isConfirm = options.type === "confirm";
            
            // Build notification container
            var notification = $("<div>").addClass("notifie clearfix alert alert-" + options.severity);
            
            // Set margins of notification
            if (options.margin){
                var margin = {};
                // If margin property exists, set that as the margin
                if (options.margin.margin){
                    // Set CSS
                    notification.css('margin', options.margin.margin);
                }
                // If inherit is true
                else if (options.margin.inherit){
                    var inheritFrom = options.margin.inherit === 'padding' ? 'padding-' : 'margin-';
                    // If margin value is set, use it, otherwise inherit
                    margin['margin-top'] = options.margin['margin-top'] || owner.css(inheritFrom + 'top');
                    margin['margin-bottom'] = options.margin['margin-bottom'] || owner.css(inheritFrom + 'bottom');
                    margin['margin-left'] = options.margin['margin-left'] || owner.css(inheritFrom + 'left');
                    margin['margin-right'] = options.margin['margin-right'] || owner.css(inheritFrom + 'right');
                    
                    // Set CSS
                    notification.css(margin);
                }
                // Otherwise inherit is false
                else {
                    // If margin value is set, use it
                    if (options.margin['margin-top']) margin['margin-top'] = options.margin['margin-top'];
                    if (options.margin['margin-bottom']) margin['margin-bottom'] = options.margin['margin-bottom'];
                    if (options.margin['margin-left']) margin['margin-left'] = options.margin['margin-left'];
                    if (options.margin['margin-right']) margin['margin-right'] = options.margin['margin-right'];
                    
                    // Set CSS
                    notification.css(margin);
                }
            }
            
            // Add custom exit event triggered when user manually closes the notification
            notification.on('exit', function(e, confirm){
                // Hide the notification
                $(this).slideUp(options.duration, function(){
                    // Enable self on exit if it was disabled
                    if (options.disable){
                        self.prop('disabled', false);
                    }
                    // If confirm is not undefined, call a callback function
                    if (confirm !== undefined){
                        // If confirm is true or notification is alert, call onConfirm, else call onReject
                        if (confirm || isAlert) options.onConfirm.call(self);
                        else options.onReject.call(self);
                    }
                    // Remove the notification
                    $(this).remove();
                });
                // Prevent default on this event, so it doesn't trigger form submits
                if(e.preventDefault) e.preventDefault();
                else e.returnValue = false;
            });
            
            // If only 1 owner, therefore only 1 notification 
            if (owner.length <= 1){
                // Add one time events to self for exiting the notifications
                self.one(options.exitEvents, function(e){
                    notification.trigger('exit', false);
                });
            }

            // Build notification close button and attach exit event function on click
            $("<button>").addClass('fa fa-times close').on('click', function(e){
                // Close popup and call appropriate onConfirm/onReject function (which is handled by the exit event)
                $(this).closest('.notifie').trigger('exit', false);
            }).appendTo(notification);
            // Build notification message
            $("<div>").addClass("notifie-message").html(options.message).appendTo(notification);
            // If confirm, build buttons
            if (isConfirm){
                // Build button group
                var buttons = $("<div>").addClass("notifie-buttons alert-" + options.severity).appendTo(notification);
                
                // Create button
                var rejectBtn = $("<button>").addClass("btn btn-danger btn-sm pull-right reject").appendTo(buttons);
                // Add dismiss/cancel button text or icon
                if (options.textButtons) rejectBtn.addClass("text").text(options.rejectText); 
                else rejectBtn.addClass("fa fa-times");
                // Add click event to button
                rejectBtn.on('click', function(e){
                    // Close popup and call appropriate onConfirm/onReject function (which is handled by the exit event)
                    $(this).closest('.notifie').trigger('exit', false);
                });
                
                // Create button
                var confirmBtn = $("<button>").addClass("btn btn-success btn-sm pull-right confirm").appendTo(buttons);
                // Add ok button text or icon
                if (options.textButtons) confirmBtn.addClass("text").text(options.confirmText); 
                else confirmBtn.addClass("fa fa-check");
                // Add click event to button
                confirmBtn.on('click', function(e){
                    // Close popup and call onConfirm function (which is handled by the exit event)
                    $(this).closest('.notifie').trigger('exit', true);
                });
            }
            
            // Clear any existing notifications if required
            if (options.clearExisting) owner.prevUntil(':not(div.notifie)').trigger('exit', false);
            
            // Add as sibling immediately before owner and show notification
            notification.insertBefore(owner).slideDown(options.duration, function(){
                // Call onShow function
                options.onShow.call(self);
                // Disable self if necessary
                if (options.disable){
                    self.prop('disabled', true);
                }
                if (isAlert && options.expire){
                    var nSelf = $(this);
                    setTimeout(function() {
                        nSelf.trigger('exit', false);
                    }, options.expire);
                }
            });
        }
        
        // Return self for chaining
        return self;
    }
});

/**
 * Change Log
 * 
 * v0.3 2015-10-02
 *  - The message can now contain html.
 *  - Added toggle option, which when set to true, will only close any existing notifications, and if no existing notifications then will open new notification. 
 *  - Changed exitEvents option to only apply if a single notification will be opened via the .notfie call.
 *  - Added event.preventDefault to exit event so it won't trigger form submits.
 *  - Fixed issue where not all existing notifications were being cleared when using exit option.
 *  - Fixed bug where when calling .notifie on a set of elements, functionality didn't work properly.
 * v0.2.1 2015-09-10
 *  - Fixed some styling issues and clearExisting issue where not all existing notifications were being cleared.
 * v0.2 2015-09-09
 *  - Change parent option name to anchor. 
 *  - Fixed bug where sibling elements would clear each other's notifications.
 *  - Added margin option to set margins around notification. 
 * v0.1 2015-08-24
 *  - Initial implementation. Includes alert and confirm notifications. 
 *
 */