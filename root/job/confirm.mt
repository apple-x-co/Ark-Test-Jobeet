? my $form = $c->stash->{form};

? extends 'common/jobs_base';

? block content => sub {

<h1>New Job (Confirm)</h1>

?= include('job/_partial_form_confirm', $form);

? } # endblock content