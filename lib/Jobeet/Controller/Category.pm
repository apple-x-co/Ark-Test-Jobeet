package Jobeet::Controller::Category;
use Ark 'Controller';

use Jobeet::Models;

sub show :Path :Args(1) {
    my ($self, $c, $category_name) = @_;

}

1;