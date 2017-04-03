
"use strict";

jQuery(function() {
    jQuery('.search input[type="submit"]').hide();

    jQuery('#search_keywords').on('keyup', function(key) {
        if (this.value.length >= 3 || this.value == '') {
            jQuery('#loader').show();
            jQuery('#jobs').load(
                jQuery(this).parents('form').attr('action'),
                { q: this.value },
                function() { jQuery('#loader').hide(); }
            );
        }
    });
});