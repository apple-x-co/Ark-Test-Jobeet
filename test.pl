use strict;
use warnings;
use lib 'lib';

use Data::Dumper;
use Jobeet::Schema;


my $schema = Jobeet::Schema->connect('dbi:SQLite:./test.db');

my $category_rs = $schema->resultset('Category');
print $category_rs->count, "\n";
#print Dumper($category_rs), "\n";

# INSERT
#my $category = $category_rs->create({
#    name => 'new category',
#});
#print $category_rs->count, "\n";

# SELECT
#my $new_rs = $category_rs->search({ name => 'new category' });
#my $new_rs = $category_rs->search({ }, { rows => 5, page => 1 });
#print $new_rs->count, "\n";

#my $category = $category_rs->find('id');
#my @categories = $category_rs->all;
while (my $category = $category_rs->next) {
    print $category->name, "\n";
}

# UPDATE
#$category->update({ name => 'new name' });

# DELETE
#$category->delete;
