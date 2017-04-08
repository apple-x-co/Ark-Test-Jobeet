package Jobeet::Controller::Rooter;
use Ark 'Controller';

# /rooter
sub index :Path {
}

######################################
# private : /rooter/rooter
sub rooter :Chained('/') {
}

# /rooter/hoge
sub hoge :Chained('rooter') {
}

# /rooter/hoge/*
sub hoge :Chained('rooter') :Args(1) {
}

# /rooter/hoge/*/*
sub hoge :Chained('rooter') :Args(2) {
}

######################################
# private function for "/fuga/*/xxx"
sub fuga :Chained('/') :PathPart :CaptureArgs(1) {
}

# /fuga/*/edit
sub edit :Chained('fuga') :PathPart :Args(0) {
}

# /fuga/*/delete
sub delete :Chained('fuga') :PathPart :Args(0) {
}

1;