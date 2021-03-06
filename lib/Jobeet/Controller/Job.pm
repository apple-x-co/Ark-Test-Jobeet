package Jobeet::Controller::Job;
use Ark 'Controller';
with 'Ark::ActionClass::Form';

use DateTime::Format::W3CDTF;

use Jobeet::Models;

sub index :Path {
    my ($self, $c) = @_;

#    $c->stash->{jobs} = models('Schema::Job');

#    $c->stash->{jobs} = models('Schema::Job')->search({
#        expires_at => { '>=', models('Schema')->now->add( days => models('conf')->{active_days} ) },
#    });

#    $c->stash->{jobs} = models('Schema::Job')->get_active_jobs;

    $c->stash->{categories} = models('Schema::Category')->get_with_jobs;

    $c->localize('Hello');
}

# /job/{job_token} （詳細）
sub show :Path :Args(1) {
    my ($self, $c, $job_token) = @_;

    $c->stash->{job} = models('Schema::Job')->find({ token => $job_token })
        or $c->detach('/default');

    my $history = $c->session->get('job_history') || [];

    unshift @$history, { $c->stash->{job}->get_columns };

    $c->session->set( job_history => $history );
}

# /job/create （新規作成）
use Data::Dumper;
sub create :Local :Form('Jobeet::Form::Job') {
    my ($self, $c) = @_;

#    $c->stash->{form} = $self->form;

#    if ($c->req->method eq 'POST' and $self->form->submitted_and_valid) {
#        my $job = models('Schema::Job')->create_from_form($self->form);
#        $c->redirect( $c->uri_for('/job', $job->token) );
#    }

    my $confirm = $c->req->raw_param('__confirm');
    my $register = $c->req->raw_param('__register');
    if ($c->req->method eq 'POST' and $self->form->submitted_and_valid and defined($confirm)) {
        $c->forward('/job/confirm');
    }
}

# /job/confirm
sub confirm :Local :Form('Jobeet::Form::Job') {
    my ($self, $c) = @_;

    $c->view('MT')->template('job/confirm');
}

sub job :Chained('/') :PathPart :CaptureArgs(1) {
    my ($self, $c, $job_token) = @_;

    $c->stash->{job} = models('Schema::Job')->find({ token => $job_token })
        or $c->detach('/default');
}

# /job/{job_token}/edit （編集）
sub edit :Chained('job') :PathPart :Args(0) {
    my ($self, $c) = @_;

    my $job = $c->stash->{job};

    if ($c->req->method eq 'POST') {
        if ($self->form->submitted_and_valid) {
            $job->update_from_form($self->form);
            $c->redirect( $c->uri_for('/job', $job->token) );
        }
    }
    else {
        $self->form->fill({
            $job->get_columns,
            category => $job->category->slug,
        });
    }
}

# /job/{job_token}/delete （削除）
sub delete :Chained('job') :PathPart :Args(0) {
    my ($self, $c) = @_;

    $c->stash->{job}->delete;
    $c->redirect( $c->uri_for('/job') );
}

# /job/publish
sub publish :Chained('job') :PathPart {
    my ($self, $c) = @_;

    my $job = $c->stash->{job};

    $job->publish;
    $c->redirect( $c->uri_for('/job', $job->token) );
}

# /job/atom
sub atom :Local {
    my ($self, $c) = @_;
    $c->res->content_type('application/atom+xml; charset=utf-8');

    $c->stash->{w3c_date} = DateTime::Format::W3CDTF->new;
    $c->stash->{latest_post} = models('Schema::Job')->latest_post;

    $c->forward('index');
}

1;